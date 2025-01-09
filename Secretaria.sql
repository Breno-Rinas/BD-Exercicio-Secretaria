create database Secretaria;
use Secretaria;

create table cidade(
cod_cidade int not null auto_increment primary key,
nome varchar(50) not null,
uf char(2)
);

insert into cidade(nome, uf) value("Marcelino Ramos", "RS");
insert into cidade(nome, uf) value("Paulo Bento", "RS");
insert into cidade(nome, uf) value("Erechim", "RS");
insert into cidade(nome, uf) value("Barão de Cotegipe", "RS");
insert into cidade(nome, uf) value("Passo Fundo", "RS");

create table curso(
cod_curso int not null auto_increment primary key,
nome_curso varchar(50) not null
);

insert into curso(nome_curso) value("Informática");
insert into curso(nome_curso) value("Mecatrônica");
insert into curso(nome_curso) value("Técnico em alimentos");
insert into curso(nome_curso) value("Técnico em agropecuária");
insert into curso(nome_curso) value("Engenharia");

create table disciplina(
cod_disciplina int not null auto_increment primary key,
nome_disciplina varchar(50) not null,
numero_credito int not null
);

insert into disciplina(nome_disciplina, numero_credito) value("Matemática", 4);
insert into disciplina(nome_disciplina, numero_credito) value("Geografia", 1);
insert into disciplina(nome_disciplina, numero_credito) value("História", 3);
insert into disciplina(nome_disciplina, numero_credito) value("Artes", 5);
insert into disciplina(nome_disciplina, numero_credito) value("Filosofia", 5);


create table professores(
cod_professor int not null auto_increment primary key,
nome_professor varchar(50) not null
);

insert into professores(nome_professor) value("Josmar");
insert into professores(nome_professor) value("Enivaldo");
insert into professores(nome_professor) value("Cleiton");
insert into professores(nome_professor) value("Maria");
insert into professores(nome_professor) value("Edilene");


create table alunos(
cod_matricula int not null auto_increment primary key,
nome_aluno varchar(50) not null,
nascimento date not null,
sexo char(1),
endereco varchar(100) not null,
cod_cidade int NOT NULL,
CONSTRAINT cidade_cod_cidade_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade), 
cep int(8) not null,
CI varchar(20) not null, 
CPF bigint(11) not null,
cod_curso  int NOT NULL,
CONSTRAINT curso_cod_curso_fk
FOREIGN KEY (cod_curso)
REFERENCES curso (cod_curso)
);

insert into alunos(nome_aluno, nascimento, sexo, endereco, cod_cidade, cep, CI, CPF, cod_curso) value ('Breno', '2005.09.15', 'M', 'Linha 4 - Gramado', 1, 77006190, 87655987, 81166612308, 1); 
insert into alunos(nome_aluno, nascimento, sexo, endereco, cod_cidade, cep, CI, CPF, cod_curso) value ('Alex', '2004.12.12', 'M', 'Bairro do Limoeiro', 2, 89106114, 32149696, 31266732100, 2); 
insert into alunos(nome_aluno, nascimento, sexo, endereco, cod_cidade, cep, CI, CPF, cod_curso) value ('Mircos', '2003.03.11', 'M', 'Bairro do Bode', 3, 97856430, 65798542, 76558987641, 3); 
insert into alunos(nome_aluno, nascimento, sexo, endereco, cod_cidade, cep, CI, CPF, cod_curso) value ('Letícia', '2006.07.21', 'F', 'Bairro Grande', 4, 87890965, 36548764, 09807658087, 4); 
insert into alunos(nome_aluno, nascimento, sexo, endereco, cod_cidade, cep, CI, CPF, cod_curso) value ('Janisse', '2000.03.01', 'F', 'Bairro do Jacaré', 5, 67459875, 87453782, 22096854, 5); 

create table historico(
cod_historico int not null auto_increment primary key,
cod_matricula int NOT NULL,
CONSTRAINT alunos_cod_matricula_fk
FOREIGN KEY (cod_matricula)
REFERENCES alunos (cod_matricula),
cod_disciplina int NOT NULL,
CONSTRAINT disciplina_cod_disciplina_fk
FOREIGN KEY (cod_disciplina)
REFERENCES disciplina (cod_disciplina),
nota decimal not null,
ano_semestre int not null
);

insert into historico(cod_matricula, cod_disciplina, nota, ano_semestre) value("1", "1", 7, 1);
insert into historico(cod_matricula, cod_disciplina, nota, ano_semestre) value("1", "2", 2, 2);
insert into historico(cod_matricula, cod_disciplina, nota, ano_semestre) value("2", "3", 9, 1);
insert into historico(cod_matricula, cod_disciplina, nota, ano_semestre) value("2", "5", 5, 2);
insert into historico(cod_matricula, cod_disciplina, nota, ano_semestre) value("3", "4", 9, 1);


