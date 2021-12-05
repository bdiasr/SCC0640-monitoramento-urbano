CREATE TABLE PESSOA (
    CPF CHAR(14),
    TipoDePessoa CHAR(1), --F: Funcionário, U: Usuário, A: Usuário e Funcionária
    Nome VARCHAR2(50),
    DataDeNasc DATE,
    RG VARCHAR2(15),
        CONSTRAINT PK_PESSOA PRIMARY KEY (CPF),
        CONSTRAINT SK_PESSOA UNIQUE (RG),
        CONSTRAINT CK_TIPODEPESSOA CHECK (UPPER(TipoDePessoa) IN ('F', 'U', 'A')),
        CONSTRAINT CK_CPF CHECK (REGEXP_LIKE(CPF, '\d\d\d(.)\d\d\d(.)\d\d\d-\d\d'))
);


CREATE TABLE USUARIO (
    CPF CHAR(14),
    Login VARCHAR2(30) NOT NULL,
    Email VARCHAR2(320) NOT NULL,
    Senha VARCHAR2(128) NOT NULL,
        CONSTRAINT PK_USUARIO PRIMARY KEY (CPF),
        CONSTRAINT FK_USUARIO FOREIGN KEY (CPF)
                    REFERENCES PESSOA(CPF)
                    ON DELETE CASCADE,
        CONSTRAINT SK_USUARIO UNIQUE (Login),
        CONSTRAINT TK_USUARIO UNIQUE (Email), 
        CONSTRAINT CK_EMAIL CHECK (Email LIKE '%@%.%')         
);

CREATE TABLE EMPRESA(
    CNPJ CHAR(19),
    Endereco VARCHAR2(255),
        CONSTRAINT PK_EMPRESA  PRIMARY KEY (CNPJ),
        CONSTRAINT CK_CNPJ CHECK (REGEXP_LIKE(CNPJ, '\d\d(.)\d\d\d(.)\d\d\d' || '/' || '000(1|2)-\d\d'))  
);

CREATE TABLE GARAGEM(
    QuantidadeMaxOnibus INTEGER, 
    CNPJ CHAR(19),
    Endereco VARCHAR2(255),
        CONSTRAINT PK_GARAGEM PRIMARY KEY (Endereco, CNPJ), 
        CONSTRAINT FK_GARAGEM FOREIGN KEY (CNPJ)
                    REFERENCES EMPRESA(CNPJ)
                    ON DELETE CASCADE,
        CONSTRAINT CK_MAXONIBUS CHECK (QuantidadeMaxOnibus > 0)  
);

CREATE TABLE FUNCIONARIO (
    CPF CHAR(14),
    Cargos CHAR(1) NOT NULL, --C: Cobrador, M: Motorista, A: Administrador
    CNPJ CHAR(19) NOT NULL,
        CONSTRAINT PK_FUNCIONARIO PRIMARY KEY (CPF),
        CONSTRAINT FK1_FUNCIONARIO FOREIGN KEY (CPF)
                    REFERENCES PESSOA(CPF)
                    ON DELETE CASCADE,
        CONSTRAINT FK2_FUNCIONARIO FOREIGN KEY (CNPJ)
                    REFERENCES EMPRESA(CNPJ)
                    ON DELETE CASCADE,
        CONSTRAINT CK_FUNCIONARIO CHECK (UPPER(Cargos) IN ('C', 'M', 'A'))
);

CREATE TABLE ADM(
    CPF CHAR(14),
        CONSTRAINT PK_ADM PRIMARY KEY (CPF),
        CONSTRAINT FK_ADM FOREIGN KEY (CPF)
                    REFERENCES FUNCIONARIO(CPF)
                    ON DELETE CASCADE
);

CREATE TABLE COBRADOR(
    CPF CHAR(14),
        CONSTRAINT  PK_COBRADOR PRIMARY KEY (CPF),
        CONSTRAINT  FK_COBRADOR FOREIGN KEY(CPF)
                    REFERENCES FUNCIONARIO(CPF)
                    ON DELETE CASCADE
);


CREATE TABLE MOTORISTA(
    CPF CHAR(14),
    CNH CHAR(11) NOT NULL,
        CONSTRAINT PK_MOTORISTA PRIMARY KEY (CPF),
        CONSTRAINT FK_MOTORISTA FOREIGN KEY(CPF)
                    REFERENCES FUNCIONARIO(CPF)
                    ON DELETE CASCADE,
        CONSTRAINT SK_CNH UNIQUE (CNH),
        CONSTRAINT CK_CNH CHECK (REGEXP_LIKE(CNH, '\d\d\d\d\d\d\d\d\d\d\d'))
);


