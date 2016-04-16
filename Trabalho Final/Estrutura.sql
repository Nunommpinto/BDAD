DROP TRIGGER IF EXISTS EquipaSemNome;
DROP TRIGGER IF EXISTS SalarioMinimo;
DROP TRIGGER IF EXISTS defaultModalidade;

DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Atleta;
DROP TABLE IF EXISTS Socio;
DROP TABLE IF EXISTS ContratoDeSocio;
DROP TABLE IF EXISTS Treinador;
DROP TABLE IF EXISTS FuncionarioDeSaude;
DROP TABLE IF EXISTS Especializacao;
DROP TABLE IF EXISTS FuncionarioDeLimpeza;
DROP TABLE IF EXISTS CalendarioDeLimpeza;
DROP TABLE IF EXISTS GestorFinanceiro;
DROP TABLE IF EXISTS ComplexoDesportivo;
DROP TABLE IF EXISTS Modalidade;
DROP TABLE IF EXISTS Treino;
DROP TABLE IF EXISTS Equipa;
DROP TABLE IF EXISTS Jogo;
DROP TABLE IF EXISTS CheckupAtleta;
DROP TABLE IF EXISTS TreinoAtleta;
DROP TABLE IF EXISTS TreinadorDaModalidade;
DROP TABLE IF EXISTS AtletaDaModalidade;

CREATE TABLE Pessoa(
idPessoa	INTEGER ,
nome		CHAR(20) NOT NULL,
idade		INTEGER,
NIF 		INTEGER UNIQUE NOT NULL,
Morada	CHAR(20),
tipoDePessoa CHAR(20),

PRIMARY KEY (idPessoa)
);

CREATE TABLE Atleta(
idPessoa	INTEGER  REFERENCES Pessoa(idPessoa),
professional	BOOLEAN,
idEquipa	INTEGER,
CONSTRAINT fk_Equipa FOREIGN KEY(idEquipa) REFERENCES Equipa(idEquipa),

PRIMARY KEY (idPessoa)
);

CREATE TABLE Socio(
idPessoa	INTEGER   REFERENCES Pessoa(idPessoa),	

PRIMARY KEY (idPessoa)
);

CREATE TABLE ContratoDeSocio(
idContratoDeSocio	INTEGER ,
mensalidade		INTEGER CHECK(mensalidade > 0),

PRIMARY KEY (idContratoDeSocio)
);

CREATE TABLE Treinador(
idPessoa	INTEGER  REFERENCES Pessoa(idPessoa),
salario		INTEGER CHECK(salario > 0),

PRIMARY KEY (idPessoa)
);

CREATE TABLE FuncionarioDeSaude(
idPessoa		INTEGER  REFERENCES Pessoa(idPessoa),
salario			INTEGER CHECK(salario > 0),
 idEspecializacao	INTEGER,
CONSTRAINT fk_Especializacao FOREIGN KEY(idEspecializacao) REFERENCES Especializacao(idEspecializacao),

PRIMARY KEY (idPessoa)
);

CREATE TABLE Especializacao(
idEspecializacao	INTEGER ,
nome			CHAR(20) NOT NULL,

PRIMARY KEY (idEspecializacao)
);

CREATE TABLE FuncionarioDeLimpeza(
idPessoa	INTEGER REFERENCES Pessoa(idPessoa),
salario		INTEGER CHECK(salario > 0),

PRIMARY KEY (idPessoa)
);

CREATE TABLE CalendarioDeLimpeza(
idFuncionarioDeLimpeza INTEGER REFERENCES FuncionarioDeLimpeza(idFuncionarioDeLimpeza), 
idComplexoDesportivo INTEGER REFERENCES ComplexoDesportivo(idComplexoDesportivo),
DataDeLimpeza		CHAR(20),
hora				INTEGER,
CONSTRAINT pk_CalendarioDeLimpeza PRIMARY KEY(idFuncionarioDeLimpeza,idComplexoDesportivo)

);	

