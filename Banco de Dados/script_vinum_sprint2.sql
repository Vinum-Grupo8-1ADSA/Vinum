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

insert into assinaturas values
(null, 'Miolo', 12, 999.99),
(null, 'Castilla', 36, 2399.99),
(null, 'Domaine', 60, 4999.99);

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