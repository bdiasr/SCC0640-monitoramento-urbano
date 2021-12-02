-- ADICIONANDO PESSOAS 
INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('111.111.111-11', 'U', 'Juliana Bernardes Freitas', TO_DATE('05/05/1999'), NULL);

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('123.456.789-10', 'A', 'Rafael Kuhn Takano', TO_DATE('29/05/2001'), '012.677.931-7');

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('790.018.618-77', 'F', 'Juliana Martins Le�ncio Eus�bio', TO_DATE('07/11/2000'), NULL);

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('124.890.179-12', 'U', 'Beatriz Helena Dias Rocha', TO_DATE('10/12/2000'), '0.0129.2120');

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('222.222.222-22', 'F', 'Adelaide Manoela da Silva Pinto', TO_DATE('04/07/1969'), '0.0000.7474');

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc, RG) 
            VALUES ('171.666.666-69', 'A', 'Larissa Manoela Taques Elias Santos', TO_DATE('28/12/2000'), '0.6666.6666');

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc,RG) 
            VALUES ('777.777.777-69', 'F', 'Albert Einstein', TO_DATE('14/03/1879'), '0.5555.6666');

INSERT INTO PESSOA (CPF, TipoDePessoa, Nome, DataDeNasc,RG) 
            VALUES ('333.333.333-33', 'F', 'Fausto Corr�a da Silva', TO_DATE('02/05/1950'), '0.3333.3333');

-- ADICIONANDO USU�RIOS
INSERT INTO USUARIO (CPF, Login, Email, Senha)
            VALUES ('111.111.111-11', 'julianabfreitas', 'julianabfreitas@usp.br', 'senhamuitosegura456!'); 

INSERT INTO USUARIO (CPF, Login, Email, Senha)
            VALUES ('123.456.789-10', 'rafael.takano', 'rafael.takano@usp.br', '$abacaxi524$'); 

INSERT INTO USUARIO (CPF, Login, Email, Senha) 
            VALUES ('124.890.179-12','beatrizhdr', 'beatrizhdr@usp.br', 'beatrizGatinha123');

INSERT INTO USUARIO (CPF, Login, Email, Senha)
            VALUES ('171.666.666-69', 'larissa-manoela', 'larissa-manoela@gmail.com', 'amocarrosel123s2'); 

-- ADICIONANDO EMPRESA   
INSERT INTO EMPRESA (CNPJ, Endereco)
            VALUES ('12.345.678/0001-91', 'Rua das Galinhas, Quadra 76, Lote 3, NR 93');

INSERT INTO EMPRESA (CNPJ, Endereco) 
            VALUES ('10.987.654/0001-32','Avenida dos Sonhos, Quadra 10, Lote 10, SN');

-- INSERINDO GARAGEM 

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('20','12.345.678/0001-91', 'Rua Dos Galos, Quadra 39, Lote 6, S/N');

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('50','10.987.654/0001-32', 'Rua do Desespero, Quadra 1, Lt 8, N 5');

-- INSERINDO OS FUNCIONARIOS 

INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('777.777.777-69','M', '12.345.678/0001-91');

INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('123.456.789-10', 'M', '10.987.654/0001-32');

INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('790.018.618-77','A','10.987.654/0001-32');

INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('222.222.222-22','A','12.345.678/0001-91');

INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('171.666.666-69','C', '10.987.654/0001-32');
            
INSERT INTO FUNCIONARIO (CPF, Cargos, CNPJ)
            VALUES ('333.333.333-33','C', '12.345.678/0001-91'); 
        
-- INSERINDO TIPOS DE FUNCIONARIO

INSERT INTO ADM(CPF)
            VALUES('790.018.618-77');

INSERT INTO ADM(CPF)
            VALUES('222.222.222-22');

INSERT INTO COBRADOR(CPF)
            VALUES('333.333.333-33');

INSERT INTO COBRADOR(CPF)
            VALUES('171.666.666-69');

INSERT INTO MOTORISTA(CPF, CNH)
            VALUES('123.456.789-10', '12345678910');

INSERT INTO MOTORISTA(CPF, CNH)
            VALUES('777.777.777-69', '01987654321');

-- INSERINDO LINHAS

INSERT INTO LINHA(Nome, Codigo)
            VALUES('Amarela' , 'JRB160');

INSERT INTO LINHA(Nome, Codigo)
            VALUES('Vermelha', 'KLM415');

-- INSERINDO PONTOS DE ONIBUS

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-22.000633,-47.895713,'Alameda dos Crisântemos, 504','PP');

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-21.998466,-47.894341,'Alameda das Hortências, 661','PF');

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-21.997591,-47.897367,'R. Amarela, 123','CC');

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-22.888477,-47.774342,'R. Vermelha, 123','CC');

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-22.200655,-47.900722,'R. Azul, 123','CC');

INSERT INTO PONTO_ONIBUS(Latitude, Longitude, Endereco, Tipo)
            VALUES(-22.700477,-47.400342,'R. Verde, 123','CC');

-- INSERINDO PONTOS LINHA

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.000633,-47.895713,'JRB160', 1);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-21.998466,-47.894341,'KLM415', 1);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-21.997591,-47.897367,'JRB160', 4);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.888477,-47.774342,'KLM415', 7);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.200655,-47.900722,'JRB160', 2);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.700477,-47.400342,'KLM415', 3);

