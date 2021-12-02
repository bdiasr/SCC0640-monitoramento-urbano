import cx_Oracle
import pandas as pd
import numpy as np

from folium import plugins
from branca.element import Figure
from folium.map import Popup, Tooltip

import conexao
from datetime import datetime


connection = conexao.conexao_client()
logins = pd.read_sql('select Login from USUARIO', connection)
senhas = pd.read_sql('select Login, Senha from USUARIO', connection)
emails = pd.read_sql('select Email from USUARIO', connection)


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
        newCPF = input("Digite seu CPF: ")

        insere_dados(newCPF, novousuario, email, novasenha)
        print("Usuário cadastrado com sucesso")



    else:
        print("Ops, por favor digite um número válido")
        menu()

def insere_dados(CPF, Login, Email, Senha):
    
    # construct an insert statement that add a new row to the billing_headers table
    sql = ('insert into USUARIO(CPF, Login, Email, Senha) '
        'values(:CPF,:Login,:Email,:Senha)')

    try:
        # establish a new connection
        with cx_Oracle.connect(conexao.username,
                            conexao.password,
                            conexao.dsn,
                            encoding=conexao.encoding) as connection:
            # create a cursor
            with connection.cursor() as cursor:
                # execute the insert statement
                cursor.execute(sql, [CPF, Login, Email, Senha])
                # commit work
                connection.commit()
    except cx_Oracle.Error as error:
        print('Error occurred:')
        print(error)


if __name__ == '__main__':
    insere_dados(datetime.now(), 1200, 1, None)

print("Olá bem vindo ao Busanca, o melhor aplicativo de ônibus da cidade!")

menu()