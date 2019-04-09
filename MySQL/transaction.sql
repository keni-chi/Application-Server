create table sample(
id int(11) AUTO_INCREMENT NOT NULL,
val int(11) DEFAULT NULL,
constraint ID_PK primary key (id)
);
desc sample;


//TRUNCATEした時点で暗黙的にコミット(最後にデータは空)
select @@autocommit;
set autocommit = 0;

insert into sample(val) values(10),(20),(30);
start transaction;
select * from sample;
truncate table sample;
rollback;
select * from sample;


//TRUNCATEした時点で暗黙的にコミット(最後にデータはあり)
select @@autocommit;
set autocommit = 0;

insert into sample(val) values(10),(20),(30);
select * from sample;
start transaction;
delete from sample;
select * from sample;
rollback;
select * from sample;


//ロック中はトランザクションが効いている
select @@autocommit;
set autocommit = 0;

insert into sample(val) values(10),(20),(30);
lock table sample write;
delete from sample;
rollback;
select * from sample;