create table prof_disc(
cod_profdisc int not null auto_increment primary key,
cod_disciplina int NOT NULL,
CONSTRAINT disciplina_cod_disciplina_fk
FOREIGN KEY (cod_disciplina)
REFERENCES disciplina (cod_disciplina),
cod_professor int NOT NULL,
CONSTRAINT professores_cod_professor_fk
FOREIGN KEY (cod_professor)
REFERENCES preofessores (cod_professor)
);

insert into prof_disc(cod_disciplina, cod_professor) value("1", "1");

insert into prof_disc(cod_disciplina, cod_professor) value("2", "2");
insert into prof_disc(cod_disciplina, cod_professor) value("3", "3");
insert into prof_disc(cod_disciplina, cod_professor) value("4", "4");
insert into prof_disc(cod_disciplina, cod_professor) value("5", "5");


/*2 Gerar lista dos nomes dos alunos qual nota deve estar entre 5.5 e 10, organize em ordem crescente. (Maria)*/
select nome_aluno, historico.nota from alunos inner join historico on alunos.cod_matricula = historico.cod_historico where historico.nota between 5.5 and 10 order by nota desc;

/*3 -Selecione o nome do aluno que comece com K, o nome e o código do curso e a sua nota. OBS troquei K por B */
select nome_aluno, curso.nome_curso, curso.cod_curso, historico.nota from alunos inner join curso on alunos.cod_curso=curso.cod_curso inner join historico on alunos.cod_matricula=historico.cod_matricula where alunos.nome_aluno like 'B%';

/*4 - Selecione o nome do aluno cujo tem a cidade igual a tabela cidade e que seu nome começa com A.*/
select nome_aluno, cidade.nome from alunos inner join cidade on alunos.cod_cidade=cidade.cod_cidade where alunos.nome_aluno like 'A%';

/*5 - Selecione o nome do aluno, nome do curso, data de nascimento e a disciplina dos alunos que tem a cidade com as iniciais em "ER". (Luis)*/
select nome_aluno, curso.nome_curso, nascimento, disciplina.nome_disciplina from alunos inner join curso on alunos.cod_curso = curso.cod_curso inner join disciplina on disciplina.cod_disciplina = curso.cod_curso inner join cidade on alunos.cod_cidade = cidade.cod_cidade where cidade.nome like 'ER%';

/*7 - Selecione o nome da disciplina, o semestre e a nota daquele período para os alunos que tenham uma nota maior que 7.*/
select nome_disciplina , historico.ano_semestre, historico.nota from disciplina inner join historico on historico.cod_disciplina=disciplina.cod_disciplina where historico.nota > 7;

/*8 - Selecione o nome das disciplinas e o nome do curso cujo ID seja 2, ordene por nome de disciplina.*/
select nome_disciplina, curso.nome_curso from disciplina inner join curso on curso.cod_curso = disciplina.cod_disciplina where curso.cod_curso = 2 order by (nome_disciplina);

/*9 - Selecione o nome e curso dos alunos cujo nome comece com M.*/
select alunos.nome_aluno, curso.nome_curso from alunos inner join curso on alunos.cod_matricula=curso.cod_curso where nome_aluno like 'M%';

/*10 - Liste o nome , a data de nascimento, o CPF, nome do curso dos alunos do sexo feminino em que o código corresponde a 1. OBS: Troquei pelo código 4*/
select nome_aluno, nascimento, CPF, curso.nome_curso from alunos inner join curso on alunos.cod_curso=curso.cod_curso where sexo = 'F' and cod_matricula = 4;

/*11 - Selecione nome, endereço, CPF, nome do curso, nota e ano da tabela histórico onde o código de matrícula for entre 1 e 3 e ordenado por nota.*/
select nome_aluno , endereco, CPF, curso.nome_curso, historico.nota, historico.ano_semestre from alunos inner join curso on alunos.cod_curso=curso.cod_curso inner join historico on alunos.cod_matricula=historico.cod_matricula where alunos.cod_matricula between 1 and 3 order by (historico.nota);

/*12 - Selecione o nome do aluno, CPF, CEP, nome da disciplina onde o código for correspondente a 1.*/
select nome_aluno, CPF, CEP, disciplina.nome_disciplina from alunos inner join disciplina on alunos.cod_matricula=disciplina.cod_disciplina where alunos.cod_matricula = 1;

/*13 - Selecione o nome dos alunos que estudam História e morem em Erechim.OBS: Troquei para Técnico em alimentos*/
select nome_aluno from alunos inner join curso on alunos.cod_curso = curso.cod_curso inner join cidade on alunos.cod_cidade = cidade.cod_cidade where cidade.nome= "Erechim" and curso.nome_curso="Técnico em alimentos";

