import folium
import webbrowser
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip

import cx_Oracle

# Setando a conexão com o servidor 
#Cliente ORACLE -- esse endereço é o endereço que está o meu client no meu pc - bia 
cx_Oracle.init_oracle_client(lib_dir=r"D:\instantclient-basic-windows.x64-21.3.0.0.0\instantclient_21_3")
#Conexão 
ip = 'grad.icmc.usp.br'
port = 15215
SID = 'orcl'
dsn = cx_Oracle.makedsn(ip, port, SID)
# dados da conexão Usuário - Senha
username = 'J11317928'
password = 'bd992226'
connection = cx_Oracle.connect(username, password, dsn)
print(connection.version)

#Latitude e Longitude de onde queremos começar o mapa, no caso o escolhido foi a catedral de são Carlos 
sc_Latitude = -22.005080902589146
sc_Longitude = -47.88923382637606

#Criando o mapa
mapa = folium.Map(
    location=[sc_Latitude, sc_Longitude],
    zoom_start= 15.5
)

#posição dos onibus 

coords_onibus_Amarelo = [[-22.000633, -47.895713], [-21.997591,-47.897367]]
coords_onibus_Vermelho = []

#Coordenadas da linha amarela -- transformar o DF e cortar a tabela de datas 
coords_LinhaAmarela = [[[-22.005080902589146, -47.88923382637606], [-22.00506354983044, -47.889021235871716], [-22.005050751424008, -47.88822060280874]]]

#Coordenadas de todas as linhas - as list -> transformar pra pandas DataFrame?
coords_e_tempo_LinhaAmarela = [[-22.005080902589146, -47.88923382637606, '2017-06-02T00:00:00'], [-22.00506354983044, -47.889021235871716, '2017-06-02T00:10:00'], [-22.005050751424008, -47.88822060280874, '2017-06-02T00:20:00'], [-22.00537605671807, -47.888046273379516, '2017-06-02T00:30:00'], [-22.0058870669561, -47.88817382731898, '2017-06-02T00:40:00'], [-22.00506378858982, -47.88873889826529, '2017-06-02T00:50:00']]
coords_LinhaVermelha = [[-21.998466, -47.894341],]

#Transformar o array de coordenadas e tempo em um dataframe para que o Folium possa analisar 
df = pd.DataFrame(coords_e_tempo_LinhaAmarela, columns = ['Latitude', 'Longitude', 'Hora'])
df["Latitude anterior"] = df["Latitude"].shift()
df["Longitude anterior"] = df["Longitude"].shift()
df['Hora anterior'] = df['Hora'].shift()


#Criando grupos 
linhaAmarela = folium.FeatureGroup("Linha Amarela")
LinhaVermelha = folium.FeatureGroup("Linha Vermelha")

#Adicionando as linhas de onibus aos grupos
linha_Onibus_LinhaAmarela = folium.vector_layers.PolyLine(coords_LinhaAmarela, Popup='<b>Linha Amarela<b>', Tooltip="Linha Amarela",color='yellow').add_to(linhaAmarela)
linha_Onibus_LinhaVermelha = folium.vector_layers.PolyLine(coords_LinhaVermelha, Popup='<b>Linha Vermelha<b>', Tooltip="Linha Vermelha",color='red').add_to(LinhaVermelha)

#Gerando marcador Linha amarela no inicio da linha 
folium.Marker(location=[-22.005080902589146, -47.88923382637606], popup='Linha Amarela', tooltip='<strong>Linha Amarela</strong>', icon=folium.Icon(color='orange', prefix='fa', icon='bus')).add_to(linhaAmarela)
folium.Marker(location=[-21.998466, -47.894341], popup='Linha Vermelha', tooltip='<strong>Linha Vermelha</strong>', icon=folium.Icon(color='red', prefix='fa', icon='bus')).add_to(LinhaVermelha)

linhaAmarela.add_to(mapa)
LinhaVermelha.add_to(mapa)
folium.LayerControl().add_to(mapa)


# criação das Linhas a serem mostradas
#Ordem das coordenadas (Longitude, Latitude)
lines = []
features = []

for index, row in df.iloc[1:].iterrows():

    coordinates = [
        [
            row['Longitude anterior'], 
            row['Latitude anterior']
        ], 
        [
            row['Longitude'], 
            row['Latitude']
        ]
    ]
    times = [row['Hora anterior'], row['Hora']]
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
mapa.save("mapa_sc.html")
webbrowser.open("mapa_sc.html")