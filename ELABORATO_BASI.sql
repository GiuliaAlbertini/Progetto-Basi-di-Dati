-- *********************************************
-- * SQL MySQL generation                      
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Sun Aug 11 17:25:16 2024 
-- * LUN file: C:\Users\kimio\Desktop\Uni_Kimi\Secondo_Anno\Database\Elaborato\Lavoro\ELABORATO_BASI.lun 
-- * Schema: SCHEMA LOGICO/1-1 
-- ********************************************* 


-- Database Section
-- ________________ 

create database federgolf;
use federgolf;


-- Tables Section
-- _____________ 

create table ASSOCIAZIONI (
     nomeCircolo varchar(30) not null,
     numTessera int not null,
     anno year not null,
     constraint IDASSOCIAZIONE primary key (numTessera, anno));

create table ATTRIBUZIONI (
     nomeCircolo varchar(30) not null,
     nomeCarica varchar(30) not null,
     anno year not null,
     numTessera int not null,
     constraint IDATTRIBUZIONE primary key (nomeCircolo, nomeCarica, anno, numTessera));

create table CARICHE (
     nomeCarica varchar(30) not null,
     constraint IDCARICA primary key (nomeCarica));

create table CATEGORIE (
     nomeCategoria char(1) not null,
     constraint IDCATEGORIA primary key (nomeCategoria));

create table CERTIFICATI_MEDICI (
     numCertificato int not null auto_increment,
     emissione date not null,
     scadenza date not null,
     constraint IDCERTIFICATO_MEDICO primary key (numCertificato));

create table CIRCOLI (
     nomeCircolo varchar(30) not null,
     indirizzo varchar(50) not null,
     constraint IDCIRCOLO primary key (nomeCircolo));

create table GARE (
     nomeGara char(50) not null,
     durata int not null,
     dataInizio date not null,
     categoriaStatus char(1) not null,
     maxIscritti int default 70 not null,
     dataChiusuraIscrizioni date not null,
     nomeCircolo varchar(30) not null,
     nomePercorso varchar(30) not null,
     nomeCategoria char(1) not null,
     constraint IDGARA primary key (nomeGara));

create table ISCRIZIONI (
     dataIscrizione date not null,
     posizioneFinale int,
     puntiOttenuti int,
     nomeGara char(50) not null,
     numTessera int not null,
     constraint IDISCRIZIONE primary key (nomeGara, numTessera));

create table NOMINE (
     nomeCarica varchar(30) not null,
     nomeCircolo varchar(30) not null,
     anno year not null,
     constraint IDNOMINA_ID primary key (nomeCircolo, nomeCarica, anno));

create table PERCORSI (
     nomeCircolo varchar(30) not null,
     nomePercorso varchar(30) not null,
     par int not null,
     courseRating float(4) not null,
     constraint IDPERCORSO primary key (nomeCircolo, nomePercorso));

create table POSIZIONAMENTI (
     nomeCategoria char(1) not null,
     posizione int not null,
     punteggio int not null,
     constraint IDPOSIZIONAMENTO primary key (nomeCategoria, posizione));

create table PRENOTAZIONI (
     nomeCircolo varchar(30) not null,
     nomePercorso varchar(30) not null,
     dataPrenotazione date not null,
     oraPrenotazione time not null,
     numTessera1 int not null,
     numTessera2 int,
     numTessera3 int,
     numTessera4 int,
     constraint IDPRENOTAZIONE primary key (nomeCircolo, nomePercorso, dataPrenotazione, oraPrenotazione));

create table RISERVE (
     maxNomine int not null,
     nomeCircolo varchar(30) not null,
     nomeCarica varchar(30) not null,
     constraint IDRISERVA primary key (nomeCircolo, nomeCarica));

create table TESSERATI (
     numTessera int not null auto_increment,
     numCertificato int,
     nome varchar(20) not null,
     cognome varchar(20) not null,
     dataDiNascita date not null,
     email varchar(50),
     telefono char(10),
     statusProfessionista char default 'f' not null,
     eraProfessionista char default 'f' not null,
     puntiOdM int default 0 not null,
     squalifica char default 'f' not null,
     constraint IDTESSERATO primary key (numTessera),
     constraint FKR_ID unique (numCertificato));


-- Constraints Section
-- ___________________ 

alter table ASSOCIAZIONI add constraint FKSOTTOSCRIZIONE
     foreign key (numTessera)
     references TESSERATI (numTessera);

alter table ASSOCIAZIONI add constraint FKRESIDENZA
     foreign key (nomeCircolo)
     references CIRCOLI (nomeCircolo);

alter table ATTRIBUZIONI add constraint FKR_1
     foreign key (nomeCircolo, nomeCarica, anno)
     references NOMINE (nomeCircolo, nomeCarica, anno);

alter table ATTRIBUZIONI add constraint FKR
     foreign key (numTessera)
     references TESSERATI (numTessera);

alter table GARE add constraint FKSVOLGIMENTO
     foreign key (nomeCircolo, nomePercorso)
     references PERCORSI (nomeCircolo, nomePercorso);

alter table GARE add constraint FKCORRISPONDENZA
     foreign key (nomeCategoria)
     references CATEGORIE (nomeCategoria);

alter table ISCRIZIONI add constraint FKR_2
     foreign key (nomeGara)
     references GARE (nomeGara);

alter table ISCRIZIONI add constraint FKR_3
     foreign key (numTessera)
     references TESSERATI (numTessera);

alter table NOMINE add constraint FKINERENZA
     foreign key (nomeCircolo)
     references CIRCOLI (nomeCircolo);

alter table NOMINE add constraint FKRELAZIONE
     foreign key (nomeCarica)
     references CARICHE (nomeCarica);

alter table PERCORSI add constraint FKAPPARTENENZA
     foreign key (nomeCircolo)
     references CIRCOLI (nomeCircolo);

alter table POSIZIONAMENTI add constraint FKPERTINENZA_POSIZIONE
     foreign key (nomeCategoria)
     references CATEGORIE (nomeCategoria);

alter table PRENOTAZIONI add constraint FKAFFERENZA
     foreign key (nomeCircolo, nomePercorso)
     references PERCORSI (nomeCircolo, nomePercorso);

alter table PRENOTAZIONI add constraint FKEFFETTUAZIONE1
     foreign key (numTessera1)
     references TESSERATI (numTessera);
     
 alter table PRENOTAZIONI add constraint FKEFFETTUAZIONE2
     foreign key (numTessera2)
     references TESSERATI (numTessera);

alter table PRENOTAZIONI add constraint FKEFFETTUAZIONE3
     foreign key (numTessera3)
     references TESSERATI (numTessera);
     
 alter table PRENOTAZIONI add constraint FKEFFETTUAZIONE4
     foreign key (numTessera4)
     references TESSERATI (numTessera);

alter table RISERVE add constraint FKR_4
     foreign key (nomeCircolo)
     references CIRCOLI (nomeCircolo);

alter table RISERVE add constraint FKR_5
     foreign key (nomeCarica)
     references CARICHE (nomeCarica);

alter table TESSERATI add constraint FKR_FK
     foreign key (numCertificato)
     references CERTIFICATI_MEDICI (numCertificato);


-- Index Section
-- _____________ 


-- Populating database
-- _____________

-- Table "categorie"
insert into categorie(nomecategoria)
values('a');
insert into categorie(nomecategoria)
values('b');
insert into categorie(nomecategoria)
values('c');
insert into categorie(nomecategoria)
values('d');
insert into categorie(nomecategoria)
values('e');
insert into categorie(nomecategoria)
values('f');
insert into categorie(nomecategoria)
values('g');

-- Table "posizionamenti"
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 1, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 2, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 3, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 4, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 5, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 6, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 7, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 8, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 9, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 10, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 11, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 12, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 13, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 14, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 15, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 16, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 17, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 18, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 19, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 20, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 21, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 22, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 23, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 24, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 25, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 26, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 27, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 28, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 29, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 30, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 31, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 32, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 33, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 34, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 35, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 36, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 37, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 38, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 39, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 40, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 41, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 42, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 43, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 44, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 45, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 46, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 47, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 48, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 49, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 50, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 51, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 52, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 53, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 54, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 55, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 56, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 57, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 58, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 59, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 60, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('g', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 1, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 2, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 3, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 4, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 5, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 6, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 7, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 8, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 9, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 10, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 11, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 12, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 13, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 14, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 15, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 16, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 17, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 18, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 19, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 20, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 21, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 22, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 23, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 24, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 25, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 26, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 27, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 28, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 29, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 30, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 31, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 32, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 33, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 34, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 35, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 36, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 37, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 38, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 39, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 40, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 41, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 42, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 43, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 44, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 45, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 46, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 47, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 48, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 49, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 50, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 51, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 52, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 53, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 54, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 55, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 56, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 57, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 58, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 59, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 60, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('f', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 1, 20);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 2, 13);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 3, 11);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 4, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 5, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 6, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 7, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 8, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 9, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 10, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 11, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 12, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 13, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 14, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 15, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 16, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 17, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 18, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 19, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 20, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 21, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 22, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 23, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 24, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 25, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 26, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 27, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 28, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 29, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 30, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 31, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 32, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 33, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 34, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 35, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 36, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 37, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 38, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 39, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 40, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 41, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 42, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 43, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 44, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 45, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 46, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 47, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 48, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 49, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 50, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 51, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 52, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 53, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 54, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 55, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 56, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 57, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 58, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 59, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 60, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('e', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 1, 40);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 2, 26);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 3, 22);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 4, 19);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 5, 17);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 6, 16);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 7, 15);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 8, 14);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 9, 13);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 10, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 11, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 12, 11);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 13, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 14, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 15, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 16, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 17, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 18, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 19, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 20, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 21, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 22, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 23, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 24, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 25, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 26, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 27, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 28, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 29, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 30, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 31, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 32, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 33, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 34, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 35, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 36, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 37, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 38, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 39, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 40, 1);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 41, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 42, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 43, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 44, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 45, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 46, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 47, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 48, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 49, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 50, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 51, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 52, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 53, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 54, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 55, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 56, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 57, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 58, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 59, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 60, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('d', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 1, 80);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 2, 51);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 3, 44);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 4, 37);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 5, 35);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 6, 33);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 7, 31);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 8, 29);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 9, 27);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 10, 24);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 11, 23);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 12, 22);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 13, 20);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 14, 19);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 15, 18);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 16, 17);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 17, 16);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 18, 16);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 19, 15);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 20, 14);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 21, 14);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 22, 13);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 23, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 24, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 25, 11);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 26, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 27, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 28, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 29, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 30, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 31, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 32, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 33, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 34, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 35, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 36, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 37, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 38, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 39, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 40, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 41, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 42, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 43, 3);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 44, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 45, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 46, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 47, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 48, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 49, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 50, 2);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 51, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 52, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 53, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 54, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 55, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 56, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 57, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 58, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 59, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 60, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('c', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 1, 140);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 2, 89);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 3, 77);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 4, 65);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 5, 61);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 6, 57);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 7, 54);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 8, 50);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 9, 46);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 10, 43);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 11, 40);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 12, 38);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 13, 36);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 14, 33);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 15, 31);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 16, 30);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 17, 29);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 18, 27);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 19, 26);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 20, 25);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 21, 24);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 22, 23);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 23, 21);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 24, 20);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 25, 19);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 26, 18);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 27, 17);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 28, 15);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 29, 14);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 30, 13);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 31, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 32, 11);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 33, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 34, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 35, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 36, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 37, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 38, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 39, 7);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 40, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 41, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 42, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 43, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 44, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 45, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 46, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 47, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 48, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 49, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 50, 5);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 51, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 52, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 53, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 54, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 55, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 56, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 57, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 58, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 59, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 60, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 61, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 62, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 63, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 64, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 65, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 66, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 67, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 68, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 69, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('b', 70, 0);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 1, 200);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 2, 150);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 3, 130);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 4, 110);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 5, 102);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 6, 96);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 7, 90);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 8, 84);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 9, 78);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 10, 72);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 11, 68);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 12, 64);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 13, 60);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 14, 56);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 15, 52);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 16, 50);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 17, 48);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 18, 46);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 19, 44);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 20, 42);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 21, 40);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 22, 38);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 23, 36);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 24, 34);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 25, 32);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 26, 30);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 27, 28);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 28, 26);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 29, 24);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 30, 22);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 31, 20);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 32, 18);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 33, 17);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 34, 16);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 35, 15);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 36, 14);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 37, 13);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 38, 12);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 39, 11);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 40, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 41, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 42, 10);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 43, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 44, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 45, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 46, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 47, 9);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 48, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 49, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 50, 8);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 51, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 52, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 53, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 54, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 55, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 56, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 57, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 58, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 59, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 60, 6);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 61, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 62, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 63, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 64, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 65, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 66, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 67, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 68, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 69, 4);
insert into posizionamenti(nomecategoria, posizione, punteggio)
values ('a', 70, 4);

-- Table "circoli"
insert into circoli(nomecircolo, indirizzo)
values('Golf Royal Park i Roveri', 'Rotta Cerbiatta, Fiano TO');
insert into circoli(nomecircolo, indirizzo)
values('Circolo Golf Torino La Mandria', 'via Agnelli, Fiano TO');
insert into circoli(nomecircolo, indirizzo)
values('Olgiata Golf Club', 'largo Olgiata, Roma RM');
insert into circoli(nomecircolo, indirizzo)
values('Modena Golf and Country Club', 'via Castelnuovo Rangone, Colombaro MO');
insert into circoli(nomecircolo, indirizzo)
values('Adriatic Golf Cervia', 'via Jelena Gora, Milano Marittima RA');
insert into circoli(nomecircolo, indirizzo)
values('Golf Club Le Fonti', 'viale Terme, Castel San Pietro BO');
insert into circoli(nomecircolo, indirizzo)
values('Golf Club Villa Condulmer', 'via Della Croce, Mogliano Veneto TV');
insert into circoli(nomecircolo, indirizzo)
values('Bergamo Albenza Golf Club', 'via Longoni, Almenno San Bartolomeo BG');
insert into circoli(nomecircolo, indirizzo)
values('Golf Club Ambrosiano', 'via Cascina Bertacca, Bubbiano MI');
insert into circoli(nomecircolo, indirizzo)
values('Golf Club Le Pavoniere', 'via Traversa Il Crocifisso, Prato PO');
insert into circoli(nomecircolo, indirizzo)
values('Golf Nazionale', 'via Cassia, Sutri VT');
insert into circoli(nomecircolo, indirizzo)
values('Asolo Golf Club', 'via dei Borghi, Cavaso del Tomba TV');
insert into circoli(nomecircolo, indirizzo)
values('Acaya Golf Resort', 'strada Comunale Acaya, Acaya LE');
insert into circoli(nomecircolo, indirizzo)
values('Riviera Golf Resort', 'via Conca Nuova, San Giovanni in Marignano RN');
insert into circoli(nomecircolo, indirizzo)
values('Golf Villa Paradiso', 'località Villa Paradiso, Cornate d\'Adda MB');
insert into circoli(nomecircolo, indirizzo)
values('Circolo Golf dell\'Ugolino', 'via Chiantigiana per Strada, Impruneta FI');
insert into circoli(nomecircolo, indirizzo)
values('Golf Club Milano', 'via Regina Margherita, Biassono MB');
insert into circoli(nomecircolo, indirizzo)
values('Garda Golf and Country Club', 'via Omodeo, Soiano BS');
insert into circoli(nomecircolo, indirizzo)
values('Bogogno Golf Resort', 'via San Isidoro, Bogogno NO');
insert into circoli(nomecircolo, indirizzo)
values('Rimini Verucchio Golf', 'via Molino Bianco, Verucchio RN');

-- Table "percorsi"
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Royal Park i Roveri', 'Allianz Course', 72, 73.3);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Royal Park i Roveri', 'Allianz Bank Course', 72, 72.3);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Circolo Golf Torino La Mandria', 'Blu', 72, 72.3);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Circolo Golf Torino La Mandria', 'Giallo', 72, 72.6);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Olgiata Golf Club', 'Ovest', 73, 73.7);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Modena Golf and Country Club', 'Bernhard Langer', 72, 72.2);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Adriatic Golf Cervia', 'Rosso-Giallo', 71, 71.7);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Adriatic Golf Cervia', 'Blu-Giallo', 71, 70.4);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Club Le Fonti', 'Championship', 71, 71.4);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Club Villa Condulmer', 'Championship', 71, 69.8);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Bergamo Albenza Golf Club', 'Blu-Giallo', 72, 71.8);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Club Ambrosiano', 'Championship', 72, 71.9);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Club Le Pavoniere', 'Arnold Palmer', 72, 73.0);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Nazionale', 'Championship', 72, 71.7);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Nazionale', 'Carta', 72, 73.4);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Asolo Golf Club', 'Giallo-Verde', 72, 71.6);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Acaya Golf Resort', 'Championship', 71, 71.8);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Riviera Golf Resort', 'Championship', 70, 70.1);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Villa Paradiso', 'Championship', 72, 70.7);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Circolo Golf dell\'Ugolino', 'Championship', 72, 70.9);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Golf Club Milano', '1-2', 72, 73.4);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Garda Golf and Country Club', 'Rosso-Bianco', 72, 72.5);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Bogogno Golf Resort', 'Bonora', 72, 72.5);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Bogogno Golf Resort', 'del Conte', 72, 71.0);
insert into percorsi(nomecircolo, nomepercorso, par, courserating)
values('Rimini Verucchio Golf', 'Championship', 72, 70.0);

-- Table "cariche"
insert into cariche(nomecarica)
values('Presidente');
insert into cariche(nomecarica)
values('Direttore');
insert into cariche(nomecarica)
values('Maestro');
insert into cariche(nomecarica)
values('Segretario');
insert into cariche(nomecarica)
values('Caddie Master');
insert into cariche(nomecarica)
values('Greenkeeper');
insert into cariche(nomecarica)
values('Referente atleti');

-- Table "riserve"
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Royal Park i Roveri', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Royal Park i Roveri', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Royal Park i Roveri', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Golf Royal Park i Roveri', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Royal Park i Roveri', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Royal Park i Roveri', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Royal Park i Roveri', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf Torino La Mandria', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf Torino La Mandria', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Circolo Golf Torino La Mandria', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Circolo Golf Torino La Mandria', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Circolo Golf Torino La Mandria', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Circolo Golf Torino La Mandria', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Circolo Golf Torino La Mandria', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Olgiata Golf Club', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Olgiata Golf Club', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Olgiata Golf Club', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Olgiata Golf Club', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Olgiata Golf Club', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Olgiata Golf Club', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Olgiata Golf Club', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Modena Golf and Country Club', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Modena Golf and Country Club', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Modena Golf and Country Club', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Modena Golf and Country Club', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Modena Golf and Country Club', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Modena Golf and Country Club', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (4, 'Modena Golf and Country Club', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Adriatic Golf Cervia', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Adriatic Golf Cervia', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Adriatic Golf Cervia', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Adriatic Golf Cervia', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Adriatic Golf Cervia', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Adriatic Golf Cervia', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Adriatic Golf Cervia', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Fonti', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Fonti', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Fonti', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Le Fonti', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Fonti', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Fonti', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Fonti', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Villa Condulmer', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Villa Condulmer', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Villa Condulmer', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Villa Condulmer', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Villa Condulmer', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Villa Condulmer', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Villa Condulmer', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Bergamo Albenza Golf Club', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Bergamo Albenza Golf Club', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Bergamo Albenza Golf Club', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Bergamo Albenza Golf Club', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Bergamo Albenza Golf Club', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Bergamo Albenza Golf Club', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Bergamo Albenza Golf Club', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Pavoniere', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Pavoniere', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Pavoniere', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Le Pavoniere', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Pavoniere', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Le Pavoniere', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Le Pavoniere', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Nazionale', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Nazionale', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Golf Nazionale', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Nazionale', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Nazionale', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Nazionale', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Golf Nazionale', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Asolo Golf Club', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Asolo Golf Club', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Asolo Golf Club', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Asolo Golf Club', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Asolo Golf Club', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Asolo Golf Club', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Asolo Golf Club', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Acaya Golf Resort', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Acaya Golf Resort', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Acaya Golf Resort', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Acaya Golf Resort', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Acaya Golf Resort', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Acaya Golf Resort', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Acaya Golf Resort', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Riviera Golf Resort', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Riviera Golf Resort', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Riviera Golf Resort', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Riviera Golf Resort', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Riviera Golf Resort', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Riviera Golf Resort', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Riviera Golf Resort', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf dell\'Ugolino', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf dell\'Ugolino', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Circolo Golf dell\'Ugolino', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Circolo Golf dell\'Ugolino', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf dell\'Ugolino', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Circolo Golf dell\'Ugolino', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Circolo Golf dell\'Ugolino', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Villa Paradiso', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Villa Paradiso', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Villa Paradiso', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Golf Villa Paradiso', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Villa Paradiso', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Villa Paradiso', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Villa Paradiso', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Milano', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Milano', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Milano', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Golf Club Milano', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Milano', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Milano', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Milano', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Garda Golf and Country Club', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Garda Golf and Country Club', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Garda Golf and Country Club', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Garda Golf and Country Club', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Garda Golf and Country Club', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Garda Golf and Country Club', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Garda Golf and Country Club', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Bogogno Golf Resort', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Bogogno Golf Resort', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Bogogno Golf Resort', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (5, 'Bogogno Golf Resort', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Bogogno Golf Resort', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Bogogno Golf Resort', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (4, 'Bogogno Golf Resort', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Rimini Verucchio Golf', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Rimini Verucchio Golf', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Rimini Verucchio Golf', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Rimini Verucchio Golf', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Rimini Verucchio Golf', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Rimini Verucchio Golf', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Rimini Verucchio Golf', 'Referente atleti');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Ambrosiano', 'Presidente');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Ambrosiano', 'Direttore');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Ambrosiano', 'Maestro');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Ambrosiano', 'Segretario');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (2, 'Golf Club Ambrosiano', 'Caddie Master');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (1, 'Golf Club Ambrosiano', 'Greenkeeper');
insert into riserve(maxnomine, nomecircolo, nomecarica)
values (3, 'Golf Club Ambrosiano', 'Referente atleti');