CREATE TABLE GestorFinanceiro(
idPessoa	INTEGER  REFERENCES Pessoa(idPessoa),
salario 		INTEGER,

PRIMARY KEY (idPessoa)
);

CREATE TABLE ComplexoDesportivo(
idComplexoDesportivo	INTEGER ,				
localizacao			CHAR(20) NOT NULL,
capacidade			INTEGER,

PRIMARY KEY (idComplexoDesportivo)
);


CREATE TABLE Modalidade(
idModalidade		INTEGER ,
nome			CHAR(20),
idComplexoDesportivo INTEGER,
CONSTRAINT fk_ComplexoDesportivo FOREIGN KEY(idComplexoDesportivo) REFERENCES ComplexoDesportivo(idComplexoDesportivo),

PRIMARY KEY (idModalidade)
);

CREATE TABLE Treino(
idTreino			INTEGER,
DataTreino			CHAR(80) NOT NULL,
hora				INTEGER NOT NULL,
idModalidade 			INTEGER, 
idEquipa 			INTEGER, 
idComplexoDesportivo 	INTEGER, 
 idPessoa 			INTEGER, 	
CONSTRAINT fk_Modalidade FOREIGN KEY(idModalidade)  REFERENCES Modalidade(idModalidade),
CONSTRAINT fk_Equipa FOREIGN KEY(idEquipa)  REFERENCES Equipa(idEquipa),
CONSTRAINT fk_ComplexoDesportivo FOREIGN KEY(idComplexoDesportivo) REFERENCES ComplexoDesportivo(idComplexoDesporrivo),
CONSTRAINT fk_Treinador FOREIGN KEY(idPessoa) REFERENCES Treinador(idPessoa),

PRIMARY KEY (idTreino)
);


CREATE TABLE Equipa(
idEquipa	INTEGER ,							
nome		CHAR(20),
idPessoa	 INTEGER,
CONSTRAINT fk_GestorFinanceiro FOREIGN KEY(idPessoa) REFERENCES GestorFinanceiro(idPessoa)
);

CREATE TABLE Jogo(
idJogo				INTEGER ,							
publico				BOOLEAN,
DataJogo			CHAR(20) NOT NULL,
hora				INTEGER NOT NULL,
idComplexoDesportivo  	INTEGER,
 idEquipa 			INTEGER,
CONSTRAINT fk_ComplexoDesportivo FOREIGN KEY(idComplexoDesportivo) REFERENCES ComplexoDesportivo(idComplexoDesportivo),
CONSTRAINT fk_Equipa FOREIGN KEY(idEquipa) REFERENCES Equipa(idEquipa),


PRIMARY KEY (idJogo)
);





CREATE TABLE CheckupAtleta(
idFuncionarioDeSaude INTEGER REFERENCES FuncionarioDeSaude(idFuncionarioDeSaude), 
idPessoa INTEGER REFERENCES Atleta(idPessoa),

CONSTRAINT pk_CheckupAtleta PRIMARY KEY(idFuncionarioDeSaude,idPessoa)
);

CREATE TABLE TreinoAtleta(
idTreino INTEGER REFERENCES Treino(idTreino),
 idPessoa INTEGER REFERENCES Atleta(idPessoa),

CONSTRAINT pk_TreinoAtleta PRIMARY KEY(idTreino,idPessoa)
);

CREATE TABLE TreinadorDaModalidade(
idPessoa INTEGER REFERENCES Treinador(idPessoa), 
idModalidade INTEGER REFERENCES Modalidade(idModalidade),

CONSTRAINT pk_TreinadorDaModalidade PRIMARY KEY(idPessoa,idModalidade)
);

CREATE TABLE AtletaDaModalidade(
idPessoa INTEGER REFERENCES Atleta(idPessoa),
 idModalidade INTEGER REFERENCES Modalidade(idModalidade),

CONSTRAINT pk_AtletaDaModalidade PRIMARY KEY(idPessoa, idModalidade)
);
