--Consulta para verificar o atraso do onibus, possui a posição e a hora em que o onibus deve passar o ponto de onibus mais proximo da hora, e a ultima localização recebida pelo BD do onibus.
SELECT  HP.ONIBUS, HP.Latitude AS Lat_Ponto, HP.Longitude AS Lon_Ponto, AGR_MINUS_PADRAO , LC.Latitude AS Lat_Posicao, LC.Longitude AS Lon_Posicao, AGR_MINUS_LOCAL  
FROM
(SELECT Onibus, Latitude, Longitude, ABS(24*60*EXTRACT(Hour FROM Hora)+60*EXTRACT(MINUTE FROM hora)+EXTRACT(SECOND FROM hora)-(24*60*EXTRACT(Hour FROM SYSTIMESTAMP)+60*EXTRACT(MINUTE FROM SYSTIMESTAMP)+EXTRACT(SECOND FROM SYSTIMESTAMP))) AS AGR_MINUS_PADRAO
FROM HORARIO_PADRAO) HP
JOIN                        
(SELECT Onibus, Latitude, Longitude, ABS((24*60*EXTRACT(Hour FROM DataHora)+60*EXTRACT(MINUTE FROM Datahora)+EXTRACT(SECOND FROM Datahora))-(24*60*EXTRACT(Hour FROM SYSTIMESTAMP)+60*EXTRACT(MINUTE FROM SYSTIMESTAMP)+EXTRACT(SECOND FROM SYSTIMESTAMP))) AS AGR_MINUS_LOCAL 
FROM LOCALIZACAO) LC
ON LC.Onibus = HP.Onibus
WHERE HP.ONIBUS = 'HAY1F47' AND rownum = 1
ORDER BY AGR_MINUS_PADRAO, AGR_MINUS_LOCAL;           

--Ônibus + Turnos de Motorista + Turno de Cobrador: quem está no ônibus na hora
SELECT L.ONIBUS, M.Nome AS Motorista, C.Nome AS Cobrador 
FROM (SELECT A1.Nome, B1.CPF, B1.placa, B1.PontoEntrada From Pessoa A1 JOIN TURNO_MOTORISTA B1 ON A1.CPF = B1.CPF) M, 
     (SELECT A2.Nome, B2.CPF, B2.placa, B2.PontoEntrada From Pessoa A2 JOIN TURNO_COBRADOR B2 ON A2.CPF = B2.CPF) C, LOCALIZACAO L
WHERE L.ONIBUS = M.Placa AND L.Onibus = C.Placa AND L.Onibus = 'HAY1F47'   
ORDER BY ((24*60*EXTRACT(Hour FROM L.DataHora)+60*EXTRACT(MINUTE FROM L.DataHora)+EXTRACT(SECOND FROM L.DataHora))-(24*60*EXTRACT(Hour FROM SYSTIMESTAMP)+60*EXTRACT(MINUTE FROM SYSTIMESTAMP)+EXTRACT(SECOND FROM SYSTIMESTAMP))), ((24*60*EXTRACT(Hour FROM M.PontoEntrada)+60*EXTRACT(MINUTE FROM M.PontoEntrada)+EXTRACT(SECOND FROM M.PontoEntrada))-(24*60*EXTRACT(Hour FROM SYSTIMESTAMP)+60*EXTRACT(MINUTE FROM SYSTIMESTAMP)+EXTRACT(SECOND FROM SYSTIMESTAMP))), ((24*60*EXTRACT(Hour FROM C.PontoEntrada)+60*EXTRACT(MINUTE FROM C.PontoEntrada)+EXTRACT(SECOND FROM C.PontoEntrada))-(24*60*EXTRACT(Hour FROM SYSTIMESTAMP)+60*EXTRACT(MINUTE FROM SYSTIMESTAMP)+EXTRACT(SECOND FROM SYSTIMESTAMP)));


--Onde estão os ônibus de determinada empresa? (localização + ônibus)
SELECT O.CNPJ, L.Onibus, L.Latitude, L.Longitude, L.DataHora as Horario
FROM LOCALIZACAO L, ONIBUS O
WHERE L.ONIBUS = O.Placa AND EXTRACT(DAY FROM (SYSTIMESTAMP-L.DataHora)) = 0 AND EXTRACT(HOUR FROM (SYSTIMESTAMP-L.DataHora)) = 1 AND EXTRACT(MINUTE FROM (SYSTIMESTAMP-L.DataHora)) < 10
ORDER BY O.CNPJ, Horario;

---Verificar quais rotas fazem os ônibus que são acessíveis
SELECT DISTINCT OL.Codigo as CodigoLinha, OL.Nome, PLO.Latitude, PLO.Longitude, PLO.Ordenacao, OL.Adaptado
FROM (SELECT O.Adaptado, L.Nome, L.Codigo 
FROM ONIBUS O, LINHA L
WHERE O.Codigo = L.Codigo AND O.Adaptado = 'T') OL
JOIN
(SELECT PO.Latitude, PO.Longitude, PL.Codigo, PL.Ordenacao
FROM  PONTOS_LINHA PL, PONTO_ONIBUS PO 
WHERE PL.Latitude = PO.Latitude AND PL.Longitude = PO.Longitude) PLO
ON OL.Codigo = PLO.Codigo
ORDER BY CodigoLinha, PLO.Ordenacao;


--Consulta os endereços de garagens que pertence a duas empresa especificadas(DIVISAO DE GARAGEM POR SUBTABELA DE EMPRESA)
SELECT Endereco FROM GARAGEM
MINUS
SELECT Endereco FROM 
(SELECT A.Endereco,B.CNPJ FROM GARAGEM A, (SELECT CNPJ FROM EMPRESA WHERE CNPJ = '10.987.654/0001-32' OR CNPJ = '12.345.678/0001-91') B
MINUS 
SELECT Endereco,CNPJ FROM GARAGEM);

-- Em que horas passa alguns ônibus em determinado ponto de uma linha específica
SELECT L.Latitude, L.Longitude, H.Hora, H.Onibus
FROM ONIBUS O JOIN PONTOS_LINHA L ON O.Codigo = L.Codigo
JOIN HORARIO_PADRAO H ON H.Onibus = O.Placa
WHERE O.Codigo = 'KLM415' --Linha
ORDER BY Latitude, Longitude, H.Hora;

-- Consulta quantos onibus de uma determinada linha estao rodando naquele momento
SELECT O.Codigo as LinhaOni, count(*) as QuantidadeOnibus
FROM LOCALIZACAO L, ONIBUS O
WHERE L.ONIBUS = O.Placa AND EXTRACT(DAY FROM (SYSTIMESTAMP-L.DataHora)) = 0 AND EXTRACT(HOUR FROM (SYSTIMESTAMP-L.DataHora)) = 1 AND EXTRACT(MINUTE FROM (SYSTIMESTAMP-L.DataHora)) < 10
GROUP BY  O.Codigo;

-- Conferir se um administrador é usuário
SELECT * --U.CPF, U.email, U.Login, A.CNPJ
FROM USUARIO
NATURAL JOIN Adm;

-- Mostrar tabela de horários padrao de um ônibus específico 
SELECT *
FROM HORARIO_PADRAO
WHERE onibus = '';

-- Mostrar pontos de ônibus no mapa
SELECT Latitude, Longitude
FROM PONTO_ONIBUS;

-- Mostrar rotas no mapa
SELECT A.Latitude, A.Longitude, A.Codigo, B.Nome, A.Ordenacao
FROM PONTOS_LINHA A JOIN LINHA B
ON A.Codigo = B.Codigo
ORDER BY Codigo, Ordenacao;