-- Table "tesserati"
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Edoardo', 'Trocchi', '2004-11-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Franco', 'Chimenti', '1939-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Bisazza', '1980-06-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Valli', '2004-06-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Callegati', '2003-04-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Rossi', '1990-11-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Cavina', '2003-05-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Lauria', '1985-03-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Bianchi', '1994-07-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Santandrea', '2005-07-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Mazzotti', '2005-11-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Boni', '1986-02-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Basso', '1999-05-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Carletti', '1991-05-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Martini', '1998-12-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Franceschini', '1981-07-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Salvatori', '1993-05-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Pacelli', '1968-03-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Marchetti', '1981-01-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Malaguti', '1976-09-05');
insert into tesserati(nome, cognome, datadinascita, eraprofessionista)
values ('Giovanni', 'Lanzoni', '1980-06-11', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Maserati', '2001-11-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Guido', 'Guiducci', '1991-03-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Franco', 'Fabbri', '2002-09-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Bartolini', '1986-11-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Frasca', '1979-12-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Caltagirone', '1990-07-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Sandron', '1966-12-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Paolo', 'Albertazzi', '2003-01-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfredo', 'Montalti', '1971-10-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Nicola', 'Sangiorgi', '1991-11-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Di Pietro', '1956-04-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Mellina', '1989-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Santovito', '1998-06-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Manini', '1981-12-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Burratti', '1999-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Pallotti', '2001-11-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Michele', 'Romoli', '2000-03-07', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Gubellini', '2004-08-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Baroncini', '1996-11-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Cristian', 'Stuppioni', '1983-06-11', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Baravelli', '1978-12-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Brighi', '1991-12-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Vetricini', '2003-09-15');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Paolo', 'Zanzani', '2003-04-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lamberto', 'Conti', '2001-01-31');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Pietro', 'Finali', '1989-10-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Fiorentini', '1983-06-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Jacopo', 'Loffredo', '1971-05-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Manuel', 'Locatelli', '1990-12-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Nicola', 'Neri', '1964-09-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mirco', 'Bandini', '2001-04-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Sabetta', '1960-01-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Mariani', '2004-11-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mario', 'Scotti', '1971-08-28', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Ballarini', '1961-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Virginio', 'Marchetti', '1963-12-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Cremonini', '1998-10-16');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Graziano', 'Nardella', '2001-07-07', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Perini', '2005-12-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Nicola', 'Razza', '2003-06-18', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giovanni', 'Guerzoni', '2003-06-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Ciani', '1998-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Orzi', '1996-06-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Miguel', 'Cristoni', '1989-10-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Artioli', '1995-05-10', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Ernesto', 'Bagnulo', '1987-03-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Donatelli', '1993-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Erik', 'Carta', '1997-09-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Coi', '1994-10-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Minarelli', '1997-09-01');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Tommaso', 'Mattiazzo', '1996-08-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Giordani', '2001-04-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Montanari', '2004-02-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Piazzi', '2003-01-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Bonini', '2002-06-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Pellegrini', '1999-11-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Castelvetri', '1989-10-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Finali', '1985-12-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Lamberto', 'Nardozza', '1989-11-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Filipelli', '1998-10-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Bruni', '1987-08-16');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Filippo', 'Vandelli', '1990-06-29', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Ligabue', '2001-05-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'D\'Errico', '2004-07-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Casali', '2001-01-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giorgio', 'Stagni', '2005-03-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Melloni', '1994-11-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Cantone', '1991-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Bavila', '1996-11-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Bruno', 'Bergami', '1992-05-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marino', 'Zannoni', '1994-04-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Mariani', '1989-10-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Lanfranco', 'Vicari', '1980-12-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alessio', 'Martelli', '1990-04-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Alessi', '1995-09-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Valerio', 'Fabbri', '2000-10-10', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Filippo', 'Baldoni', '1996-05-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Ragazzini', '1989-10-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Perrone', '1985-09-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Zambon', '1959-11-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Michele', 'Baroni', '1995-01-31', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Verdi', '2000-09-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Denis', 'Moccia', '1990-01-28');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Dario', 'Di Iorio', '1998-05-01', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Aleotti', '1998-07-16', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giacomo', 'Fini', '1998-10-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Cristiani', '1999-01-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Santi', '1999-06-11');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Lantino', '1999-07-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Cataldo', '1999-09-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Drago', '1999-09-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Colombarini', '1999-10-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Giovannini', '1999-12-17');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giacomo', 'Orlandini', '2000-12-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Nanni', '2001-03-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Thomas', 'Motola', '2001-06-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Mongiusti', '2001-11-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Zambrini', '2001-11-13', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianmarco', 'Cartoceti', '2002-01-31', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Carnevali', '2002-05-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Rugolo', '2002-10-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Campisi', '2003-05-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Torchia', '2004-06-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Favalezza', '2004-08-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Vittorio', 'Cornacchia', '2004-08-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Venturoli', '2005-06-08', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Mazzali', '2005-08-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Straulino', '2005-11-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Edoardo', 'De Simone', '1979-03-04', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Taroni', '1979-03-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Martini', '1979-09-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Schieppati', '1979-11-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Passardi', '1980-05-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Filippo', 'Machiavelli', '1980-09-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Ragazzini', '1980-11-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Vittorio', 'Antichi', '1980-07-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Giardina', '1981-06-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Calò', '1981-08-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Corrado', 'Aulisa', '1982-08-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Frasca', '1982-12-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Piero', 'Brutti', '1983-07-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Simoni', '1984-12-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Banchelli', '1985-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Florioli', '1985-10-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Felice', '1986-08-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Martino', 'Merlini', '1986-08-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Alaimo', '1988-02-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Bufferli', '1988-11-01');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Montalbani', '1989-06-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Regoli', '1990-03-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Zannoni', '1990-08-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Leonardo', 'Dardi', '1990-02-10', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alex', 'Novelli', '1991-04-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuliano', 'Sangiorgi', '1979-01-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Renili', '1986-06-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Paoltroni', '1986-06-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Biancamano', '1987-08-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Angelo', 'Geminiani', '1987-11-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'Lundini', '1988-07-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Angelucci', '1988-11-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Sassaroli', '1998-11-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'De Novellis', '1998-12-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Ricciardi', '1989-02-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Olimpio', 'Avanzato', '1989-06-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Carmelo', 'Siciliano', '1989-07-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Fazioli', '1989-09-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabiano', 'Ballarin', '1979-10-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Raffaele', 'Valente', '1990-01-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Menci', '1990-06-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Fazio', '1990-08-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Vito', 'Lazzari', '1991-11-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Tumminello', '1992-01-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonino', 'Ceroni', '1993-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Fernando', 'Cerati', '1993-06-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Alberti', '1995-11-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Riccardo', 'Carletti', '1996-02-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Palumbo', '1996-03-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Tonelli', '1996-12-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Cuomo', '1997-02-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Moretto', '1997-05-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Turrin', '1993-02-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Bastianello', '1993-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Martorana', '1994-11-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Mirko', 'Fini', '1994-11-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Cosimo', 'Polonara', '1995-03-24');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Achille', 'Ricci', '1996-04-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Spissu', '1996-09-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Gallinari', '1997-01-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Danilo', 'Belinelli', '1997-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Fontecchio', '1997-07-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Della Valle', '1997-12-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Amedeo', 'Pacelli', '1999-03-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Ascanio', 'Toscanini', '1999-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Arturo', 'Rossini', '1999-11-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Giancarlo', 'Valletta', '1999-12-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Carmine', 'Bruzzese', '2000-01-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Ezio', 'Cardone', '2000-05-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Cantoni', '2000-05-06');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Eric', 'Rapisarda', '2000-08-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Giambelli', '2001-06-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Emiliano', 'Palumbo', '2002-02-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Bonci', '2002-05-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Elia', 'Cosco', '2003-08-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Domenico', 'Franchini', '2005-06-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Paoletti', '1981-03-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Raffaele', 'Ricci', '1982-05-24', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giuliano', 'Polimeno', '1983-02-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Tonini', '1983-10-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Ennio', 'Visani', '1983-11-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Lucio', 'Stifani', '1984-03-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Vaselli', '1984-05-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Ambrosini', '1984-12-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Scudetta', '1985-03-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfonso', 'Di Maio', '1985-07-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Silvio', 'Bembo', '1985-11-09', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fulvio', 'Fiorio', '1986-04-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Thomas', 'Degli Esposti', '1986-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Cannabei', '1986-09-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Benda', '1986-12-19');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Filippo', 'Vivaldi', '1987-05-15', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Paradisi', '1987-10-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Galuppi', '1988-05-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Rutini', '1988-12-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Fernando', 'Di Benedetto', '1989-01-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Sammartini', '1989-01-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Sammarchi', '1991-01-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuliano', 'Rivalta', '1993-04-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Goldoni', '1993-07-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Fernandini', '1993-11-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Leopoldo', 'Ginestri', '1958-01-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Quattrocolo', '1968-12-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alfredo', 'Neri', '1971-10-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mark', 'Valentini', '1991-09-11');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Canducci', '1973-12-08', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Cinquegrana', '1990-01-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Salvatore', 'Mineo', '1991-12-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Danilo', 'Zagato', '2000-10-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianmarco', 'Riviera', '1981-02-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Conti', '1981-03-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'Rossi', '1982-12-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Stelio', 'Montorsi', '1984-10-11');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Enrico', 'Maimura', '1986-01-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giulio', 'Vannacci', '1986-10-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Spiga', '1987-05-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Di Martino', '1987-07-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Martino', 'Maioli', '1987-08-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Fiorenzo', 'Sacchetti', '1988-10-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Farneti', '1988-12-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Cappucci', '1989-11-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Pozzi', '1990-10-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giampaolo', 'Zorloni', '1992-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuliano', 'Focaccia', '1993-07-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianstefano', 'Neri', '1993-10-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Baiardi', '1993-10-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Marcello', 'Battistini', '1995-02-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Camice', '1999-09-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Ferrara', '2000-05-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Tabanelli', '2001-03-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Acquaviva', '2002-12-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Adriano', 'Giorgini', '2003-05-08', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luciano', 'Dall\'Olio', '2001-10-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Amedeo', 'Turchetti', '1998-06-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Magnani', '1993-09-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Muccioli', '1991-09-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Caroli', '1981-08-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuliano', 'Alberici', '1987-01-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Visani', '1976-10-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Matteo', 'Di Primio', '1981-09-14', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Palladini', '1989-10-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Magalotti', '1995-10-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Cottignola', '1995-03-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Baruzzi', '1996-03-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Deyan', 'Carmagnola', '2001-07-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Franco', 'Pinna', '1964-09-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Freschi', '2004-12-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Tarozzi', '2000-09-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Manuel', 'Rastelli', '1996-10-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Fabrizio', 'Brignoli', '1987-11-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Tronconi', '1989-09-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'Di Girolami', '1989-12-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Di Bernardo', '1990-03-27');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianluca', 'Baldisserri', '1990-05-29', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Camaggi', '1991-05-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianni', 'Di Diego', '1993-08-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'D\'Ambrosio', '1994-02-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Martino', 'Talamonti', '1994-04-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Di Diego', '1994-05-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Fabbri', '1994-07-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Simonetti', '1995-07-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Merrino', '1995-12-17');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Sturniolo', '1996-08-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Marchesini', '1997-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Franchi', '1997-01-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Chirico', '1998-12-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Marcheselli', '1999-03-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Sbabo', '1999-05-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Ulivi', '2000-03-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Menati', '2000-06-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'D\'Amato', '2001-03-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Dardi', '2001-10-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Loris', 'Ziron', '2002-03-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Lorenzini', '2002-07-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Antonelli', '1989-08-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimiliano', 'Boldrini', '1990-10-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Bassi', '1990-11-06');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Leonardo', 'Tassi', '1991-02-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fausto', 'Zini', '1991-05-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Biagio', 'Galleri', '1991-11-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Costantino', 'Vecchi', '1992-05-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Vladimiro', 'Ferrari', '1993-09-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Elia', 'Lamio', '1994-05-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Baldini', '1994-10-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Fiammenghi', '1995-02-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Stefano', 'Mancini', '1996-04-07', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Resta', '1997-07-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Giordano', '1997-10-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Greco', '1998-11-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Russo', '1999-02-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonino', 'Lanzoni', '1999-08-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianfranco', 'Perrone', '1999-10-17', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Casadei', '2000-03-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Scarpellini', '2000-06-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Carandini', '2001-02-15');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Daniele', 'Barbaglio', '2001-02-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Losito', '2001-12-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Malandri', '2002-05-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Mambelli', '2002-11-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Giancarlo', 'Lazzari', '1974-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Alberti', '1979-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Gualdi', '1993-04-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Gulmini', '1991-11-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Daliso', 'Ciacci', '2001-12-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Donati', '2004-07-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Miale', '2000-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Broglia', '1998-09-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Capponi', '1981-12-24');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Bonfiglioli', '1993-07-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Spatafora', '2001-12-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Nanni', '1990-09-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Brighi', '1994-09-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Sermenghi', '1989-10-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Canè', '1968-10-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Casarini', '1970-11-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Bellocchio', '1967-01-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Di Maria', '1967-09-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Orioli', '1968-06-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Spreafico', '1968-07-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Lelli', '1968-10-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Beltrandi', '1969-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Montebugnoli', '1971-11-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Cantelli', '1973-09-15');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Flavio', 'Facchini', '1974-09-10', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Maurizio', 'Rossanigo', '1974-10-08', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giancarlo', 'Coraci', '1975-04-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Stefanini', '1976-02-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Bernardo', 'Spatoloni', '1976-06-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Ettore', 'Sinigaglia', '1978-06-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Bietoli', '1978-06-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Zaghi', '1979-06-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Uberti', '1979-05-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Gandolfi', '1980-06-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Gambarota', '1980-12-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Verzelli', '1981-01-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Rino', 'Campomori', '1981-01-22', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Maurizio', 'Bacchelli', '1981-08-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Scialfa', '1982-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Agostino', 'Lunardon', '1996-12-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Pietrobon', '1995-03-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Raccampo', '1999-06-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Confalonieri', '1989-09-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianmaria', 'Giuffrè', '2000-10-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Rovatti', '2005-09-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Gallini', '2003-01-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Russo', '2004-10-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Buletti', '1994-08-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Raffaele', 'Bellei', '1993-06-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Spotti', '1993-05-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Pianetti', '1994-04-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Riva', '2001-10-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Rosiello', '2002-09-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Marchese', '1993-06-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Mella', '1974-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Cavalli', '1973-03-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Andrenelli', '1991-02-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Flavio Massimo', 'Corapi', '2000-01-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniel', 'Galeppini', '2004-08-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Luchetti', '1990-12-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Castelletti', '2004-07-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Leon', 'Pollastri', '1986-04-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Moneta', '1991-04-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Sebastiano', 'Pozza', '1993-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Bocchi', '1992-09-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Bedeschi', '1978-04-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Baccega', '1985-10-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Chiari', '1994-03-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Gatti', '1991-09-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Albini', '1994-09-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Guerzoni', '1995-08-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Capotorto', '2001-02-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Corali', '2004-08-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Umberto', 'Mesini', '2000-10-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Victor', 'Cavazzini', '1983-04-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Trenti', '2001-05-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Testa', '2005-05-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Ronconi', '2002-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Gelsomino', '2003-08-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Billi', '1996-04-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Ludovico', 'Spisani', '1997-03-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Fontana', '2002-10-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Pellacani', '1992-04-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Altruda', '1980-02-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Silba', '1981-06-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Bonati', '1981-09-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Ilari', '1981-12-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Ettore', 'Bolelli', '1982-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Maisto', '1982-02-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Brogi', '1982-08-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianfranco', 'Barioni', '1982-11-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Pallavicini', '1983-05-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Mazzoni', '1983-10-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Benfenati', '1984-03-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Romano', 'Bastianini', '1984-09-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Enea', 'Marini', '1984-11-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Bagnaia', '1986-10-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Giovinazzi', '1986-11-27', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Lucarelli', '1987-09-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Fuoco', '1987-12-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Simoncelli', '1989-06-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Iannone', '1989-08-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Cairoli', '1989-08-14', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Dovizioso', '1989-10-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Dall\'Igna', '1990-02-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Binotto', '1990-04-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Arrivabene', '1990-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Maurizio', 'Lamborghini', '1991-02-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Ferrari', '1990-03-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Enzo', 'Malaguti', '1991-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Introna', '1991-07-31');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mario', 'Zoia', '1991-09-08', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Renato', 'Prodi', '1992-02-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Romano', 'Franceschini', '1992-09-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Elia', 'Franchini', '1994-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Valli', '1994-06-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Manini', '1994-09-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Manassero', '1995-07-11', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Matteo', 'Molinari', '1995-09-14', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Migliozzi', '1995-12-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Guido', 'Molinari', '1996-02-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Pavan', '1996-12-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Laporta', '1996-12-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Scalise', '1997-02-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Bertasio', '1997-03-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'De Leo', '1997-04-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Zucchetti', '1997-09-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Bergamaschi', '1998-10-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Trinchero', '2000-02-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianmaria', 'Cianchetti', '2000-07-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Parenti', '2000-08-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Agnelli', '1954-07-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Vittorio', 'Nervi', '2001-02-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Bitta', '2002-03-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Paolo', 'Rogi', '2002-10-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Silvano', 'Ghesizzi', '2003-08-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Olmo', 'De Marinis', '2003-09-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Augusto', 'Auditore', '1951-10-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Ezio', 'Capelli', '2004-12-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Ambrosini', '2005-01-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Brambilla', '1979-04-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Ponti', '2005-01-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'D\'Agostino', '1996-12-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Bettini', '1994-10-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mario', 'Antonini', '1981-08-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Della Chiesa', '1986-09-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Piantedosi', '1981-03-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Acquafresca', '1994-10-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Pasquato', '2000-10-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Morleo', '2001-09-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Archimede', 'Soriano', '1979-08-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Roberto', 'Poli', '1980-04-23', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Di Vaio', '1985-08-22', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Diamanti', '1991-05-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Giaccherini', '1993-05-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Insigne', '1988-01-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Gabriellini', '1988-08-27');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Antonio', 'Frescobaldi', '1990-04-07', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Claudio', 'Manfredini', '1971-11-09', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Caprini', '1990-07-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Allevi', '1996-03-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Muti', '1989-04-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Aldo', 'Sordi', '1990-01-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Martelli', '1994-08-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Moreno', 'Bianchi', '2000-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Giampaolo', 'Marchesini', '2000-05-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Moretti', '1965-11-01');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Costantino', 'Rocca', '1956-12-04', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Maurizi', '2000-08-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Locatelli', '2000-11-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Santini', '2000-12-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Sangiuliani', '1978-05-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'De Lorenzi', '2001-01-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Viserni', '2001-09-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Cantagalli', '2001-09-23');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Baroni', '2001-11-25', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Bastianelli', '2001-12-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Gallieri', '2002-09-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Andalò', '2002-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Renato', 'Zerini', '2003-07-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfredo', 'Colombo', '2003-08-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Magellano', '2004-08-23');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Franco', 'Pesci', '1994-08-29', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Goriziani', '2004-10-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Aventino', '1984-12-18', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giorgio', 'Fattori', '2004-12-25', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Maurizio', 'Lega', '2005-01-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Luce', '2005-02-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Matteotti', '2005-03-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Mambelli', '2005-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Luciano', 'D\'Amato', '2005-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Pratelli', '1990-12-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Cavalieri', '1991-06-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Adriano', 'Stallieri', '1991-06-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Mariani', '1991-10-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Fabi', '1993-02-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Dario', 'Giannelli', '1993-05-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Daddario', '1993-08-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'D\'Onofrio', '1993-08-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Giustapposti', '1993-10-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Troncon', '1993-10-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Tito', 'Tavernelli', '1993-12-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Teodoro', 'Orsini', '1994-02-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Maurizio', 'Corsini', '1995-04-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfredo', 'Verdi', '1995-11-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Simone', 'Bruschi', '1996-01-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Bevilacqua', '1996-06-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Fulvio', 'Rossellini', '1997-02-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianni', 'Amato', '1997-06-15', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Merighi', '1997-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Piantanida', '1998-05-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Bernardini', '1999-02-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Vasti', '1999-04-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Antonio', 'Peschini', '1999-06-18', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giorgio', 'Muratori', '1999-08-30', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Rodolfo', 'Andalusini', '1999-11-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Vito', 'Adorni', '1999-12-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Camillini', '1980-05-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Vestalini', '1980-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Piero', 'Fiorentini', '1980-11-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Damiano', 'Betti', '1980-12-29');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Antonio', 'Battisti', '1981-01-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Mantellini', '1981-03-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Gandolfi', '1982-09-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Gaudenti', '1982-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Martorano', '1981-06-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Verdi', '1982-10-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Piloni', '1982-10-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Cavallini', '1984-01-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Presti', '1984-11-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Fausto', 'Martinelli', '1985-03-06');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Zampati', '1985-04-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfredo', 'Testoni', '1985-06-16');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Fabio', 'Castorini', '1985-09-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lucio', 'Mastrota', '1985-10-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Guido', 'Buscaroni', '1958-12-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianandrea', 'Castelli', '1986-06-27');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Fossa', '1986-07-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Beltrani', '1986-08-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Benedettini', '1987-03-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Pacelli', '1988-04-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Ascanio', 'Torreggiani', '1989-05-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Paolini', '1989-08-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Paolo', 'Cavalli', '1989-11-19', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Tosarelli', '1990-02-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Bucci', '1990-03-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Attilio', 'Genovesi', '1990-11-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Maurizio', 'Caia', '1990-11-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Sarti', '1991-05-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonello', 'Venturi', '1991-07-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Marchi', '1991-07-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Marchesini', '1991-12-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Enea', 'Andreoli', '1992-08-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Achille', 'Tabanelli', '1993-02-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Vaselli', '1993-10-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Callegati', '1983-11-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Santi', '1994-06-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Marino', 'Costa', '1994-08-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Cazzari', '1995-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Mattioli', '1995-12-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Cataldo', '1996-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Martinelli', '1996-10-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Martino', 'Alberici', '1997-01-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'De Giglio', '1997-09-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Castaldini', '1997-11-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Maurizio', 'Abbiati', '1998-11-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Darmian', '1999-01-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Masini', '1999-01-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Domenico', 'Bertini', '1999-02-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Ludovico', 'Bini', '1999-04-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Novelli', '2000-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Pisani', '2000-05-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Ciro', 'Esposito', '2000-08-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Marchi', '2000-10-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivano', 'Fabbri', '2001-03-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Lorenzani', '2001-08-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Bifulco', '2001-11-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Mandolfi', '2001-12-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Casta', '2001-12-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Peroni', '2002-07-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Cola', '2002-08-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Dutu', '2002-12-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Tudor', '2003-08-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Poggioli', '2004-02-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Zama', '2004-04-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Albertini', '2004-05-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Scaio', '2004-06-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Pagani', '2004-08-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Cacciapuoti', '2005-02-11');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Antimo', 'Tinaglia', '2005-03-11', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Pinza', '2005-08-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Ivan', 'Caselli', '2000-03-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Giambi', '2000-07-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Pucci', '2001-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Vivacqua', '2001-01-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Andriulo', '2001-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Costantini', '2002-01-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Matti', '2002-02-28');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Osti', '2003-12-18', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Puglioli', '2002-10-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Panetti', '2003-05-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'La Medica', '2003-06-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Betti', '2003-08-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicholas', 'Mucollari', '2003-12-15');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Flavio', 'Rodolfi', '2004-01-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Rossi', '2004-07-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Dennis', 'Gironi', '2004-10-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Canu', '2004-12-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Danilo', 'Balboni', '2005-04-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Foresta', '2005-04-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Tortoro', '2005-05-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Pesci', '2005-07-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Zoccarelli', '2005-10-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Biacchessi', '2005-11-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Dranga', '2005-11-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Sebastian', 'Vignoli', '1990-11-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Gabrielli', '1991-03-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Bravi', '1991-11-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Ventura', '1992-10-06');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Simone', 'Ferri', '1993-03-18', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Ferar', '1993-06-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luca', 'Baraldini', '1994-03-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Balestra', '1994-04-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Fabio', 'Dagos', '1994-09-18', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Orsi', '1994-12-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Marchesini', '1995-02-21');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gabriele', 'Fogliamanzillo', '1995-11-27', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Zignani', '1996-04-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Vignola', '1996-04-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Mariani', '1996-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Manuel', 'Madeo', '1996-08-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Maccioni', '1996-11-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Germano', 'Poggi', '1998-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Fiordelisi', '1998-05-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Ferruzzi', '1998-05-29');
insert into tesserati(nome, cognome, datadinascita, eraprofessionista)
values ('Ernesto', 'Marini', '1959-12-27', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giovanni', 'Locatelli', '1998-08-31', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Guerra', '1998-09-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Valentini', '1999-05-01');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Massari', '1999-07-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Ravaglioli', '1990-02-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Sanzani', '1990-09-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Daniele', 'Fabbri', '1990-09-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Buzzi', '1991-05-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Samir', 'Carloni', '1991-10-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Venturini', '1992-01-02');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Riccardo', 'Addimando', '1993-05-06', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Colombarini', '1973-06-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Salvatore', 'Canali', '1993-09-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Incanti', '1994-09-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Edoardo', 'Tumedei', '1995-07-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Andreoli', '1996-09-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Gardelli', '1996-11-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Gollinucci', '1996-12-27', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Capelli', '1997-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Tobia', 'Guizzarelli', '1007-08-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Samori', '1997-10-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Bazzocchi', '1997-10-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alan', 'Zavalloni', '1998-01-10', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Jacopo', 'Porrari', '1998-05-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Pasquale', 'Lomuscio', '1998-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Jonathan', 'Gaggi', '1998-08-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Ettore', 'Bongiovanni', '1998-08-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Zampa', '1999-03-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Montaletti', '1999-09-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Lorenzi', '1981-02-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Tiberio', 'Rondoni', '1981-03-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Riccardo', 'Prugnoli', '1981-03-25', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Silvani', '1981-12-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Pinardi', '1982-07-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Busi', '1982-07-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Capodanno', '1982-08-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Lipparini', '1982-10-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Corti', '1983-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Storoni', '1983-02-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Umberto', 'Gherardi', '1983-07-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Pampaloni', '1983-08-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Galletti', '1984-03-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianmaria', 'Giovannini', '1984-04-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Alex', 'Mantuano', '1984-05-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Maranesi', '1985-01-04', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Garofalo', '1985-04-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Morselli', '1986-03-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mattia', 'Bianchi', '1986-10-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Grandi', '1987-06-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giulio', 'Giusti', '1987-08-15', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Braga', '1988-06-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'De Santis', '1988-09-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Dallura', '1989-01-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Campion', '1989-08-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Candini', '1990-01-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Elia', 'Flora', '1996-04-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Iannuzzi', '1993-12-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Rubino', '1991-08-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Piacenti', '1997-09-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Baraldi', '1998-04-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Ghignatti', '1999-05-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Nicola', 'Berardi', '1990-07-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Cantonari', '1992-12-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Antonacci', '1994-11-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Fantoni', '1993-05-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Mirco', 'Perini', '1993-04-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Santi', '1997-07-16');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alessandro', 'Conti', '1991-10-10', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Lascala', '1990-05-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Saltarelli', '1995-03-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'De Paola', '1992-08-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Thomas', 'Gramigni', '1994-07-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Alex', 'Amanti', '1995-06-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Guzzinati', '1999-05-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Porcari', '1994-04-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Daniele', '1991-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Salvatore', 'Zini', '1995-01-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Guseli', '1998-02-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Valentino', 'Salvarezza', '1996-11-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Kevin', 'Masetti', '1993-02-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Diego', 'Lucchi', '1998-10-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianluca', 'Tonelli', '1992-06-29', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Angelini', '1991-03-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Lapi', '1990-04-12');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Klima', 'Stana', '1999-08-09', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alex', 'Bonesio', '1999-09-08');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giorgio', 'Mazzacurati', '1980-09-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Sanna', '1980-09-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Giulio', 'Minelli', '1981-02-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Cavalli', '1981-07-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Gigli', '1982-01-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Filippo', 'Divera', '1982-02-11', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Micheletti', '1982-06-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Franco', 'Petrucci', '1984-04-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Minarini', '1985-02-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Mazza', '1985-04-23');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alessandro', 'Galletti', '1985-08-09', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Tiziano', 'Saltarelli', '1986-10-16', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Samuele', 'Pugliese', '1986-12-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Fontana', '1987-02-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Rizzi', '1987-04-12');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Riccardo', 'Carboni', '1987-04-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Diego', 'Casanova', '1960-11-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'Mandelli', '1987-09-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Calvo', '1988-01-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Gabriele', 'Campagna', '1988-03-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Stoduto', '1988-06-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Costantino', 'Romagnoli', '1988-08-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Matteo', 'Mazzanti', '1988-12-26', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Baccianti', '1989-03-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Camagni', '1989-07-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Mark', 'Inserra', '1991-04-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Busni', '1991-04-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Martineli', '1991-10-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Gaetano', 'Abbate', '1992-08-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Gabriele', '1993-03-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Alberici', '1993-04-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Pignatti', '1993-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Farina', '1993-09-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Montano', '1993-10-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Bettelli', '1994-01-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Monti', '1994-09-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Alan', 'Fornasari', '1995-01-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuel', 'Nascetti', '1995-11-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Gradauer', '1996-02-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Pugliese', '1996-10-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Petrolini', '1996-11-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Cicognani', '1997-02-27');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giorgio', 'Mastroianni', '1997-07-25', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Cornacchia', '1997-05-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Mazziotta', '1997-06-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Biffoni', '1997-06-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Passatempi', '1997-07-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Moscatiello', '1997-10-28');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Nicholas', 'Sandri', '1998-05-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Gemelli', '1998-05-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Fazio', '1988-11-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Domenico', 'Santangelo', '1991-09-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lucio', 'Trapani', '1999-08-30', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Valentini', '2000-03-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Cagliero', '2000-06-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Zambellini', '2000-06-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Gregorio', 'Antonini', '2000-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'D\'Agostino', '2000-10-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Palmucci', '2000-12-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Sansone', '2001-07-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Filippini', '2001-08-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Calabria', '2001-11-11');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Andrea', 'Mastellari', '2001-12-11', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alex', 'Ferretti', '2002-04-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Bernardi', '2002-08-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Bergitto', '2003-03-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Achiluzzi', '2003-06-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Gasparini', '2003-11-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Pagani', '2003-12-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimiliano', 'Pelloni', '2004-01-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Caldas', '2004-04-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Grandis', '2004-11-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Finocchiaro', '2004-12-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Angelo', 'Corsi', '2005-08-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianmaria', 'Visani', '2005-09-27');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Biagini', '1994-10-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Pozza', '1991-12-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Lelli', '1992-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Brini', '1995-06-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Raffaele', 'Fiorini', '1991-05-31');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Emilio', 'Pedini', '1990-07-22', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Benedetto', 'Barone', '1997-09-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Sauro', 'Panfini', '1996-10-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Martino', 'Fiorini', '1999-04-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Danilo', 'Ghini', '1999-04-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Sammarchi', '1991-09-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Saitta', '1995-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Aulisa', '1996-03-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Lazzaro', '1991-02-26', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Damiano', 'Guidi', '1995-05-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Buonanno', '1999-08-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Mattia', 'Malengo', '1994-10-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Marabini', '1993-11-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Chiofalo', '1990-03-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Totti', '1993-08-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Cherubini', '1998-12-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Massimiliano', 'Valitutti', '1993-11-09', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Ignazio', 'Boschetti', '1990-09-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Valsecchi', '1995-03-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Bobbi', '1994-04-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Vanzini', '2000-02-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Malanchino', '2000-04-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Bosca', '2000-11-16');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Pasquale', 'Fiorillo', '2000-12-24', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Dario', 'Ligotti', '2001-02-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Colasanti', '2001-03-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuliano', 'Calza', '2001-04-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivano', 'Serrantoni', '1953-10-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Maggio', '2001-07-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Manfredi', '2002-02-06');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Claudio', 'Pupellini', '2002-07-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Eugenio', 'Contenti', '2002-08-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Rocco', 'Giallini', '2002-08-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Aversano', '2002-11-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Paoli', '2003-01-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Stefano', 'Fresi', '2003-02-20', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Pietro', 'Panni', '1971-08-14', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Bolle', '2003-10-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Ciro', 'Priello', '2001-11-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Angelo', 'Recchia', '2003-11-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Alimenti', '2004-05-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Ludovico', 'Tersigni', '2004-06-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Burroni', '2004-11-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Aremi', '2004-12-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Mengoni', '2005-02-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Chiapponi', '2005-03-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Walter', 'Mengucci', '2005-12-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Ramazzotti', '1960-01-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Ettore', 'Zatta', '1961-04-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Nolasco', '1962-04-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Castellari', '1963-12-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Poccia', '1963-03-02');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Simone', 'Guidone', '1963-03-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfredo', 'Rosetta', '1964-01-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Silvio', 'Pisanu', '1964-04-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Canova', '1965-02-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianni', 'Insigne', '1966-02-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Federici', '1967-02-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Beccucci', '1969-09-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Seccia', '1970-04-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Marabini', '1970-11-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Bannò', '1971-03-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Pirozzi', '1971-07-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Prosatore', '1972-01-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Nicolini', '1972-12-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Manuele', 'Soave', '1973-09-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Mottica', '1975-07-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Marchi', '1976-02-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Palmieri', '1976-11-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Perciavalle', '1978-02-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Giorgetti', '1978-12-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Massimo', 'Piavani', '1980-01-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Montesi', '1980-02-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gabriel', 'Scarpa', '1975-10-10', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alex', 'Scotti', '1980-07-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Filippo', 'Orrei', '1980-07-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Somma', '1981-07-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Pasquale', 'Abbatangelo', '1981-10-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Ragno', '1982-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Di Martino', '1982-08-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Ludovico', 'Sorrentino', '1982-12-21');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Angelo', 'Fidato', '1983-09-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Silvestrini', '1984-08-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Cuomo', '1984-10-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Domenico', 'Palmeri', '1985-10-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Castellito', '1987-01-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Amantini', '1987-04-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Moreno', 'Catello', '1987-12-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Cesare', 'Longobardi', '1988-04-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Michele', 'Solimene', '1989-01-16', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Michele', 'Ferrara', '1989-02-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Piccioli', '1989-02-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Pierpaolo', 'Rigatti', '1989-02-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Maurizio', 'Venturi', '1989-02-26', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Lancillotti', '1989-03-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Russo', '1989-05-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Vittorio', 'Fusco', '1989-06-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Giancarlo', 'Salerno', '1990-05-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Dario', 'Savastano', '1990-09-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Salvatore', 'Favalezza', '1990-09-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Vittorio', 'Iavazzi', '1990-10-21', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Armando', 'Torchia', '1991-06-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Carlino', '1991-08-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Scafa', '1991-11-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Lattanzi', '1991-12-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Einaudi', '1992-06-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Ludovico', 'Avolio', '1992-08-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Esposito', '1993-02-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Donia', '1993-07-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Pierluigi', 'Caressa', '1994-01-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Fabio', 'Bergomi', '1994-06-02', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Pardo', '1995-02-07');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Pierluigi', 'Orefici', '1995-09-27', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Galasso', '1995-10-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Di Caprio', '1996-01-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Leonardo', 'Sabatino', '1996-04-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Paolillo', '1996-10-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Olandese', '1997-02-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Mascolo', '1997-03-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Bruno', 'Cuomo', '1997-06-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Gennaro', 'Fusco', '1997-09-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Fantuzzi', '1998-08-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Brini', '1990-06-08', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Paolo', 'Cerati', '1991-06-11', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Montanari', '1991-08-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Minghetti', '1991-10-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Dario', 'Buffoni', '1992-08-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Aldo', 'Santarelli', '1992-12-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Campisi', '1993-06-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Campisanti', '1993-09-30', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Visardini', '1994-07-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Alboreto', '1994-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Todaro', '1994-09-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Raimondo', 'Scuderi', '1995-04-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Giacomo', 'Musetti', '1996-01-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Caccamo', '1996-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Carmelo', 'Trapanese', '1996-02-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Ernesto', 'Garibaldi', '1996-03-09');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giuseppe', 'Coiro', '1996-03-14', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Tiziano', 'Baiocco', '1996-06-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Lodi', '1996-12-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Marchese', '1997-09-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Galluzzo', '1998-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Bosco', '1969-04-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Baggio', '1998-03-05');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Roberto', 'Battaglia', '1998-04-07', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Lorenzo', 'Ognibene', '1998-06-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Vito', 'Ghermandi', '1999-10-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicolò', 'Campagnuolo', '2000-04-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Salvatore', 'Balestrini', '2001-01-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Fina', '2001-03-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Saporito', '2001-03-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Sergio', 'Secco', '2002-03-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Chiaretto', '2002-04-14');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Zanuso', '2002-05-08', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Claudio', 'Giusto', '2002-06-04', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristiano', 'Polloni', '2002-07-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Rosita', '2002-11-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Carnevale', '2002-12-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Dario', 'Vanoncini', '2002-12-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Alberto', 'Petroni', '2003-02-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Rino', 'Pavoni', '2003-08-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Idini', '2004-02-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Liberati', '2003-03-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Melilli', '2004-05-25');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimiliano', 'Semola', '2004-09-18');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Emanuele', 'Gelonese', '2004-09-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Gritti', '2005-04-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Massimo', 'Togna', '1987-12-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alfonso', 'Tommasoni', '2005-05-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Reges', '2005-06-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Bramante', '2005-07-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Matteo', 'Restieri', '2005-07-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Costantino', 'Elcino', '2005-12-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Sandro', 'Donvito', '1980-01-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincent', 'Ercoli', '1980-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Flavio', 'Selva', '1980-09-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Armando', 'Lentino', '1981-02-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Guglielmo', 'Borrelli', '1981-06-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giuseppe', 'Mantovani', '1981-10-29', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fernando', 'Pepe', '1982-01-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessio', 'Bonomo', '1982-07-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Ennio', 'Ruocco', '1982-08-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Emanuele', 'Bonfanti', '1982-12-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Angelo', 'Antonetti', '1983-09-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Barba', '1983-10-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Rappa', '1984-06-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Lotito', '1984-08-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Loiacono', '1985-02-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Patrizio', 'Di Stefano', '1985-05-19');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Vito', 'Ricciarelli', '1985-08-20', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Cuorleone', '1986-12-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Giotto', 'Romeo', '1988-01-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristiano', 'Fiorini', '1988-03-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Petulla', '1988-03-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Pietro', 'Marsico', '1989-09-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Rocco', 'Malanca', '1989-10-13');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Mariocco', '1980-02-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Eugenio', 'Carloni', '1980-04-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Caprio', '1981-07-03');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giuseppe', 'Ciocca', '1981-10-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Zorzi', '1981-10-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Orefice', '1982-05-02');
insert into tesserati(nome, cognome, datadinascita, eraprofessionista)
values ('Giuseppe', 'Monari', '1960-01-28', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Roberto', 'Paternuostro', '1982-05-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Manuel', 'Raso', '1982-07-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Barbato', '1983-03-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'Rangonini', '1984-04-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Damiano', 'Biagioni', '1983-05-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Fabio', 'Formenti', '1983-07-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Pietrosanti', '1984-01-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Tiziano', 'Pellegrini', '1984-02-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Stifani', '1984-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Nunzio', 'Lari', '1985-04-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Piccinni', '1985-04-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Giovenco', '1985-04-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Emilio', 'Picollo', '1985-10-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Jacopo', 'Giordano', '1985-12-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Colombo', '1986-09-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Cascone', '1988-01-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Damiano', 'Cutrino', '1989-01-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Mauro', 'Russo', '1989-07-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Ennio', 'Piagno', '1989-11-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Gianluca', 'Baiardo', '1990-01-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonello', 'Mazzoleni', '1990-02-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Savino', '1990-06-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Pozzi', '1991-06-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mauro', 'Spada', '1991-10-16', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Mauloni', '1992-01-23');
insert into tesserati(nome, cognome, datadinascita, eraprofessionista)
values ('Fabrizio', 'Cannone', '1961-08-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Paoliello', '1992-04-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Achille', 'Primavera', '1993-04-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristian', 'Bianco', '1993-07-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Luciano', 'Caputo', '1993-08-24', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Piero', 'Goffi', '1993-09-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Pinzani', '1993-09-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Riccardo', 'Petracca', '1994-03-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Telesi', '1994-10-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabrizio', 'Mottola', '1994-08-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Girelli', '1995-12-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Gaetano', 'Bosio', '1996-05-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Pagano', '1996-09-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Bartolotta', '1979-08-11', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Giuseppe', 'Pisaniello', '1996-10-13', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Pasquale', 'Clemente', '1996-10-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Bozzetto', '1997-04-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Nicola', 'Scarazzini', '1998-01-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Gianluca', 'Castellino', '1998-12-11');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Baroni', '1999-08-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Michele', 'Braga', '1990-07-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Enrico', 'Zatta', '1990-10-02');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Maurizio', 'Cattaneo', '1991-01-12', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Perillo', '1991-05-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Mario', 'Varga', '1991-08-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Villani', '1991-12-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Battistini', '1992-02-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Galioto', '1992-07-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Vincenzo', 'Boriello', '1992-08-20');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carmine', 'Morazzano', '1992-11-30', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Giordano', '1993-10-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Paciotti', '1993-11-30');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Marco', 'Ranieri', '1978-09-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Mutti', '1994-04-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Moreno', 'Sanna', '1994-08-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Bettoni', '1994-11-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Vincenzi', '1995-12-13');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Francesco', 'Mariani', '1996-10-26', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Daniele', 'D\'Amico', '1997-11-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Cosimo', 'Scacchi', '1998-04-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Ciarelli', '1998-04-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Antonio', 'Branchetti', '1998-06-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Carlo', 'Binotti', '1998-09-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Aron', 'Giurgola', '1999-03-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Guido', 'Feroleto', '1961-05-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Simone', 'Abeti', '1999-11-03', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Raffaele', 'Molluso', '1980-07-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Arturo', 'Rozza', '1981-02-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Tommaso', 'Matani', '1981-11-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Elia', 'Bertolin', '1968-06-12');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Roberto', 'Ghittoni', '1983-03-27', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Roffi', '1983-04-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Scamperle', '1983-08-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Ellero', '1983-09-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Paolo', 'Parodi', '1984-06-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Pizzuto', '1984-07-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Damiano', 'Zanetti', '1984-09-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Patrizio', 'Favilli', '1984-09-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Salemi', '1984-12-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Giulio', 'Pilozzi', '1985-02-04');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Renzo', 'Chiarella', '1985-04-28', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Gregorio', 'Tomaselli', '1985-05-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Danilo', 'Gallinella', '1985-06-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Capuani', '1986-05-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Angelo', 'Giordano', '1986-06-18');
insert into tesserati(nome, cognome, datadinascita)
values ('Igor', 'Trevisani', '1966-03-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Schettino', '1986-10-10');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Calzone', '1987-05-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Claudio', 'Vanzolini', '1987-10-29');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Tatti', '1988-07-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Casellini', '1989-04-02');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Mario', 'Fardello', '2000-02-18', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Fonseca', '2000-06-12');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Corrado', 'Buriola', '1971-11-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Cristiano', 'Dini', '2000-07-01');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Angelo', 'Eposito', '2000-10-06', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Fassina', '2000-10-21');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Daniele', 'Benassi', '2001-04-05', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Fabio', 'Zanda', '2001-05-26');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Matteo', 'Del Podio', '1985-06-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Piero', 'Iannetta', '2001-08-01');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Tonghini', '2002-01-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Sebastiano', 'Fumaioli', '2002-02-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Diego', 'Garotti', '2002-11-04');
insert into tesserati(nome, cognome, datadinascita)
values ('Maurizio', 'Cesaro', '2002-11-21');
insert into tesserati(nome, cognome, datadinascita)
values ('Dario', 'Poli', '2002-12-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Corda', '2003-04-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Pagano', '2003-06-17');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Mezzadra', '2003-08-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Manno', '2003-10-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Carmelo', 'Mendicino', '2004-02-03');
insert into tesserati(nome, cognome, datadinascita)
values ('Tommaso', 'Simonetti', '2004-04-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Martinello', '2004-06-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Giuseppe', 'Roccia', '2004-08-15');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Erminio', 'Caperna', '2004-10-10', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Garenna', '2004-10-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Raffaele', 'Giannini', '2004-11-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Striano', '2005-08-02');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Brandi', '1971-05-28');
insert into tesserati(nome, cognome, datadinascita)
values ('Livio', 'Rizza', '1972-04-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Carlo', 'Asaro', '1972-06-12', 't');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alberto', 'Martucci', '1973-01-26', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Argentiero', '1973-11-24');
insert into tesserati(nome, cognome, datadinascita)
values ('Andrea', 'Denti', '1976-02-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Angelino', 'Osele', '1976-04-07');
insert into tesserati(nome, cognome, datadinascita)
values ('Federico', 'Mirabilio', '1977-09-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Emiliano', 'Santaterra', '1979-06-10');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Alessandro', 'Proscia', '1980-07-19', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Giovanni', 'Talpacci', '1981-01-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Scala', '1981-07-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Francesco', 'Baccolini', '1982-01-08');
insert into tesserati(nome, cognome, datadinascita)
values ('Filiberto', 'Stagni', '1987-02-09');
insert into tesserati(nome, cognome, datadinascita)
values ('Patrizio', 'Cioffi', '1987-02-14');
insert into tesserati(nome, cognome, datadinascita)
values ('Martino', 'Sabatiello', '1990-02-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Simone', 'Pittarello', '1990-12-25');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Thomas', 'Bernardello', '1993-02-09', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Massimo', 'Vitale', '1994-02-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Gennaro', 'Valle', '1994-03-22');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Davide', 'Arena', '1996-02-01', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Marcello', 'Sacco', '1997-07-31');
insert into tesserati(nome, cognome, datadinascita)
values ('Stefano', 'Scarallo', '2000-11-12');
insert into tesserati(nome, cognome, datadinascita, statusprofessionista)
values ('Claudio', 'Rispoli', '2000-11-23', 't');
insert into tesserati(nome, cognome, datadinascita)
values ('Valentino', 'Belotti', '1993-03-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Roberto', 'Massazza', '1993-04-19');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Sacchetto', '1993-07-23');
insert into tesserati(nome, cognome, datadinascita)
values ('Marco', 'Mistro', '1993-08-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Alessandro', 'Ranzi', '1993-11-12');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Bellani', '1994-02-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Samuele', 'Leone', '1994-11-22');
insert into tesserati(nome, cognome, datadinascita)
values ('Pino', 'Abeti', '1995-07-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Sandrolini', '1997-03-30');
insert into tesserati(nome, cognome, datadinascita)
values ('Giorgio', 'Montalti', '1997-02-26');
insert into tesserati(nome, cognome, datadinascita)
values ('Valerio', 'Alessi', '1999-02-06');
insert into tesserati(nome, cognome, datadinascita)
values ('Lorenzo', 'Benfenati', '2000-02-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Davide', 'Bonafè', '2000-05-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Luca', 'Gilmozzi', '2001-08-27');
insert into tesserati(nome, cognome, datadinascita)
values ('Saverio', 'Zanoni', '2002-12-05');
insert into tesserati(nome, cognome, datadinascita)
values ('Luigi', 'Ghinello', '2003-08-20');
insert into tesserati(nome, cognome, datadinascita)
values ('Dario', 'Santori', '2003-11-15');
insert into tesserati(nome, cognome, datadinascita)
values ('Ivan', 'Montebelli', '2004-05-16');
insert into tesserati(nome, cognome, datadinascita)
values ('Dante', 'Signori', '2004-08-23');

