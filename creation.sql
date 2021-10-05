DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Compte_utilisateur CASCADE; 
DROP TABLE IF EXISTS Ressource CASCADE;
DROP TABLE IF EXISTS Membre CASCADE;
DROP TABLE IF EXISTS Adherent CASCADE;
DROP TABLE IF EXISTS Exemplaire CASCADE;
DROP TABLE IF EXISTS Contributeur CASCADE;
DROP TABLE IF EXISTS Oeuvre_musicale CASCADE;
DROP TABLE IF EXISTS Auteur CASCADE;
DROP TABLE IF EXISTS Acteur CASCADE;
DROP TABLE IF EXISTS Livre CASCADE;
DROP TABLE IF EXISTS Film CASCADE;
DROP TABLE IF EXISTS Compositeur CASCADE;
DROP TABLE IF EXISTS Interprete CASCADE;
DROP TABLE IF EXISTS Realisateur CASCADE;


CREATE TABLE Contributeur (
id_contributeur INT PRIMARY KEY, 
nom VARCHAR,
prenom VARCHAR,
nom_artiste VARCHAR, 
date_naissance DATE NOT NULL,
nationalite VARCHAR
);

CREATE TABLE Ressource (
code INT PRIMARY KEY,
titre VARCHAR NOT NULL,
date_apparition NUMERIC(4) CHECK (date_apparition< '2022'), 
editeur VARCHAR,
genre VARCHAR,
code_classification INT NOT NULL
); 

CREATE TABLE Acteur (
code INT, 
id_contributeur INT,
PRIMARY KEY (code, id_contributeur),
FOREIGN KEY (code) REFERENCES Ressource(code),
FOREIGN KEY (id_contributeur) REFERENCES Contributeur(id_contributeur)
); 

CREATE TABLE Interprete (
code INT, 
id_contributeur INT,
PRIMARY KEY (code, id_contributeur),
FOREIGN KEY (code) REFERENCES Ressource(code),
FOREIGN KEY (id_contributeur) REFERENCES Contributeur(id_contributeur)
);

CREATE TABLE Compositeur (
code INT, 
id_contributeur INT,
PRIMARY KEY (code, id_contributeur),
FOREIGN KEY (code) REFERENCES Ressource(code),
FOREIGN KEY (id_contributeur) REFERENCES Contributeur(id_contributeur)
);

CREATE TABLE Realisateur (
code INT, 
id_contributeur INT,
PRIMARY KEY (code, id_contributeur),
FOREIGN KEY (code) REFERENCES Ressource(code),
FOREIGN KEY (id_contributeur) REFERENCES Contributeur(id_contributeur)
);

CREATE TABLE Auteur (
code INT, 
id_contributeur INT,
PRIMARY KEY (code, id_contributeur),
FOREIGN KEY (code) REFERENCES Ressource(code),
FOREIGN KEY (id_contributeur) REFERENCES Contributeur(id_contributeur)
);

CREATE TABLE Oeuvre_musicale (
code INT PRIMARY KEY,
longueur DECIMAL NOT NULL ,
FOREIGN KEY (code) REFERENCES RESSOURCE (code)
);

CREATE TABLE Livre (
ressource INT PRIMARY KEY, 
isbn INT, 
resume VARCHAR, 
FOREIGN KEY (ressource) REFERENCES RESSOURCE (code)
); 

CREATE TABLE Film (
ressource INT PRIMARY KEY,
longueur INT, 
synopsis VARCHAR, 
FOREIGN KEY (ressource) REFERENCES RESSOURCE(code)
);

CREATE TABLE Utilisateur(
adresse_mail VARCHAR(320) PRIMARY KEY,
nom VARCHAR(30) NOT NULL,
prenom VARCHAR(30) NOT NULL,
date_naissance DATE NOT NULL,
adresse VARCHAR(255),
UNIQUE (nom, prenom, date_naissance)
);

CREATE TABLE Compte_utilisateur(
login VARCHAR(30) PRIMARY KEY,
mdp VARCHAR(30) NOT NULL,
adresse_mail VARCHAR(320),
FOREIGN KEY(adresse_mail) REFERENCES Utilisateur,
UNIQUE (adresse_mail)
);

CREATE TABLE Membre(
adresse_mail VARCHAR(320) PRIMARY KEY,
FOREIGN KEY(adresse_mail) REFERENCES Utilisateur(adresse_mail)
);

CREATE TABLE Adherent(
adresse_mail VARCHAR(320) PRIMARY KEY,
nombre_emprunts INTEGER,
blackliste BOOLEAN,
FOREIGN KEY(adresse_mail) REFERENCES Utilisateur(adresse_mail),
CHECK(nombre_emprunts < 10)
);

DROP TABLE IF EXISTS Pret CASCADE;
CREATE TABLE Pret (
id_pret SERIAL PRIMARY KEY,
date_pret DATE NOT NULL,
date_fin DATE NOT NULL,
adresse_mail VARCHAR(320) REFERENCES Membre (adresse_mail)
);

DROP TABLE IF EXISTS Sanction;
CREATE TABLE Sanction (
id_pret INTEGER PRIMARY KEY,
FOREIGN KEY (id_pret) REFERENCES Pret (id_pret)
);

DROP TABLE IF EXISTS Retard;
CREATE TABLE Retard (
id_pret INTEGER PRIMARY KEY,
nb_jours INTEGER NOT NULL,
FOREIGN KEY (id_pret) REFERENCES Pret (id_pret)
);

DROP TABLE IF EXISTS Degradation;
CREATE TABLE Degradation (
id_pret INTEGER PRIMARY KEY,
remboursement BOOLEAN NOT NULL,
FOREIGN KEY (id_pret) REFERENCES Pret (id_pret)
);

DROP TYPE IF EXISTS etats CASCADE;
CREATE TYPE etats AS ENUM ('neuf', 'bon', 'abime', 'perdu');

CREATE TABLE Exemplaire (
code INTEGER PRIMARY KEY,
id_pret INTEGER,
disponible BOOLEAN NOT NULL,
etat etats NOT NULL,
ressource INT NOT NULL, 
FOREIGN KEY (id_pret) REFERENCES Pret (id_pret),
FOREIGN KEY (ressource) REFERENCES Ressource (code)
);


