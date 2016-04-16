--Numero de Socios
SELECT '############################################################';
SELECT '1.Quantos Socios existem';
SELECT ' ';

SELECT COUNT(*) FROM Pessoa 
WHERE idPessoa IN (SELECT idPessoa FROM
(SELECT * FROM Socio));

SELECT '############################################################';
SELECT ' ';

--atletas com idade superior a 25 que sao professionais e jogam na equipa 2
SELECT '############################################################';
SELECT '2.Selecionar os atletas com idade superior a 25 
que sao professionais e jogam na equipa 2';
SELECT ' ';

SELECT * FROM Pessoa 
WHERE idade >25 AND idPessoa IN (SELECT idPessoa FROM 
(SELECT * FROM Atleta WHERE professional='YES' AND idEquipa='2'));

SELECT '############################################################';
SELECT ' ';

--nome, nif e mensalidade do Socio com mesalidade igual ou superior a 10euros e que o nif contenha o numero 34
SELECT '############################################################';
SELECT '3.Nome, NIF e mensalidade do Socio com mesalidade 
igual ou superior a 10euros e que o NIF contenha o numero 34';
SELECT ' ';

SELECT DISTINCT nome,NIF,mensalidade FROM Pessoa,Socio,ContratoDeSocio
WHERE Pessoa.idPessoa=Socio.idPessoa 
AND NIF LIKE '%34%' AND mensalidade >= 10;

SELECT '############################################################';
SELECT ' ';

--nome do Socio cuja a morada contem o "do" , a sua idade seja superior a 30 e organiza por ordem decrescente da idade
SELECT '############################################################';
SELECT '4.Nome do Socio cuja a morada contem "do", a sua idade seja 
superior a 30 e organizar por ordem decrescente da idade';
SELECT ' ';

SELECT DISTINCT nome FROM Pessoa,Socio
WHERE Pessoa.idPessoa=Socio.idPessoa AND morada LIKE '%do%' AND idade > 30
ORDER BY idade DESC;

SELECT '############################################################';
SELECT ' ';

--idade media dos funcionarios de limpeza que trabalham as tercas-feiras
SELECT '############################################################';
SELECT '5.Idade media dos Funcionarios de Limpeza que 
trabalham as tercas-feiras';
SELECT ' ';

SELECT AVG(idade) FROM Pessoa 
WHERE idPessoa IN (SELECT idFuncionarioDeLimpeza FROM
(SELECT * FROM CalendarioDeLimpeza WHERE DataDeLimpeza='Tercas-Feiras'));

SELECT '############################################################';
SELECT ' ';

--Selecionar todos os socios e treinadores
SELECT '############################################################';
SELECT '6.Selecionar todos os Socios e Treinadores';
SELECT ' ';

SELECT nome FROM Pessoa,Socio
WHERE Pessoa.idPessoa = Socio.idPessoa
UNION
SELECT nome FROM Pessoa,Treinador
WHERE Pessoa.idPessoa = Treinador.idPessoa;

SELECT '############################################################';
SELECT ' ';

--seleciona id da funcionaria de limpeza Alice Novais
SELECT '############################################################';
SELECT '7.Qual e o id da Funcionaria de Limpeza Alice Novais';
SELECT ' ';

CREATE TEMP TABLE IF NOT EXISTS FuncionariosLimpeza AS
SELECT Pessoa.idPessoa, Pessoa.nome
FROM Pessoa, FuncionarioDeLimpeza
WHERE FuncionarioDeLimpeza.idPessoa = Pessoa.idPessoa
ORDER BY nome ASC;

SELECT DISTINCT Pessoa.idPessoa from Pessoa, FuncionarioDeLimpeza
WHERE Pessoa.nome IN (SELECT nome FROM FuncionarioDeLimpeza) 
AND Pessoa.nome = 'Alice Novais';

SELECT '############################################################';
SELECT ' ';

--o nome do funcionario de saude com salario maximo(organizado por nome)
SELECT '############################################################';
SELECT '8.O nome do Funcionario de Saude com salario maximo,
organizado por nome';
SELECT ' ';