-- Table "certificati_medici"
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 3;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 4;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 5;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 6;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 7;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 8;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 9;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 10;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 11;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 12;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 13;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 14;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 15;
insert into certificati_medici(emissione, scadenza) values('2023-01-20', '2025-01-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 16;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 18;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 19;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 20;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 21;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 22;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 23;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 24;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 25;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 27;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 28;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 29;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 30;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 31;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 32;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 33;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 34;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 35;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 36;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 37;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 38;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 39;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 40;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 41;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 42;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 43;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 44;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 45;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 46;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 47;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 48;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 49;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 50;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 51;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 52;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 54;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 55;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 57;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 58;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 59;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 60;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 61;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 62;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 63;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 64;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 65;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 66;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 67;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 68;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 69;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 70;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 71;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 72;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 73;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 74;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 75;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 76;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 77;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 78;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 79;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 80;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 81;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 82;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 83;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 84;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 85;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 86;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 87;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 88;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 89;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 90;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 91;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 92;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 93;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 95;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 96;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 97;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 98;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 99;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 100;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 101;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 102;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 103;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 104;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 105;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 106;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 107;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 108;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 109;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 110;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 111;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 112;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 113;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 114;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 115;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 116;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 117;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 118;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 119;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 120;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 121;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 122;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 123;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 124;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 125;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 126;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 127;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 128;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 129;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 130;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 131;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 132;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 133;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 134;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 135;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 136;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 137;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 138;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 139;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 140;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 141;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 142;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 143;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 144;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 145;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 146;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 147;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 149;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 150;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 151;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 152;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 153;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 154;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 155;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 156;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 157;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 158;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 159;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 160;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 161;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 162;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 163;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 164;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 165;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 166;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 167;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 169;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 170;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 171;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 172;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 173;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 174;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 175;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 176;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 177;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 178;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 179;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 180;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 181;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 182;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 183;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 184;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 185;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 186;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 187;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 188;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 189;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 190;
insert into certificati_medici(emissione, scadenza) values('2023-03-26', '2025-03-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 191;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 192;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 193;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 194;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 195;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 196;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 197;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 198;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 199;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 200;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 201;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 202;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 203;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 204;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 205;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 206;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 207;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 208;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 209;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 210;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 211;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 212;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 213;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 214;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 215;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 216;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 217;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 218;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 219;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 220;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 221;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 222;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 223;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 224;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 225;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 226;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 227;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 228;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 229;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 232;
insert into certificati_medici(emissione, scadenza) values('2023-02-05', '2025-02-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 233;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 234;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 235;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 236;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 237;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 238;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 239;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 240;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 241;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 242;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 243;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 244;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 245;
insert into certificati_medici(emissione, scadenza) values('2023-01-20', '2025-01-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 246;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 247;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 248;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 249;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 250;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 251;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 252;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 253;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 254;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 255;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 256;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 257;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 258;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 259;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 260;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 261;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 262;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 263;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 264;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 265;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 266;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 267;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 268;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 269;
insert into certificati_medici(emissione, scadenza) values('2023-03-08', '2025-03-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 270;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 271;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 272;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 273;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 274;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 277;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 278;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 279;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 280;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 281;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 282;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 283;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 284;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 285;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 286;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 288;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 289;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 290;
insert into certificati_medici(emissione, scadenza) values('2023-01-20', '2025-01-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 291;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 292;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 293;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 294;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 295;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 296;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 297;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 298;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 299;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 300;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 301;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 302;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 303;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 304;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 305;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 306;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 307;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 308;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 309;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 310;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 311;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 312;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 313;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 314;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 315;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 316;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 317;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 318;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 319;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 320;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 321;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 322;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 323;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 324;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 325;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 326;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 327;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 328;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 329;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 330;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 331;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 332;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 333;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 334;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 335;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 336;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 337;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 338;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 339;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 340;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 341;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 342;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 344;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 345;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 346;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 347;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 348;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 349;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 350;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 351;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 352;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 353;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 354;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 355;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 356;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 357;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 358;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 359;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 360;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 361;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 362;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 363;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 364;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 365;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 366;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 367;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 368;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 369;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 370;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 371;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 372;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 373;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 374;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 375;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 376;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 377;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 378;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 379;
insert into certificati_medici(emissione, scadenza) values('2023-03-08', '2025-03-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 380;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 381;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 382;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 383;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 384;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 385;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 386;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 387;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 388;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 389;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 390;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 391;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 392;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 393;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 394;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 395;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 396;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 397;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 398;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 399;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 400;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 401;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 402;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 403;
insert into certificati_medici(emissione, scadenza) values('2023-02-05', '2025-02-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 404;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 405;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 406;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 407;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 408;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 409;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 410;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 411;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 412;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 413;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 414;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 415;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 416;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 417;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 418;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 419;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 420;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 421;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 422;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 423;
insert into certificati_medici(emissione, scadenza) values('2023-03-26', '2025-03-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 424;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 425;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 426;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 427;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 428;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 429;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 430;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 431;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 432;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 433;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 434;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 435;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 436;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 437;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 438;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 439;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 440;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 441;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 442;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 443;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 444;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 445;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 446;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 447;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 448;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 449;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 450;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 451;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 452;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 453;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 454;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 455;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 456;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 457;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 458;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 459;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 461;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 462;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 463;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 464;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 465;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 467;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 468;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 470;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 471;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 472;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 473;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 474;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 475;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 476;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 477;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 478;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 479;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 480;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 481;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 482;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 483;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 484;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 485;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 486;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 487;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 488;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 489;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 490;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 491;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 492;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 493;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 494;
insert into certificati_medici(emissione, scadenza) values('2023-03-26', '2025-03-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 496;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 497;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 498;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 499;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 500;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 501;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 502;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 503;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 504;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 505;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 506;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 507;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 508;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 509;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 510;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 511;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 512;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 513;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 514;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 515;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 516;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 517;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 518;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 519;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 520;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 521;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 522;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 523;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 524;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 525;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 526;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 527;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 528;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 529;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 530;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 531;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 532;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 533;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 534;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 535;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 536;
insert into certificati_medici(emissione, scadenza) values('2023-03-08', '2025-03-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 537;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 538;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 539;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 540;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 541;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 542;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 543;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 544;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 545;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 546;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 547;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 548;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 549;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 550;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 551;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 552;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 553;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 554;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 555;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 556;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 557;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 558;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 559;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 560;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 561;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 562;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 563;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 564;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 565;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 566;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 567;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 568;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 569;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 570;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 571;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 572;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 573;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 574;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 575;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 576;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 577;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 578;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 579;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 580;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 581;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 582;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 583;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 584;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 586;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 587;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 588;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 589;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 590;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 591;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 592;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 593;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 594;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 595;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 596;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 597;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 598;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 599;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 600;
insert into certificati_medici(emissione, scadenza) values('2023-03-08', '2025-03-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 601;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 602;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 603;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 604;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 605;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 606;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 607;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 608;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 609;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 610;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 611;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 612;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 613;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 614;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 615;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 616;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 617;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 618;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 619;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 620;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 621;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 622;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 623;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 624;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 625;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 626;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 627;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 628;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 629;
insert into certificati_medici(emissione, scadenza) values('2023-03-01', '2025-03-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 630;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 631;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 632;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 633;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 634;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 635;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 636;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 637;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 638;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 639;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 640;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 641;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 642;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 643;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 644;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 645;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 646;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 647;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 648;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 649;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 650;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 651;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 652;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 653;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 654;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 655;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 656;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 657;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 658;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 659;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 660;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 661;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 662;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 663;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 664;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 665;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 666;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 667;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 668;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 669;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 670;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 671;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 672;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 673;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 674;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 675;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 676;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 678;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 679;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 680;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 681;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 682;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 683;
insert into certificati_medici(emissione, scadenza) values('2023-02-05', '2025-02-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 684;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 685;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 686;
insert into certificati_medici(emissione, scadenza) values('2023-03-08', '2025-03-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 687;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 688;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 689;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 690;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 691;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 692;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 693;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 694;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 695;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 696;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 697;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 698;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 699;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 700;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 701;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 702;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 703;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 704;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 705;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 706;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 707;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 708;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 709;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 710;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 711;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 712;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 713;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 714;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 715;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 716;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 717;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 718;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 719;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 720;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 721;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 722;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 723;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 724;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 725;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 726;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 727;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 728;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 729;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 730;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 731;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 732;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 733;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 734;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 735;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 736;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 737;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 738;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 739;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 740;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 741;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 742;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 743;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 744;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 745;
insert into certificati_medici(emissione, scadenza) values('2023-02-07', '2025-02-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 746;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 747;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 748;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 749;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 750;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 751;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 752;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 753;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 754;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 755;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 756;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 757;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 758;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 759;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 760;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 761;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 762;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 763;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 764;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 765;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 766;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 768;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 769;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 770;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 771;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 772;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 773;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 774;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 775;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 776;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 777;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 778;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 779;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 780;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 781;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 782;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 783;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 784;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 785;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 786;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 787;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 788;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 789;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 790;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 791;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 792;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 793;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 794;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 795;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 796;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 797;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 798;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 799;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 800;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 801;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 803;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 804;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 805;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 806;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 807;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 808;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 809;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 810;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 811;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 812;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 813;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 814;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 815;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 816;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 817;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 818;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 819;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 820;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 821;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 822;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 823;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 824;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 825;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 826;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 827;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 828;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 829;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 830;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 831;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 832;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 833;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 834;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 835;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 836;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 837;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 838;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 839;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 840;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 841;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 842;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 843;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 844;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 845;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 846;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 847;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 848;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 849;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 850;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 851;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 852;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 853;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 854;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 855;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 856;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 857;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 858;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 859;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 860;
insert into certificati_medici(emissione, scadenza) values('2023-02-19', '2025-02-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 861;
insert into certificati_medici(emissione, scadenza) values('2023-01-29', '2025-01-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 862;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 863;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 864;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 865;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 866;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 867;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 868;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 869;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 870;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 871;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 872;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 873;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 874;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 875;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 876;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 877;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 878;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 879;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 880;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 881;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 882;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 883;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 884;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 885;
insert into certificati_medici(emissione, scadenza) values('2023-02-06', '2025-02-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 886;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 887;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 888;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 889;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 890;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 891;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 892;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 893;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 894;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 895;
insert into certificati_medici(emissione, scadenza) values('2023-03-29', '2025-03-29');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 896;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 897;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 898;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 899;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 900;
insert into certificati_medici(emissione, scadenza) values('2023-02-02', '2025-02-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 901;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 902;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 903;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 905;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 906;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 907;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 908;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 909;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 910;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 911;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 912;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 913;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 914;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 915;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 916;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 917;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 918;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 919;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 920;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 921;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 922;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 923;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 924;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 925;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 926;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 927;
insert into certificati_medici(emissione, scadenza) values('2023-03-09', '2025-03-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 928;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 929;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 930;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 931;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 932;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 933;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 934;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 935;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 936;
insert into certificati_medici(emissione, scadenza) values('2023-01-02', '2025-01-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 937;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 938;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 939;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 940;
insert into certificati_medici(emissione, scadenza) values('2023-02-15', '2025-02-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 941;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 942;
insert into certificati_medici(emissione, scadenza) values('2023-01-15', '2025-01-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 943;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 944;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 945;
insert into certificati_medici(emissione, scadenza) values('2023-01-11', '2025-01-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 946;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 947;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 948;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 949;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 950;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 951;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 952;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 953;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 954;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 955;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 956;
insert into certificati_medici(emissione, scadenza) values('2023-01-18', '2025-01-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 957;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 958;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 959;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 960;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 961;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 962;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 963;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 964;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 965;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 966;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 967;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 968;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 969;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 970;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 971;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 972;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 973;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 974;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 975;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 976;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 977;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 978;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 979;
insert into certificati_medici(emissione, scadenza) values('2023-01-20', '2025-01-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 980;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 981;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 982;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 983;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 984;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 985;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 986;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 987;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 988;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 989;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 990;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 991;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 992;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 993;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 994;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 995;
insert into certificati_medici(emissione, scadenza) values('2023-01-03', '2025-01-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 996;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 997;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 998;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 999;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1000;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1001;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1002;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1003;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1004;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1005;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1006;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1007;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1008;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1009;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1010;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1011;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1012;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1013;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1014;
insert into certificati_medici(emissione, scadenza) values('2023-01-20', '2025-01-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1015;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1016;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1017;
insert into certificati_medici(emissione, scadenza) values('2023-02-17', '2025-02-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1018;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1019;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1020;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1021;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1022;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1023;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1024;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1025;
insert into certificati_medici(emissione, scadenza) values('2023-03-27', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1026;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1027;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1028;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1029;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1030;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1031;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1032;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1033;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1035;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1036;
insert into certificati_medici(emissione, scadenza) values('2023-01-19', '2025-01-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1037;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1038;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1039;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1040;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1041;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1042;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1043;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1044;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1045;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1046;
insert into certificati_medici(emissione, scadenza) values('2023-02-05', '2025-02-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1047;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1048;
insert into certificati_medici(emissione, scadenza) values('2023-03-15', '2025-03-15');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1049;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1050;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1051;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1052;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1053;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1054;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1055;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1056;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1057;
insert into certificati_medici(emissione, scadenza) values('2023-03-19', '2025-03-19');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1058;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1059;
insert into certificati_medici(emissione, scadenza) values('2023-01-23', '2025-01-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1061;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1062;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1063;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1064;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1065;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1066;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1067;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1068;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1069;
insert into certificati_medici(emissione, scadenza) values('2023-01-27', '2025-01-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1070;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1071;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1072;
insert into certificati_medici(emissione, scadenza) values('2023-01-06', '2025-01-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1073;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1074;
insert into certificati_medici(emissione, scadenza) values('2023-01-26', '2025-01-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1075;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1076;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1077;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1078;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1079;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1080;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1081;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1082;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1083;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1084;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1085;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1086;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1087;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1088;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1089;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1090;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1091;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1092;
insert into certificati_medici(emissione, scadenza) values('2023-02-12', '2025-02-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1093;
insert into certificati_medici(emissione, scadenza) values('2023-03-28', '2025-03-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1094;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1095;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1096;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1097;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1098;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1099;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1100;
insert into certificati_medici(emissione, scadenza) values('2023-03-21', '2025-03-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1101;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1102;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1103;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1104;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1105;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1106;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1107;
insert into certificati_medici(emissione, scadenza) values('2023-03-18', '2025-03-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1108;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1110;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1111;
insert into certificati_medici(emissione, scadenza) values('2023-03-11', '2025-03-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1112;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1113;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1114;
insert into certificati_medici(emissione, scadenza) values('2023-02-14', '2025-02-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1115;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1116;
insert into certificati_medici(emissione, scadenza) values('2023-03-06', '2025-03-06');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1117;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1118;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1119;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1120;
insert into certificati_medici(emissione, scadenza) values('2023-03-16', '2025-03-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1121;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1122;
insert into certificati_medici(emissione, scadenza) values('2023-01-12', '2025-01-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1123;
insert into certificati_medici(emissione, scadenza) values('2023-02-10', '2025-02-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1124;
insert into certificati_medici(emissione, scadenza) values('2023-01-07', '2025-01-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1125;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1126;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1127;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1128;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1129;
insert into certificati_medici(emissione, scadenza) values('2023-01-16', '2025-01-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1130;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1131;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1132;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1133;
insert into certificati_medici(emissione, scadenza) values('2023-02-25', '2025-02-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1134;
insert into certificati_medici(emissione, scadenza) values('2023-02-18', '2025-02-18');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1135;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1136;
insert into certificati_medici(emissione, scadenza) values('2023-01-28', '2025-01-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1137;
insert into certificati_medici(emissione, scadenza) values('2023-03-13', '2025-03-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1138;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1139;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1140;
insert into certificati_medici(emissione, scadenza) values('2023-02-03', '2025-02-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1141;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1142;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1143;
insert into certificati_medici(emissione, scadenza) values('2023-01-08', '2025-01-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1144;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1145;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1146;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1147;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1148;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1149;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1150;
insert into certificati_medici(emissione, scadenza) values('2023-02-01', '2025-02-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1151;
insert into certificati_medici(emissione, scadenza) values('2023-03-03', '2025-03-03');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1152;
insert into certificati_medici(emissione, scadenza) values('2023-02-27', '2025-02-27');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1153;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1154;
insert into certificati_medici(emissione, scadenza) values('2023-02-21', '2025-02-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1155;
insert into certificati_medici(emissione, scadenza) values('2023-03-07', '2025-03-07');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1156;
insert into certificati_medici(emissione, scadenza) values('2023-02-26', '2025-02-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1157;
insert into certificati_medici(emissione, scadenza) values('2023-01-30', '2025-01-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1159;
insert into certificati_medici(emissione, scadenza) values('2023-03-20', '2025-03-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1160;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1161;
insert into certificati_medici(emissione, scadenza) values('2023-01-31', '2025-01-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1162;
insert into certificati_medici(emissione, scadenza) values('2023-02-22', '2025-02-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1163;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1164;
insert into certificati_medici(emissione, scadenza) values('2023-03-22', '2025-03-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1165;
insert into certificati_medici(emissione, scadenza) values('2023-01-14', '2025-01-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1166;
insert into certificati_medici(emissione, scadenza) values('2023-02-28', '2025-02-28');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1167;
insert into certificati_medici(emissione, scadenza) values('2023-01-21', '2025-01-21');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1168;
insert into certificati_medici(emissione, scadenza) values('2023-03-25', '2025-03-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1169;
insert into certificati_medici(emissione, scadenza) values('2023-02-23', '2025-02-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1170;
insert into certificati_medici(emissione, scadenza) values('2023-02-13', '2025-02-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1171;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1172;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1173;
insert into certificati_medici(emissione, scadenza) values('2023-01-25', '2025-01-25');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1174;
insert into certificati_medici(emissione, scadenza) values('2023-03-26', '2025-03-26');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1175;
insert into certificati_medici(emissione, scadenza) values('2023-01-17', '2025-01-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1176;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1177;
insert into certificati_medici(emissione, scadenza) values('2023-01-09', '2025-01-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1178;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1179;
insert into certificati_medici(emissione, scadenza) values('2023-01-10', '2025-01-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1180;
insert into certificati_medici(emissione, scadenza) values('2023-03-10', '2025-03-10');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1181;
insert into certificati_medici(emissione, scadenza) values('2023-03-17', '2025-03-17');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1182;
insert into certificati_medici(emissione, scadenza) values('2023-03-04', '2025-03-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1183;
insert into certificati_medici(emissione, scadenza) values('2023-02-09', '2025-02-09');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1184;
insert into certificati_medici(emissione, scadenza) values('2023-01-13', '2025-01-13');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1185;
insert into certificati_medici(emissione, scadenza) values('2023-03-23', '2025-03-23');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1186;
insert into certificati_medici(emissione, scadenza) values('2023-02-04', '2025-02-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1187;
insert into certificati_medici(emissione, scadenza) values('2023-01-22', '2025-01-22');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1188;
insert into certificati_medici(emissione, scadenza) values('2023-03-14', '2025-03-14');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1189;
insert into certificati_medici(emissione, scadenza) values('2023-03-30', '2025-03-30');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1190;
insert into certificati_medici(emissione, scadenza) values('2023-03-12', '2025-03-12');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1191;
insert into certificati_medici(emissione, scadenza) values('2023-02-11', '2025-02-11');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1192;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1193;
insert into certificati_medici(emissione, scadenza) values('2023-01-05', '2025-01-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1194;
insert into certificati_medici(emissione, scadenza) values('2023-03-02', '2025-03-02');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1195;
insert into certificati_medici(emissione, scadenza) values('2023-03-05', '2025-03-05');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1196;
insert into certificati_medici(emissione, scadenza) values('2023-02-08', '2025-02-08');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1197;
insert into certificati_medici(emissione, scadenza) values('2023-02-16', '2025-02-16');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1198;
insert into certificati_medici(emissione, scadenza) values('2023-01-01', '2025-01-01');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1199;
insert into certificati_medici(emissione, scadenza) values('2023-03-31', '2025-03-31');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1200;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 148;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 230;
insert into certificati_medici(emissione, scadenza) values('2023-02-24', '2025-02-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 275;
insert into certificati_medici(emissione, scadenza) values('2023-02-20', '2025-02-20');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 276;
insert into certificati_medici(emissione, scadenza) values('2023-03-24', '2025-03-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 287;
insert into certificati_medici(emissione, scadenza) values('2023-01-04', '2025-01-04');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 343;
insert into certificati_medici(emissione, scadenza) values('2023-01-24', '2025-01-24');
update tesserati set numcertificato = (select max(numcertificato) from certificati_medici) where numtessera = 1158;

-- Table "gare"
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Sale d\'Oro 2024', 3, '2024-04-01', 'd', '2024-03-23', 'Adriatic Golf Cervia', 'Rosso-Giallo', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa del Garda 2024', 1, '2024-04-05', 'd', '2024-03-28', 'Garda Golf and Country Club', 'Rosso-Bianco', 'g');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Milano Golf Cup 2024', 2, '2024-04-08', 'p', '2024-04-03', 'Golf Club Milano', '1-2', 'c');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('82a coppa del Re', 3, '2024-04-11', 'd', '2024-04-07', 'Golf Royal Park i Roveri', 'Allianz Course', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, maxiscritti, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Open d\'Italia 2024', 4, '2024-04-15', 'p', 100, '2024-01-01', 'Adriatic Golf Cervia', 'Rosso-Giallo', 'a');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Puglia Classic 2024', 1, '2024-04-20', 'd', '2024-04-13', 'Acaya Golf Resort', 'Championship', 'g');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa del Conte 2024', 2, '2024-04-22', 'd', '2024-04-15', 'Circolo Golf dell\'Ugolino', 'Championship', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('III Stella d\'Oro', 3, '2024-04-26', 'd', '2024-04-19', 'Olgiata Golf Club', 'Ovest', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa del Castello 2024', 2, '2024-05-01', 'd', '2024-04-23', 'Golf Club Le Fonti', 'Championship', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Cancelletto d\'Oro 2024', 3, '2024-05-05', 'd', '2024-04-28', 'Golf Club Villa Condulmer', 'Championship', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Campionato Nazionale Open 2024', 3, '2024-05-09', 'p', '2024-05-02', 'Golf Nazionale', 'Carta', 'b');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Modena Golf Cup 2024', 2, '2024-05-13', 'd', '2024-05-06', 'Modena Golf and Country Club', 'Bernhard Langer', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Asolo Hills Classic 2024', 2, '2024-05-16', 'p', '2024-05-09', 'Asolo Golf Club', 'Giallo-Verde', 'c');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa della Sindone 2024', 2, '2024-05-19', 'd', '2024-05-12', 'Circolo Golf Torino La Mandria', 'Giallo', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('IV Coppa della Riviera', 1, '2024-05-22', 'd', '2024-05-15', 'Riviera Golf Resort', 'Championship', 'g');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Novara Classic 2024', 3, '2024-05-27', 'd', '2024-05-20', 'Bogogno Golf Resort', 'Bonora', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, maxiscritti, nomecircolo, nomepercorso, nomecategoria)
values ('Mattone d\'Oro 2024', 3, '2024-06-02', 'd', '2024-05-26', 45, 'Bergamo Albenza Golf Club', 'Blu-Giallo', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('VII Coppa del Dragone', 2, '2024-06-06', 'p', '2024-05-31', 'Golf Club Le Pavoniere', 'Arnold Palmer', 'c');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa della FIAT 2024', 3, '2024-06-09', 'p', '2024-06-02', 'Golf Royal Park i Roveri', 'Allianz Bank Course', 'b');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Rimini Open 2024', 1, '2024-06-13', 'd', '2024-06-06', 'Rimini Verucchio Golf', 'Championship', 'g');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa del Lazio 2024', 2, '2024-06-15', 'd', '2024-06-08', 'Golf Nazionale', 'Championship', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Trofeo dell\'Adda', 2, '2024-06-18', 'd', '2024-06-11', 'Golf Villa Paradiso', 'Championship', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa del Duomo 2024', 3, '2024-06-21', 'd', '2024-06-14', 'Golf Club Ambrosiano', 'Championship', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Emilia Golf Trophy 2024', 2, '2024-06-27', 'd', '2024-06-20', 'Modena Golf and Country Club', 'Bernhard Langer', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Bogogno Golf Cup 2024', 1, '2024-07-02', 'p', '2024-06-25', 'Bogogno Golf Resort', 'del Conte', 'd');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('XI Coppa del Salento', 2, '2024-07-07', 'd', '2024-06-30', 'Acaya Golf Resort', 'Championship', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Coppa della Madonnina 2024', 3, '2024-07-10', 'd', '2024-07-03', 'Golf Club Milano', '1-2', 'e');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Treviso Classic 2024', 1, '2024-07-13', 'd', '2024-07-06', 'Golf Club Villa Condulmer', 'Championship', 'g');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('XXII Coppa Malatestiana', 2, '2024-07-17', 'p', '2024-07-10', 'Rimini Verucchio Golf', 'Championship', 'c');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('XI Trofeo dell\'Adriatico', 2, '2024-07-20', 'd', '2024-07-13', 'Adriatic Golf Cervia', 'Blu-Giallo', 'f');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('Gran Premio del Lago 2024', 1, '2024-07-23', 'p', '2024-07-16', 'Garda Golf and Country Club', 'Rosso-Bianco', 'd');
insert into gare(nomegara, durata, datainizio, categoriastatus, datachiusuraiscrizioni, nomecircolo, nomepercorso, nomecategoria)
values ('XIII Coppa di Augusto', 3, '2024-07-25', 'd', '2024-07-18', 'Olgiata Golf Club', 'Ovest', 'e');

-- Table "iscrizioni"
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 1, 20, '82a Coppa del Re', 1085);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 2, 13, '82a Coppa del Re', 1196);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 3, 11, '82a Coppa del Re', 797);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 4, 9, '82a Coppa del Re', 804);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 5, 8, '82a Coppa del Re', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 6, 8, '82a Coppa del Re', 990);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-08', 7, 7, '82a Coppa del Re', 28);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 8, 8, '82a Coppa del Re', 1093);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 9, 6, '82a Coppa del Re', 540);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 10, 6, '82a Coppa del Re', 175);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 11, 5, '82a Coppa del Re', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 12, 5, '82a Coppa del Re', 1022);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 13, 4, '82a Coppa del Re', 683);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 14, 4, '82a Coppa del Re', 172);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 15, 4, '82a Coppa del Re', 727);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 16, 4, '82a Coppa del Re', 437);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 17, 3, '82a Coppa del Re', 490);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 18, 3, '82a Coppa del Re', 700);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 19, 3, '82a Coppa del Re', 862);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 20, 3, '82a Coppa del Re', 412);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 21, 3, '82a Coppa del Re', 52);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 22, 2, '82a Coppa del Re', 1178);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 23, 2, '82a Coppa del Re', 82);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 24, 2, '82a Coppa del Re', 30);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 25, 2, '82a Coppa del Re', 249);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 26, 2, '82a Coppa del Re', 1121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 27, 2, '82a Coppa del Re', 387);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 28, 1, '82a Coppa del Re', 427);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 29, 1, '82a Coppa del Re', 577);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 30, 1, '82a Coppa del Re', 471);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 31, 0, '82a Coppa del Re', 74);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 32, 0, '82a Coppa del Re', 791);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 33, 0, '82a Coppa del Re', 454);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 34, 0, '82a Coppa del Re', 936);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 35, 0, '82a Coppa del Re', 54);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 36, 0, '82a Coppa del Re', 571);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 37, 0, '82a Coppa del Re', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 38, 0, '82a Coppa del Re', 1159);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 39, 0, '82a Coppa del Re', 926);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 40, 0, '82a Coppa del Re', 1029);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 41, 0, '82a Coppa del Re', 369);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 42, 0, '82a Coppa del Re', 601);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 43, 0, '82a Coppa del Re', 470);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 44, 0, '82a Coppa del Re', 65);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 45, 0, '82a Coppa del Re', 869);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 46, 0, '82a Coppa del Re', 582);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 47, 0, '82a Coppa del Re', 612);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 48, 0, '82a Coppa del Re', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 49, 0, '82a Coppa del Re', 971);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 50, 0, '82a Coppa del Re', 329);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 51, 0, '82a Coppa del Re', 591);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 52, 0, '82a Coppa del Re', 152);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 53, 0, '82a Coppa del Re', 131);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 54, 0, '82a Coppa del Re', 211);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 55, 0, '82a Coppa del Re', 640);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 56, 0, '82a Coppa del Re', 1040);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 57, 0, '82a Coppa del Re', 421);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 58, 0, '82a Coppa del Re', 1112);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 59, 0, '82a Coppa del Re', 237);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 60, 0, '82a Coppa del Re', 515);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 61, 0, '82a Coppa del Re', 118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 62, 0, '82a Coppa del Re', 755);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 63, 0, '82a Coppa del Re', 728);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 64, 0, '82a Coppa del Re', 411);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 65, 0, '82a Coppa del Re', 570);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 66, 0, '82a Coppa del Re', 300);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-31', 67, 0, '82a Coppa del Re', 116);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 68, 0, '82a Coppa del Re', 1050);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 69, 0, '82a Coppa del Re', 1011);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 70, 0, '82a Coppa del Re', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 1, 20, 'Cancelletto d\'Oro 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 2, 13, 'Cancelletto d\'Oro 2024', 897);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 3, 11, 'Cancelletto d\'Oro 2024', 470);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 4, 9, 'Cancelletto d\'Oro 2024', 595);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 5, 8, 'Cancelletto d\'Oro 2024', 1118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 6, 8, 'Cancelletto d\'Oro 2024', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 7, 7, 'Cancelletto d\'Oro 2024', 12);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 8, 8, 'Cancelletto d\'Oro 2024', 464);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 9, 6, 'Cancelletto d\'Oro 2024', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 10, 6, 'Cancelletto d\'Oro 2024', 68);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 11, 5, 'Cancelletto d\'Oro 2024', 1039);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 12, 5, 'Cancelletto d\'Oro 2024', 669);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 13, 4, 'Cancelletto d\'Oro 2024', 1072);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 14, 4, 'Cancelletto d\'Oro 2024', 911);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 15, 4, 'Cancelletto d\'Oro 2024', 1004);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 16, 4, 'Cancelletto d\'Oro 2024', 958);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 17, 3, 'Cancelletto d\'Oro 2024', 679);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 18, 3, 'Cancelletto d\'Oro 2024', 349);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 19, 3, 'Cancelletto d\'Oro 2024', 479);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 20, 3, 'Cancelletto d\'Oro 2024', 400);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 21, 3, 'Cancelletto d\'Oro 2024', 309);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 22, 2, 'Cancelletto d\'Oro 2024', 859);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 23, 2, 'Cancelletto d\'Oro 2024', 981);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 24, 2, 'Cancelletto d\'Oro 2024', 85);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 25, 2, 'Cancelletto d\'Oro 2024', 1106);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 26, 2, 'Cancelletto d\'Oro 2024', 361);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 27, 2, 'Cancelletto d\'Oro 2024', 193);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 28, 1, 'Cancelletto d\'Oro 2024', 121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 29, 1, 'Cancelletto d\'Oro 2024', 940);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 30, 1, 'Cancelletto d\'Oro 2024', 1129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 31, 0, 'Cancelletto d\'Oro 2024', 833);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 32, 0, 'Cancelletto d\'Oro 2024', 276);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 33, 0, 'Cancelletto d\'Oro 2024', 882);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 34, 0, 'Cancelletto d\'Oro 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 35, 0, 'Cancelletto d\'Oro 2024', 658);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 36, 0, 'Cancelletto d\'Oro 2024', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 37, 0, 'Cancelletto d\'Oro 2024', 287);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 38, 0, 'Cancelletto d\'Oro 2024', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 39, 0, 'Cancelletto d\'Oro 2024', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 40, 0, 'Cancelletto d\'Oro 2024', 738);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 41, 0, 'Cancelletto d\'Oro 2024', 884);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 42, 0, 'Cancelletto d\'Oro 2024', 364);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 43, 0, 'Cancelletto d\'Oro 2024', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 44, 0, 'Cancelletto d\'Oro 2024', 787);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 45, 0, 'Cancelletto d\'Oro 2024', 99);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 46, 0, 'Cancelletto d\'Oro 2024', 1169);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 47, 0, 'Cancelletto d\'Oro 2024', 640);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 48, 0, 'Cancelletto d\'Oro 2024', 1015);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 49, 0, 'Cancelletto d\'Oro 2024', 651);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 50, 0, 'Cancelletto d\'Oro 2024', 118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 51, 0, 'Cancelletto d\'Oro 2024', 772);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 52, 0, 'Cancelletto d\'Oro 2024', 1096);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 53, 0, 'Cancelletto d\'Oro 2024', 100);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 54, 0, 'Cancelletto d\'Oro 2024', 832);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 55, 0, 'Cancelletto d\'Oro 2024', 988);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 56, 0, 'Cancelletto d\'Oro 2024', 1047);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 57, 0, 'Cancelletto d\'Oro 2024', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 58, 0, 'Cancelletto d\'Oro 2024', 1190);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 59, 0, 'Cancelletto d\'Oro 2024', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 60, 0, 'Cancelletto d\'Oro 2024', 337);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 61, 0, 'Cancelletto d\'Oro 2024', 1050);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 62, 0, 'Cancelletto d\'Oro 2024', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 63, 0, 'Cancelletto d\'Oro 2024', 776);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 64, 0, 'Cancelletto d\'Oro 2024', 800);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 65, 0, 'Cancelletto d\'Oro 2024', 1165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-01', 66, 0, 'Cancelletto d\'Oro 2024', 1002);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 67, 0, 'Cancelletto d\'Oro 2024', 951);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 68, 0, 'Cancelletto d\'Oro 2024', 743);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 69, 0, 'Cancelletto d\'Oro 2024', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 70, 0, 'Cancelletto d\'Oro 2024', 5);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 1, 20, 'Coppa del Duomo 2024', 632);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 2, 13, 'Coppa del Duomo 2024', 575);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 3, 11, 'Coppa del Duomo 2024', 789);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 4, 9, 'Coppa del Duomo 2024', 739);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 5, 8, 'Coppa del Duomo 2024', 266);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 6, 8, 'Coppa del Duomo 2024', 645);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 7, 7, 'Coppa del Duomo 2024', 579);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 8, 8, 'Coppa del Duomo 2024', 1065);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 9, 6, 'Coppa del Duomo 2024', 990);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 10, 6, 'Coppa del Duomo 2024', 602);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 11, 5, 'Coppa del Duomo 2024', 399);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 12, 5, 'Coppa del Duomo 2024', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 13, 4, 'Coppa del Duomo 2024', 565);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 14, 4, 'Coppa del Duomo 2024', 260);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 15, 4, 'Coppa del Duomo 2024', 104);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 16, 4, 'Coppa del Duomo 2024', 678);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 17, 3, 'Coppa del Duomo 2024', 707);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 18, 3, 'Coppa del Duomo 2024', 73);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 19, 3, 'Coppa del Duomo 2024', 970);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 20, 3, 'Coppa del Duomo 2024', 368);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 21, 3, 'Coppa del Duomo 2024', 1069);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 12, 2, 'Coppa del Duomo 2024', 1198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 23, 2, 'Coppa del Duomo 2024', 1055);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 24, 2, 'Coppa del Duomo 2024', 192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 25, 2, 'Coppa del Duomo 2024', 1165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 26, 2, 'Coppa del Duomo 2024', 284);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 27, 2, 'Coppa del Duomo 2024', 624);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 28, 1, 'Coppa del Duomo 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 29, 1, 'Coppa del Duomo 2024', 798);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 30, 1, 'Coppa del Duomo 2024', 370);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 31, 0, 'Coppa del Duomo 2024', 967);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 32, 0, 'Coppa del Duomo 2024', 484);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 33, 0, 'Coppa del Duomo 2024', 1138);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 34, 0, 'Coppa del Duomo 2024', 961);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 35, 0, 'Coppa del Duomo 2024', 913);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 36, 0, 'Coppa del Duomo 2024', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 37, 0, 'Coppa del Duomo 2024', 875);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 38, 0, 'Coppa del Duomo 2024', 180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 39, 0, 'Coppa del Duomo 2024', 485);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 40, 0, 'Coppa del Duomo 2024', 884);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 41, 0, 'Coppa del Duomo 2024', 60);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 42, 0, 'Coppa del Duomo 2024', 30);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 43, 0, 'Coppa del Duomo 2024', 156);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 44, 0, 'Coppa del Duomo 2024', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 45, 0, 'Coppa del Duomo 2024', 592);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 46, 0, 'Coppa del Duomo 2024', 922);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 47, 0, 'Coppa del Duomo 2024', 930);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 48, 0, 'Coppa del Duomo 2024', 546);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 49, 0, 'Coppa del Duomo 2024', 383);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 50, 0, 'Coppa del Duomo 2024', 968);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 51, 0, 'Coppa del Duomo 2024', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 52, 0, 'Coppa del Duomo 2024', 443);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 53, 0, 'Coppa del Duomo 2024', 88);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 54, 0, 'Coppa del Duomo 2024', 1068);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 55, 0, 'Coppa del Duomo 2024', 128);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 56, 0, 'Coppa del Duomo 2024', 1017);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 57, 0, 'Coppa del Duomo 2024', 433);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 58, 0, 'Coppa del Duomo 2024', 391);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 59, 0, 'Coppa del Duomo 2024', 838);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 60, 0, 'Coppa del Duomo 2024', 661);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 61, 0, 'Coppa del Duomo 2024', 644);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 62, 0, 'Coppa del Duomo 2024', 944);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 63, 0, 'Coppa del Duomo 2024', 263);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 64, 0, 'Coppa del Duomo 2024', 75);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 65, 0, 'Coppa del Duomo 2024', 197);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 66, 0, 'Coppa del Duomo 2024', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 67, 0, 'Coppa del Duomo 2024', 437);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 68, 0, 'Coppa del Duomo 2024', 57);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 69, 0, 'Coppa del Duomo 2024', 124);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 70, 0, 'Coppa del Duomo 2024', 651);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 1, 20, 'Coppa della Madonnina 2024', 718);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 2, 13, 'Coppa della Madonnina 2024', 1130);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 3, 11, 'Coppa della Madonnina 2024', 436);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 4, 9, 'Coppa della Madonnina 2024', 1070);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 5, 8, 'Coppa della Madonnina 2024', 253);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 6, 8, 'Coppa della Madonnina 2024', 674);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 7, 7, 'Coppa della Madonnina 2024', 68);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 8, 8, 'Coppa della Madonnina 2024', 893);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 9, 6, 'Coppa della Madonnina 2024', 1041);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 10, 6, 'Coppa della Madonnina 2024', 568);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 11, 5, 'Coppa della Madonnina 2024', 832);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 12, 5, 'Coppa della Madonnina 2024', 1113);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 13, 4, 'Coppa della Madonnina 2024', 1012);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 14, 4, 'Coppa della Madonnina 2024', 1116);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 15, 4, 'Coppa della Madonnina 2024', 1172);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 16, 4, 'Coppa della Madonnina 2024', 740);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 17, 3, 'Coppa della Madonnina 2024', 439);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 18, 3, 'Coppa della Madonnina 2024', 889);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 19, 3, 'Coppa della Madonnina 2024', 70);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 20, 3, 'Coppa della Madonnina 2024', 657);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 21, 3, 'Coppa della Madonnina 2024', 30);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 12, 2, 'Coppa della Madonnina 2024', 210);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 23, 2, 'Coppa della Madonnina 2024', 375);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 24, 2, 'Coppa della Madonnina 2024', 753);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 25, 2, 'Coppa della Madonnina 2024', 39);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 26, 2, 'Coppa della Madonnina 2024', 1121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 27, 2, 'Coppa della Madonnina 2024', 341);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 28, 1, 'Coppa della Madonnina 2024', 519);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 29, 1, 'Coppa della Madonnina 2024', 651);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 30, 1, 'Coppa della Madonnina 2024', 394);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 31, 0, 'Coppa della Madonnina 2024', 49);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 32, 0, 'Coppa della Madonnina 2024', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 33, 0, 'Coppa della Madonnina 2024', 517);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 34, 0, 'Coppa della Madonnina 2024', 1156);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 35, 0, 'Coppa della Madonnina 2024', 878);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 36, 0, 'Coppa della Madonnina 2024', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 37, 0, 'Coppa della Madonnina 2024', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 38, 0, 'Coppa della Madonnina 2024', 768);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 39, 0, 'Coppa della Madonnina 2024', 914);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 40, 0, 'Coppa della Madonnina 2024', 86);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 41, 0, 'Coppa della Madonnina 2024', 757);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 42, 0, 'Coppa della Madonnina 2024', 465);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 43, 0, 'Coppa della Madonnina 2024', 318);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 44, 0, 'Coppa della Madonnina 2024', 523);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 45, 0, 'Coppa della Madonnina 2024', 191);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 46, 0, 'Coppa della Madonnina 2024', 319);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 47, 0, 'Coppa della Madonnina 2024', 96);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 48, 0, 'Coppa della Madonnina 2024', 929);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 49, 0, 'Coppa della Madonnina 2024', 846);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 50, 0, 'Coppa della Madonnina 2024', 949);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 51, 0, 'Coppa della Madonnina 2024', 161);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 52, 0, 'Coppa della Madonnina 2024', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 53, 0, 'Coppa della Madonnina 2024', 1046);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 54, 0, 'Coppa della Madonnina 2024', 334);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 55, 0, 'Coppa della Madonnina 2024', 497);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 56, 0, 'Coppa della Madonnina 2024', 844);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 57, 0, 'Coppa della Madonnina 2024', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 58, 0, 'Coppa della Madonnina 2024', 304);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 59, 0, 'Coppa della Madonnina 2024', 987);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 60, 0, 'Coppa della Madonnina 2024', 653);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 61, 0, 'Coppa della Madonnina 2024', 21);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 62, 0, 'Coppa della Madonnina 2024', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 63, 0, 'Coppa della Madonnina 2024', 557);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 64, 0, 'Coppa della Madonnina 2024', 48);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 65, 0, 'Coppa della Madonnina 2024', 984);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 66, 0, 'Coppa della Madonnina 2024', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 67, 0, 'Coppa della Madonnina 2024', 610);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 68, 0, 'Coppa della Madonnina 2024', 1111);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 69, 0, 'Coppa della Madonnina 2024', 1065);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 70, 0, 'Coppa della Madonnina 2024', 479);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 1, 20, 'III Stella d\'Oro', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 2, 13, 'III Stella d\'Oro', 541);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 3, 11, 'III Stella d\'Oro', 136);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 4, 9, 'III Stella d\'Oro', 182);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 5, 8, 'III Stella d\'Oro', 406);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 6, 8, 'III Stella d\'Oro', 162);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 7, 7, 'III Stella d\'Oro', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 8, 8, 'III Stella d\'Oro', 404);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 9, 6, 'III Stella d\'Oro', 684);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 10, 6, 'III Stella d\'Oro', 623);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 11, 5, 'III Stella d\'Oro', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 12, 5, 'III Stella d\'Oro', 530);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 13, 4, 'III Stella d\'Oro', 352);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 14, 4, 'III Stella d\'Oro', 332);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 15, 4, 'III Stella d\'Oro', 570);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 16, 4, 'III Stella d\'Oro', 643);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 17, 3, 'III Stella d\'Oro', 1083);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 18, 3, 'III Stella d\'Oro', 113);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 19, 3, 'III Stella d\'Oro', 608);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 20, 3, 'III Stella d\'Oro', 202);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 21, 3, 'III Stella d\'Oro', 178);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 12, 2, 'III Stella d\'Oro', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 23, 2, 'III Stella d\'Oro', 133);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 24, 2, 'III Stella d\'Oro', 146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 25, 2, 'III Stella d\'Oro', 821);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 26, 2, 'III Stella d\'Oro', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 27, 2, 'III Stella d\'Oro', 6);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 28, 1, 'III Stella d\'Oro', 1024);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 29, 1, 'III Stella d\'Oro', 874);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 30, 1, 'III Stella d\'Oro', 1185);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 31, 0, 'III Stella d\'Oro', 549);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 32, 0, 'III Stella d\'Oro', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 33, 0, 'III Stella d\'Oro', 369);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 34, 0, 'III Stella d\'Oro', 319);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 35, 0, 'III Stella d\'Oro', 956);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 36, 0, 'III Stella d\'Oro', 498);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 37, 0, 'III Stella d\'Oro', 1180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 38, 0, 'III Stella d\'Oro', 571);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 39, 0, 'III Stella d\'Oro', 885);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 40, 0, 'III Stella d\'Oro', 121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 41, 0, 'III Stella d\'Oro', 60);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 42, 0, 'III Stella d\'Oro', 346);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 43, 0, 'III Stella d\'Oro', 894);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 44, 0, 'III Stella d\'Oro', 592);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 45, 0, 'III Stella d\'Oro', 303);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 46, 0, 'III Stella d\'Oro', 811);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 47, 0, 'III Stella d\'Oro', 501);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 48, 0, 'III Stella d\'Oro', 350);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 49, 0, 'III Stella d\'Oro', 129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 50, 0, 'III Stella d\'Oro', 579);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 51, 0, 'III Stella d\'Oro', 1150);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 52, 0, 'III Stella d\'Oro', 398);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 53, 0, 'III Stella d\'Oro', 619);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 54, 0, 'III Stella d\'Oro', 50);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 55, 0, 'III Stella d\'Oro', 1006);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 56, 0, 'III Stella d\'Oro', 906);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 57, 0, 'III Stella d\'Oro', 253);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 58, 0, 'III Stella d\'Oro', 760);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 59, 0, 'III Stella d\'Oro', 662);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 60, 0, 'III Stella d\'Oro', 815);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 61, 0, 'III Stella d\'Oro', 1193);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 62, 0, 'III Stella d\'Oro', 179);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 63, 0, 'III Stella d\'Oro', 39);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 64, 0, 'III Stella d\'Oro', 219);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 65, 0, 'III Stella d\'Oro', 664);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 66, 0, 'III Stella d\'Oro', 337);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 67, 0, 'III Stella d\'Oro', 544);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 68, 0, 'III Stella d\'Oro', 502);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 69, 0, 'III Stella d\'Oro', 929);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 70, 0, 'III Stella d\'Oro', 522);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 1, 20, 'Mattone d\'Oro 2024', 848);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 2, 13, 'Mattone d\'Oro 2024', 642);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 3, 11, 'Mattone d\'Oro 2024', 989);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 4, 9, 'Mattone d\'Oro 2024', 678);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 5, 8, 'Mattone d\'Oro 2024', 540);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 6, 8, 'Mattone d\'Oro 2024', 27);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 7, 7, 'Mattone d\'Oro 2024', 250);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-20', 8, 7, 'Mattone d\'Oro 2024', 1198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 9, 6, 'Mattone d\'Oro 2024', 1038);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 10, 6, 'Mattone d\'Oro 2024', 146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 11, 5, 'Mattone d\'Oro 2024', 765);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 12, 5, 'Mattone d\'Oro 2024', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 13, 4, 'Mattone d\'Oro 2024', 555);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 14, 4, 'Mattone d\'Oro 2024', 1075);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 15, 4, 'Mattone d\'Oro 2024', 842);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 16, 4, 'Mattone d\'Oro 2024', 424);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 17, 3, 'Mattone d\'Oro 2024', 251);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 18, 3, 'Mattone d\'Oro 2024', 1050);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 19, 3, 'Mattone d\'Oro 2024', 1164);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 20, 3, 'Mattone d\'Oro 2024', 1009);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-31', 21, 3, 'Mattone d\'Oro 2024', 569);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 22, 2, 'Mattone d\'Oro 2024', 392);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 23, 2, 'Mattone d\'Oro 2024', 1027);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-31', 24, 2, 'Mattone d\'Oro 2024', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 25, 2, 'Mattone d\'Oro 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 26, 2, 'Mattone d\'Oro 2024', 619);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 27, 2, 'Mattone d\'Oro 2024', 785);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 28, 1, 'Mattone d\'Oro 2024', 310);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 29, 1, 'Mattone d\'Oro 2024', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 30, 1, 'Mattone d\'Oro 2024', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 31, 0, 'Mattone d\'Oro 2024', 713);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 32, 0, 'Mattone d\'Oro 2024', 808);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 33, 0, 'Mattone d\'Oro 2024', 946);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 34, 0, 'Mattone d\'Oro 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 35, 0, 'Mattone d\'Oro 2024', 990);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 36, 0, 'Mattone d\'Oro 2024', 865);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 37, 0, 'Mattone d\'Oro 2024', 84);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 38, 0, 'Mattone d\'Oro 2024', 968);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 39, 0, 'Mattone d\'Oro 2024', 497);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 40, 0, 'Mattone d\'Oro 2024', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 41, 0, 'Mattone d\'Oro 2024', 935);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 42, 0, 'Mattone d\'Oro 2024', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 43, 0, 'Mattone d\'Oro 2024', 242);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 44, 0, 'Mattone d\'Oro 2024', 355);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 45, 0, 'Mattone d\'Oro 2024', 745);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 1, 20, 'Novara Classic 2024', 592);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 2, 13, 'Novara Classic 2024', 515);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 3, 11, 'Novara Classic 2024', 608);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-18', 4, 9, 'Novara Classic 2024', 597);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 5, 8, 'Novara Classic 2024', 591);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-20', 6, 8, 'Novara Classic 2024', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 7, 7, 'Novara Classic 2024', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 8, 8, 'Novara Classic 2024', 1192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-17', 9, 6, 'Novara Classic 2024', 848);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-17', 10, 6, 'Novara Classic 2024', 815);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-20', 11, 5, 'Novara Classic 2024', 654);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 12, 5, 'Novara Classic 2024', 386);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-18', 13, 4, 'Novara Classic 2024', 289);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 14, 4, 'Novara Classic 2024', 1065);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 15, 4, 'Novara Classic 2024', 975);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 16, 4, 'Novara Classic 2024', 949);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 17, 3, 'Novara Classic 2024', 843);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 18, 3, 'Novara Classic 2024', 286);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 19, 3, 'Novara Classic 2024', 1028);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 20, 3, 'Novara Classic 2024', 394);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 21, 3, 'Novara Classic 2024', 612);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-17', 12, 2, 'Novara Classic 2024', 404);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-18', 23, 2, 'Novara Classic 2024', 1145);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 24, 2, 'Novara Classic 2024', 262);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 25, 2, 'Novara Classic 2024', 720);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 26, 2, 'Novara Classic 2024', 1032);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 27, 2, 'Novara Classic 2024', 895);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 28, 1, 'Novara Classic 2024', 1155);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 29, 1, 'Novara Classic 2024', 295);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 30, 1, 'Novara Classic 2024', 856);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 31, 0, 'Novara Classic 2024', 488);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 32, 0, 'Novara Classic 2024', 210);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 33, 0, 'Novara Classic 2024', 1159);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 34, 0, 'Novara Classic 2024', 344);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 35, 0, 'Novara Classic 2024', 461);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 36, 0, 'Novara Classic 2024', 520);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 37, 0, 'Novara Classic 2024', 913);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 38, 0, 'Novara Classic 2024', 432);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 39, 0, 'Novara Classic 2024', 576);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 40, 0, 'Novara Classic 2024', 1166);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 41, 0, 'Novara Classic 2024', 617);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 42, 0, 'Novara Classic 2024', 348);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-17', 43, 0, 'Novara Classic 2024', 46);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 44, 0, 'Novara Classic 2024', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 45, 0, 'Novara Classic 2024', 589);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-18', 46, 0, 'Novara Classic 2024', 770);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 47, 0, 'Novara Classic 2024', 873);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 48, 0, 'Novara Classic 2024', 143);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 49, 0, 'Novara Classic 2024', 782);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 50, 0, 'Novara Classic 2024', 174);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-17', 51, 0, 'Novara Classic 2024', 281);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 52, 0, 'Novara Classic 2024', 154);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 53, 0, 'Novara Classic 2024', 718);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 54, 0, 'Novara Classic 2024', 30);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 55, 0, 'Novara Classic 2024', 1018);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-20', 56, 0, 'Novara Classic 2024', 906);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 57, 0, 'Novara Classic 2024', 1091);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 58, 0, 'Novara Classic 2024', 583);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 59, 0, 'Novara Classic 2024', 453);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 60, 0, 'Novara Classic 2024', 484);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 61, 0, 'Novara Classic 2024', 400);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 62, 0, 'Novara Classic 2024', 43);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-19', 63, 0, 'Novara Classic 2024', 1197);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 64, 0, 'Novara Classic 2024', 1049);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 65, 0, 'Novara Classic 2024', 103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 66, 0, 'Novara Classic 2024', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-16', 67, 0, 'Novara Classic 2024', 1184);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 68, 0, 'Novara Classic 2024', 7);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-18', 69, 0, 'Novara Classic 2024', 1038);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 70, 0, 'Novara Classic 2024', 525);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 1, 20, 'Sale d\'Oro 2024', 737);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 2, 13, 'Sale d\'Oro 2024', 374);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 3, 11, 'Sale d\'Oro 2024', 1044);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 4, 9, 'Sale d\'Oro 2024', 372);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 5, 8, 'Sale d\'Oro 2024', 174);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 6, 8, 'Sale d\'Oro 2024', 351);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 7, 7, 'Sale d\'Oro 2024', 1069);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 8, 8, 'Sale d\'Oro 2024', 468);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 9, 6, 'Sale d\'Oro 2024', 663);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 10, 6, 'Sale d\'Oro 2024', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 11, 5, 'Sale d\'Oro 2024', 204);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 12, 5, 'Sale d\'Oro 2024', 499);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 13, 4, 'Sale d\'Oro 2024', 917);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 14, 4, 'Sale d\'Oro 2024', 728);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 15, 4, 'Sale d\'Oro 2024', 157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 16, 4, 'Sale d\'Oro 2024', 658);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 17, 3, 'Sale d\'Oro 2024', 317);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 18, 3, 'Sale d\'Oro 2024', 1083);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 19, 3, 'Sale d\'Oro 2024', 1151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 20, 3, 'Sale d\'Oro 2024', 596);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 21, 3, 'Sale d\'Oro 2024', 50);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 12, 2, 'Sale d\'Oro 2024', 497);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 23, 2, 'Sale d\'Oro 2024', 727);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 24, 2, 'Sale d\'Oro 2024', 215);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-10', 25, 2, 'Sale d\'Oro 2024', 760);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 26, 2, 'Sale d\'Oro 2024', 294);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 27, 2, 'Sale d\'Oro 2024', 632);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 28, 1, 'Sale d\'Oro 2024', 815);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 29, 1, 'Sale d\'Oro 2024', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 30, 1, 'Sale d\'Oro 2024', 226);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 31, 0, 'Sale d\'Oro 2024', 516);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 32, 0, 'Sale d\'Oro 2024', 837);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 33, 0, 'Sale d\'Oro 2024', 248);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 34, 0, 'Sale d\'Oro 2024', 386);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 35, 0, 'Sale d\'Oro 2024', 1185);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 36, 0, 'Sale d\'Oro 2024', 138);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 37, 0, 'Sale d\'Oro 2024', 508);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 38, 0, 'Sale d\'Oro 2024', 694);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 39, 0, 'Sale d\'Oro 2024', 379);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 40, 0, 'Sale d\'Oro 2024', 748);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 41, 0, 'Sale d\'Oro 2024', 586);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 42, 0, 'Sale d\'Oro 2024', 829);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 43, 0, 'Sale d\'Oro 2024', 776);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 44, 0, 'Sale d\'Oro 2024', 644);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 45, 0, 'Sale d\'Oro 2024', 783);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 46, 0, 'Sale d\'Oro 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 47, 0, 'Sale d\'Oro 2024', 36);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 48, 0, 'Sale d\'Oro 2024', 1004);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 49, 0, 'Sale d\'Oro 2024', 409);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 50, 0, 'Sale d\'Oro 2024', 91);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 51, 0, 'Sale d\'Oro 2024', 865);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 52, 0, 'Sale d\'Oro 2024', 437);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 53, 0, 'Sale d\'Oro 2024', 435);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 54, 0, 'Sale d\'Oro 2024', 393);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 55, 0, 'Sale d\'Oro 2024', 1111);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 56, 0, 'Sale d\'Oro 2024', 488);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 57, 0, 'Sale d\'Oro 2024', 1123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 58, 0, 'Sale d\'Oro 2024', 1186);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-14', 59, 0, 'Sale d\'Oro 2024', 505);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 60, 0, 'Sale d\'Oro 2024', 1056);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-10', 61, 0, 'Sale d\'Oro 2024', 908);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 62, 0, 'Sale d\'Oro 2024', 927);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 63, 0, 'Sale d\'Oro 2024', 239);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-10', 64, 0, 'Sale d\'Oro 2024', 230);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-12', 65, 0, 'Sale d\'Oro 2024', 670);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 66, 0, 'Sale d\'Oro 2024', 389);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 67, 0, 'Sale d\'Oro 2024', 14);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 68, 0, 'Sale d\'Oro 2024', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 69, 0, 'Sale d\'Oro 2024', 686);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 70, 0, 'Sale d\'Oro 2024', 515);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 1, 20, 'XIII Coppa di Augusto', 44);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 2, 13, 'XIII Coppa di Augusto', 1177);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 3, 11, 'XIII Coppa di Augusto', 619);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-18', 4, 9, 'XIII Coppa di Augusto', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 5, 8, 'XIII Coppa di Augusto', 372);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 6, 8, 'XIII Coppa di Augusto', 804);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 7, 7, 'XIII Coppa di Augusto', 678);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 8, 8, 'XIII Coppa di Augusto', 242);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-17', 9, 6, 'XIII Coppa di Augusto', 434);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-17', 10, 6, 'XIII Coppa di Augusto', 78);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 11, 5, 'XIII Coppa di Augusto', 384);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 12, 5, 'XIII Coppa di Augusto', 1096);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-18', 13, 4, 'XIII Coppa di Augusto', 230);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 14, 4, 'XIII Coppa di Augusto', 686);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 15, 4, 'XIII Coppa di Augusto', 314);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 16, 4, 'XIII Coppa di Augusto', 1081);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 17, 3, 'XIII Coppa di Augusto', 599);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 18, 3, 'XIII Coppa di Augusto', 306);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 19, 3, 'XIII Coppa di Augusto', 490);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 20, 3, 'XIII Coppa di Augusto', 1187);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 21, 3, 'XIII Coppa di Augusto', 234);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-17', 12, 2, 'XIII Coppa di Augusto', 863);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-18', 23, 2, 'XIII Coppa di Augusto', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 24, 2, 'XIII Coppa di Augusto', 146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 25, 2, 'XIII Coppa di Augusto', 160);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 26, 2, 'XIII Coppa di Augusto', 600);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 27, 2, 'XIII Coppa di Augusto', 432);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 28, 1, 'XIII Coppa di Augusto', 551);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 29, 1, 'XIII Coppa di Augusto', 276);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 30, 1, 'XIII Coppa di Augusto', 868);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 31, 0, 'XIII Coppa di Augusto', 144);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 32, 0, 'XIII Coppa di Augusto', 50);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 33, 0, 'XIII Coppa di Augusto', 407);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 34, 0, 'XIII Coppa di Augusto', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 35, 0, 'XIII Coppa di Augusto', 503);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 36, 0, 'XIII Coppa di Augusto', 915);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 37, 0, 'XIII Coppa di Augusto', 35);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 38, 0, 'XIII Coppa di Augusto', 1146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 39, 0, 'XIII Coppa di Augusto', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 40, 0, 'XIII Coppa di Augusto', 251);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 41, 0, 'XIII Coppa di Augusto', 283);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 42, 0, 'XIII Coppa di Augusto', 46);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-17', 43, 0, 'XIII Coppa di Augusto', 885);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 44, 0, 'XIII Coppa di Augusto', 352);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 45, 0, 'XIII Coppa di Augusto', 710);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-18', 46, 0, 'XIII Coppa di Augusto', 415);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 47, 0, 'XIII Coppa di Augusto', 1115);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 48, 0, 'XIII Coppa di Augusto', 708);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 49, 0, 'XIII Coppa di Augusto', 284);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 50, 0, 'XIII Coppa di Augusto', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-17', 51, 0, 'XIII Coppa di Augusto', 1036);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 52, 0, 'XIII Coppa di Augusto', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 53, 0, 'XIII Coppa di Augusto', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 54, 0, 'XIII Coppa di Augusto', 657);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 55, 0, 'XIII Coppa di Augusto', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 56, 0, 'XIII Coppa di Augusto', 951);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 57, 0, 'XIII Coppa di Augusto', 355);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 58, 0, 'XIII Coppa di Augusto', 699);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 59, 0, 'XIII Coppa di Augusto', 617);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 60, 0, 'XIII Coppa di Augusto', 73);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 61, 0, 'XIII Coppa di Augusto', 396);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 62, 0, 'XIII Coppa di Augusto', 974);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 63, 0, 'XIII Coppa di Augusto', 1095);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 64, 0, 'XIII Coppa di Augusto', 1149);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 65, 0, 'XIII Coppa di Augusto', 827);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 66, 0, 'XIII Coppa di Augusto', 787);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-16', 67, 0, 'XIII Coppa di Augusto', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 68, 0, 'XIII Coppa di Augusto',324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-18', 69, 0, 'XIII Coppa di Augusto', 438);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 70, 0, 'XIII Coppa di Augusto', 439);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 1, 4, 'Coppa del Garda 2024', 1162);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 2, 3, 'Coppa del Garda 2024', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 3, 2, 'Coppa del Garda 2024', 126);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 4, 2, 'Coppa del Garda 2024', 267);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 5, 2, 'Coppa del Garda 2024', 140);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 6, 1, 'Coppa del Garda 2024', 86);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 7, 1, 'Coppa del Garda 2024', 9);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 8, 1, 'Coppa del Garda 2024', 674);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 9, 1, 'Coppa del Garda 2024', 1007);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 10, 1, 'Coppa del Garda 2024', 747);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 11, 0, 'Coppa del Garda 2024', 109);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 12, 0, 'Coppa del Garda 2024', 518);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 13, 0, 'Coppa del Garda 2024', 991);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 14, 0, 'Coppa del Garda 2024', 536);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 15, 0, 'Coppa del Garda 2024', 63);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 16, 0, 'Coppa del Garda 2024', 1138);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 17, 0, 'Coppa del Garda 2024', 882);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 18, 0, 'Coppa del Garda 2024', 68);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 19, 0, 'Coppa del Garda 2024', 593);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 20, 0, 'Coppa del Garda 2024', 396);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 21, 0, 'Coppa del Garda 2024', 923);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 12, 0, 'Coppa del Garda 2024', 967);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 23, 0, 'Coppa del Garda 2024', 952);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 24, 0, 'Coppa del Garda 2024', 704);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 25, 0, 'Coppa del Garda 2024', 790);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 26, 0, 'Coppa del Garda 2024', 557);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 27, 0, 'Coppa del Garda 2024', 373);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 28, 0, 'Coppa del Garda 2024', 210);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 29, 0, 'Coppa del Garda 2024', 465);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 30, 0, 'Coppa del Garda 2024', 503);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 31, 0, 'Coppa del Garda 2024', 1182);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 32, 0, 'Coppa del Garda 2024', 681);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 33, 0, 'Coppa del Garda 2024', 424);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 34, 0, 'Coppa del Garda 2024', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 35, 0, 'Coppa del Garda 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 36, 0, 'Coppa del Garda 2024', 1020);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-17', 37, 0, 'Coppa del Garda 2024', 1183);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-15', 38, 0, 'Coppa del Garda 2024', 535);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 39, 0, 'Coppa del Garda 2024', 788);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 40, 0, 'Coppa del Garda 2024', 245);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 41, 0, 'Coppa del Garda 2024', 639);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 42, 0, 'Coppa del Garda 2024', 805);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 43, 0, 'Coppa del Garda 2024', 556);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 44, 0, 'Coppa del Garda 2024', 494);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 45, 0, 'Coppa del Garda 2024', 24);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-18', 46, 0, 'Coppa del Garda 2024', 1118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 47, 0, 'Coppa del Garda 2024', 407);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 48, 0, 'Coppa del Garda 2024', 275);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 49, 0, 'Coppa del Garda 2024', 502);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 50, 0, 'Coppa del Garda 2024', 295);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 51, 0, 'Coppa del Garda 2024', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 52, 0, 'Coppa del Garda 2024', 369);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 53, 0, 'Coppa del Garda 2024', 226);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 54, 0, 'Coppa del Garda 2024', 1096);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 55, 0, 'Coppa del Garda 2024', 917);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 56, 0, 'Coppa del Garda 2024', 1188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 57, 0, 'Coppa del Garda 2024', 176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 58, 0, 'Coppa del Garda 2024', 1072);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 59, 0, 'Coppa del Garda 2024', 753);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 60, 0, 'Coppa del Garda 2024', 698);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-20', 61, 0, 'Coppa del Garda 2024', 348);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 62, 0, 'Coppa del Garda 2024', 1005);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-19', 63, 0, 'Coppa del Garda 2024', 79);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-10', 64, 0, 'Coppa del Garda 2024', 1091);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 65, 0, 'Coppa del Garda 2024', 390);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-13', 66, 0, 'Coppa del Garda 2024', 132);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-16', 67, 0, 'Coppa del Garda 2024', 520);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 68, 0, 'Coppa del Garda 2024', 171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 69, 0, 'Coppa del Garda 2024', 875);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-11', 70, 0, 'Coppa del Garda 2024', 39);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 1, 4, 'IV Coppa della Riviera', 938);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 2, 3, 'IV Coppa della Riviera', 1087);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 3, 2, 'IV Coppa della Riviera', 659);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 4, 2, 'IV Coppa della Riviera', 52);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 5, 2, 'IV Coppa della Riviera', 677);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 6, 1, 'IV Coppa della Riviera', 158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 7, 1, 'IV Coppa della Riviera', 86);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 8, 1, 'IV Coppa della Riviera', 25);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 9, 1, 'IV Coppa della Riviera', 663);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 10, 1, 'IV Coppa della Riviera', 1176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 11, 0, 'IV Coppa della Riviera', 894);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 12, 0, 'IV Coppa della Riviera', 1125);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 13, 0, 'IV Coppa della Riviera', 873);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 14, 0, 'IV Coppa della Riviera', 915);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 15, 0, 'IV Coppa della Riviera', 1194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 16, 0, 'IV Coppa della Riviera', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 17, 0, 'IV Coppa della Riviera', 765);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 18, 0, 'IV Coppa della Riviera', 88);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 19, 0, 'IV Coppa della Riviera', 1187);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 20, 0, 'IV Coppa della Riviera', 394);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 21, 0, 'IV Coppa della Riviera', 118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 12, 0, 'IV Coppa della Riviera', 922);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 23, 0, 'IV Coppa della Riviera', 406);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 24, 0, 'IV Coppa della Riviera', 457);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 25, 0, 'IV Coppa della Riviera', 264);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 26, 0, 'IV Coppa della Riviera', 1032);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 27, 0, 'IV Coppa della Riviera', 151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 28, 0, 'IV Coppa della Riviera', 552);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 29, 0, 'IV Coppa della Riviera', 882);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 30, 0, 'IV Coppa della Riviera', 1079);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 31, 0, 'IV Coppa della Riviera', 257);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 32, 0, 'IV Coppa della Riviera', 1182);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 33, 0, 'IV Coppa della Riviera', 936);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 34, 0, 'IV Coppa della Riviera', 328);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 35, 0, 'IV Coppa della Riviera', 280);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 36, 0, 'IV Coppa della Riviera', 176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 37, 0, 'IV Coppa della Riviera', 360);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 38, 0, 'IV Coppa della Riviera', 794);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 39, 0, 'IV Coppa della Riviera', 1066);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 40, 0, 'IV Coppa della Riviera', 1003);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 41, 0, 'IV Coppa della Riviera', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 42, 0, 'IV Coppa della Riviera', 5);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 43, 0, 'IV Coppa della Riviera', 413);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 44, 0, 'IV Coppa della Riviera', 291);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 45, 0, 'IV Coppa della Riviera', 303);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 46, 0, 'IV Coppa della Riviera', 152);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 47, 0, 'IV Coppa della Riviera', 1123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 48, 0, 'IV Coppa della Riviera', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 49, 0, 'IV Coppa della Riviera', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 50, 0, 'IV Coppa della Riviera', 515);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 51, 0, 'IV Coppa della Riviera', 891);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 52, 0, 'IV Coppa della Riviera', 903);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 53, 0, 'IV Coppa della Riviera', 1027);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 54, 0, 'IV Coppa della Riviera', 606);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 55, 0, 'IV Coppa della Riviera', 608);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 56, 0, 'IV Coppa della Riviera', 510);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 57, 0, 'IV Coppa della Riviera', 436);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-15', 58, 0, 'IV Coppa della Riviera', 664);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 59, 0, 'IV Coppa della Riviera', 287);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 60, 0, 'IV Coppa della Riviera', 962);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 61, 0, 'IV Coppa della Riviera', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 62, 0, 'IV Coppa della Riviera', 81);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 63, 0, 'IV Coppa della Riviera', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 64, 0, 'IV Coppa della Riviera', 520);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 65, 0, 'IV Coppa della Riviera', 725);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-13', 66, 0, 'IV Coppa della Riviera', 842);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-14', 67, 0, 'IV Coppa della Riviera', 757);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 68, 0, 'IV Coppa della Riviera', 625);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 69, 0, 'IV Coppa della Riviera', 824);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 70, 0, 'IV Coppa della Riviera', 344);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 1, 4, 'Puglia Classic 2024', 1030);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 2, 3, 'Puglia Classic 2024', 112);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 3, 2, 'Puglia Classic 2024', 837);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 4, 2, 'Puglia Classic 2024', 103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 5, 2, 'Puglia Classic 2024', 626);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 6, 1, 'Puglia Classic 2024', 782);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 7, 1, 'Puglia Classic 2024', 493);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 8, 1, 'Puglia Classic 2024', 337);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 9, 1, 'Puglia Classic 2024', 835);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 10, 1, 'Puglia Classic 2024', 728);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 11, 0, 'Puglia Classic 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 12, 0, 'Puglia Classic 2024', 812);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-06', 13, 0, 'Puglia Classic 2024', 1166);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 14, 0, 'Puglia Classic 2024', 252);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 15, 0, 'Puglia Classic 2024', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 16, 0, 'Puglia Classic 2024', 1140);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 17, 0, 'Puglia Classic 2024', 432);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 18, 0, 'Puglia Classic 2024', 1123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 19, 0, 'Puglia Classic 2024', 564);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 20, 0, 'Puglia Classic 2024', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 21, 0, 'Puglia Classic 2024', 166);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 12, 0, 'Puglia Classic 2024', 88);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 23, 0, 'Puglia Classic 2024', 688);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 24, 0, 'Puglia Classic 2024', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 25, 0, 'Puglia Classic 2024', 368);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 26, 0, 'Puglia Classic 2024', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-06', 27, 0, 'Puglia Classic 2024', 1050);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-06', 28, 0, 'Puglia Classic 2024', 1114);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 29, 0, 'Puglia Classic 2024', 865);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 30, 0, 'Puglia Classic 2024', 260);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 31, 0, 'Puglia Classic 2024', 1132);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 32, 0, 'Puglia Classic 2024', 198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 33, 0, 'Puglia Classic 2024', 448);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 34, 0, 'Puglia Classic 2024', 1012);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 35, 0, 'Puglia Classic 2024', 875);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 36, 0, 'Puglia Classic 2024', 996);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 37, 0, 'Puglia Classic 2024', 90);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 38, 0, 'Puglia Classic 2024', 421);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 39, 0, 'Puglia Classic 2024', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 40, 0, 'Puglia Classic 2024', 190);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 41, 0, 'Puglia Classic 2024', 406);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 42, 0, 'Puglia Classic 2024', 28);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 43, 0, 'Puglia Classic 2024', 459);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 44, 0, 'Puglia Classic 2024', 311);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 45, 0, 'Puglia Classic 2024', 593);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-08', 46, 0, 'Puglia Classic 2024', 680);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 47, 0, 'Puglia Classic 2024', 851);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 48, 0, 'Puglia Classic 2024', 57);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 49, 0, 'Puglia Classic 2024', 434);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 50, 0, 'Puglia Classic 2024', 218);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 51, 0, 'Puglia Classic 2024', 316);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 52, 0, 'Puglia Classic 2024', 324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 53, 0, 'Puglia Classic 2024', 963);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 54, 0, 'Puglia Classic 2024', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 55, 0, 'Puglia Classic 2024', 457);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 56, 0, 'Puglia Classic 2024', 651);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 57, 0, 'Puglia Classic 2024', 1174);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 58, 0, 'Puglia Classic 2024', 49);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 59, 0, 'Puglia Classic 2024', 468);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 60, 0, 'Puglia Classic 2024', 299);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 61, 0, 'Puglia Classic 2024', 832);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-06', 62, 0, 'Puglia Classic 2024', 647);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 63, 0, 'Puglia Classic 2024', 829);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-10', 64, 0, 'Puglia Classic 2024', 524);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 65, 0, 'Puglia Classic 2024', 1147);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 66, 0, 'Puglia Classic 2024', 508);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-04', 67, 0, 'Puglia Classic 2024', 925);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 68, 0, 'Puglia Classic 2024', 441);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-08', 69, 0, 'Puglia Classic 2024', 203);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 70, 0, 'Puglia Classic 2024', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 1, 4, 'Rimini Open 2024', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 2, 3, 'Rimini Open 2024', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 3, 2, 'Rimini Open 2024', 1163);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 4, 2, 'Rimini Open 2024', 993);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 5, 2, 'Rimini Open 2024', 508);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 6, 1, 'Rimini Open 2024', 118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 7, 1, 'Rimini Open 2024', 896);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 8, 1, 'Rimini Open 2024', 1063);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 9, 1, 'Rimini Open 2024', 910);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 10, 1, 'Rimini Open 2024', 291);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 11, 0, 'Rimini Open 2024', 1173);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 12, 0, 'Rimini Open 2024', 444);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 13, 0, 'Rimini Open 2024', 923);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 14, 0, 'Rimini Open 2024', 294);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 15, 0, 'Rimini Open 2024', 488);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 16, 0, 'Rimini Open 2024', 919);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 17, 0, 'Rimini Open 2024', 14);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 18, 0, 'Rimini Open 2024', 1122);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 19, 0, 'Rimini Open 2024', 391);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 20, 0, 'Rimini Open 2024', 991);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 21, 0, 'Rimini Open 2024', 502);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 12, 0, 'Rimini Open 2024', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 23, 0, 'Rimini Open 2024', 768);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 24, 0, 'Rimini Open 2024', 588);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 25, 0, 'Rimini Open 2024', 1124);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 26, 0, 'Rimini Open 2024', 510);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 27, 0, 'Rimini Open 2024', 340);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 28, 0, 'Rimini Open 2024', 865);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 29, 0, 'Rimini Open 2024', 1091);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 30, 0, 'Rimini Open 2024', 121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 31, 0, 'Rimini Open 2024', 1049);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 32, 0, 'Rimini Open 2024', 731);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 33, 0, 'Rimini Open 2024', 1119);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 34, 0, 'Rimini Open 2024', 1059);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 35, 0, 'Rimini Open 2024', 396);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 36, 0, 'Rimini Open 2024', 835);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 37, 0, 'Rimini Open 2024', 362);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 38, 0, 'Rimini Open 2024', 1029);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 39, 0, 'Rimini Open 2024', 867);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 40, 0, 'Rimini Open 2024', 1191);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 41, 0, 'Rimini Open 2024', 1127);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 42, 0, 'Rimini Open 2024', 881);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 43, 0, 'Rimini Open 2024', 1053);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 44, 0, 'Rimini Open 2024', 819);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 45, 0, 'Rimini Open 2024', 383);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 46, 0, 'Rimini Open 2024', 952);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 47, 0, 'Rimini Open 2024', 476);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 48, 0, 'Rimini Open 2024', 211);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 49, 0, 'Rimini Open 2024', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 50, 0, 'Rimini Open 2024', 1125);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 51, 0, 'Rimini Open 2024', 597);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 52, 0, 'Rimini Open 2024', 707);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 53, 0, 'Rimini Open 2024', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 54, 0, 'Rimini Open 2024', 158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 55, 0, 'Rimini Open 2024', 193);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 56, 0, 'Rimini Open 2024', 114);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 57, 0, 'Rimini Open 2024', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 58, 0, 'Rimini Open 2024', 262);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 59, 0, 'Rimini Open 2024', 868);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 60, 0, 'Rimini Open 2024', 962);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 61, 0, 'Rimini Open 2024', 223);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 62, 0, 'Rimini Open 2024', 287);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 63, 0, 'Rimini Open 2024', 52);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 64, 0, 'Rimini Open 2024', 657);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 65, 0, 'Rimini Open 2024', 402);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 66, 0, 'Rimini Open 2024', 518);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 67, 0, 'Rimini Open 2024', 725);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 68, 0, 'Rimini Open 2024', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 69, 0, 'Rimini Open 2024', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 70, 0, 'Rimini Open 2024', 1065);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 1, 4, 'Treviso Classic 2024', 615);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 2, 3, 'Treviso Classic 2024', 199);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 3, 2, 'Treviso Classic 2024', 44);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 4, 2, 'Treviso Classic 2024', 993);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 5, 2, 'Treviso Classic 2024', 774);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 6, 1, 'Treviso Classic 2024', 574);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 7, 1, 'Treviso Classic 2024', 230);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 8, 1, 'Treviso Classic 2024', 451);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 9, 1, 'Treviso Classic 2024', 575);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 10, 1, 'Treviso Classic 2024', 791);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 11, 0, 'Treviso Classic 2024', 100);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 12, 0, 'Treviso Classic 2024', 278);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 13, 0, 'Treviso Classic 2024', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 14, 0, 'Treviso Classic 2024', 475);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 15, 0, 'Treviso Classic 2024', 734);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 16, 0, 'Treviso Classic 2024', 885);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 17, 0, 'Treviso Classic 2024', 722);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 18, 0, 'Treviso Classic 2024', 386);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 19, 0, 'Treviso Classic 2024', 811);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 20, 0, 'Treviso Classic 2024', 951);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 21, 0, 'Treviso Classic 2024', 264);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 12, 0, 'Treviso Classic 2024', 786);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 23, 0, 'Treviso Classic 2024', 63);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 24, 0, 'Treviso Classic 2024', 173);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 25, 0, 'Treviso Classic 2024', 718);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 26, 0, 'Treviso Classic 2024', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 27, 0, 'Treviso Classic 2024', 565);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 28, 0, 'Treviso Classic 2024', 91);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 29, 0, 'Treviso Classic 2024', 864);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 30, 0, 'Treviso Classic 2024', 468);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 31, 0, 'Treviso Classic 2024', 669);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 32, 0, 'Treviso Classic 2024', 602);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 33, 0, 'Treviso Classic 2024', 621);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 34, 0, 'Treviso Classic 2024', 88);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 35, 0, 'Treviso Classic 2024', 759);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 36, 0, 'Treviso Classic 2024', 595);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 37, 0, 'Treviso Classic 2024', 387);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 38, 0, 'Treviso Classic 2024', 552);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 39, 0, 'Treviso Classic 2024', 1039);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 40, 0, 'Treviso Classic 2024', 324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 41, 0, 'Treviso Classic 2024', 313);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 42, 0, 'Treviso Classic 2024', 510);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 43, 0, 'Treviso Classic 2024', 1036);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 44, 0, 'Treviso Classic 2024', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 45, 0, 'Treviso Classic 2024', 917);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 46, 0, 'Treviso Classic 2024', 1143);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 47, 0, 'Treviso Classic 2024', 530);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 48, 0, 'Treviso Classic 2024', 536);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 49, 0, 'Treviso Classic 2024', 881);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 50, 0, 'Treviso Classic 2024', 979);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 51, 0, 'Treviso Classic 2024', 850);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 52, 0, 'Treviso Classic 2024', 411);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 53, 0, 'Treviso Classic 2024', 332);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 54, 0, 'Treviso Classic 2024', 996);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 55, 0, 'Treviso Classic 2024', 478);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 56, 0, 'Treviso Classic 2024', 364);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 57, 0, 'Treviso Classic 2024', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 58, 0, 'Treviso Classic 2024', 282);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 59, 0, 'Treviso Classic 2024', 1032);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 60, 0, 'Treviso Classic 2024', 251);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 61, 0, 'Treviso Classic 2024', 947);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 62, 0, 'Treviso Classic 2024', 695);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 63, 0, 'Treviso Classic 2024', 1055);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 64, 0, 'Treviso Classic 2024', 434);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 65, 0, 'Treviso Classic 2024', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 66, 0, 'Treviso Classic 2024', 981);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 67, 0, 'Treviso Classic 2024', 439);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 68, 0, 'Treviso Classic 2024', 1153);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 69, 0, 'Treviso Classic 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 70, 0, 'Treviso Classic 2024', 280);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 1, 10, 'Coppa del Conte 2024', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 2, 6, 'Coppa del Conte 2024', 414);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 3, 5, 'Coppa del Conte 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 4, 4, 'Coppa del Conte 2024', 1117);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-05', 5, 4, 'Coppa del Conte 2024', 430);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-08', 6, 4, 'Coppa del Conte 2024', 859);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 7, 3, 'Coppa del Conte 2024', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 8, 3, 'Coppa del Conte 2024', 850);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 9, 3, 'Coppa del Conte 2024', 172);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 10, 3, 'Coppa del Conte 2024', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 11, 2, 'Coppa del Conte 2024', 1158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 12, 2, 'Coppa del Conte 2024', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 13, 2, 'Coppa del Conte 2024', 1148);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 14, 2, 'Coppa del Conte 2024', 786);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 15, 1, 'Coppa del Conte 2024', 939);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 16, 1, 'Coppa del Conte 2024', 85);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 17, 1, 'Coppa del Conte 2024', 555);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 18, 1, 'Coppa del Conte 2024', 58);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 19, 1, 'Coppa del Conte 2024', 968);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 20, 1, 'Coppa del Conte 2024', 372);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 21, 0, 'Coppa del Conte 2024', 91);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 12, 0, 'Coppa del Conte 2024', 1047);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 23, 0, 'Coppa del Conte 2024', 108);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 24, 0, 'Coppa del Conte 2024', 103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 25, 0, 'Coppa del Conte 2024', 242);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 26, 0, 'Coppa del Conte 2024', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 27, 0, 'Coppa del Conte 2024', 522);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 28, 0, 'Coppa del Conte 2024', 375);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 29, 0, 'Coppa del Conte 2024', 956);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 30, 0, 'Coppa del Conte 2024', 782);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 31, 0, 'Coppa del Conte 2024', 44);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 32, 0, 'Coppa del Conte 2024', 1176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 33, 0, 'Coppa del Conte 2024', 471);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 34, 0, 'Coppa del Conte 2024', 441);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 35, 0, 'Coppa del Conte 2024', 1119);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 36, 0, 'Coppa del Conte 2024', 631);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 37, 0, 'Coppa del Conte 2024', 967);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 38, 0, 'Coppa del Conte 2024', 232);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 39, 0, 'Coppa del Conte 2024', 1030);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 40, 0, 'Coppa del Conte 2024', 760);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 41, 0, 'Coppa del Conte 2024', 454);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 42, 0, 'Coppa del Conte 2024', 672);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 43, 0, 'Coppa del Conte 2024', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 44, 0, 'Coppa del Conte 2024', 669);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 45, 0, 'Coppa del Conte 2024', 908);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 46, 0, 'Coppa del Conte 2024', 348);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 47, 0, 'Coppa del Conte 2024', 262);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 48, 0, 'Coppa del Conte 2024', 192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 49, 0, 'Coppa del Conte 2024', 1147);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 50, 0, 'Coppa del Conte 2024', 148);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 51, 0, 'Coppa del Conte 2024', 359);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 52, 0, 'Coppa del Conte 2024', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 53, 0, 'Coppa del Conte 2024', 24);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 54, 0, 'Coppa del Conte 2024', 734);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-09', 55, 0, 'Coppa del Conte 2024', 1182);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-11', 56, 0, 'Coppa del Conte 2024', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 57, 0, 'Coppa del Conte 2024', 1075);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 58, 0, 'Coppa del Conte 2024', 899);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 59, 0, 'Coppa del Conte 2024', 880);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 60, 0, 'Coppa del Conte 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 61, 0, 'Coppa del Conte 2024', 991);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 62, 0, 'Coppa del Conte 2024', 158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 63, 0, 'Coppa del Conte 2024', 630);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 64, 0, 'Coppa del Conte 2024', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 65, 0, 'Coppa del Conte 2024', 947);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 66, 0, 'Coppa del Conte 2024', 884);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 67, 0, 'Coppa del Conte 2024', 1195);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 68, 0, 'Coppa del Conte 2024', 295);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 69, 0, 'Coppa del Conte 2024', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-07', 70, 0, 'Coppa del Conte 2024', 169);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 1, 10, 'Coppa del Castello 2024', 1153);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 2, 6, 'Coppa del Castello 2024', 1046);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 3, 5, 'Coppa del Castello 2024', 670);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 4, 4, 'Coppa del Castello 2024', 68);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 5, 4, 'Coppa del Castello 2024', 525);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 6, 4, 'Coppa del Castello 2024', 1174);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 7, 3, 'Coppa del Castello 2024', 832);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 8, 3, 'Coppa del Castello 2024', 919);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 9, 3, 'Coppa del Castello 2024', 828);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 10, 3, 'Coppa del Castello 2024', 879);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 11, 2, 'Coppa del Castello 2024', 254);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 12, 2, 'Coppa del Castello 2024', 1156);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 13, 2, 'Coppa del Castello 2024', 1125);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 14, 2, 'Coppa del Castello 2024', 191);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 15, 1, 'Coppa del Castello 2024', 474);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 16, 1, 'Coppa del Castello 2024', 959);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 17, 1, 'Coppa del Castello 2024', 1170);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 18, 1, 'Coppa del Castello 2024', 430);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 19, 1, 'Coppa del Castello 2024', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 20, 1, 'Coppa del Castello 2024', 122);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 21, 0, 'Coppa del Castello 2024', 312);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 12, 0, 'Coppa del Castello 2024', 422);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 23, 0, 'Coppa del Castello 2024', 662);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 24, 0, 'Coppa del Castello 2024', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 25, 0, 'Coppa del Castello 2024', 731);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 26, 0, 'Coppa del Castello 2024', 858);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 27, 0, 'Coppa del Castello 2024', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 28, 0, 'Coppa del Castello 2024', 721);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 29, 0, 'Coppa del Castello 2024', 989);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 30, 0, 'Coppa del Castello 2024', 227);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 31, 0, 'Coppa del Castello 2024', 123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 32, 0, 'Coppa del Castello 2024', 258);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-18', 33, 0, 'Coppa del Castello 2024', 1194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 34, 0, 'Coppa del Castello 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-15', 35, 0, 'Coppa del Castello 2024', 339);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 36, 0, 'Coppa del Castello 2024', 971);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 37, 0, 'Coppa del Castello 2024', 699);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 38, 0, 'Coppa del Castello 2024', 1099);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 39, 0, 'Coppa del Castello 2024', 151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 40, 0, 'Coppa del Castello 2024', 384);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 41, 0, 'Coppa del Castello 2024', 980);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 42, 0, 'Coppa del Castello 2024', 99);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 43, 0, 'Coppa del Castello 2024', 202);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 44, 0, 'Coppa del Castello 2024', 631);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 45, 0, 'Coppa del Castello 2024', 1087);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 46, 0, 'Coppa del Castello 2024', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 47, 0, 'Coppa del Castello 2024', 475);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 48, 0, 'Coppa del Castello 2024', 210);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 49, 0, 'Coppa del Castello 2024', 1053);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 50, 0, 'Coppa del Castello 2024', 944);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-14', 51, 0, 'Coppa del Castello 2024', 451);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-17', 52, 0, 'Coppa del Castello 2024', 323);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 53, 0, 'Coppa del Castello 2024', 1171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 54, 0, 'Coppa del Castello 2024', 896);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 55, 0, 'Coppa del Castello 2024', 593);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 56, 0, 'Coppa del Castello 2024', 801);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 57, 0, 'Coppa del Castello 2024', 1103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 58, 0, 'Coppa del Castello 2024', 794);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 59, 0, 'Coppa del Castello 2024', 328);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 60, 0, 'Coppa del Castello 2024', 456);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 61, 0, 'Coppa del Castello 2024', 770);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-13', 62, 0, 'Coppa del Castello 2024', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-12', 63, 0, 'Coppa del Castello 2024', 144);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-16', 64, 0, 'Coppa del Castello 2024', 1067);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-19', 65, 0, 'Coppa del Castello 2024', 1051);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 66, 0, 'Coppa del Castello 2024', 659);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 67, 0, 'Coppa del Castello 2024', 780);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 68, 0, 'Coppa del Castello 2024', 695);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 69, 0, 'Coppa del Castello 2024', 836);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-20', 70, 0, 'Coppa del Castello 2024', 833);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 1, 10, 'Modena Golf Cup 2024', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 2, 6, 'Modena Golf Cup 2024', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 3, 5, 'Modena Golf Cup 2024', 592);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 4, 4, 'Modena Golf Cup 2024', 578);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 5, 4, 'Modena Golf Cup 2024', 850);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 6, 4, 'Modena Golf Cup 2024', 1063);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 7, 3, 'Modena Golf Cup 2024', 1044);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 8, 3, 'Modena Golf Cup 2024', 453);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 9, 3, 'Modena Golf Cup 2024', 734);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 10, 3, 'Modena Golf Cup 2024', 600);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 11, 2, 'Modena Golf Cup 2024', 151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 12, 2, 'Modena Golf Cup 2024', 324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 13, 2, 'Modena Golf Cup 2024', 740);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 14, 2, 'Modena Golf Cup 2024', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 15, 1, 'Modena Golf Cup 2024', 296);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 16, 1, 'Modena Golf Cup 2024', 532);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 17, 1, 'Modena Golf Cup 2024', 895);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 18, 1, 'Modena Golf Cup 2024', 166);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 19, 1, 'Modena Golf Cup 2024', 893);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 20, 1, 'Modena Golf Cup 2024', 376);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 21, 0, 'Modena Golf Cup 2024', 862);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 12, 0, 'Modena Golf Cup 2024', 169);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 23, 0, 'Modena Golf Cup 2024', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 24, 0, 'Modena Golf Cup 2024', 543);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 25, 0, 'Modena Golf Cup 2024', 121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 26, 0, 'Modena Golf Cup 2024', 920);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 27, 0, 'Modena Golf Cup 2024', 427);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 28, 0, 'Modena Golf Cup 2024', 407);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 29, 0, 'Modena Golf Cup 2024', 591);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 30, 0, 'Modena Golf Cup 2024', 741);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 31, 0, 'Modena Golf Cup 2024', 988);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 32, 0, 'Modena Golf Cup 2024', 123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 33, 0, 'Modena Golf Cup 2024', 343);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 34, 0, 'Modena Golf Cup 2024', 1102);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 35, 0, 'Modena Golf Cup 2024', 1013);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 36, 0, 'Modena Golf Cup 2024', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 37, 0, 'Modena Golf Cup 2024', 890);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 38, 0, 'Modena Golf Cup 2024', 232);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 39, 0, 'Modena Golf Cup 2024', 1053);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 40, 0, 'Modena Golf Cup 2024', 201);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 41, 0, 'Modena Golf Cup 2024', 48);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 42, 0, 'Modena Golf Cup 2024', 602);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 43, 0, 'Modena Golf Cup 2024', 74);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 44, 0, 'Modena Golf Cup 2024', 699);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 45, 0, 'Modena Golf Cup 2024', 963);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 46, 0, 'Modena Golf Cup 2024', 872);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 47, 0, 'Modena Golf Cup 2024', 1020);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 48, 0, 'Modena Golf Cup 2024', 175);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 49, 0, 'Modena Golf Cup 2024', 1111);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 50, 0, 'Modena Golf Cup 2024', 1149);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 51, 0, 'Modena Golf Cup 2024', 213);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 52, 0, 'Modena Golf Cup 2024', 299);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 53, 0, 'Modena Golf Cup 2024', 332);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 54, 0, 'Modena Golf Cup 2024', 303);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 55, 0, 'Modena Golf Cup 2024', 149);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 56, 0, 'Modena Golf Cup 2024', 631);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 57, 0, 'Modena Golf Cup 2024', 30);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 58, 0, 'Modena Golf Cup 2024', 198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 59, 0, 'Modena Golf Cup 2024', 829);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 60, 0, 'Modena Golf Cup 2024', 1151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 61, 0, 'Modena Golf Cup 2024', 63);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 62, 0, 'Modena Golf Cup 2024', 158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 63, 0, 'Modena Golf Cup 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 64, 0, 'Modena Golf Cup 2024', 565);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 65, 0, 'Modena Golf Cup 2024', 731);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 66, 0, 'Modena Golf Cup 2024', 370);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 67, 0, 'Modena Golf Cup 2024', 1146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 68, 0, 'Modena Golf Cup 2024', 457);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 69, 0, 'Modena Golf Cup 2024', 541);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 70, 0, 'Modena Golf Cup 2024', 65);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 1, 10, 'Coppa della Sindone 2024', 880);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 2, 6, 'Coppa della Sindone 2024', 1152);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 3, 5, 'Coppa della Sindone 2024', 37);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 4, 4, 'Coppa della Sindone 2024', 963);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 5, 4, 'Coppa della Sindone 2024', 163);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 6, 4, 'Coppa della Sindone 2024', 223);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 7, 3, 'Coppa della Sindone 2024', 1049);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 8, 3, 'Coppa della Sindone 2024', 472);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 9, 3, 'Coppa della Sindone 2024', 795);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 10, 3, 'Coppa della Sindone 2024', 1136);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 11, 2, 'Coppa della Sindone 2024', 1007);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 12, 2, 'Coppa della Sindone 2024', 215);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 13, 2, 'Coppa della Sindone 2024', 160);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 14, 2, 'Coppa della Sindone 2024', 745);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 15, 1, 'Coppa della Sindone 2024', 1032);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 16, 1, 'Coppa della Sindone 2024', 484);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 17, 1, 'Coppa della Sindone 2024', 1033);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 18, 1, 'Coppa della Sindone 2024', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 19, 1, 'Coppa della Sindone 2024', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 20, 1, 'Coppa della Sindone 2024', 44);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 21, 0, 'Coppa della Sindone 2024', 948);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 12, 0, 'Coppa della Sindone 2024', 549);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 23, 0, 'Coppa della Sindone 2024', 741);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 24, 0, 'Coppa della Sindone 2024', 213);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 25, 0, 'Coppa della Sindone 2024', 74);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 26, 0, 'Coppa della Sindone 2024', 506);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 27, 0, 'Coppa della Sindone 2024', 952);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 28, 0, 'Coppa della Sindone 2024', 339);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 29, 0, 'Coppa della Sindone 2024', 686);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 30, 0, 'Coppa della Sindone 2024', 300);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 31, 0, 'Coppa della Sindone 2024', 949);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 32, 0, 'Coppa della Sindone 2024', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 33, 0, 'Coppa della Sindone 2024', 624);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 34, 0, 'Coppa della Sindone 2024', 593);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 35, 0, 'Coppa della Sindone 2024', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 36, 0, 'Coppa della Sindone 2024', 801);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 37, 0, 'Coppa della Sindone 2024', 217);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 38, 0, 'Coppa della Sindone 2024', 901);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 39, 0, 'Coppa della Sindone 2024', 493);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 40, 0, 'Coppa della Sindone 2024', 1075);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 41, 0, 'Coppa della Sindone 2024', 589);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 42, 0, 'Coppa della Sindone 2024', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 43, 0, 'Coppa della Sindone 2024', 810);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 44, 0, 'Coppa della Sindone 2024', 1122);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 45, 0, 'Coppa della Sindone 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 46, 0, 'Coppa della Sindone 2024', 1143);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 47, 0, 'Coppa della Sindone 2024', 85);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 48, 0, 'Coppa della Sindone 2024', 352);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 49, 0, 'Coppa della Sindone 2024', 792);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 50, 0, 'Coppa della Sindone 2024', 936);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 51, 0, 'Coppa della Sindone 2024', 1142);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 52, 0, 'Coppa della Sindone 2024', 881);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 53, 0, 'Coppa della Sindone 2024', 282);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 54, 0, 'Coppa della Sindone 2024', 118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 55, 0, 'Coppa della Sindone 2024', 747);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-10', 56, 0, 'Coppa della Sindone 2024', 397);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 57, 0, 'Coppa della Sindone 2024', 559);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 58, 0, 'Coppa della Sindone 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-11', 59, 0, 'Coppa della Sindone 2024', 490);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-12', 60, 0, 'Coppa della Sindone 2024', 1030);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 61, 0, 'Coppa della Sindone 2024', 104);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 62, 0, 'Coppa della Sindone 2024', 700);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 63, 0, 'Coppa della Sindone 2024', 1192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 64, 0, 'Coppa della Sindone 2024', 717);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 65, 0, 'Coppa della Sindone 2024', 698);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 66, 0, 'Coppa della Sindone 2024', 632);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 67, 0, 'Coppa della Sindone 2024', 1123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 68, 0, 'Coppa della Sindone 2024', 910);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 69, 0, 'Coppa della Sindone 2024', 536);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-07', 70, 0, 'Coppa della Sindone 2024', 1157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 1, 10, 'Coppa del Lazio 2024', 1168);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 2, 6, 'Coppa del Lazio 2024', 142);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 3, 5, 'Coppa del Lazio 2024', 306);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 4, 4, 'Coppa del Lazio 2024', 316);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 5, 4, 'Coppa del Lazio 2024', 736);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 6, 4, 'Coppa del Lazio 2024', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 7, 3, 'Coppa del Lazio 2024', 1022);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 8, 3, 'Coppa del Lazio 2024', 991);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 9, 3, 'Coppa del Lazio 2024', 363);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 10, 3, 'Coppa del Lazio 2024', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 11, 2, 'Coppa del Lazio 2024', 393);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 12, 2, 'Coppa del Lazio 2024', 1177);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 13, 2, 'Coppa del Lazio 2024', 291);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 14, 2, 'Coppa del Lazio 2024', 28);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 15, 1, 'Coppa del Lazio 2024', 888);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 16, 1, 'Coppa del Lazio 2024', 8);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 17, 1, 'Coppa del Lazio 2024', 1026);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 18, 1, 'Coppa del Lazio 2024', 273);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 19, 1, 'Coppa del Lazio 2024', 314);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 20, 1, 'Coppa del Lazio 2024', 351);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 21, 0, 'Coppa del Lazio 2024', 952);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 12, 0, 'Coppa del Lazio 2024', 194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 23, 0, 'Coppa del Lazio 2024', 961);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 24, 0, 'Coppa del Lazio 2024', 956);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 25, 0, 'Coppa del Lazio 2024', 483);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 26, 0, 'Coppa del Lazio 2024', 465);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 27, 0, 'Coppa del Lazio 2024', 857);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 28, 0, 'Coppa del Lazio 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 29, 0, 'Coppa del Lazio 2024', 1136);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 30, 0, 'Coppa del Lazio 2024', 908);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 31, 0, 'Coppa del Lazio 2024', 436);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 32, 0, 'Coppa del Lazio 2024', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 33, 0, 'Coppa del Lazio 2024', 545);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 34, 0, 'Coppa del Lazio 2024', 965);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 35, 0, 'Coppa del Lazio 2024', 1188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 36, 0, 'Coppa del Lazio 2024', 829);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 37, 0, 'Coppa del Lazio 2024', 479);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 38, 0, 'Coppa del Lazio 2024', 824);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 39, 0, 'Coppa del Lazio 2024', 488);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 40, 0, 'Coppa del Lazio 2024', 752);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 41, 0, 'Coppa del Lazio 2024', 626);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 42, 0, 'Coppa del Lazio 2024', 590);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 43, 0, 'Coppa del Lazio 2024', 213);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 44, 0, 'Coppa del Lazio 2024', 42);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 45, 0, 'Coppa del Lazio 2024', 467);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 46, 0, 'Coppa del Lazio 2024', 186);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 47, 0, 'Coppa del Lazio 2024', 441);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 48, 0, 'Coppa del Lazio 2024', 1189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 49, 0, 'Coppa del Lazio 2024', 63);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 50, 0, 'Coppa del Lazio 2024', 796);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 51, 0, 'Coppa del Lazio 2024', 514);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 52, 0, 'Coppa del Lazio 2024', 1171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 53, 0, 'Coppa del Lazio 2024', 215);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 54, 0, 'Coppa del Lazio 2024', 670);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 55, 0, 'Coppa del Lazio 2024', 1075);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 56, 0, 'Coppa del Lazio 2024', 69);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 57, 0, 'Coppa del Lazio 2024', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 58, 0, 'Coppa del Lazio 2024', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 59, 0, 'Coppa del Lazio 2024', 603);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 60, 0, 'Coppa del Lazio 2024', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 61, 0, 'Coppa del Lazio 2024', 234);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 62, 0, 'Coppa del Lazio 2024', 731);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 63, 0, 'Coppa del Lazio 2024', 891);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 64, 0, 'Coppa del Lazio 2024', 429);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 65, 0, 'Coppa del Lazio 2024', 1179);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 66, 0, 'Coppa del Lazio 2024', 1015);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 67, 0, 'Coppa del Lazio 2024', 414);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 68, 0, 'Coppa del Lazio 2024', 856);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 69, 0, 'Coppa del Lazio 2024', 27);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 70, 0, 'Coppa del Lazio 2024', 998);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 1, 10, 'Trofeo dell\'Adda', 1083);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 2, 6, 'Trofeo dell\'Adda', 946);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 3, 5, 'Trofeo dell\'Adda', 607);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 4, 4, 'Trofeo dell\'Adda', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 5, 4, 'Trofeo dell\'Adda', 1177);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 6, 4, 'Trofeo dell\'Adda', 683);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 7, 3, 'Trofeo dell\'Adda', 1036);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 8, 3, 'Trofeo dell\'Adda', 58);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 9, 3, 'Trofeo dell\'Adda', 679);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 10, 3, 'Trofeo dell\'Adda', 33);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 11, 2, 'Trofeo dell\'Adda', 859);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 12, 2, 'Trofeo dell\'Adda', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 13, 2, 'Trofeo dell\'Adda', 733);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 14, 2, 'Trofeo dell\'Adda', 123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 15, 1, 'Trofeo dell\'Adda', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 16, 1, 'Trofeo dell\'Adda', 1096);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 17, 1, 'Trofeo dell\'Adda', 930);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 18, 1, 'Trofeo dell\'Adda', 539);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 19, 1, 'Trofeo dell\'Adda', 926);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 20, 1, 'Trofeo dell\'Adda', 903);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 21, 0, 'Trofeo dell\'Adda', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 12, 0, 'Trofeo dell\'Adda', 239);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 23, 0, 'Trofeo dell\'Adda', 379);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 24, 0, 'Trofeo dell\'Adda', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 25, 0, 'Trofeo dell\'Adda', 25);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 26, 0, 'Trofeo dell\'Adda', 955);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 27, 0, 'Trofeo dell\'Adda', 281);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 28, 0, 'Trofeo dell\'Adda', 209);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 29, 0, 'Trofeo dell\'Adda', 1009);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 30, 0, 'Trofeo dell\'Adda', 526);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 31, 0, 'Trofeo dell\'Adda', 234);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 32, 0, 'Trofeo dell\'Adda', 326);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 33, 0, 'Trofeo dell\'Adda', 57);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 34, 0, 'Trofeo dell\'Adda', 445);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 35, 0, 'Trofeo dell\'Adda', 182);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 36, 0, 'Trofeo dell\'Adda', 1125);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 37, 0, 'Trofeo dell\'Adda', 704);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 38, 0, 'Trofeo dell\'Adda', 1162);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 39, 0, 'Trofeo dell\'Adda', 126);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 40, 0, 'Trofeo dell\'Adda', 225);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 41, 0, 'Trofeo dell\'Adda', 467);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 42, 0, 'Trofeo dell\'Adda', 360);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 43, 0, 'Trofeo dell\'Adda', 765);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 44, 0, 'Trofeo dell\'Adda', 449);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 45, 0, 'Trofeo dell\'Adda', 857);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-02', 46, 0, 'Trofeo dell\'Adda', 133);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 47, 0, 'Trofeo dell\'Adda', 217);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 48, 0, 'Trofeo dell\'Adda', 697);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 49, 0, 'Trofeo dell\'Adda', 636);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 50, 0, 'Trofeo dell\'Adda', 895);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 51, 0, 'Trofeo dell\'Adda', 280);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 52, 0, 'Trofeo dell\'Adda', 1045);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 53, 0, 'Trofeo dell\'Adda', 288);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 54, 0, 'Trofeo dell\'Adda', 577);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 55, 0, 'Trofeo dell\'Adda', 951);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 56, 0, 'Trofeo dell\'Adda', 82);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-07', 57, 0, 'Trofeo dell\'Adda', 442);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 58, 0, 'Trofeo dell\'Adda', 96);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-04', 59, 0, 'Trofeo dell\'Adda', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-08', 60, 0, 'Trofeo dell\'Adda', 364);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 61, 0, 'Trofeo dell\'Adda', 674);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 62, 0, 'Trofeo dell\'Adda', 252);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 63, 0, 'Trofeo dell\'Adda', 540);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-03', 64, 0, 'Trofeo dell\'Adda', 11);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 65, 0, 'Trofeo dell\'Adda', 339);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-06', 66, 0, 'Trofeo dell\'Adda', 1033);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-09', 67, 0, 'Trofeo dell\'Adda', 948);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 68, 0, 'Trofeo dell\'Adda', 856);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 69, 0, 'Trofeo dell\'Adda', 478);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-05', 70, 0, 'Trofeo dell\'Adda', 708);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 1, 10, 'Emilia Golf Trophy 2024', 1151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 2, 6, 'Emilia Golf Trophy 2024', 234);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 3, 5, 'Emilia Golf Trophy 2024', 973);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 4, 4, 'Emilia Golf Trophy 2024', 722);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 5, 4, 'Emilia Golf Trophy 2024', 837);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 6, 4, 'Emilia Golf Trophy 2024', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 7, 3, 'Emilia Golf Trophy 2024', 180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 8, 3, 'Emilia Golf Trophy 2024', 254);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 9, 3, 'Emilia Golf Trophy 2024', 162);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 10, 3, 'Emilia Golf Trophy 2024', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 11, 2, 'Emilia Golf Trophy 2024', 623);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 12, 2, 'Emilia Golf Trophy 2024', 865);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 13, 2, 'Emilia Golf Trophy 2024', 692);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 14, 2, 'Emilia Golf Trophy 2024', 299);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 15, 1, 'Emilia Golf Trophy 2024', 1177);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 16, 1, 'Emilia Golf Trophy 2024', 927);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 17, 1, 'Emilia Golf Trophy 2024', 303);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 18, 1, 'Emilia Golf Trophy 2024', 1189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 19, 1, 'Emilia Golf Trophy 2024', 654);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 20, 1, 'Emilia Golf Trophy 2024', 55);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 21, 0, 'Emilia Golf Trophy 2024', 230);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 12, 0, 'Emilia Golf Trophy 2024', 522);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 23, 0, 'Emilia Golf Trophy 2024', 384);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 24, 0, 'Emilia Golf Trophy 2024', 635);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 25, 0, 'Emilia Golf Trophy 2024', 643);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 26, 0, 'Emilia Golf Trophy 2024', 827);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 27, 0, 'Emilia Golf Trophy 2024', 20);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 28, 0, 'Emilia Golf Trophy 2024', 73);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 29, 0, 'Emilia Golf Trophy 2024', 129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 30, 0, 'Emilia Golf Trophy 2024', 509);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 31, 0, 'Emilia Golf Trophy 2024', 1103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 32, 0, 'Emilia Golf Trophy 2024', 689);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 33, 0, 'Emilia Golf Trophy 2024', 735);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 34, 0, 'Emilia Golf Trophy 2024', 996);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 35, 0, 'Emilia Golf Trophy 2024', 419);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 36, 0, 'Emilia Golf Trophy 2024', 1165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 37, 0, 'Emilia Golf Trophy 2024', 13);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 38, 0, 'Emilia Golf Trophy 2024', 923);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 39, 0, 'Emilia Golf Trophy 2024', 1007);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 40, 0, 'Emilia Golf Trophy 2024', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 41, 0, 'Emilia Golf Trophy 2024', 22);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 42, 0, 'Emilia Golf Trophy 2024', 797);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 43, 0, 'Emilia Golf Trophy 2024', 718);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 44, 0, 'Emilia Golf Trophy 2024', 1196);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 45, 0, 'Emilia Golf Trophy 2024', 75);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 46, 0, 'Emilia Golf Trophy 2024', 220);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 47, 0, 'Emilia Golf Trophy 2024', 474);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 48, 0, 'Emilia Golf Trophy 2024', 597);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 49, 0, 'Emilia Golf Trophy 2024', 93);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 50, 0, 'Emilia Golf Trophy 2024', 949);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 51, 0, 'Emilia Golf Trophy 2024', 427);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 52, 0, 'Emilia Golf Trophy 2024', 817);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 53, 0, 'Emilia Golf Trophy 2024', 541);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 54, 0, 'Emilia Golf Trophy 2024', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 55, 0, 'Emilia Golf Trophy 2024', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 56, 0, 'Emilia Golf Trophy 2024', 99);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 57, 0, 'Emilia Golf Trophy 2024', 925);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 58, 0, 'Emilia Golf Trophy 2024', 708);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 59, 0, 'Emilia Golf Trophy 2024', 563);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 60, 0, 'Emilia Golf Trophy 2024', 1117);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 61, 0, 'Emilia Golf Trophy 2024', 4);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 62, 0, 'Emilia Golf Trophy 2024', 253);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 63, 0, 'Emilia Golf Trophy 2024', 561);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-11', 64, 0, 'Emilia Golf Trophy 2024', 260);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 65, 0, 'Emilia Golf Trophy 2024', 877);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-10', 66, 0, 'Emilia Golf Trophy 2024', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 67, 0, 'Emilia Golf Trophy 2024', 955);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 68, 0, 'Emilia Golf Trophy 2024', 772);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 69, 0, 'Emilia Golf Trophy 2024', 186);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-12', 70, 0, 'Emilia Golf Trophy 2024', 1130);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 1, 10, 'XI Coppa del Salento', 559);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 2, 6, 'XI Coppa del Salento', 547);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 3, 5, 'XI Coppa del Salento', 1019);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 4, 4, 'XI Coppa del Salento', 117);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 5, 4, 'XI Coppa del Salento', 917);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 6, 4, 'XI Coppa del Salento', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 7, 3, 'XI Coppa del Salento', 465);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 8, 3, 'XI Coppa del Salento', 22);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 9, 3, 'XI Coppa del Salento', 275);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 10, 3, 'XI Coppa del Salento', 877);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 11, 2, 'XI Coppa del Salento', 561);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 12, 2, 'XI Coppa del Salento', 1104);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 13, 2, 'XI Coppa del Salento', 932);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 14, 2, 'XI Coppa del Salento', 792);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 15, 1, 'XI Coppa del Salento', 1179);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 16, 1, 'XI Coppa del Salento', 266);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 17, 1, 'XI Coppa del Salento', 252);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 18, 1, 'XI Coppa del Salento', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 19, 1, 'XI Coppa del Salento', 380);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 20, 1, 'XI Coppa del Salento', 797);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 21, 0, 'XI Coppa del Salento', 830);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 12, 0, 'XI Coppa del Salento', 563);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 23, 0, 'XI Coppa del Salento', 531);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 24, 0, 'XI Coppa del Salento', 584);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 25, 0, 'XI Coppa del Salento', 521);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 26, 0, 'XI Coppa del Salento', 373);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 27, 0, 'XI Coppa del Salento', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 28, 0, 'XI Coppa del Salento', 765);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 29, 0, 'XI Coppa del Salento', 1159);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 30, 0, 'XI Coppa del Salento', 1093);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 31, 0, 'XI Coppa del Salento', 998);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 32, 0, 'XI Coppa del Salento', 1052);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 33, 0, 'XI Coppa del Salento', 1190);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 34, 0, 'XI Coppa del Salento', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 35, 0, 'XI Coppa del Salento', 869);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 36, 0, 'XI Coppa del Salento', 9);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 37, 0, 'XI Coppa del Salento', 643);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 38, 0, 'XI Coppa del Salento', 878);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 39, 0, 'XI Coppa del Salento', 314);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 40, 0, 'XI Coppa del Salento', 82);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 41, 0, 'XI Coppa del Salento', 905);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-28', 42, 0, 'XI Coppa del Salento', 454);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 43, 0, 'XI Coppa del Salento', 533);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 44, 0, 'XI Coppa del Salento', 467);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 45, 0, 'XI Coppa del Salento', 434);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-29', 46, 0, 'XI Coppa del Salento', 776);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 47, 0, 'XI Coppa del Salento', 485);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 48, 0, 'XI Coppa del Salento', 330);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 49, 0, 'XI Coppa del Salento', 947);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 50, 0, 'XI Coppa del Salento', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 51, 0, 'XI Coppa del Salento', 224);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 52, 0, 'XI Coppa del Salento', 268);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 53, 0, 'XI Coppa del Salento', 536);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 54, 0, 'XI Coppa del Salento', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 55, 0, 'XI Coppa del Salento', 935);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 56, 0, 'XI Coppa del Salento', 286);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 57, 0, 'XI Coppa del Salento', 798);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 58, 0, 'XI Coppa del Salento', 1081);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 59, 0, 'XI Coppa del Salento', 1180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 60, 0, 'XI Coppa del Salento', 24);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 61, 0, 'XI Coppa del Salento', 501);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 62, 0, 'XI Coppa del Salento', 794);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-27', 63, 0, 'XI Coppa del Salento', 800);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 64, 0, 'XI Coppa del Salento', 849);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 65, 0, 'XI Coppa del Salento', 129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 66, 0, 'XI Coppa del Salento', 768);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-26', 67, 0, 'XI Coppa del Salento', 272);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 68, 0, 'XI Coppa del Salento', 772);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 69, 0, 'XI Coppa del Salento', 939);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-30', 70, 0, 'XI Coppa del Salento', 474);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 1, 10, 'XI Trofeo dell\'Adriatico', 138);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 2, 6, 'XI Trofeo dell\'Adriatico', 760);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 3, 5, 'XI Trofeo dell\'Adriatico', 667);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 4, 4, 'XI Trofeo dell\'Adriatico', 829);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 5, 4, 'XI Trofeo dell\'Adriatico', 157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 6, 4, 'XI Trofeo dell\'Adriatico', 239);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 7, 3, 'XI Trofeo dell\'Adriatico', 551);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 8, 3, 'XI Trofeo dell\'Adriatico', 404);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 9, 3, 'XI Trofeo dell\'Adriatico', 291);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 10, 3, 'XI Trofeo dell\'Adriatico', 186);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 11, 2, 'XI Trofeo dell\'Adriatico', 812);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 12, 2, 'XI Trofeo dell\'Adriatico', 775);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 13, 2, 'XI Trofeo dell\'Adriatico', 595);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 14, 2, 'XI Trofeo dell\'Adriatico', 355);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 15, 1, 'XI Trofeo dell\'Adriatico', 364);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 16, 1, 'XI Trofeo dell\'Adriatico', 1095);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 17, 1, 'XI Trofeo dell\'Adriatico', 328);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 18, 1, 'XI Trofeo dell\'Adriatico', 583);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 19, 1, 'XI Trofeo dell\'Adriatico', 57);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 20, 1, 'XI Trofeo dell\'Adriatico', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 21, 0, 'XI Trofeo dell\'Adriatico', 309);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 12, 0, 'XI Trofeo dell\'Adriatico', 1113);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 23, 0, 'XI Trofeo dell\'Adriatico', 340);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 24, 0, 'XI Trofeo dell\'Adriatico', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 25, 0, 'XI Trofeo dell\'Adriatico', 783);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 26, 0, 'XI Trofeo dell\'Adriatico', 734);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 27, 0, 'XI Trofeo dell\'Adriatico', 154);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 28, 0, 'XI Trofeo dell\'Adriatico', 410);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 29, 0, 'XI Trofeo dell\'Adriatico', 1094);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 30, 0, 'XI Trofeo dell\'Adriatico', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 31, 0, 'XI Trofeo dell\'Adriatico', 278);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 32, 0, 'XI Trofeo dell\'Adriatico', 958);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 33, 0, 'XI Trofeo dell\'Adriatico', 273);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 34, 0, 'XI Trofeo dell\'Adriatico', 308);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 35, 0, 'XI Trofeo dell\'Adriatico', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 36, 0, 'XI Trofeo dell\'Adriatico', 14);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 37, 0, 'XI Trofeo dell\'Adriatico', 319);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 38, 0, 'XI Trofeo dell\'Adriatico', 367);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 39, 0, 'XI Trofeo dell\'Adriatico', 389);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 40, 0, 'XI Trofeo dell\'Adriatico', 1003);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 41, 0, 'XI Trofeo dell\'Adriatico', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 42, 0, 'XI Trofeo dell\'Adriatico', 395);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 43, 0, 'XI Trofeo dell\'Adriatico', 242);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 44, 0, 'XI Trofeo dell\'Adriatico', 116);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 45, 0, 'XI Trofeo dell\'Adriatico', 363);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 46, 0, 'XI Trofeo dell\'Adriatico', 691);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 47, 0, 'XI Trofeo dell\'Adriatico', 493);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 48, 0, 'XI Trofeo dell\'Adriatico', 192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 49, 0, 'XI Trofeo dell\'Adriatico', 518);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 50, 0, 'XI Trofeo dell\'Adriatico', 942);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 51, 0, 'XI Trofeo dell\'Adriatico', 425);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 52, 0, 'XI Trofeo dell\'Adriatico', 849);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 53, 0, 'XI Trofeo dell\'Adriatico', 442);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 54, 0, 'XI Trofeo dell\'Adriatico', 922);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 55, 0, 'XI Trofeo dell\'Adriatico', 171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 56, 0, 'XI Trofeo dell\'Adriatico', 979);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 57, 0, 'XI Trofeo dell\'Adriatico', 1188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 58, 0, 'XI Trofeo dell\'Adriatico', 1022);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 59, 0, 'XI Trofeo dell\'Adriatico', 593);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 60, 0, 'XI Trofeo dell\'Adriatico', 406);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 61, 0, 'XI Trofeo dell\'Adriatico', 381);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 62, 0, 'XI Trofeo dell\'Adriatico', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 63, 0, 'XI Trofeo dell\'Adriatico', 838);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 64, 0, 'XI Trofeo dell\'Adriatico', 617);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 65, 0, 'XI Trofeo dell\'Adriatico', 857);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 66, 0, 'XI Trofeo dell\'Adriatico', 79);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 67, 0, 'XI Trofeo dell\'Adriatico', 1027);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 68, 0, 'XI Trofeo dell\'Adriatico', 1009);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 69, 0, 'XI Trofeo dell\'Adriatico', 190);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 70, 0, 'XI Trofeo dell\'Adriatico', 163);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 1, 40, 'Bogogno Golf Cup 2024', 290);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 2, 26, 'Bogogno Golf Cup 2024', 331);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 3, 22, 'Bogogno Golf Cup 2024', 99);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 4, 19, 'Bogogno Golf Cup 2024', 494);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-13', 5, 17, 'Bogogno Golf Cup 2024', 412);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 6, 16, 'Bogogno Golf Cup 2024', 384);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 7, 15, 'Bogogno Golf Cup 2024', 672);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 8, 14, 'Bogogno Golf Cup 2024', 796);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 9, 13, 'Bogogno Golf Cup 2024', 421);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 10, 12, 'Bogogno Golf Cup 2024', 400);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 11, 12, 'Bogogno Golf Cup 2024', 310);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 12, 11, 'Bogogno Golf Cup 2024', 844);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 13, 10, 'Bogogno Golf Cup 2024', 157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 14, 10, 'Bogogno Golf Cup 2024', 706);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 15, 9, 'Bogogno Golf Cup 2024', 685);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 16, 9, 'Bogogno Golf Cup 2024', 950);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 17, 8, 'Bogogno Golf Cup 2024', 632);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 18, 8, 'Bogogno Golf Cup 2024', 878);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 19, 7, 'Bogogno Golf Cup 2024', 597);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 20, 7, 'Bogogno Golf Cup 2024', 143);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 21, 7, 'Bogogno Golf Cup 2024', 262);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 12, 6, 'Bogogno Golf Cup 2024', 822);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 23, 6, 'Bogogno Golf Cup 2024', 694);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 24, 6, 'Bogogno Golf Cup 2024', 516);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 25, 5, 'Bogogno Golf Cup 2024', 124);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 26, 5, 'Bogogno Golf Cup 2024', 213);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 27, 5, 'Bogogno Golf Cup 2024', 259);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 28, 4, 'Bogogno Golf Cup 2024', 438);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 29, 4, 'Bogogno Golf Cup 2024', 4);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 30, 4, 'Bogogno Golf Cup 2024', 299);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 31, 3, 'Bogogno Golf Cup 2024', 843);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 32, 3, 'Bogogno Golf Cup 2024', 739);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 33, 3, 'Bogogno Golf Cup 2024', 135);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-16', 34, 2, 'Bogogno Golf Cup 2024', 784);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 35, 2, 'Bogogno Golf Cup 2024', 529);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 36, 2, 'Bogogno Golf Cup 2024', 307);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 37, 1, 'Bogogno Golf Cup 2024', 622);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 38, 1, 'Bogogno Golf Cup 2024', 792);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 39, 1, 'Bogogno Golf Cup 2024', 691);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 40, 0, 'Bogogno Golf Cup 2024', 957);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 41, 0, 'Bogogno Golf Cup 2024', 292);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 42, 0, 'Bogogno Golf Cup 2024', 1);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 43, 0, 'Bogogno Golf Cup 2024', 18);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 44, 0, 'Bogogno Golf Cup 2024', 1135);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 45, 0, 'Bogogno Golf Cup 2024', 350);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 46, 0, 'Bogogno Golf Cup 2024', 1061);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-14', 47, 0, 'Bogogno Golf Cup 2024', 216);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-15', 48, 0, 'Bogogno Golf Cup 2024', 1059);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 49, 0, 'Bogogno Golf Cup 2024', 951);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 50, 0, 'Bogogno Golf Cup 2024', 671);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 51, 0, 'Bogogno Golf Cup 2024', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 52, 0, 'Bogogno Golf Cup 2024', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 53, 0, 'Bogogno Golf Cup 2024', 146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 54, 0, 'Bogogno Golf Cup 2024', 252);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 55, 0, 'Bogogno Golf Cup 2024', 580);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 56, 0, 'Bogogno Golf Cup 2024', 913);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-25', 57, 0, 'Bogogno Golf Cup 2024', 673);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-24', 58, 0, 'Bogogno Golf Cup 2024', 148);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 59, 0, 'Bogogno Golf Cup 2024', 47);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 60, 0, 'Bogogno Golf Cup 2024', 425);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 61, 0, 'Bogogno Golf Cup 2024', 1157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-20', 62, 0, 'Bogogno Golf Cup 2024', 370);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 63, 0, 'Bogogno Golf Cup 2024', 883);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 64, 0, 'Bogogno Golf Cup 2024', 50);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-17', 65, 0, 'Bogogno Golf Cup 2024', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-19', 66, 0, 'Bogogno Golf Cup 2024', 132);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-18', 67, 0, 'Bogogno Golf Cup 2024', 975);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-23', 68, 0, 'Bogogno Golf Cup 2024', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-21', 69, 0, 'Bogogno Golf Cup 2024', 82);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-22', 70, 0, 'Bogogno Golf Cup 2024', 27);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 1, 40, 'Gran Premio del Lago 2024', 1012);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 2, 26, 'Gran Premio del Lago 2024', 1024);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 3, 22, 'Gran Premio del Lago 2024', 1095);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 4, 19, 'Gran Premio del Lago 2024', 788);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 5, 17, 'Gran Premio del Lago 2024', 165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 6, 16, 'Gran Premio del Lago 2024', 1092);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 7, 15, 'Gran Premio del Lago 2024', 255);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 8, 14, 'Gran Premio del Lago 2024', 605);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 9, 13, 'Gran Premio del Lago 2024', 624);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 10, 12, 'Gran Premio del Lago 2024', 474);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 11, 12, 'Gran Premio del Lago 2024', 1025);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 12, 11, 'Gran Premio del Lago 2024', 979);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 13, 10, 'Gran Premio del Lago 2024', 126);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 14, 10, 'Gran Premio del Lago 2024', 1118);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 15, 9, 'Gran Premio del Lago 2024', 194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 16, 9, 'Gran Premio del Lago 2024', 1162);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 17, 8, 'Gran Premio del Lago 2024', 379);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 18, 8, 'Gran Premio del Lago 2024', 886);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 19, 7, 'Gran Premio del Lago 2024', 356);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 20, 7, 'Gran Premio del Lago 2024', 198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 21, 7, 'Gran Premio del Lago 2024', 1082);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 12, 6, 'Gran Premio del Lago 2024', 1047);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 23, 6, 'Gran Premio del Lago 2024', 1083);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 24, 6, 'Gran Premio del Lago 2024', 639);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 25, 5, 'Gran Premio del Lago 2024', 368);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 26, 5, 'Gran Premio del Lago 2024', 98);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 27, 5, 'Gran Premio del Lago 2024', 176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 28, 4, 'Gran Premio del Lago 2024', 187);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 29, 4, 'Gran Premio del Lago 2024', 266);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 30, 4, 'Gran Premio del Lago 2024', 995);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 31, 3, 'Gran Premio del Lago 2024', 52);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 32, 3, 'Gran Premio del Lago 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 33, 3, 'Gran Premio del Lago 2024', 1146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 34, 2, 'Gran Premio del Lago 2024', 1166);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 35, 2, 'Gran Premio del Lago 2024', 637);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 36, 2, 'Gran Premio del Lago 2024', 361);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 37, 1, 'Gran Premio del Lago 2024', 660);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 38, 1, 'Gran Premio del Lago 2024', 137);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 39, 1, 'Gran Premio del Lago 2024', 189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 40, 0, 'Gran Premio del Lago 2024', 611);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 41, 0, 'Gran Premio del Lago 2024', 207);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 42, 0, 'Gran Premio del Lago 2024', 535);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 43, 0, 'Gran Premio del Lago 2024', 868);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 44, 0, 'Gran Premio del Lago 2024', 551);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 45, 0, 'Gran Premio del Lago 2024', 304);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 46, 0, 'Gran Premio del Lago 2024', 154);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 47, 0, 'Gran Premio del Lago 2024', 1180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 48, 0, 'Gran Premio del Lago 2024', 649);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 49, 0, 'Gran Premio del Lago 2024', 1058);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 50, 0, 'Gran Premio del Lago 2024', 950);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 51, 0, 'Gran Premio del Lago 2024', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 52, 0, 'Gran Premio del Lago 2024', 549);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 53, 0, 'Gran Premio del Lago 2024', 144);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 54, 0, 'Gran Premio del Lago 2024', 743);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 55, 0, 'Gran Premio del Lago 2024', 55);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 56, 0, 'Gran Premio del Lago 2024', 385);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 57, 0, 'Gran Premio del Lago 2024', 298);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 58, 0, 'Gran Premio del Lago 2024', 340);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 59, 0, 'Gran Premio del Lago 2024', 233);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 60, 0, 'Gran Premio del Lago 2024', 1042);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-15', 61, 0, 'Gran Premio del Lago 2024', 12);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 62, 0, 'Gran Premio del Lago 2024', 557);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 63, 0, 'Gran Premio del Lago 2024', 270);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-14', 64, 0, 'Gran Premio del Lago 2024', 409);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-13', 65, 0, 'Gran Premio del Lago 2024', 192);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-12', 66, 0, 'Gran Premio del Lago 2024', 259);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 67, 0, 'Gran Premio del Lago 2024', 446);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-11', 68, 0, 'Gran Premio del Lago 2024', 1052);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 69, 0, 'Gran Premio del Lago 2024', 510);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 70, 0, 'Gran Premio del Lago 2024', 1004);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 1, 80, 'XXII Coppa Malatestiana', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 2, 51, 'XXII Coppa Malatestiana', 448);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 3, 44, 'XXII Coppa Malatestiana', 88);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 4, 37, 'XXII Coppa Malatestiana', 631);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 5, 35, 'XXII Coppa Malatestiana', 903);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 6, 33, 'XXII Coppa Malatestiana', 599);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 7, 31, 'XXII Coppa Malatestiana', 401);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 8, 39, 'XXII Coppa Malatestiana', 519);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 9, 27, 'XXII Coppa Malatestiana', 407);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 10, 24, 'XXII Coppa Malatestiana', 786);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 11, 23, 'XXII Coppa Malatestiana', 212);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 12, 22, 'XXII Coppa Malatestiana', 662);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 13, 20, 'XXII Coppa Malatestiana', 1099);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 14, 19, 'XXII Coppa Malatestiana', 293);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 15, 18, 'XXII Coppa Malatestiana', 411);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 16, 17, 'XXII Coppa Malatestiana', 983);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 17, 16, 'XXII Coppa Malatestiana', 193);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 18, 16, 'XXII Coppa Malatestiana', 703);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 19, 15, 'XXII Coppa Malatestiana', 1041);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 20, 14, 'XXII Coppa Malatestiana', 471);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 21, 14, 'XXII Coppa Malatestiana', 563);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 12, 13, 'XXII Coppa Malatestiana', 228);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 23, 12, 'XXII Coppa Malatestiana', 1123);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 24, 12, 'XXII Coppa Malatestiana', 772);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 25, 11, 'XXII Coppa Malatestiana', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 26, 10, 'XXII Coppa Malatestiana', 614);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 27, 10, 'XXII Coppa Malatestiana', 791);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 28, 9, 'XXII Coppa Malatestiana', 85);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 29, 8, 'XXII Coppa Malatestiana', 134);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 30, 7, 'XXII Coppa Malatestiana', 171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 31, 6, 'XXII Coppa Malatestiana', 644);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 32, 5, 'XXII Coppa Malatestiana', 1142);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 33, 5, 'XXII Coppa Malatestiana', 194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 34, 5, 'XXII Coppa Malatestiana', 1057);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 35, 3, 'XXII Coppa Malatestiana', 359);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 36, 3, 'XXII Coppa Malatestiana', 933);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 37, 3, 'XXII Coppa Malatestiana', 670);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 38, 3, 'XXII Coppa Malatestiana', 1012);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 39, 3, 'XXII Coppa Malatestiana', 313);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 40, 3, 'XXII Coppa Malatestiana', 919);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 41, 3, 'XXII Coppa Malatestiana', 523);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-10', 42, 3, 'XXII Coppa Malatestiana', 98);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 43, 3, 'XXII Coppa Malatestiana', 260);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 44, 2, 'XXII Coppa Malatestiana', 939);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 45, 2, 'XXII Coppa Malatestiana', 602);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-01', 46, 2, 'XXII Coppa Malatestiana', 1159);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 47, 2, 'XXII Coppa Malatestiana', 145);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 48, 2, 'XXII Coppa Malatestiana', 393);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 49, 2, 'XXII Coppa Malatestiana', 545);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 50, 2, 'XXII Coppa Malatestiana', 598);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 51, 0, 'XXII Coppa Malatestiana', 295);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 52, 0, 'XXII Coppa Malatestiana', 341);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 53, 0, 'XXII Coppa Malatestiana', 564);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 54, 0, 'XXII Coppa Malatestiana', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-04', 55, 0, 'XXII Coppa Malatestiana', 502);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 56, 0, 'XXII Coppa Malatestiana', 682);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-03', 57, 0, 'XXII Coppa Malatestiana', 320);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 58, 0, 'XXII Coppa Malatestiana', 745);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 59, 0, 'XXII Coppa Malatestiana', 235);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-02', 60, 0, 'XXII Coppa Malatestiana', 1044);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 61, 0, 'XXII Coppa Malatestiana', 1055);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 62, 0, 'XXII Coppa Malatestiana', 796);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-06', 63, 0, 'XXII Coppa Malatestiana', 499);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 64, 0, 'XXII Coppa Malatestiana', 632);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-05', 65, 0, 'XXII Coppa Malatestiana', 482);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-07', 66, 0, 'XXII Coppa Malatestiana', 202);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 67, 0, 'XXII Coppa Malatestiana', 1061);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-08', 68, 0, 'XXII Coppa Malatestiana', 833);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 69, 0, 'XXII Coppa Malatestiana', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-07-09', 70, 0, 'XXII Coppa Malatestiana', 988);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 1, 80, 'Asolo Hills Classic 2024', 1082);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 2, 51, 'Asolo Hills Classic 2024', 453);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 3, 44, 'Asolo Hills Classic 2024', 663);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 4, 37, 'Asolo Hills Classic 2024', 377);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 5, 35, 'Asolo Hills Classic 2024', 71);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 6, 33, 'Asolo Hills Classic 2024', 640);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 7, 31, 'Asolo Hills Classic 2024', 859);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 8, 39, 'Asolo Hills Classic 2024', 481);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 9, 27, 'Asolo Hills Classic 2024', 923);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 10, 24, 'Asolo Hills Classic 2024', 248);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 11, 23, 'Asolo Hills Classic 2024', 1148);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 12, 22, 'Asolo Hills Classic 2024', 202);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 13, 20, 'Asolo Hills Classic 2024', 1177);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 14, 19, 'Asolo Hills Classic 2024', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 15, 18, 'Asolo Hills Classic 2024', 351);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 16, 17, 'Asolo Hills Classic 2024', 334);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 17, 16, 'Asolo Hills Classic 2024', 658);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 18, 16, 'Asolo Hills Classic 2024', 761);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 19, 15, 'Asolo Hills Classic 2024', 835);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 20, 14, 'Asolo Hills Classic 2024', 444);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 21, 14, 'Asolo Hills Classic 2024', 296);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 12, 13, 'Asolo Hills Classic 2024', 903);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 23, 12, 'Asolo Hills Classic 2024', 505);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 24, 12, 'Asolo Hills Classic 2024', 851);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 25, 11, 'Asolo Hills Classic 2024', 637);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 26, 10, 'Asolo Hills Classic 2024', 1117);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 27, 10, 'Asolo Hills Classic 2024', 32);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 28, 9, 'Asolo Hills Classic 2024', 333);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 29, 8, 'Asolo Hills Classic 2024', 547);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 30, 7, 'Asolo Hills Classic 2024', 842);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 31, 6, 'Asolo Hills Classic 2024', 20);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 32, 5, 'Asolo Hills Classic 2024', 1021);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 33, 5, 'Asolo Hills Classic 2024', 996);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 34, 5, 'Asolo Hills Classic 2024', 584);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 35, 3, 'Asolo Hills Classic 2024', 65);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 36, 3, 'Asolo Hills Classic 2024', 1113);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 37, 3, 'Asolo Hills Classic 2024', 312);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 38, 3, 'Asolo Hills Classic 2024', 1176);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 39, 3, 'Asolo Hills Classic 2024', 779);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 40, 3, 'Asolo Hills Classic 2024', 895);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 41, 3, 'Asolo Hills Classic 2024', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 42, 3, 'Asolo Hills Classic 2024', 389);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 43, 3, 'Asolo Hills Classic 2024', 788);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 44, 2, 'Asolo Hills Classic 2024', 135);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 45, 2, 'Asolo Hills Classic 2024', 4);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 46, 2, 'Asolo Hills Classic 2024', 229);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 47, 2, 'Asolo Hills Classic 2024', 917);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 48, 2, 'Asolo Hills Classic 2024', 1184);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 49, 2, 'Asolo Hills Classic 2024', 215);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 50, 2, 'Asolo Hills Classic 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 51, 0, 'Asolo Hills Classic 2024', 819);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 52, 0, 'Asolo Hills Classic 2024', 89);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 53, 0, 'Asolo Hills Classic 2024', 520);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 54, 0, 'Asolo Hills Classic 2024', 908);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-04', 55, 0, 'Asolo Hills Classic 2024', 999);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 56, 0, 'Asolo Hills Classic 2024', 1059);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-03', 57, 0, 'Asolo Hills Classic 2024', 318);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 58, 0, 'Asolo Hills Classic 2024', 436);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 59, 0, 'Asolo Hills Classic 2024', 834);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 60, 0, 'Asolo Hills Classic 2024', 552);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 61, 0, 'Asolo Hills Classic 2024', 993);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 62, 0, 'Asolo Hills Classic 2024', 878);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-06', 63, 0, 'Asolo Hills Classic 2024', 382);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 64, 0, 'Asolo Hills Classic 2024', 1129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 65, 0, 'Asolo Hills Classic 2024', 1058);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-05', 66, 0, 'Asolo Hills Classic 2024', 1161);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 67, 0, 'Asolo Hills Classic 2024', 462);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-08', 68, 0, 'Asolo Hills Classic 2024', 328);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 69, 0, 'Asolo Hills Classic 2024', 1124);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-09', 70, 0, 'Asolo Hills Classic 2024', 915);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 1, 80, 'Milano Golf Cup 2024', 23);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 2, 51, 'Milano Golf Cup 2024', 69);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 3, 44, 'Milano Golf Cup 2024', 891);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 4, 37, 'Milano Golf Cup 2024', 1047);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 5, 35, 'Milano Golf Cup 2024', 353);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 6, 33, 'Milano Golf Cup 2024', 1198);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 7, 31, 'Milano Golf Cup 2024', 159);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 8, 39, 'Milano Golf Cup 2024', 355);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 9, 27, 'Milano Golf Cup 2024', 188);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 10, 24, 'Milano Golf Cup 2024', 1194);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 11, 23, 'Milano Golf Cup 2024', 996);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 12, 22, 'Milano Golf Cup 2024', 769);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 13, 20, 'Milano Golf Cup 2024', 80);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 14, 19, 'Milano Golf Cup 2024', 1078);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 15, 18, 'Milano Golf Cup 2024', 510);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 16, 17, 'Milano Golf Cup 2024', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 17, 16, 'Milano Golf Cup 2024', 365);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 18, 16, 'Milano Golf Cup 2024', 292);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 19, 15, 'Milano Golf Cup 2024', 122);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 20, 14, 'Milano Golf Cup 2024', 28);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 21, 14, 'Milano Golf Cup 2024', 184);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 12, 13, 'Milano Golf Cup 2024', 280);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 23, 12, 'Milano Golf Cup 2024', 1018);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 24, 12, 'Milano Golf Cup 2024', 621);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 25, 11, 'Milano Golf Cup 2024', 1151);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 26, 10, 'Milano Golf Cup 2024', 757);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 27, 10, 'Milano Golf Cup 2024', 20);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 28, 9, 'Milano Golf Cup 2024', 59);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 29, 8, 'Milano Golf Cup 2024', 410);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 30, 7, 'Milano Golf Cup 2024', 691);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 31, 6, 'Milano Golf Cup 2024', 160);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 32, 5, 'Milano Golf Cup 2024', 25);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 33, 5, 'Milano Golf Cup 2024', 203);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 34, 5, 'Milano Golf Cup 2024', 307);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 35, 3, 'Milano Golf Cup 2024', 717);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 36, 3, 'Milano Golf Cup 2024', 968);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 37, 3, 'Milano Golf Cup 2024', 818);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 38, 3, 'Milano Golf Cup 2024', 1103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-23', 39, 3, 'Milano Golf Cup 2024', 392);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 40, 3, 'Milano Golf Cup 2024', 1094);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 41, 3, 'Milano Golf Cup 2024', 984);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 42, 3, 'Milano Golf Cup 2024', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 43, 3, 'Milano Golf Cup 2024', 150);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 44, 2, 'Milano Golf Cup 2024', 894);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 45, 2, 'Milano Golf Cup 2024', 1);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 46, 2, 'Milano Golf Cup 2024', 774);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 47, 2, 'Milano Golf Cup 2024', 668);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-21', 48, 2, 'Milano Golf Cup 2024', 61);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 49, 2, 'Milano Golf Cup 2024', 979);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 50, 2, 'Milano Golf Cup 2024', 350);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 51, 0, 'Milano Golf Cup 2024', 212);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-26', 52, 0, 'Milano Golf Cup 2024', 821);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 53, 0, 'Milano Golf Cup 2024', 1120);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 54, 0, 'Milano Golf Cup 2024', 711);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 55, 0, 'Milano Golf Cup 2024', 612);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 56, 0, 'Milano Golf Cup 2024', 832);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 57, 0, 'Milano Golf Cup 2024', 430);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 58, 0, 'Milano Golf Cup 2024', 907);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-22', 59, 0, 'Milano Golf Cup 2024', 22);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-24', 60, 0, 'Milano Golf Cup 2024', 153);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-25', 61, 0, 'Milano Golf Cup 2024', 328);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 62, 0, 'Milano Golf Cup 2024', 913);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 63, 0, 'Milano Golf Cup 2024', 359);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 64, 0, 'Milano Golf Cup 2024', 1157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 65, 0, 'Milano Golf Cup 2024', 300);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 66, 0, 'Milano Golf Cup 2024', 546);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-27', 67, 0, 'Milano Golf Cup 2024', 661);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-30', 68, 0, 'Milano Golf Cup 2024', 1057);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-28', 69, 0, 'Milano Golf Cup 2024', 651);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-03-29', 70, 0, 'Milano Golf Cup 2024', 1008);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 1, 80, 'VII Coppa del Dragone', 921);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 2, 51, 'VII Coppa del Dragone', 76);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 3, 44, 'VII Coppa del Dragone', 1121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 4, 37, 'VII Coppa del Dragone', 261);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 5, 35, 'VII Coppa del Dragone', 157);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 6, 33, 'VII Coppa del Dragone', 285);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 7, 31, 'VII Coppa del Dragone', 1115);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 8, 39, 'VII Coppa del Dragone', 354);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 9, 27, 'VII Coppa del Dragone', 1082);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 10, 24, 'VII Coppa del Dragone', 61);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 11, 23, 'VII Coppa del Dragone', 719);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 12, 22, 'VII Coppa del Dragone', 1);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 13, 20, 'VII Coppa del Dragone', 480);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 14, 19, 'VII Coppa del Dragone', 924);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 15, 18, 'VII Coppa del Dragone', 541);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 16, 17, 'VII Coppa del Dragone', 202);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 17, 16, 'VII Coppa del Dragone', 223);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 18, 16, 'VII Coppa del Dragone', 728);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 19, 15, 'VII Coppa del Dragone', 958);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 20, 14, 'VII Coppa del Dragone', 454);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 21, 14, 'VII Coppa del Dragone', 808);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 12, 13, 'VII Coppa del Dragone', 816);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 23, 12, 'VII Coppa del Dragone', 1047);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 24, 12, 'VII Coppa del Dragone', 1128);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 25, 11, 'VII Coppa del Dragone', 196);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 26, 10, 'VII Coppa del Dragone', 711);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 27, 10, 'VII Coppa del Dragone', 552);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 28, 9, 'VII Coppa del Dragone', 1087);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 29, 8, 'VII Coppa del Dragone', 896);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 30, 7, 'VII Coppa del Dragone', 377);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 31, 6, 'VII Coppa del Dragone', 1137);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 32, 5, 'VII Coppa del Dragone', 919);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 33, 5, 'VII Coppa del Dragone', 381);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 34, 5, 'VII Coppa del Dragone', 806);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 35, 3, 'VII Coppa del Dragone', 526);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 36, 3, 'VII Coppa del Dragone', 849);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 37, 3, 'VII Coppa del Dragone', 119);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 38, 3, 'VII Coppa del Dragone', 357);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 39, 3, 'VII Coppa del Dragone', 97);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 40, 3, 'VII Coppa del Dragone', 1027);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 41, 3, 'VII Coppa del Dragone', 1103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 42, 3, 'VII Coppa del Dragone', 1113);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 43, 3, 'VII Coppa del Dragone', 683);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 44, 2, 'VII Coppa del Dragone', 397);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 45, 2, 'VII Coppa del Dragone', 589);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 46, 2, 'VII Coppa del Dragone', 229);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 47, 2, 'VII Coppa del Dragone', 586);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 48, 2, 'VII Coppa del Dragone', 952);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 49, 2, 'VII Coppa del Dragone', 173);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 50, 2, 'VII Coppa del Dragone', 708);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 51, 0, 'VII Coppa del Dragone', 936);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 52, 0, 'VII Coppa del Dragone', 1033);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 53, 0, 'VII Coppa del Dragone', 274);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 54, 0, 'VII Coppa del Dragone', 689);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 55, 0, 'VII Coppa del Dragone', 170);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 56, 0, 'VII Coppa del Dragone', 129);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 57, 0, 'VII Coppa del Dragone', 696);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 58, 0, 'VII Coppa del Dragone', 693);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 59, 0, 'VII Coppa del Dragone', 1189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 60, 0, 'VII Coppa del Dragone', 738);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 61, 0, 'VII Coppa del Dragone', 775);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 62, 0, 'VII Coppa del Dragone', 976);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 63, 0, 'VII Coppa del Dragone', 579);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 64, 0, 'VII Coppa del Dragone', 1026);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 65, 0, 'VII Coppa del Dragone', 403);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 66, 0, 'VII Coppa del Dragone', 542);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 67, 0, 'VII Coppa del Dragone', 423);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 68, 0, 'VII Coppa del Dragone', 825);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 69, 0, 'VII Coppa del Dragone', 673);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 70, 0, 'VII Coppa del Dragone', 204);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 1, 140, 'Campionato Nazionale Open 2024', 831);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 2, 89, 'Campionato Nazionale Open 2024', 910);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 3, 77, 'Campionato Nazionale Open 2024', 571);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 4, 65, 'Campionato Nazionale Open 2024', 628);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 5, 61, 'Campionato Nazionale Open 2024', 787);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 6, 57, 'Campionato Nazionale Open 2024', 853);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 7, 54, 'Campionato Nazionale Open 2024', 117);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 8, 50, 'Campionato Nazionale Open 2024', 1191);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 9, 46, 'Campionato Nazionale Open 2024', 500);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 10, 43, 'Campionato Nazionale Open 2024', 772);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 11, 40, 'Campionato Nazionale Open 2024', 206);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 12, 38, 'Campionato Nazionale Open 2024', 669);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 13, 36, 'Campionato Nazionale Open 2024', 1105);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 14, 33, 'Campionato Nazionale Open 2024', 1143);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 15, 31, 'Campionato Nazionale Open 2024', 967);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 16, 30, 'Campionato Nazionale Open 2024', 837);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 17, 29, 'Campionato Nazionale Open 2024', 291);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 18, 27, 'Campionato Nazionale Open 2024', 390);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 19, 26, 'Campionato Nazionale Open 2024', 478);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 20, 25, 'Campionato Nazionale Open 2024', 57);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 21, 24, 'Campionato Nazionale Open 2024', 205);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 12, 23, 'Campionato Nazionale Open 2024', 61);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 23, 21, 'Campionato Nazionale Open 2024', 1171);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 24, 20, 'Campionato Nazionale Open 2024', 635);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 25, 19, 'Campionato Nazionale Open 2024', 309);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 26, 18, 'Campionato Nazionale Open 2024', 964);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 27, 17, 'Campionato Nazionale Open 2024', 1158);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 28, 15, 'Campionato Nazionale Open 2024', 874);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-01', 29, 14, 'Campionato Nazionale Open 2024', 630);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 30, 13, 'Campionato Nazionale Open 2024', 264);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 31, 12, 'Campionato Nazionale Open 2024', 130);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 32, 11, 'Campionato Nazionale Open 2024', 750);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 33, 10, 'Campionato Nazionale Open 2024', 187);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 34, 10, 'Campionato Nazionale Open 2024', 418);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 35, 9, 'Campionato Nazionale Open 2024', 970);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 36, 8, 'Campionato Nazionale Open 2024', 801);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 37, 8, 'Campionato Nazionale Open 2024', 384);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 38, 7, 'Campionato Nazionale Open 2024', 579);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-23', 39, 7, 'Campionato Nazionale Open 2024', 520);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 40, 6, 'Campionato Nazionale Open 2024', 688);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 41, 6, 'Campionato Nazionale Open 2024', 937);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 42, 6, 'Campionato Nazionale Open 2024', 641);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 43, 6, 'Campionato Nazionale Open 2024', 260);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 44, 5, 'Campionato Nazionale Open 2024', 670);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 45, 5, 'Campionato Nazionale Open 2024', 55);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 46, 5, 'Campionato Nazionale Open 2024', 706);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 47, 5, 'Campionato Nazionale Open 2024', 640);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-21', 48, 5, 'Campionato Nazionale Open 2024', 966);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 49, 5, 'Campionato Nazionale Open 2024', 773);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 50, 5, 'Campionato Nazionale Open 2024', 273);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 51, 4, 'Campionato Nazionale Open 2024', 85);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-26', 52, 4, 'Campionato Nazionale Open 2024', 958);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 53, 4, 'Campionato Nazionale Open 2024', 634);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 54, 4, 'Campionato Nazionale Open 2024', 447);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 55, 4, 'Campionato Nazionale Open 2024', 942);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 56, 4, 'Campionato Nazionale Open 2024', 436);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 57, 4, 'Campionato Nazionale Open 2024', 707);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 58, 4, 'Campionato Nazionale Open 2024', 1199);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-22', 59, 4, 'Campionato Nazionale Open 2024', 471);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-24', 60, 4, 'Campionato Nazionale Open 2024', 398);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-25', 61, 0, 'Campionato Nazionale Open 2024', 211);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 62, 0, 'Campionato Nazionale Open 2024', 271);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 63, 0, 'Campionato Nazionale Open 2024', 429);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 64, 0, 'Campionato Nazionale Open 2024', 366);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 65, 0, 'Campionato Nazionale Open 2024', 324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 66, 0, 'Campionato Nazionale Open 2024', 52);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-27', 67, 0, 'Campionato Nazionale Open 2024', 186);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-30', 68, 0, 'Campionato Nazionale Open 2024', 70);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-28', 69, 0, 'Campionato Nazionale Open 2024', 399);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-04-29', 70, 0, 'Campionato Nazionale Open 2024', 101);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 1, 140, 'Coppa della FIAT 2024', 1088);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 2, 89, 'Coppa della FIAT 2024', 229);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 3, 77, 'Coppa della FIAT 2024', 485);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 4, 65, 'Coppa della FIAT 2024', 506);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 5, 61, 'Coppa della FIAT 2024', 153);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 6, 57, 'Coppa della FIAT 2024', 808);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 7, 54, 'Coppa della FIAT 2024', 324);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 8, 50, 'Coppa della FIAT 2024', 1055);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 9, 46, 'Coppa della FIAT 2024', 652);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 10, 43, 'Coppa della FIAT 2024', 199);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 11, 40, 'Coppa della FIAT 2024', 633);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 12, 38, 'Coppa della FIAT 2024', 454);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 13, 36, 'Coppa della FIAT 2024', 1090);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 14, 33, 'Coppa della FIAT 2024', 303);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 15, 31, 'Coppa della FIAT 2024', 121);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 16, 30, 'Coppa della FIAT 2024', 864);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 17, 29, 'Coppa della FIAT 2024', 706);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 18, 27, 'Coppa della FIAT 2024', 165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 19, 26, 'Coppa della FIAT 2024', 1106);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 20, 25, 'Coppa della FIAT 2024', 512);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 21, 24, 'Coppa della FIAT 2024', 318);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 12, 23, 'Coppa della FIAT 2024', 1150);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 23, 21, 'Coppa della FIAT 2024', 975);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 24, 20, 'Coppa della FIAT 2024', 818);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 25, 19, 'Coppa della FIAT 2024', 169);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 26, 18, 'Coppa della FIAT 2024', 515);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 27, 17, 'Coppa della FIAT 2024', 768);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 28, 15, 'Coppa della FIAT 2024', 73);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-06-01', 29, 14, 'Coppa della FIAT 2024', 462);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 30, 13, 'Coppa della FIAT 2024', 1107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 31, 12, 'Coppa della FIAT 2024', 1153);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-02', 32, 11, 'Coppa della FIAT 2024', 777);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 33, 10, 'Coppa della FIAT 2024', 106);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 34, 10, 'Coppa della FIAT 2024', 259);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 35, 9, 'Coppa della FIAT 2024', 1147);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 36, 8, 'Coppa della FIAT 2024', 386);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 37, 8, 'Coppa della FIAT 2024', 311);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 38, 7, 'Coppa della FIAT 2024', 1146);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-23', 39, 7, 'Coppa della FIAT 2024', 284);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 40, 6, 'Coppa della FIAT 2024', 775);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 41, 6, 'Coppa della FIAT 2024', 450);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 42, 6, 'Coppa della FIAT 2024', 604);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 43, 6, 'Coppa della FIAT 2024', 1122);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 44, 5, 'Coppa della FIAT 2024', 841);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 45, 5, 'Coppa della FIAT 2024', 796);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 46, 5, 'Coppa della FIAT 2024', 271);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 47, 5, 'Coppa della FIAT 2024', 329);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-21', 48, 5, 'Coppa della FIAT 2024', 582);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 49, 5, 'Coppa della FIAT 2024', 837);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 50, 5, 'Coppa della FIAT 2024', 397);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 51, 4, 'Coppa della FIAT 2024', 1189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-26', 52, 4, 'Coppa della FIAT 2024', 1120);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 53, 4, 'Coppa della FIAT 2024', 451);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 54, 4, 'Coppa della FIAT 2024', 224);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 55, 4, 'Coppa della FIAT 2024', 862);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 56, 4, 'Coppa della FIAT 2024', 1165);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 57, 4, 'Coppa della FIAT 2024', 536);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 58, 4, 'Coppa della FIAT 2024', 1008);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-22', 59, 4, 'Coppa della FIAT 2024', 403);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-24', 60, 4, 'Coppa della FIAT 2024', 856);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-25', 61, 0, 'Coppa della FIAT 2024', 789);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 62, 0, 'Coppa della FIAT 2024', 1093);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 63, 0, 'Coppa della FIAT 2024', 28);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 64, 0, 'Coppa della FIAT 2024', 735);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 65, 0, 'Coppa della FIAT 2024', 539);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 66, 0, 'Coppa della FIAT 2024', 1009);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-27', 67, 0, 'Coppa della FIAT 2024', 457);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-30', 68, 0, 'Coppa della FIAT 2024', 701);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-28', 69, 0, 'Coppa della FIAT 2024', 247);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2024-05-29', 70, 0, 'Coppa della FIAT 2024', 16);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 1, 200, 'Open d\'Italia 2024', 1);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 2, 150, 'Open d\'Italia 2024', 587);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 3, 130, 'Open d\'Italia 2024', 519);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-20', 4, 110, 'Open d\'Italia 2024', 916);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-31', 5, 102, 'Open d\'Italia 2024', 476);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-30', 6, 96, 'Open d\'Italia 2024', 853);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 7, 90, 'Open d\'Italia 2024', 589);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-28', 8, 84, 'Open d\'Italia 2024', 366);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-22', 9, 78, 'Open d\'Italia 2024', 119);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 10, 72, 'Open d\'Italia 2024', 857);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-30', 11, 68, 'Open d\'Italia 2024', 236);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 12, 64, 'Open d\'Italia 2024', 797);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-28', 13, 60, 'Open d\'Italia 2024', 294);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 14, 56, 'Open d\'Italia 2024', 433);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-22', 15, 52, 'Open d\'Italia 2024', 1093);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 16, 50, 'Open d\'Italia 2024', 926);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 17, 48, 'Open d\'Italia 2024', 271);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 18, 46, 'Open d\'Italia 2024', 549);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-31', 19, 44, 'Open d\'Italia 2024', 507);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 20, 42, 'Open d\'Italia 2024', 1026);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 21, 40, 'Open d\'Italia 2024', 1200);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-20', 12, 38, 'Open d\'Italia 2024', 223);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-16', 23, 36, 'Open d\'Italia 2024', 855);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-14', 24, 34, 'Open d\'Italia 2024', 717);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 25, 32, 'Open d\'Italia 2024', 849);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 26, 30, 'Open d\'Italia 2024', 347);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-20', 27, 28, 'Open d\'Italia 2024', 571);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 28, 26, 'Open d\'Italia 2024', 107);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-06-21', 29, 24, 'Open d\'Italia 2024', 727);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 30, 22, 'Open d\'Italia 2024', 1199);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 31, 20, 'Open d\'Italia 2024', 905);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 32, 18, 'Open d\'Italia 2024', 199);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 33, 17, 'Open d\'Italia 2024', 934);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 34, 16, 'Open d\'Italia 2024', 875);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-28', 35, 15, 'Open d\'Italia 2024', 774);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 36, 14, 'Open d\'Italia 2024', 432);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 37, 13, 'Open d\'Italia 2024', 840);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 38, 12, 'Open d\'Italia 2024', 620);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 39, 11, 'Open d\'Italia 2024', 753);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 40, 10, 'Open d\'Italia 2024', 900);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 41, 10, 'Open d\'Italia 2024', 301);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 42, 10, 'Open d\'Italia 2024', 131);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-22', 43, 9, 'Open d\'Italia 2024', 819);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 44, 9, 'Open d\'Italia 2024', 968);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 45, 9, 'Open d\'Italia 2024', 741);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 46, 9, 'Open d\'Italia 2024', 104);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 47, 9, 'Open d\'Italia 2024', 674);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 48, 8, 'Open d\'Italia 2024', 224);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 49, 8, 'Open d\'Italia 2024', 331);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 50, 8, 'Open d\'Italia 2024', 487);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 50, 6, 'Open d\'Italia 2024', 764);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 52, 6, 'Open d\'Italia 2024', 1074);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-31', 53, 6, 'Open d\'Italia 2024', 715);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-30', 54, 6, 'Open d\'Italia 2024', 978);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 55, 6, 'Open d\'Italia 2024', 311);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 56, 6, 'Open d\'Italia 2024', 971);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 57, 6, 'Open d\'Italia 2024', 133);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 58, 6, 'Open d\'Italia 2024', 221);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 59, 6, 'Open d\'Italia 2024', 870);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 60, 6, 'Open d\'Italia 2024', 676);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 61, 4, 'Open d\'Italia 2024', 1000);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 62, 4, 'Open d\'Italia 2024', 861);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 63, 4, 'Open d\'Italia 2024', 967);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 64, 4, 'Open d\'Italia 2024', 561);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 65, 4, 'Open d\'Italia 2024', 768);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 66, 4, 'Open d\'Italia 2024', 673);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 67, 4, 'Open d\'Italia 2024', 54);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 68, 4, 'Open d\'Italia 2024', 386);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 69, 4, 'Open d\'Italia 2024', 1070);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 70, 4, 'Open d\'Italia 2024', 1042);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-20', 71, 6, 'Open d\'Italia 2024', 881);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 72, 6, 'Open d\'Italia 2024', 615);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 73, 6, 'Open d\'Italia 2024', 103);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 74, 5, 'Open d\'Italia 2024', 407);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 75, 5, 'Open d\'Italia 2024', 869);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-28', 76, 5, 'Open d\'Italia 2024', 467);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-29', 77, 5, 'Open d\'Italia 2024', 201);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 78, 5, 'Open d\'Italia 2024', 534);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 79, 5, 'Open d\'Italia 2024', 803);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 80, 5, 'Open d\'Italia 2024', 4);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 81, 4, 'Open d\'Italia 2024', 805);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 82, 4, 'Open d\'Italia 2024', 1180);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 83, 4, 'Open d\'Italia 2024', 810);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 84, 4, 'Open d\'Italia 2024', 402);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 85, 4, 'Open d\'Italia 2024', 280);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 86, 4, 'Open d\'Italia 2024', 600);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-30', 87, 4, 'Open d\'Italia 2024', 994);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-31', 88, 4, 'Open d\'Italia 2024', 963);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 89, 4, 'Open d\'Italia 2024', 409);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 90, 4, 'Open d\'Italia 2024', 879);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 91, 0, 'Open d\'Italia 2024', 696);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-27', 92, 0, 'Open d\'Italia 2024', 790);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 93, 0, 'Open d\'Italia 2024', 3);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 94, 0, 'Open d\'Italia 2024', 1195);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 95, 0, 'Open d\'Italia 2024', 426);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-24', 96, 0, 'Open d\'Italia 2024', 1078);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-23', 97, 0, 'Open d\'Italia 2024', 189);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-21', 98, 0, 'Open d\'Italia 2024', 1061);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-25', 99, 0, 'Open d\'Italia 2024', 20);
insert into iscrizioni(dataiscrizione, posizionefinale, puntiottenuti, nomegara, numtessera)
values ('2023-12-26', 100, 0, 'Open d\'Italia 2024', 649);

