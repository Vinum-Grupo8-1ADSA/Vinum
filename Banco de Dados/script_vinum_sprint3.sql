create database VinumSprint3;

use VinumSprint3;

create table assinaturas (
idAssinaturas int primary key auto_increment,
nomePlano varchar(50) not null,
duracaoMeses int not null,
constraint ckduracaomeses check (duracaoMeses in (12, 36, 60)),
constraint cknomePlano check (nomePlano in ('Miolo', 'Castilla', 'Domaine'))
);

create table distribuidora (
idDistribuidora int primary key auto_increment,
nomeFantasia varchar(20) not null,
razaoSocial varchar(20) not null,
CNPJ char(14) not null unique,
telefone varchar(15),
email varchar(30) not null,
senha varchar(30) not null,
fkAssinaturas int not null,
constraint fkAssinaturas foreign key (fkAssinaturas) 
references assinaturas(idAssinaturas)
);

create table endereco (
idEndereco int primary key auto_increment,
CEP char(8) not null,
logradouro varchar(50),
numEndereco int,
complemento varchar(10),
fkDistribuidora int not null,
constraint fkdistribuidora foreign key (fkDistribuidora) 
references distribuidora(idDistribuidora)
);

create table usuario (
idUsuario int primary key auto_increment,
nomeUser varchar(30),
cpf char(11),
email varchar(50) not null,
senha varchar(30) not null,
fkDistribuidora int not null,
constraint fkdistribuidoraUsuario foreign key (fkDistribuidora) references distribuidora(idDistribuidora)
);

create table produto (
idProduto int primary key auto_increment,
categoriaVinho varchar(30) not null,
constraint ckcategoriavinho check (categoriaVinho in ("Vinho Tinto", "Vinho Branco", "Vinho Rosé", "Vinho Espumante", "Vinho Licoroso")),
marcaVinho varchar(30),
dataSafra date,
qtdVinho int,
fkDistribuidora int not null,
constraint fkDistribuidoraProduto foreign key (fkDistribuidora)
 references distribuidora(idDistribuidora)
);

create table adega (
idAdega int primary key auto_increment,
posicao varchar(100),
fkProduto int not null,
constraint fkProdutoAdega foreign key (fkProduto) 
references produto(idProduto),
fkDistribuidora int not null,
constraint fkDistribuidoraAdega foreign key (fkDistribuidora) 
references produto(fkDistribuidora)
);

create table sensor (
idSensor int primary key auto_increment,
nomeSensor varchar(20),
fkAdega int not null,
fkProduto int not null,
fkDistribuidora int not null,
constraint fkAdega foreign key (fkAdega) 
references adega(idAdega),
constraint fkProduto foreign key (fkProduto)
references adega(fkProduto),
constraint fkDistribuidoraSensor foreign key (fkDistribuidora)
references adega(fkDistribuidora));

create table registro (
idRegistro int primary key auto_increment,
temperatura float not null,
umidade float not null,
dtHora datetime not null,
fkSensor int not null,
constraint fkSensor foreign key (fkSensor)
references sensor(idSensor));

insert into assinaturas values
(null, 'Miolo', 12),
(null, 'Castilla', 36),
(null, 'Domaine', 60);

select * from assinaturas;

insert into distribuidora (nomeFantasia, razaoSocial, CNPJ, telefone, email, senha, fkAssinaturas) values
	('Empresa A', 'empresa A LTDA.', '01234567892023', '', 'empresaA@gmail.com', '123456', 1),
    ('Empresa B', 'empresa B LTDA.', '01234567892024', '11911223344', 'empresaB@gmail.com', '123456', 3);
    

select * from distribuidora;

insert into produto (categoriaVinho, marcaVinho, dataSafra, qtdVinho, fkDistribuidora) values
	('Vinho Tinto', 'Chandon', '2021-11-20', 100, 1),
    ('Vinho Rosé', 'Jonas', '2022-10-26', 80, 2);

select * from produto;

insert into adega (posicao, fkProduto, fkDistribuidora) values
	('Primeira adega a esquerda no subsolo', 1, 1),
	('Não existe', 2, 2);
select * from adega;

insert into sensor (nomeSensor, fkAdega, fkProduto, fkDistribuidora) values
	('sensor A', 1, 1, 1),
	('sensor B', 1, 1, 1),
    ('sensor C', 1, 1, 1),
    ('sensor A', 2, 2, 2),
	('sensor B', 2, 2, 2),
    ('sensor C', 2, 2, 2);

select * from sensor;

insert into registro (temperatura, umidade, dtHora, fkSensor) values
	(8, 72, now(), 1),
    (8, 76, now(), 2),
    (8, 80, now(), 3);

select *
from sensor
join distribuidora on fkDistribuidora = idDistribuidora;

select
            temperatura, 
            umidade,
            dtHora,
            DATE_FORMAT(dtHora,'%H:%i:%s') as momento_grafico
        from registro
        join sensor on fkSensor = idSensor
        where fkSensor = 1 and fkDistribuidora = 2
        order by idRegistro desc limit 7;

insert into registro (temperatura, umidade, dtHora, fkSensor) values
	(10.01, 36, now(), 1);

insert into registro (temperatura, umidade, dtHora, fkSensor) values
	(30, 20, now(), 2);

insert into registro (temperatura, umidade, dtHora, fkSensor) values
	(30, 20, now(), 5);

select * from registro;

-- User com permição de tudo, aquele que vai ser o Servidor    
create user 'vinumAllGrupo'@'10.18.36.100' identified by 'grupoAll';
grant all privileges on VinumSprint3.* to 'vinumAllGrupo'@'10.18.36.100';
flush privileges;

create user 'vinumAllGrupoLocal'@'localhost' identified by 'grupoAll';
grant all privileges on VinumSprint3.* to 'vinumAllGrupoLocal'@'localhost';
flush privileges;

-- User com permição de Inserir dados, aquele que vai inserir os dados criados para o servidor
create user 'vinumInsertGrupo'@'10.18.36.70' identified by 'grupoAll';
grant insert on VinumSprint3.* to 'vinumInsertGrupo'@'10.18.36.70';
flush privileges;

-- User com permição de Exibir dados, aquele que vai fazer o select para abrir a pagina
create user 'vinumSelectGrupo'@'10.18.35.6' identified by 'grupoAll';
grant select on VinumSprint3.* to 'vinumSelectGrupo'@'10.18.35.6';
flush privileges;

select * from distribuidora;

truncate table registro;
select * from registro;