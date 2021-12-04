import cx_Oracle

import folium
import webbrowser
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip

import private 


def conexao_client():

    #Cliente ORACLE -- esse endereço é o endereço que está o meu client no meu pc - bia 
    cx_Oracle.init_oracle_client(lib_dir=r"D:\instantclient-basic-windows.x64-21.3.0.0.0\instantclient_21_3")

    #Conexão 
    ip = 'grad.icmc.usp.br'
    port = 15215
    SID = 'orcl'
    dsn = cx_Oracle.makedsn(ip, port, SID)
    #Usuário - Senha
    username = private.username()
    password = private.password()
    connection = cx_Oracle.connect(username, password, dsn)


    print(connection.version)

    cursor = connection.cursor()

    return connection
