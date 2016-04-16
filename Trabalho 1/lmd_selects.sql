--SELECTS

/*
*Todas as pessoas
*/
SELECT * FROM Pessoa;

/*
*Atletas professionais
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idPessoa FROM (SELECT * FROM Atleta WHERE professional='YES'));

/*
*Atletas nao professionais
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idPessoa FROM (SELECT * FROM Atleta WHERE professional='NO'));
/*
*Atletas da equipa 1
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idPessoa FROM (SELECT * FROM Atleta WHERE idEquipa=1));
/*
*Atletas da equipa 2
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idPessoa FROM (SELECT * FROM Atleta WHERE idEquipa=2));
/*
*Atletas da equipa 2 que sao professionais
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idPessoa FROM (SELECT * FROM Atleta WHERE idEquipa=2 and professional='YES'));

/*
*Funcionarios de limpeza que trabalham ao segunda
*/
SELECT * FROM Pessoa WHERE idPessoa in (SELECT idFuncionarioDeLimpeza FROM (SELECT * FROM CalendarioDeLimpeza WHERE DataDeLimpeza='Tercas-Feiras'));