-- Table "nomine"
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Acaya Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Adriatic Golf Cervia', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Asolo Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Bergamo Albenza Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Bogogno Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Circolo Golf dell\'Ugolino', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Circolo Golf Torino La Mandria', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Garda Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Club Ambrosiano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Club Le Fonti', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Club Le Pavoniere', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Club Milano', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Club Villa Condulmer', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Nazionale', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Royal Park i Roveri', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Golf Villa Paradiso', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Modena Golf and Country Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Olgiata Golf Club', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Rimini Verucchio Golf', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Caddie Master', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Direttore', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Greenkeeper', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Maestro', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Presidente', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Referente atleti', 'Riviera Golf Resort', 2024);
insert into nomine(nomecarica, nomecircolo, anno)
values ('Segretario', 'Riviera Golf Resort', 2024);

-- Tables "attribuzioni" and "associazioni"
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 53, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Acaya Golf Resort', 53, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 155, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Acaya Golf Resort', 155, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 495, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Adriatic Golf Cervia', 495, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 32, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Adriatic Golf Cervia', 32, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 101, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Asolo Golf Club', 101, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 168, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Asolo Golf Club', 168, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 554, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Bergamo Albenza Golf Club', 554, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 496, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Bergamo Albenza Golf Club', 496, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 466, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Bogogno Golf Resort', 466, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 1092, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Bogogno Golf Resort', 1092, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 584, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Circolo Golf dell\'Ugolino', 584, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 1133, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Circolo Golf dell\'Ugolino', 1133, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 231, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Circolo Golf Torino La Mandria', 231, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 1125, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Circolo Golf Torino La Mandria', 1125, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 487, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Garda Golf and Country Club', 487, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 1109, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Garda Golf and Country Club', 1109, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 1104, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Club Ambrosiano', 1104, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 469, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Club Ambrosiano', 469, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 904, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Club Le Fonti', 904, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 858, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Club Le Fonti', 858, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 564, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Club Le Pavoniere', 564, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 1060, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Club Le Pavoniere', 1060, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 56, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Club Milano', 56, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 767, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Club Milano', 767, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 1034, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Club Villa Condulmer', 1034, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 28, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Club Villa Condulmer', 28, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 1139, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Nazionale', 1139, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 2, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Nazionale', 2, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 460, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Royal Park i Roveri', 460, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 802, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Royal Park i Roveri', 802, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 1073, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Golf Villa Paradiso', 1073, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 500, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Golf Villa Paradiso', 500, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 664, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Modena Golf and Country Club', 664, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 676, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Modena Golf and Country Club', 676, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 137, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Olgiata Golf Club', 137, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 26, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Olgiata Golf Club', 26, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 17, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Rimini Verucchio Golf', 17, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 21, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Rimini Verucchio Golf', 21, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 974, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Direttore', 'Riviera Golf Resort', 974, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 94, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Presidente', 'Riviera Golf Resort', 94, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 150, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Acaya Golf Resort', 150, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 839, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Adriatic Golf Cervia', 839, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 110, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Adriatic Golf Cervia', 110, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 119, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Asolo Golf Club', 119, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Bergamo Albenza Golf Club', 496, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 15, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Bergamo Albenza Golf Club', 15, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 47, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Bogogno Golf Resort', 47, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 292, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Circolo Golf dell\'Ugolino', 292, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 1010, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Circolo Golf Torino La Mandria', 1010, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 1131, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Garda Golf and Country Club', 1131, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 1031, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Club Ambrosiano', 1031, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 1035, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Club Le Fonti', 1035, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 1175, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Club Le Pavoniere', 1175, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 976, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Club Milano', 976, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 999, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Club Villa Condulmer', 999, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 307, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Nazionale', 307, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 463, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Nazionale', 463, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 504, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Royal Park i Roveri', 504, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 486, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Golf Villa Paradiso', 486, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 458, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Modena Golf and Country Club', 458, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 481, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Olgiata Golf Club', 481, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 773, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Rimini Verucchio Golf', 773, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 912, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Maestro', 'Riviera Golf Resort', 912, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 18, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Acaya Golf Resort', 18, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 25, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Adriatic Golf Cervia', 25, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 419, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Asolo Golf Club', 419, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 1103, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Bergamo Albenza Golf Club', 1103, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 852, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Bogogno Golf Resort', 852, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 349, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Circolo Golf dell\'Ugolino', 349, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 596, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Circolo Golf Torino La Mandria', 596, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 197, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Garda Golf and Country Club', 197, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 45, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Club Ambrosiano', 45, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 414, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Club Le Fonti', 414, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 520, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Club Le Pavoniere', 520, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 462, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Club Milano', 462, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 417, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Club Villa Condulmer', 417, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 295, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Nazionale', 295, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 369, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Royal Park i Roveri', 369, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 1178, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Golf Villa Paradiso', 1178, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 1068, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Modena Golf and Country Club', 1068, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 1057, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Olgiata Golf Club', 1057, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 679, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Rimini Verucchio Golf', 679, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 595, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Caddie Master', 'Riviera Golf Resort', 595, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 480, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Acaya Golf Resort', 480, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 461, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Adriatic Golf Cervia', 461, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 881, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Asolo Golf Club', 881, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 157, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Bergamo Albenza Golf Club', 157, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 588, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Bogogno Golf Resort', 588, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 585, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Circolo Golf dell\'Ugolino', 585, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 129, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Circolo Golf Torino La Mandria', 129, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 1187, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Garda Golf and Country Club', 1187, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 851, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Club Ambrosiano', 851, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 272, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Club Le Fonti', 272, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 248, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Club Le Pavoniere', 248, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 1076, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Club Milano', 1076, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 1126, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Club Villa Condulmer', 1126, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 138, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Nazionale', 138, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 392, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Royal Park i Roveri', 392, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 630, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Golf Villa Paradiso', 630, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 586, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Modena Golf and Country Club', 586, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 950, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Olgiata Golf Club', 950, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 787, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Rimini Verucchio Golf', 787, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 1174, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Greenkeeper', 'Riviera Golf Resort', 1174, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 555, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Acaya Golf Resort', 555, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 95, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Adriatic Golf Cervia', 95, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 505, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Asolo Golf Club', 505, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 493, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Bergamo Albenza Golf Club', 493, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 288, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Bogogno Golf Resort', 288, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf dell\'Ugolino', 305, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Circolo Golf dell\'Ugolino', 305, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 1190, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Circolo Golf Torino La Mandria', 1190, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 814, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Garda Golf and Country Club', 814, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 212, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Club Ambrosiano', 212, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 1089, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Club Le Fonti', 1089, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 735, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Club Le Pavoniere', 735, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 1011, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Club Milano', 1011, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 329, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Club Villa Condulmer', 329, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 589, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Nazionale', 589, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 184, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Royal Park i Roveri', 184, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 316, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Golf Villa Paradiso', 316, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 964, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Modena Golf and Country Club', 964, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 1054, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Olgiata Golf Club', 1054, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 1015, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Rimini Verucchio Golf', 1015, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 253, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Referente atleti', 'Riviera Golf Resort', 253, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Acaya Golf Resort', 663, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Acaya Golf Resort', 663, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Adriatic Golf Cervia', 27, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Adriatic Golf Cervia', 27, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Asolo Golf Club', 1129, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Asolo Golf Club', 1129, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bergamo Albenza Golf Club', 696, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Bergamo Albenza Golf Club', 696, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Bogogno Golf Resort', 707, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Bogogno Golf Resort', 707, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Circolo Golf dell\'Ugolino', 349, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Circolo Golf Torino La Mandria', 799, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Circolo Golf Torino La Mandria', 799, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Garda Golf and Country Club', 383, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Garda Golf and Country Club', 383, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Ambrosiano', 818, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Club Ambrosiano', 818, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Fonti', 934, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Club Le Fonti', 934, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Le Pavoniere', 590, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Club Le Pavoniere', 590, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Milano', 225, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Club Milano', 225, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Club Villa Condulmer', 559, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Club Villa Condulmer', 559, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Nazionale', 902, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Nazionale', 902, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Royal Park i Roveri', 716, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Royal Park i Roveri', 716, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Golf Villa Paradiso', 62, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Golf Villa Paradiso', 62, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Modena Golf and Country Club', 698, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Modena Golf and Country Club', 698, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Olgiata Golf Club', 192, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Olgiata Golf Club', 192, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Rimini Verucchio Golf', 273, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Rimini Verucchio Golf', 273, 2024);
insert into associazioni(nomecircolo, numtessera, anno)
values ('Riviera Golf Resort', 416, 2024);
insert into attribuzioni(nomecarica, nomecircolo, numtessera, anno)
values ('Segretario', 'Riviera Golf Resort', 416, 2024);

