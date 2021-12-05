import cx_Oracle

import folium
import webbrowser
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip

import conexao
import private 

#Conexão 
ip = 'grad.icmc.usp.br'
port = 15215
SID = 'orcl'
dsn = cx_Oracle.makedsn(ip, port, SID)
#Usuário - Senha
username = private.username()
password = private.password()

connection = cx_Oracle.connect(username, password, dsn)
cursor = connection.cursor()


#Latitude e Longitude de onde queremos começar o mapa, no caso o escolhido foi a catedral de são Carlos 
sc_Latitude = -22.005080902589146
sc_Longitude = -47.88923382637606

#Criando o mapa
mapa = folium.Map(
    location=[sc_Latitude, sc_Longitude],
    zoom_start= 15
)

#Essa função é responsável pela criação de uma linha de onibus (selecionar as localizações de tal linha)
#Recebe como parametro a linha do onibus 
def criaLinha(linhaOnibusCodigo):

    #Le o banco SQL a tabela LOCALIZACAO e transforma em um dataFrame pandas 
    coordenadas = pd.read_sql('select * from LOCALIZACAO', connection)

    #Latitude ; Longitude ; codigo ; ordenação(?) -- contém todas as coordenadas dos pontos por codigo da linha
    pontosLinha = pd.read_sql('select * from PONTOS_LINHA', connection)

    pontosLinha.insert(3, 'NOME', 0)
    pontosLinha.loc[pontosLinha['CODIGO'] == 'JRB160', ['NOME']] = 'Amarela'
    pontosLinha.loc[pontosLinha['CODIGO'] == 'KLM415', ['NOME']] = 'Vermelha'

    pontosLinha = pontosLinha.sort_values(['ORDENACAO'])
    #------------- criação da Linha Amarela ----------------------
    coord_LinhaAmarela = pontosLinha.loc[pontosLinha['NOME'] == 'Amarela'].drop(columns=['CODIGO', 'ORDENACAO', 'NOME']).values
    
    #print(coord_LinhaAmarela)
    inicio_LinhaAmarela = list(coord_LinhaAmarela[0])

    #------------ Criacao da linha Vermelha -----------------
    #Escolhe apenas os pontos com a linha vermelha <- pega so as coordenadas 
    coord_LinhaVermelha = pontosLinha.loc[pontosLinha['NOME'] == 'Vermelha'].drop(columns=['CODIGO', 'ORDENACAO', 'NOME']).values
    #marca o inicio da linha vermelha 
    inicio_LinhaVermelha = list(coord_LinhaVermelha[0])

    #Armazenar os onibus em um array 
    linhaOnibus = coordenadas.loc[coordenadas['ONIBUS'] == linhaOnibusCodigo].drop(columns='ONIBUS')

    #-- criando grupos de linha - Conjunto de coordenadas de cada linha 
    LinhaAmarela = folium.FeatureGroup("Linha Amarela")
    LinhaVermelha = folium.FeatureGroup("Linha Vermelha")

    linha_Onibus_Vermelha = folium.vector_layers.PolyLine(coord_LinhaVermelha, popup ='<b>Linha Vermelha<b>', pooltip="Linha Vermelha",color='red').add_to(LinhaVermelha)
    linha_Onibus_Amarela = folium.vector_layers.PolyLine(coord_LinhaAmarela, popup='<b>Linha Amarela<b>', pooltip="Linha Amarela",color='yellow').add_to(LinhaAmarela)

    folium.Marker(location=inicio_LinhaAmarela, popup='Linha Amarela', tooltip='<strong>Linha Amarela</strong>', icon=folium.Icon(color='orange', prefix='fa', icon='bus')).add_to(LinhaAmarela)
    folium.Marker(location=inicio_LinhaVermelha, popup='Linha Vermelha', tooltip='<strong>Linha Vermelha</strong>', icon=folium.Icon(color='red', prefix='fa', icon='bus')).add_to(LinhaVermelha)

    trajetoLinha = linhaOnibus
    trajetoLinha['DATAHORA'] = trajetoLinha['DATAHORA'].astype(str)
    #Transformar o array de coordenadas e tempo em um dataframe para que o Folium possa analisar -- Por onibus 
    trajetoLinha["Latitude anterior"] = trajetoLinha["LATITUDE"].shift()
    trajetoLinha["Longitude anterior"] = trajetoLinha["LONGITUDE"].shift()
    trajetoLinha['Hora anterior'] = trajetoLinha['DATAHORA'].shift()

    #Verificar a qual linha esse onibus roda 
    linhaPlacaOnibus = pd.read_sql('select Placa, Codigo from ONIBUS', connection)

    for placa in linhaPlacaOnibus['PLACA'].values:
        if placa == linhaOnibusCodigo:
            linhaOnibusBuscada = linhaPlacaOnibus.loc[linhaPlacaOnibus['PLACA'] == placa]['CODIGO'].values[0]
    
    
    if linhaOnibusBuscada == 'JRB160':
        LinhaAmarela.add_to(mapa)
    
    elif linhaOnibusBuscada == 'KLM415':
        LinhaVermelha.add_to(mapa)

    
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
                        "type": "MultiPoint",
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

    #Salvando o arquivo html e abrindo no navegador  
    mapa.save("mapaAplicacaoLinha.html")
    webbrowser.open("mapaAplicacaoLinha.html")

    return


#Função responsável por plotar os trajetos de onibus 
def linhasOnibus():

    #pegar as coordenadas das linhas e armazenar em um array? dataframe?
    coordenadas = pd.read_sql('select * from LOCALIZACAO', connection)

    #nome ; codigo -- dataFrame que contem todas as linhas existentes no BD
    linhas = pd.read_sql('select * from LINHA', connection)

    #Latitude ; Longitude ; codigo ; ordenação(?) -- contém todas as coordenadas dos pontos por codigo da linha
    pontosLinha = pd.read_sql('select * from PONTOS_LINHA', connection) 
    pontosLinha = pontosLinha.sort_values(['ORDENACAO'])
    
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

    
    return 


#linhasOnibus()
criaLinha('HAY1F47')

