create database VinumSprint3;

use VinumSprint3;

create table assinaturas (
idAssinaturas int primary key auto_increment,
nomeAssinatura varchar(50),
duracaoMeses int,
constraint ckduracaomeses check (duracaoMeses in (12, 36, 60)),
preco float
);

create table distribuidora (
idDistribuidora int primary key auto_increment,
nomeFantasia varchar(20) not null,
razaoSocial varchar(20) not null,
CNPJ char(14) not null unique,
telefone varchar(15),
email varchar(30),
senha varchar(30),
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
email varchar(50) not null,
senha varchar(30) not null,
fkDistribuidora int not null,
constraint fkdistribuidoraUsuario foreign key (fkDistribuidora) references distribuidora(idDistribuidora)
);

create table produto (
idProduto int primary key auto_increment,
categoriaVinho varchar(30),
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
desc assinaturas;
insert into assinaturas values
(null, 'Miolo', 12, 999.99),
(null, 'Castilla', 36, 2399.99),
(null, 'Domaine', 60, 4999.99);

insert into distribuidora(idDistribuidora, nomeFantasia, razaoSocial, CNPJ, telefone, email, fkAssinaturas) values
(null, 'Empresa A','Distribuidora A ltda','00000000009301','5511900001111','contato@empresaA.com', 3),
(null, 'Empresa B','Distribuidora B SA','00000000009401','5511900001112','atendimento@empresab.com', 2),
(null, 'Empresa C','Distribuidora C ltda','00000000009501','5511900001113','contato@empresaC.com', 1);

select * from distribuidora;

select * from distribuidora
	join assinaturas on fkAssinaturas = idAssinaturas;


select *  from usuario;
select * from usuario
	join distribuidora on fkDistribuidora = idDistribuidora
    join assinaturas on fkAssinaturas = idAssinaturas;

insert into produto(idProduto, fkDistribuidora, categoriaVinho, marcaVinho, datasafra, qtdVinho) values
(null, 1, 'Vinho Tinto', 'Salentein', '2020-02-19', 427),
(null, 1, 'Vinho Rosé', 'Saurus', '2019-01-22', 320),
(null, 1, 'Vinho Branco', 'Cocodrilo', '2018-03-21', 174),
(null, 2, 'Vinho Tinto', 'Salentein', '2021-02-04', 207),
(null, 2, 'Vinho Rosé', 'Garzon', '2017-01-09', 338),
(null, 3, 'Vinho Branco', 'Pizzato', '2020-02-21', 142),
(null, 3, 'Vinho Espumante', 'Ferrari', '2022-03-13', 89);

select * from produto;
select * from produto
	join usuario on fkUsuario = idUsuario;
select * from endereco order by fkDistribuidora;

insert into Adega(idAdega, fkProduto, fkEndereco, fkDistribuidora )values
(null, 1, 1,'Primeiro Módulo localizado na esquerda do subsolo 1', 1),
(null, 1, 1,'Segundo Módulo localizado na esquerda do subsolo 1', 1),
(null, 1, 1,'Terceiro Módulo localizado na esquerda do subsolo 1', 1),
(null, 1, 1,'Quarto Módulo localizado na esquerda do subsolo 1', 1),
(null, 1, 1,'Primeiro Módulo localizado na direita do subsolo 1', 1),
(null, 2, 2,'Segundo Módulo localizado na direita do subsolo 1', 1),
(null, 2, 2,'Terceiro Módulo localizado na direita do subsolo 1', 1),
(null, 2, 2,'Quarto Módulo localizado na direita do subsolo 1', 1),
(null, 2, 2,'Quinto Módulo localizado na direita do subsolo 2', 1),
(null, 2, 2,'Primeiro Módulo localizado na esquerda do subsolo 2', 1);


insert into sensor(nomeSensor, fkAdega, fkProduto, fkDistribuidora)values
('Módulo A',1,1,1),
('Módulo B',2,1,1),
('Módulo C',3,1,1),
('Módulo D',4,1,1),
('Módulo E',5,1,1),
('Módulo F',6,2,1),
('Módulo G',7,2,1),
('Módulo H',8,2,1),
('Módulo I',9,2,1),
('Módulo J',10,2,1);

insert into registro(temperatura, umidade, dtHora, fkSensor)values
(10.42, 66, '2023-10-11 09:58:30',1), 
(10.41, 67, '2023-10-11 10:00:00',2),
(10.32, 67, '2023-10-11 11:01:30',3),
(10.31, 70, '2023-10-11 11:03:00',4),
(9.98, 72, '2023-10-11 11:04:30',5),
(10.01, 73, '2023-10-11 11:06:00',6),
(11.42, 70, '2023-10-11 11:07:30',7),
(11.72, 68, '2023-10-11 11:09:00',8),
(11.20, 67, '2023-10-11 11:10:30',9),
(11.20, 67, '2023-10-11 11:12:00',10);

select * from modulo;
select * from modulo
	join produto on fkProduto = idProduto
    join localizacao on fkLocalizacao = idLocalizacao;

select m.nomeModulo, m.temperatura, 
	   m.umidade, m.horario, 
	   p.categoriaVinho, p.marcaVinho,
       p.dataSafra, l.posicao
	from modulo as m
	join produto as p on fkProduto = idProduto
    join localizacao as l on fkLocalizacao = idLocalizacao
    where nomeModulo = 'Módulo A';

select l.posicao, e.* from localizacao as l
	join endereco as e on fkEndereco = idEndereco
    where idLocalizacao = 1;
    
-- User com permição de tudo, aquele que vai ser o Servidor    
create user 'vinumAllGrupo'@'10.18.36.100' identified by 'grupoAll';
grant all privileges on VinumSprint3.* to 'vinumAllGrupo'@'10.18.36.100';
flush privileges;

-- User com permição de Inserir dados, aquele que vai inserir os dados criados para o servidor
create user 'vinumInsertGrupo'@'10.18.36.70' identified by 'grupoAll';
grant insert on VinumSprint3.* to 'vinumInsertGrupo'@'10.18.36.70';
flush privileges;

-- User com permição de Exibir dados, aquele que vai fazer o select para abrir a pagina
create user 'vinumSelectGrupo'@'10.18.35.6' identified by 'grupoAll';
grant select on VinumSprint3.* to 'vinumSelectGrupo'@'10.18.35.6';
flush privileges;
