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

INSERT INTO EMPRESA (CNPJ, Endereco) 
            VALUES ('10.923.654/0001-59','Rua Nove de Julho, Quadra 10, Lote 10, SN');
-- INSERINDO GARAGEM 

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('20','12.345.678/0001-91', 'Rua Dos Galos, Quadra 39, Lote 6, S/N');

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('50','10.987.654/0001-32', 'Rua do Desespero, Quadra 1, Lt 8, N 5');

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('20','10.987.654/0001-32', 'Rua Dos Galos, Quadra 39, Lote 6, S/N');

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('50','12.345.678/0001-91', 'Rua do Desespero, Quadra 1, Lt 8, N 5');

INSERT INTO GARAGEM (QuantidadeMaxOnibus, CNPJ, Endereco)
            VALUES ('100', '10.923.654/0001-59', 'Rua dos Bobos, Quadra 41, Lt 4, N 0');

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

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.00774, -47.892528);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.007297, -47.893623);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.005746, -47.896081);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.003703, -47.896125);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.004390, -47.893276);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.004433, -47.892124);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.004259, -47.892139);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.003402, -47.896168);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.002438, -47.896147);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.002461, -47.895830);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.002880, -47.893277);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.002736, -47.893084);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-21.999394, -47.892961);
    
INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-21.999451, -47.891554);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.001429, -47.891440);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.001374, -47.892314);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.003032, -47.892389);
        
INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.003507, -47.892058);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.004979, -47.892004);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.006279, -47.891968);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.007866, -47.891928);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.007741, -47.892528);
            
INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.017878, -47.890744);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.016811, -47.890707);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.016019, -47.890744);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.015072, -47.890725);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.015140, -47.892620);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.015158, -47.897820);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.012334, -47.897876);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.011421, -47.897894);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.011438, -47.900624);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.012334, -47.900624);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.012368, -47.899807);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.014268, -47.899783);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.014287, -47.898773);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.015190, -47.898755);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.015157, -47.895760);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.016930, -47.895715);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.016906, -47.894732);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.017900, -47.894694);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.017877, -47.893704);

INSERT INTO PONTO_ONIBUS(Latitude, Longitude)
            VALUES(-22.017883, -47.891017);

-- INSERINDO PONTOS LINHA

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.00774, -47.892528,'KLM415', 1);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.007297, -47.893623,'KLM415', 2);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.005746, -47.896081,'KLM415', 3);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.003703, -47.896125,'KLM415', 4);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.004390, -47.893276,'KLM415', 5);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.004433, -47.892124,'KLM415', 6);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.004259, -47.892139,'KLM415', 7);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.003402, -47.896168,'KLM415', 8);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.002438, -47.896147,'KLM415', 9);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.002461, -47.895830,'KLM415', 10);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.002880, -47.893277,'KLM415', 11);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.002736, -47.893084,'KLM415', 12);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-21.999394, -47.892961,'KLM415', 13);
    
INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-21.999451, -47.891554,'KLM415', 14);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.001429, -47.891440,'KLM415', 15);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.001374, -47.892314,'KLM415', 16);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.003032, -47.892389,'KLM415', 17);
        
INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.003507, -47.892058,'KLM415', 18);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.004979, -47.892004,'KLM415', 19);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.006279, -47.891968,'KLM415', 20);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.007866, -47.891928,'KLM415', 21);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.007741, -47.892528,'KLM415', 22);
            
INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.017878, -47.890744,'JRB160', 1);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.016811, -47.890707,'JRB160', 2);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.016019, -47.890744,'JRB160', 3);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.015072, -47.890725,'JRB160', 4);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.015140, -47.892620,'JRB160', 5);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.015158, -47.897820,'JRB160', 6);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.012334, -47.897876,'JRB160', 7);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.011421, -47.897894,'JRB160', 8);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.011438, -47.900624,'JRB160', 9);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.012334, -47.900624,'JRB160', 10);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.012368, -47.899807,'JRB160', 11);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.014268, -47.899783,'JRB160', 12);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.014287, -47.898773,'JRB160', 13);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.015190, -47.898755,'JRB160', 14);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.015157, -47.895760,'JRB160', 15);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.016930, -47.895715,'JRB160', 16);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.016906, -47.894732,'JRB160', 17);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.017900, -47.894694,'JRB160', 18);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.017877, -47.893704,'JRB160', 19);

INSERT INTO PONTOS_LINHA(Latitude, Longitude, Codigo, Ordenacao)
            VALUES(-22.017883, -47.891017,'JRB160', 20);

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
            VALUES(-22.017878, -47.890744,'OPGF47',TO_TIMESTAMP('01/01/2001 06:00:00','DD/MM/YYYY HH24:MI:SS'));

INSERT INTO HORARIO_PADRAO (Latitude,Longitude,Onibus,Hora)
            VALUES(-22.00774, -47.892528,'HAY1F47',TO_TIMESTAMP('01/01/2001 07:00:00','DD/MM/YYYY HH24:MI:SS'));

COMMIT;            