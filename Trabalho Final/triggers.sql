--Se um Funcionario De Limpeza ao ser criado tiver um salario inferior ao salario minimo ocorre um ABORT
CREATE TRIGGER SalarioMinimo
BEFORE INSERT ON FuncionarioDeLimpeza
FOR EACH ROW
BEGIN
	SELECT CASE 
		WHEN NEW.salario <= 589.17
	THEN RAISE(ABORT, 'Salario invalido')
END; 
END;
/*Teste para SalarioMinimo*/
/*INSERT INTO FuncionarioDeLimpeza (idPessoa,salario) VALUES (40,580);
INSERT INTO FuncionarioDeLimpeza (idPessoa,salario) VALUES (41,1000);
SELECT * FROM FuncionarioDeLimpeza;*/

--Se uma modalidade tiver nome NULL, este por defeito sera futebol
CREATE TRIGGER defaultModalidade
AFTER INSERT ON Modalidade
FOR EACH ROW
	WHEN (NEW.nome ISNULL)
		BEGIN
		UPDATE Modalidade SET nome = 'Futebol';
END;
/*Teste para defaultModalidade*/
/*INSERT INTO Modalidade(nome,idComplexoDesportivo) VALUES (NULL,1);
SELECT * FROM Modalidade;*/

--Se uma equipa ao ser inserida nao tiver nome ela é apagada
CREATE TRIGGER EquipaSemNome
AFTER INSERT ON Equipa
FOR EACH ROW
	WHEN (NEW.nome ISNULL)
		BEGIN
		DELETE FROM Equipa WHERE (SELECT idEquipa FROM Equipa
		WHERE idEquipa=NEW.idEquipa);
END;
/*Teste para EquipaSemNome*/
/*INSERT INTO Equipa (idEquipa,nome,idPessoa) VALUES (3,NULL,14);
INSERT INTO Equipa (idEquipa,nome,idPessoa) VALUES (3,'Porto',14);
SELECT * FROM Equipa;*/