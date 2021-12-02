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


criaLinha('HAY1F47')

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
    #print(coordenadas)
    return 

#trajeto()