SELECT nome FROM Pessoa,FuncionarioDeSaude WHERE 
Pessoa.idPessoa=FuncionarioDeSaude.idPessoa AND
FuncionarioDeSaude.salario = (SELECT MAX(salario) FROM FuncionarioDeSaude) 
GROUP BY nome;

SELECT '############################################################';
SELECT ' ';

--os nomes dos treinadores com idade maior do que a idade media dos treinadores (organizado por nome)
SELECT '############################################################';
SELECT '9.Os nomes dos treinadores com idade maior 
do que a idade media dos treinadores, organizado por nome';
SELECT ' ';

SELECT nome FROM Pessoa,Treinador 
WHERE Pessoa.idPessoa=Treinador.idPessoa AND
Pessoa.idade > (SELECT AVG(idade) FROM Pessoa,Treinador 
WHERE Pessoa.idPessoa=Treinador.idPessoa) 
GROUP BY nome;

SELECT '############################################################';
SELECT ' ';

--nome,idade dos Atletas que tiveram uma consulta com  o funcionario de saude Claudia Pinto e Pablo Cancela
SELECT '############################################################';
SELECT '10.Nome e idade dos Atletas que tiveram uma consulta 
com o Funcionario de Saude Claudia Pinto e Pablo Cancela';
SELECT ' ';

SELECT DISTINCT nome,idade FROM Pessoa,CheckupAtleta,Atleta,FuncionarioDeSaude
WHERE Pessoa.idPessoa=Atleta.idPessoa AND CheckupAtleta.idPessoa=Atleta.idPessoa
AND FuncionarioDeSaude.idPessoa IN 
(SELECT DISTINCT idFuncionarioDeSaude FROM Pessoa,FuncionarioDeSaude,CheckupAtleta 
WHERE Pessoa.idPessoa=FuncionarioDeSaude.idPessoa AND 
CheckupAtleta.idFuncionarioDeSaude=FuncionarioDeSaude.idPessoa AND
(nome='Claudia Pinto' OR nome='Pablo Cancela')) AND 
CheckupAtleta.idFuncionarioDeSaude=FuncionarioDeSaude.idPessoa;

SELECT '############################################################';
SELECT ' ';


--Atletas de futebol professionais maiores de 25 que jogam no CDP, tiveram treino na segunda e jogo no sabado
SELECT '############################################################';
SELECT '11.Atletas professionais com idade superior a 25 anos que 
jogam no CDP, tiveram treino na segunda e jogo no sabado';
SELECT ' ';

SELECT DISTINCT Pessoa.nome FROM Pessoa,Atleta,Treino,Equipa,Jogo
WHERE Pessoa.idPessoa=Atleta.idPessoa AND idade > 25
AND professional='YES' AND Equipa.idPessoa=Atleta.idPessoa 
AND Equipa.nome='CDP'
AND Treino.idPessoa=Pessoa.idPessoa AND DataTreino LIKE '%Segundas%'
AND Jogo.idEquipa=Equipa.idEquipa 
AND DataJogo='Sabados';

SELECT '############################################################';
SELECT ' ';

--Funcionarios de Limpeza que limpam o Complexo Desportivo da povoa de varzim as Tercas-Feiras 
SELECT '############################################################';
SELECT '12.Funcionarios de Limpeza que limpam 
o Complexo Desportivo da Povoa de Varzim as Tercas-Feiras  ';
SELECT ' ';

SELECT nome FROM Pessoa,FuncionarioDeLimpeza
WHERE Pessoa.idPessoa=FuncionarioDeLimpeza.idPessoa AND 
FuncionarioDeLimpeza.idPessoa IN(
SELECT idFuncionarioDeLimpeza FROM CalendarioDeLimpeza
WHERE DataDeLimpeza='Tercas-Feiras' and idComplexoDesportivo =
(SELECT idComplexoDesportivo FROM ComplexoDesportivo
WHERE localizacao='Povoa de Varzim'));

SELECT '############################################################';
SELECT ' ';
