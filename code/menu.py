import cx_Oracle
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip
from pandas.core.tools.datetimes import to_datetime

import conexao
from datetime import datetime
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


logins = pd.read_sql('select Login from USUARIO', connection)
senhas = pd.read_sql('select Login, Senha from USUARIO', connection)
emails = pd.read_sql('select Email from USUARIO', connection)
cpfs = pd.read_sql('select CPF from PESSOA', connection)
rgss = pd.read_sql('select RG from PESSOA', connection)

#print(senhas)

def menu():
    loginExistente = False
    usuarioautenticado = False
    print("Escolha uma das opções abaixo")
    print("1 - Fazer login")
    print("2 - Se cadastrar")
    escolha = input()
    if escolha == "1":
        usuario = input("Digite seu usuário: ")
        senha = input("Digite sua senha: ")
        for login in senhas['LOGIN'].values:
            if usuario == login:
                loginExistente = True
                loginAtual = login
                senhaLogin = senhas.loc[senhas['LOGIN'] == loginAtual]['SENHA'].values[0]
                #print(senhaLogin)   
        if(loginExistente):
            if senha == senhaLogin:
                print("Usuário autenticado!")
                usuarioautenticado = True
            else:
                print("Senha incorreta!")
                menu()
        else:
            print("Login não existente! Realize seu cadastro!")
            menu()       
        
    elif escolha == "2":
        novousuario = input("Crie seu nome de usuário: ")
        for usu in senhas['LOGIN'].values:
            if novousuario == usu:
                print("Usuário já existe!")
                menu()
        novasenha = input("Crie sua senha: ")
        email = input("Digite seu email: ")

        for emai in emails['EMAIL'].values:
            if email == emai:
                print("Email já cadastrado!")
                menu()
        newCPF = input("Digite seu CPF: (Formato: NNN.NNN.NNN-NN) ")

        for cepf in cpfs['CPF'].values:
            if newCPF == cepf:
                print("CPF já cadastrado! Por favor, faça login!")
                menu()
        nome = input("Qual é seu nome COMPLETO? ")
        nasc = input("Que dia você nasceu? (Formato: dd/mm/aaaa) : ")
        newRG = input("Digite seu RG (Formato N.NNNN.NNNN): ")
        for rge in rgss['RG'].values:
            if newRG == rge:
                print("RG já cadastrado! Por favor, faça login!")
                menu()
        func = input("Você é funcionário? (S ou N)")
        if func == "S":
            funcval = "A"
        elif func == "N":
            funcval = "U"
        
        insere_dados_pessoa(newCPF, funcval, nome, nasc, newRG)
        insere_dados(newCPF, novousuario, email, novasenha)
        print("Usuário cadastrado com sucesso")


    else:
        print("Ops, por favor digite um número válido")
        menu()

#insere dados na tabela USUARIO 
def insere_dados(CPF, Login, Email, Senha):

    connection = cx_Oracle.connect(username, password, dsn)
    cursor = connection.cursor()

    #antes de add na tabela do usuário tem que add na tabela da pessoa 
    add_usuario = ("INSERT INTO USUARIO (CPF, Login, Email, Senha) "
                    'VALUES(:CPF, :Login, :Email, :Senha)')
    dados_usuario = (CPF, Login, Email, Senha)

    try:
        # establish a new connection
        with cx_Oracle.connect(username,password,dsn,
                                encoding=connection.encoding) as connection:
            # create a cursor
            with connection.cursor() as cursor:
                # execute the insert statement
                cursor.execute(add_usuario, CPF=CPF, Login=Login, Email=Email, Senha=Senha)         #testar dessa maneira
                # commit work  
                connection.commit()
    except cx_Oracle.Error as error:
            print('Error occurred:')
            print(error)


#Insere dados na tabela PESSOA 
def insere_dados_pessoa(CPF, TipoDePessoa, Nome, DataDeNasc, RG):

    connection = cx_Oracle.connect(username, password, dsn)
    cursor = connection.cursor()
    
     #antes de add na tabela do usuário tem que add na tabela da pessoa 
    add_pessoa = ("""INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG)
                    VALUES(:CPF, :TipoDePessoa, :Nome, to_date(:DataDeNasc, 'dd/mm/yyyy'), :RG)""")
    dados_pessoa = (CPF, TipoDePessoa, Nome, DataDeNasc, RG)

    try:
        # establish a new connection
        with cx_Oracle.connect(username,password,dsn,
                                encoding= connection.encoding) as connection:
            # create a cursor
            with connection.cursor() as cursor:
                # execute the insert statement
                cursor.execute(add_pessoa, dados_pessoa)
                connection.commit()
    except cx_Oracle.Error as error:
            print('Error occurred:')
            print(error)

    return

print("Olá bem vindo ao Busanca, o melhor aplicativo de ônibus da cidade!")

menu()


cursor.close()
connection.close()