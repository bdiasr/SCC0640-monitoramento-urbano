import cx_Oracle

import folium
import webbrowser
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip

import conexao


#Latitude e Longitude de onde queremos começar o mapa, no caso o escolhido foi a catedral de são Carlos 
sc_Latitude = -22.005080902589146
sc_Longitude = -47.88923382637606

#Criando o mapa
mapa = folium.Map(
    location=[sc_Latitude, sc_Longitude],
    zoom_start= 15.5
)

#Essa função é responsável pela criação de uma linha de onibus (selecionar as localizações de tal linha)
#Recebe como parametro a linha do onibus 
def criaLinha(linhaOnibus):

    connection = conexao.conexao_client()
    #Le o banco SQL a tabela LOCALIZACAO e transforma em um dataFrame pandas 
    coordenadas = pd.read_sql('select * from LOCALIZACAO', connection)

    #Armazenar os onibus em um array 
    linhaOnibus = coordenadas.loc[coordenadas['ONIBUS'] == linhaOnibus].drop(columns='ONIBUS')
    print(linhaOnibus)

    trajetoLinha = linhaOnibus
    #Transformar o array de coordenadas e tempo em um dataframe para que o Folium possa analisar -- Por onibus 
    trajetoLinha["Latitude anterior"] = trajetoLinha["LATITUDE"].shift()
    trajetoLinha["Longitude anterior"] = trajetoLinha["LONGITUDE"].shift()
    trajetoLinha['Hora anterior'] = trajetoLinha['DATAHORA'].shift()

    lines = []
    features = []

    for index, row in trajetoLinha.iloc[1:].iterrows():

        coordinates = [
            [
                row['Longitude anterior'], 
                row['Latitude anterior']
            ], 
            [
                row['LONGITUDE'], 
                row['LATITUDE']
            ]
        ]
        times = [row['Hora anterior'], row['DATAHORA']]
        features.append(
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "LineString",
                        "coordinates": coordinates,
                    },
                    "properties": {
                        "times": times,
                        "style": {
                            "color": 'red',
                            "weight": 5,
                        },
                    },
                }
            )

    #remove o ultimo elemento da lista 
    features.pop()

    plugins.TimestampedGeoJson({
        'type': 'FeatureCollection',
        'features': features,
    }, 
        period='PT1M',
        add_last_point=True).add_to(mapa)

    #Salvando o arquivo html e mostrando 
    mapa.save("mapaAplicacaoLinha.html")
    webbrowser.open("mapaAplicacaoLinha.html")

    #encerra a conexao
    connection.close()
    return

#criaLinha('HAY1F47')