-- INSERINDO ÔNIBUS 

INSERT INTO ONIBUS(Placa, PrecoPassagem, MaxPassageiros, Adaptado, Sensor, Codigo, Endereco, CNPJ)
            VALUES('OPGF47', 4.50 , 79, 'T','12345678ABCDEFGH','JRB160','Rua do Desespero, Quadra 1, Lt 8, N 5','10.987.654/0001-32');

INSERT INTO ONIBUS(Placa, PrecoPassagem, MaxPassageiros, Adaptado, Sensor, Codigo, Endereco, CNPJ)
            VALUES('HAY1F47', 3.00, 80, 'F','ABCDEFGH123456','KLM415','Rua Dos Galos, Quadra 39, Lote 6, S/N','12.345.678/0001-91');

INSERT INTO ONIBUS(Placa, PrecoPassagem, MaxPassageiros, Adaptado, Sensor, Codigo, Endereco, CNPJ)
            VALUES('ABCD123', 1.50 , 50, 'T','45645678ABCDEFGH','JRB160','Rua do Desespero, Quadra 1, Lt 8, N 5','10.987.654/0001-32');

INSERT INTO ONIBUS(Placa, PrecoPassagem, MaxPassageiros, Adaptado, Sensor, Codigo, Endereco, CNPJ)
            VALUES('EFGH456', 2.00, 60, 'T','ABCDEFGH123ABC','KLM415','Rua Dos Galos, Quadra 39, Lote 6, S/N','12.345.678/0001-91');

-- INSERINDO TURNO COBRADOR

INSERT INTO TURNO_COBRADOR(CPF, PontoEntrada, PontoSaida, Placa)
            VALUES('333.333.333-33', TO_TIMESTAMP('27-11-17 11:20:30', 'DD-MM-RR HH24:MI:SS'), NULL, 'OPGF47');

INSERT INTO TURNO_COBRADOR(CPF, PontoEntrada, PontoSaida, Placa)
            VALUES('171.666.666-69', TO_TIMESTAMP('27-11-17 19:07:43', 'DD-MM-RR HH24:MI:SS'), TO_TIMESTAMP('28-11-17 05:13:05', 'DD-MM-RR HH24:MI:SS'), 'HAY1F47');

-- INSERINDO TURNO MOTORISTA   

INSERT INTO TURNO_MOTORISTA(CPF, PontoEntrada, PontoSaida, Placa)
            VALUES('123.456.789-10', TO_TIMESTAMP('15/11/2021 14:16:54', 'DD-MM-RR HH24:MI:SS'), TO_TIMESTAMP('15/11/2021 18:07:43', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO TURNO_MOTORISTA(CPF, PontoEntrada, PontoSaida, Placa)
            VALUES('777.777.777-69', TO_TIMESTAMP('05/12/2021 20:13:54', 'DD-MM-RR HH24:MI:SS'), NULL, 'HAY1F47');

-- INSERINDO TURNO ADM

INSERT INTO TURNO_ADM(CPF, PontoEntrada, PontoSaida)
            VALUES('222.222.222-22', TO_TIMESTAMP('23/11/2021 10:24:02', 'DD-MM-RR HH24:MI:SS'), TO_TIMESTAMP('04/12/2021 21:32:17', 'DD-MM-RR HH24:MI:SS'));

INSERT INTO TURNO_ADM(CPF, PontoEntrada, PontoSaida)
            VALUES('790.018.618-77', TO_TIMESTAMP('04/12/2021 21:32:17', 'DD-MM-RR HH24:MI:SS'), NULL);


--INSERINDO LOCALIZA�AO

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-23.550128, -46.634043,TO_TIMESTAMP('27/11/2021 : 20:00:00', 'DD-MM-RR HH24:MI:SS'),'HAY1F47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-23.550128, -46.634043,TO_TIMESTAMP('27/11/2021 : 20:00:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-23.550128, -46.634043,TO_TIMESTAMP('30/11/2021 : 11:30:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005080, -47.889233,TO_TIMESTAMP('30/11/2021 : 12:30:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005063, -47.889021,TO_TIMESTAMP('30/11/2021 : 12:31:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005050, -47.888220,TO_TIMESTAMP('30/11/2021 : 12:32:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005376, -47.888046,TO_TIMESTAMP('30/11/2021 : 12:33:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005887, -47.888173,TO_TIMESTAMP('30/11/2021 : 12:34:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');

INSERT INTO LOCALIZACAO(Latitude, Longitude, DataHora, Onibus)
            VALUES(-22.005063, -47.888738,TO_TIMESTAMP('30/11/2021 : 12:35:00', 'DD-MM-RR HH24:MI:SS'),'OPGF47');


--INSERINDO HORARIO_PADRAO

INSERT INTO HORARIO_PADRAO (Latitude,Longitude,Onibus,Hora)
            VALUES(-22.000633,-47.895713,'OPGF47',TO_TIMESTAMP('01/01/2001 06:00:00','DD/MM/YYYY HH24:MI:SS'));

INSERT INTO HORARIO_PADRAO (Latitude,Longitude,Onibus,Hora)
            VALUES(-21.998466,-47.894341,'HAY1F47',TO_TIMESTAMP('01/01/2001 07:00:00','DD/MM/YYYY HH24:MI:SS'));            