-- Table "prenotazioni"
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2)
values ('Golf Club Le Fonti', 'Championship', '2024-01-01', '10:00', 1, 821);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Riviera Golf Resort', 'Championship', '2024-03-20', '11:20', 356, 471, 29, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Adriatic Golf Cervia', 'Blu-Giallo', '2024-03-30', '14:10', 997, 1051, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Royal Park i Roveri', 'Allianz Course', '2024-04-02', '09:30', 130, 189, 513, 719);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Circolo Golf dell\'Ugolino', 'Championship', '2024-04-03', '11:30', 1200, 1004, 31, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Club Le Pavoniere', 'Arnold Palmer', '2024-04-03', '11:30', 1086, 991, 254, 142);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Adriatic Golf Cervia', 'Rosso-Giallo', '2024-04-08', '10:10', 1, 916, 356, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Nazionale', 'Carta', '2024-04-10', '11:40', 751, 1190, 875, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Modena Golf and Country Club', 'Bernhard Langer', '2024-04-21', '08:20', 41, 1035, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Bogogno Golf Resort', 'del Conte', '2024-04-25', '14:50', 945, 813, 261, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Villa Paradiso', 'Championship', '2024-04-28', '13:10', 671, 590, 132, 126);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Club Milano', '1-2', '2024-04-30', '12:30', 1109, 420, 68, 71);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Club Villa Condulmer', 'Championship', '2024-05-03', '11:40', 13, 1090, 812, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Acaya Golf Resort', 'Championship', '2024-05-06', '10:00', 41, 509, 680, 23);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Bergamo Albenza Golf Club', 'Blu-Giallo', '2024-05-09', '07:40', 31, 90, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Asolo Golf Club', 'Giallo-Verde', '2024-05-11', '08:50', 809, 751, 340, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Riviera Golf Resort', 'Championship', '2024-05-12', '15:20', 700, 1030, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Olgiata Golf Club', 'Ovest', '2024-05-18', '11:00', 41, 78, 579, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Circolo Golf Torino La Mandria', 'Giallo', '2024-05-25', '09:20', 901, 1003, 410, 76);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Nazionale', 'Championship', '2024-05-28', '07:10', 11, 780, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Garda Golf and Country Club', 'Rosso-Bianco', '2024-06-12', '12:40', 781, 314, 590, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Bogogno Golf Resort', 'Bonora', '2024-06-14', '13:00', 1094, 367, 891, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Rimini Verucchio Golf', 'Championship', '2024-06-20', '10:10', 319, 809, 16, 41);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Club Ambrosiano', 'Championship', '2024-06-24', '11:50', 671, 901, 415, 310);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Bergamo Albenza Golf Club', 'Blu-Giallo', '2024-06-30', '09:40', 314, 456, 678, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Acaya Golf Resort', 'Championship', '2024-07-01', '08:30', 50, 13, 81, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Adriatic Golf Cervia', 'Blu-Giallo', '2024-07-09', '12:00', 910, 205, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Villa Paradiso', 'Championship', '2024-07-11', '09:20', 1009, 504, 310, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Garda Golf and Country Club', 'Rosso-Bianco', '2024-07-18', '13:20', 143, 781, 905, 12);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Royal Park i Roveri', 'Allianz Bank Course', '2024-07-21', '16:40', 412, null, null, null);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Golf Nazionale', 'Carta', '2024-07-29', '08:10', 309, 471, 412, 509);
insert into prenotazioni(nomecircolo, nomepercorso, dataprenotazione, oraprenotazione, numtessera1, numtessera2, numtessera3, numtessera4)
values ('Circolo Golf Torino La Mandria', 'Blu', '2024-08-01', '07:50', 12, 398, 409, 1081);