#Função responsável por plotar os trajetos de onibus 
def linhasOnibus():
    
    connection = conexao.conexao_client()

    #pegar as coordenadas das linhas e armazenar em um array? dataframe?
    coordenadas = pd.read_sql('select * from LOCALIZACAO', connection)

    #nome ; codigo -- dataFrame que contem todas as linhas existentes no BD
    linhas = pd.read_sql('select * from LINHA', connection)

    #Latitude ; Longitude ; codigo ; ordenação(?) -- contém todas as coordenadas dos pontos por codigo da linha
    pontosLinha = pd.read_sql('select * from PONTOS_LINHA', connection)
    #teste = pd.read_sql_query('select * from PONTO_ONIBUS', connection)   

    
    #df.loc[df[<some_column_name>] == <condition>, [<another_column_name>]] = <value_to_add>
    pontosLinha.insert(3, 'NOME', 0)
    pontosLinha.loc[pontosLinha['CODIGO'] == 'JRB160', ['NOME']] = 'Amarela'
    pontosLinha.loc[pontosLinha['CODIGO'] == 'KLM415', ['NOME']] = 'Vermelha'

    #------------- criação da Linha Amarela ----------------------
    coord_LinhaAmarela = pontosLinha.loc[pontosLinha['NOME'] == 'Amarela'].drop(columns=['CODIGO', 'ORDENACAO', 'NOME']).values
    inicio_LinhaAmarela = list(coord_LinhaAmarela[0])

    #------------ Criacao da linha Vermelha -----------------
    #Escolhe apenas os pontos com a linha vermelha <- pega so as coordenadas 
    coord_LinhaVermelha = pontosLinha.loc[pontosLinha['NOME'] == 'Vermelha'].drop(columns=['CODIGO', 'ORDENACAO', 'NOME']).values
    #marca o inicio da linha vermelha 
    inicio_LinhaVermelha = list(coord_LinhaVermelha[0])

    #-- criando grupos de linha - Conjunto de coordenadas de cada linha 
    LinhaAmarela = folium.FeatureGroup("Linha Amarela")
    LinhaVermelha = folium.FeatureGroup("Linha Vermelha")

    linha_Onibus_Vermelha = folium.vector_layers.PolyLine(coord_LinhaVermelha, popup ='<b>Linha Vermelha<b>', pooltip="Linha Vermelha",color='red').add_to(LinhaVermelha)
    linha_Onibus_Amarela = folium.vector_layers.PolyLine(coord_LinhaAmarela, popup='<b>Linha Amarela<b>', pooltip="Linha Amarela",color='yellow').add_to(LinhaAmarela)

    folium.Marker(location=inicio_LinhaAmarela, popup='Linha Amarela', tooltip='<strong>Linha Amarela</strong>', icon=folium.Icon(color='orange', prefix='fa', icon='bus')).add_to(LinhaAmarela)
    folium.Marker(location=inicio_LinhaVermelha, popup='Linha Vermelha', tooltip='<strong>Linha Vermelha</strong>', icon=folium.Icon(color='red', prefix='fa', icon='bus')).add_to(LinhaVermelha)
    
    #adicionando os componentes no mapa 
    LinhaAmarela.add_to(mapa)
    LinhaVermelha.add_to(mapa)

    folium.LayerControl().add_to(mapa)

    mapa.save("mapa-teste-linhas.html")
    webbrowser.open("mapa-teste-linhas.html")

    #encerra a conexão 
    connection.close()
    return 

linhasOnibus()



def trajeto():

    connection = conexao.conexao_client()

    #Le o banco SQL a tabela LOCALIZACAO e transforma em um dataFrame pandas 
    coordenadas = pd.read_sql('select * from LOCALIZACAO', connection)

    #Armazenar os onibus em um array 
    '''
       LATITUDE  LONGITUDE            DATAHORA   ONIBUS
    0 -23.550128 -46.634043 2021-11-27 20:00:00  HAY1F47
    '''
    linhasOnibus = coordenadas['ONIBUS'].drop_duplicates().values
    print(linhasOnibus)

    trajeto = coordenadas

    #Transformar o array de coordenadas e tempo em um dataframe para que o Folium possa analisar -- Preciso separar os onibus 
    trajeto["Latitude anterior"] = trajeto["LATITUDE"].shift()
    trajeto["Longitude anterior"] = trajeto["LONGITUDE"].shift()
    trajeto['Hora anterior'] = trajeto['DATAHORA'].shift()

    # criação das Linhas a serem mostradas
    # Ordem das coordenadas (Longitude, Latitude)
    lines = []
    features = []

    for index, row in trajeto.iloc[1:].iterrows():

        coordinates = [
            [
                row['Longitude anterior'], 
                row['Latitude anterior']
            ], 
            [
                row['LONGITUDE'], 
                row['LATITUDE']
            ]
        ]
        times = [row['Hora anterior'], row['DATAHORA']]
        features.append(
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "LineString",
                        "coordinates": coordinates,
                    },
                    "properties": {
                        "times": times,
                        "style": {
                            "color": 'red',
                            "weight": 5,
                        },
                    },
                }
            )

    #remove o ultimo elemento da lista 
    features.pop()

    plugins.TimestampedGeoJson({
        'type': 'FeatureCollection',
        'features': features,
    }, 
        period='PT1M',
        add_last_point=True).add_to(mapa)

    #Salvando o arquivo html e mostrando 
    #mapa.save("mapaAplicacao.html")
    #webbrowser.open("mapaAplicacao.html")

    #encerra a conexao
    connection.close()
    return 

#trajeto()