/*14 - Selecione o nome do aluno, endereço, CEP, CPF, nome da cidade, ano/semestre que esteja entre 2010 e 2022, do curso de Informática. OBS: Troquei curso por Mecatrônica e ano/semestre por 1 e 2*/
select nome_aluno, endereco, CEP,CPF, cidade.nome, historico.ano_semestre from alunos inner join historico on historico.cod_matricula=alunos.cod_matricula inner join curso on curso.cod_curso=alunos.cod_curso inner join cidade on cidade.cod_cidade=alunos.cod_cidade where historico.ano_semestre between 1 and 2 and curso.nome_curso='Mecatrônica'; /*Troquei informática por psicologia*/

/*15- Selecione o nome dos alunos, a disciplina, o CPF, o nome do curso e anota do aluno, onde a nota for maior ou igual a 7. (Breno)*/
select alunos.nome_aluno, alunos.CPF, curso.nome_curso , disciplina.nome_disciplina, nota from historico  inner join alunos on alunos.cod_matricula = historico.cod_matricula  inner join disciplina on disciplina.cod_disciplina = historico.cod_disciplina  inner join curso on curso.cod_curso = alunos.cod_curso  where nota >=7; 

/*16 - Mostre o nome dos alunos, as cidades e o curso onde as notas devem estar entre 7 e 10.*/
select nome_aluno, cidade.nome, curso.nome_curso from alunos inner join cidade on cidade.cod_cidade=alunos.cod_cidade inner join curso on curso.cod_curso=alunos.cod_curso inner join historico on historico.cod_matricula=alunos.cod_matricula where historico.nota between 7 and 10;

/*17 - Mostre o nome dos professores e a disciplina que eles dão aula, a disciplina deve começar com L e ter carga horaria de 90h. OBS: Troquei M por F e número de crédito igual a 5*/
select professores.nome_professor, disciplina.nome_disciplina from professores inner join disciplina  on professores.cod_professor=disciplina.cod_disciplina where disciplina.nome_disciplina like 'F%' and disciplina.numero_credito=5;

/*18 - Retornar o codigo da disciplina e o nome dos alunos que não moram em RS. OBS: Todos meus alunos são de RS. OBS: Troquei RS por PR*/
select disciplina.cod_disciplina, alunos.nome_aluno, uf from cidade inner join alunos on alunos.cod_cidade=cidade.cod_cidade inner join disciplina on alunos.cod_matricula=disciplina.cod_disciplina where cidade.uf not in('PR');

/*19 - Selecione o nome do aluno, o nome do curso, a nota e o nome da cidade dos alunos que moram em cidades que não começam com E e tiveram nota maior que 7, ordene por nota em ordem crescente.*/
select nome_aluno, curso.nome_curso, historico.nota, cidade.nome from alunos inner join curso on curso.cod_curso=alunos.cod_curso inner join historico on historico.cod_matricula=alunos.cod_matricula inner join cidade on cidade.cod_cidade=alunos.cod_cidade where cidade.nome not in ('E') and historico.nota>7 order by nota ASC;

/*20 - Informe o nome do aluno, CPF e nome do curso, onde o curso for Agronomia. OBS: Troquei Agronomia por Mecatrônica*/
select nome_aluno,CPF, curso.nome_curso from alunos inner join curso on alunos.cod_curso=curso.cod_curso where curso.nome_curso = "Mecatrônica";

/*21 - Mostre a soma das notas dos alunos do curso de código 1 e mostre os que foram aprovados (nota>7).*/
select SUM(historico.nota) from  curso inner join historico on historico.cod_historico=curso.cod_curso where curso.cod_curso=1 and historico.nota>=7;

/*22 - Mostre o nome do aluno, o CPF, o nome e a uf da cidade, a nota máxima com o aluno que comece com S. OBS: Troquei S por B  */
select nome_aluno, CPF, cidade.nome, cidade.uf,  MAX(historico.nota) from alunos inner join cidade on cidade.cod_cidade=alunos.cod_cidade inner join historico on historico.cod_matricula=alunos.cod_matricula where alunos.nome_aluno like 'B%';

/*23 - Selecione o nome do aluno, nome da cidade e endereço daqueles do sexo "feminino" que nasceram antes de 2002. Por em ordem descrescente de idade.OBS: Troquei 2002 por 2007*/
select nome_aluno, cidade.nome, endereco from alunos inner join cidade on cidade.cod_cidade=alunos.cod_cidade where sexo='f' and nascimento<'2007.01.02' order by nascimento desc;