CREATE TABLE LINHA(
    Nome VARCHAR2(20),
    Codigo CHAR(6), --Codigo da linha: 3 letras e 3 numeros, Ex: AAA999
        CONSTRAINT PK_LINHA PRIMARY KEY (Codigo),
        CONSTRAINT CK_CODIGO CHECK (REGEXP_LIKE(Codigo, '\w\w\w\d\d\d'))
);


CREATE TABLE PONTO_ONIBUS(
    Latitude NUMBER(8,6), --de -90 a +90
    Longitude NUMBER(9,6), --de -180 a +180
    Endereco VARCHAR2(255),
    Tipo CHAR(2), --CC: Chapeu chines,ET: estação tubo,PP: placa em poste,NI: não informado, PF: plataforma. 
        CONSTRAINT PK_PONTO_ONIBUS PRIMARY KEY (Latitude, Longitude),
        CONSTRAINT CK_LAT_PONTO_ONIBUS CHECK (Latitude < 90 AND Latitude > -90),
        CONSTRAINT CK_LON_PONTO_ONIBUS CHECK (Longitude < 180 AND Longitude > -180),
        CONSTRAINT CK_TIPO_PONTO_ONIBUS CHECK (UPPER(Tipo) IN ('CC', 'ET', 'PP', 'NI', 'PF'))
);

CREATE TABLE PONTOS_LINHA(
    Latitude NUMBER(8,6), --de -90 a +90
    Longitude NUMBER(9,6), --de -180 a +180
    Codigo CHAR(6), --Codigo da linha: 3 letras e 3 numeros, Ex: AAA999
    Ordenacao INTEGER NOT NULL,
        CONSTRAINT CK_ORDENACAO CHECK (Ordenacao > 0),
        CONSTRAINT PK_PONTOS_LINHA PRIMARY KEY (Latitude, Longitude, Codigo),
        CONSTRAINT SK_PONTOS_LINHA UNIQUE (Codigo, Ordenacao),
        CONSTRAINT FK1_PONTOS_LINHA FOREIGN KEY (Latitude, Longitude)
                    REFERENCES PONTO_ONIBUS(Latitude, Longitude)
                    ON DELETE CASCADE,
        CONSTRAINT FK2_PONTOS_LINHA FOREIGN KEY (Codigo)
                    REFERENCES LINHA (Codigo)
                    ON DELETE CASCADE
);


CREATE TABLE ONIBUS (
    Placa CHAR(7),
    PrecoPassagem NUMBER(5,2),
    MaxPassageiros INTEGER,
    AceitaCartao CHAR(1), --T: True, F: False
    TipoOnibus CHAR(2), --MC: micro-ônibus, MN: mini-ônibus, MD: midi-ônibus, BS: ônibus básico, OP: ônibus padron, OA: ônibus articulado, BA: ônibus biarticulado   
    Adaptado CHAR(1), --T: True, F: False
    Wifi CHAR(1), --T: True, F: False
    ArCondicionado CHAR(1), --T: True, F: False
    Sensor CHAR(16) NOT NULL, --Numero de serie do sensor em questÃ£o
    Codigo CHAR(6), --Codigo da linha: 3 letras e 3 numeros, Ex: AAA999
    Endereco VARCHAR2(255), 
    CNPJ CHAR(19),
        CONSTRAINT PK_ONIBUS PRIMARY KEY (Placa),
        CONSTRAINT SK_ONIBUS UNIQUE (Sensor),
        CONSTRAINT FK1_ONIBUS FOREIGN KEY (Codigo)
                    REFERENCES LINHA(Codigo)
                    ON DELETE SET NULL,
        CONSTRAINT FK2_ONIBUS FOREIGN KEY (CNPJ, Endereco)
                    REFERENCES GARAGEM(CNPJ, Endereco)
                    ON DELETE SET NULL,
        CONSTRAINT CK_PRECO CHECK (PrecoPassagem > 0),
        CONSTRAINT CK_MAXPASSAGEIROS CHECK (MaxPassageiros > 0),
        CONSTRAINT CK_ACEITACARTAO CHECK (UPPER(AceitaCartao) IN ('T', 'F')),
        CONSTRAINT CK_TIPO_ONIBUS CHECK (UPPER(TipoOnibus) IN ('MC', 'MN', 'MD', 'BS', 'OP', 'OA', 'BA')),  
        CONSTRAINT CK_ADAPTADO  CHECK (UPPER(Adaptado) IN ('T', 'F')),
        CONSTRAINT CK_WIFI  CHECK (UPPER(Wifi) IN ('T', 'F')),
        CONSTRAINT CK_ARCONDICIONADO  CHECK (UPPER(ArCondicionado) IN ('T', 'F'))
);

CREATE TABLE TURNO_COBRADOR (
    CPF CHAR(14), 
    PontoEntrada TIMESTAMP, 
    PontoSaida TIMESTAMP,
    Placa CHAR(7) NOT NULL,
        CONSTRAINT PK_TURNO_COBRADOR PRIMARY KEY (CPF, PontoEntrada),
        CONSTRAINT FK1_TURNO_COBRADOR FOREIGN KEY (CPF)
                    REFERENCES COBRADOR (CPF)
                    ON DELETE CASCADE,
        CONSTRAINT SK_TURNO_COBRADOR UNIQUE (Placa, PontoEntrada),
        CONSTRAINT FK2_TURNO_COBRADOR FOREIGN KEY (Placa)
                    REFERENCES ONIBUS (Placa)
                    ON DELETE CASCADE,
        CONSTRAINT CHECK_PONTOS_COBRADOR CHECK (PontoSaida > PontoEntrada)

);


CREATE TABLE TURNO_MOTORISTA(
    CPF CHAR(14), 
    PontoEntrada TIMESTAMP, 
    PontoSaida TIMESTAMP,
    Placa CHAR(7) NOT NULL,
        CONSTRAINT  PK_TURNO_MOTORISTA PRIMARY KEY (CPF, PontoEntrada),
        CONSTRAINT  FK1_TURNO_MOTORISTA FOREIGN KEY (CPF)
                    REFERENCES MOTORISTA (CPF)
                    ON DELETE CASCADE,
        CONSTRAINT  SK_TURNO_MOTORISTA UNIQUE (Placa, PontoEntrada),
        CONSTRAINT  FK2_TURNO_MOTORISTA FOREIGN KEY (Placa)
                    REFERENCES ONIBUS (Placa)
                    ON DELETE CASCADE,
        CONSTRAINT CHECK_PONTOS_MOTORISTA CHECK (PontoSaida > PontoEntrada)
);

CREATE TABLE TURNO_ADM (
    CPF CHAR(14),
    PontoEntrada TIMESTAMP,
    PontoSaida TIMESTAMP,
        CONSTRAINT PK_TURNO_ADM  PRIMARY KEY (CPF, PontoEntrada),
        CONSTRAINT FK_TURNO_ADM  FOREIGN KEY (CPF)
                    REFERENCES  ADM(CPF)
                    ON DELETE CASCADE,
        CONSTRAINT CHECK_PONTOS_ADM CHECK (PontoSaida > PontoEntrada)
);

CREATE TABLE LOCALIZACAO (
    Latitude NUMBER(8,6), --de -90 a +90
    Longitude NUMBER(9,6), --de -180 a +180
    DataHora TIMESTAMP,
    Onibus CHAR(7), -- Placa do onibus  
        CONSTRAINT PK_LOCALIZACAO PRIMARY KEY (DataHora, Onibus), 
        CONSTRAINT FK_LOCALIZACAO FOREIGN KEY (Onibus)
                        REFERENCES ONIBUS(Placa)
                        ON DELETE CASCADE,
        CONSTRAINT CK_LAT_LOCALIZACAO CHECK (Latitude < 90 AND Latitude > -90),
        CONSTRAINT CK_LON_LOCALIZACAO CHECK (Longitude < 180 AND Longitude > -180)            
);

CREATE TABLE HORARIO_PADRAO ( 
    Latitude NUMBER(8,6) NOT NULL, --de -90 a +90
    Longitude NUMBER(9,6) NOT NULL, --de -180 a +180
    Onibus CHAR(7),
    Hora TIMESTAMP,
        CONSTRAINT PK_HORARIO_PADRAO PRIMARY KEY (Latitude,Longitude,Onibus,Hora),
        CONSTRAINT FK1_HORARIO_PADRAO FOREIGN KEY (Latitude,Longitude)
                        REFERENCES PONTO_ONIBUS(Latitude,Longitude)
                        ON DELETE CASCADE,
        CONSTRAINT FK2_HORARIO_PADRAO FOREIGN KEY (Onibus)
                        REFERENCES ONIBUS(Placa)
                        ON DELETE CASCADE
);

COMMIT;