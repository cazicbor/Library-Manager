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
DROP TYPE IF EXISTS Etats CASCADE;

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
date_fin DATE NOT NULL CHECK (date_fin>date_pret),
adresse_mail VARCHAR(320) REFERENCES Adherent (adresse_mail)
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

CREATE TYPE Etats AS ENUM ('neuf', 'bon', 'abime', 'perdu');

CREATE TABLE Exemplaire (
code INTEGER PRIMARY KEY,
ressource INT NOT NULL, 
etat ETATS NOT NULL,
id_pret INTEGER,
FOREIGN KEY (id_pret) REFERENCES Pret (id_pret),
FOREIGN KEY (ressource) REFERENCES Ressource (code)
);

INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (1, 'Guytoune', 2020, 'D or et de platine', 'rap', 890);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (449, 'Cremoso', 2019, 'D or et de platine', 'rap', 279);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (511, '50 nuances de Grecs', 2020, 'Bordas', 'Bande dessinée', 779);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (209, 'Stupeur et tremblements', 2008, 'Edition spinelle', 'Roman', 650);
INSERT INTO Ressource VALUES (10203, 'Comment avoir A sans réviser', 2021, 'Bor', 'Philosophie', 08);
INSERT INTO Ressource VALUES (460903, 'KillBill', 2003, 'Miramax', 'Action', 1234);
INSERT INTO Ressource VALUES (68, 'Pulp Fiction', 1994, 'Miramax', 'Action', 10);
INSERT INTO Ressource VALUES (7896, 'La Stratégie du Choc', 2007, 'Actes Sud', 'Essai', 986);
INSERT INTO Ressource VALUES (63, 'Sexe, mensonges et banlieues chaudes', 2014, 'La Musardine', 'Roman', 187);


INSERT INTO Contributeur VALUES (666, 'Acab', 'Quentin', 'AQ du tieks', '1946-09-03', 'Liechtensteinois');
INSERT INTO Contributeur VALUES (404, 'Lussier', 'Benjamin', 'Benji du 07', '1990-07-10', 'Américain'); 
INSERT INTO Contributeur VALUES (111, 'Thurman', 'Uma', 'Uma Thurman', '1970-05-29', 'Américaine'); 
INSERT INTO Contributeur VALUES (438, 'Pepin', 'Charles', 'PC', '1989-03-11', 'Français');
INSERT INTO Contributeur VALUES (5903, 'Amelie', 'Nothomb', 'Amelie Nothomb', '101-07-01', 'Belge');
INSERT INTO Contributeur VALUES (59, 'Julien', 'Mari', 'JUL', '1990-06-02', 'Marseillais');
INSERT INTO Contributeur VALUES (69, 'Samuel L', 'Jackson', 'Samuel L Jackson', '1954-08-08', 'Américain');
INSERT INTO Contributeur VALUES (7896, 'Klein', 'Naomi', 'Naomi Klein', '1970-05-05', 'Canadienne');
INSERT INTO Contributeur VALUES (99, 'Schiappa', 'Marlène', 'Marie Minelli', '1982-11-18', 'Française');

INSERT INTO Oeuvre_musicale VALUES (1, 4.3);
INSERT INTO Oeuvre_musicale VALUES (449, 3.28);

INSERT INTO Livre VALUES (511, 3, 'La mythologie grecque en satire contemporaine tout ceci raconté en bande dessinée'); 
INSERT INTO Livre VALUES (209, 5, 'L’histoire se déroule dans un aéroport… ou est-ce dans sa tête ?');
INSERT INTO Livre VALUES (10203, 10, 'Le titre explicite de cette oeuvre ne nécessite pas plus de développement');
INSERT INTO Livre VALUES (7896, 12764, 'La Stratégie du choc : la montée d un capitalisme du désastre est un essai socio politique altermondialiste');
INSERT INTO Livre VALUES (63, 3085, 'Sara vit à Neuilly, mais ne se sent pas à sa place et décide de gagner son indépendance. C est là que son chemin croise celui du mystérieux Djalil. Et si son salut se trouvait de l autre côté du périph ?');

INSERT INTO Film VALUES (460903, 125, 'Beatrix Kiddo a soif de vengeance après avoir été laissée pour morte dans le désert le jour de son mariage');
INSERT INTO Film VALUES (68, 168, 'Une odyssée sanglante et burlesque de petits malfrats dans la jungle de Hollywood à travers trois histoires qui s entremêlent.');

INSERT INTO Auteur VALUES (10203, 404);
INSERT INTO Realisateur VALUES (460903, 666);
INSERT INTO Realisateur VALUES (68, 666);
INSERT INTO Acteur VALUES (460903, 111);
INSERT INTO Acteur VALUES (68, 69);
INSERT INTO Auteur VALUES (511, 438);
INSERT INTO Auteur VALUES (209, 5903);
INSERT INTO Auteur VALUES (7896, 7896);
INSERT INTO Auteur VALUES (63, 99);
INSERT INTO Interprete VALUES (1, 59);
INSERT INTO Compositeur VALUES (1, 59); 
INSERT INTO Interprete VALUES (449, 59);
INSERT INTO Compositeur VALUES (449, 59); 

INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse_mail@gmail.com', 'Victorino', 'Alessandro', '01/01/1985', 'Quelque part');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse2@gmail.com', 'Zhang', 'Aline', '01/01/2000', 'Autre part');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse3@gmail.com', 'Cazic', 'Boris', '02/02/2000', '');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse4@gmail.com', 'Debette', 'Eugénie', '03/03/2000', '');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse5@gmail.com', 'Legrand', 'Jonathan', '03/03/2000', '');

INSERT INTO Compte_utilisateur VALUES ('euuud', 'coucou', 'adresse_mail@gmail.com'); 
INSERT INTO Compte_utilisateur VALUES ('zhangali', '1234', 'adresse2@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('cazicbor', 'abcd', 'adresse3@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('debettee', 'motdepasse', 'adresse4@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('jolegran', 'test', 'adresse5@gmail.com');

INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse_mail@gmail.com', 0, TRUE);
INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse2@gmail.com', 0, FALSE);
INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse5@gmail.com', 0, FALSE);

INSERT INTO Membre (adresse_mail) VALUES ('adresse3@gmail.com');
INSERT INTO Membre (adresse_mail) VALUES ('adresse4@gmail.com');

INSERT INTO Pret VALUES (1, '03/05/2021', '09/05/2021', 'adresse2@gmail.com');
INSERT INTO Pret VALUES (2, '02/05/2021', '10/05/2021', 'adresse_mail@gmail.com');
INSERT INTO Pret VALUES (3, '01/05/2021', '09/05/2021', 'adresse5@gmail.com');
INSERT INTO Pret VALUES (4, '01/05/2021', '09/05/2021', 'adresse5@gmail.com');

INSERT INTO Exemplaire (code, etat, ressource) VALUES (1, 'abime', 1);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (2, 'bon', 449);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (3, 'bon', 449);
INSERT INTO Exemplaire (code, id_pret, etat, ressource) VALUES (4, 1, 'neuf', 460903);
INSERT INTO Exemplaire (code, id_pret, etat, ressource) VALUES (5, 2, 'bon', 511);
INSERT INTO Exemplaire (code, id_pret, etat, ressource) VALUES (6, 3, 'neuf', 209);
INSERT INTO Exemplaire (code, id_pret, etat, ressource) VALUES (9, 4, 'neuf', 460903);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (10, 'bon', 63);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (11, 'neuf', 7896);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (12, 'neuf', 460903);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (13, 'bon', 10203);
INSERT INTO Exemplaire (code, etat, ressource) VALUES (14, 'neuf', 10203);

INSERT INTO Sanction VALUES (1);
INSERT INTO Sanction VALUES (2);
INSERT INTO Sanction VALUES (3);

INSERT INTO Retard VALUES (1, 3);

INSERT INTO Degradation VALUES (2, FALSE);
INSERT INTO Degradation VALUES (3, TRUE);

-- afficher le genre le plus emprunté par un utilisateur
CREATE VIEW Plus_emprunte (type, nombre) AS
SELECT Ressource.genre, COUNT(Pret.id_pret)
FROM Ressource JOIN Exemplaire ON Ressource.code = Exemplaire.ressource JOIN Pret ON Exemplaire.id_pret = Pret.id_pret
GROUP BY (Ressource.genre);

CREATE VIEW Emprunts_par_ressource (id, nombre_emprunts) AS
SELECT Ressource.code, COUNT(Pret.id_pret)
FROM Ressource JOIN Exemplaire ON Ressource.code = Exemplaire.ressource JOIN Pret ON Exemplaire.id_pret = Pret.id_pret
GROUP BY (Ressource.code);

CREATE VIEW Emprunts_par_genre (type, nombre) AS
SELECT Ressource.genre, COUNT(Pret.id_pret)
FROM Ressource JOIN Exemplaire ON Ressource.code = Exemplaire.ressource JOIN Pret ON Exemplaire.id_pret = Pret.id_pret
--WHERE adresse_mail = 'adresse3@gmail.com'
GROUP BY (Ressource.genre);

-- récupérer les noms, prénoms des adhérents 
CREATE VIEW Liste_Adherents (Nom, Prénom) AS 
SELECT nom, prenom FROM Utilisateur u JOIN Adherent a 
ON a.adresse_mail = u.adresse_mail ; 

-- récupérer les noms, prénoms des membres
CREATE VIEW Liste_Membres (Nom, Prénom) AS 
SELECT nom, prenom FROM Utilisateur 
JOIN Membre ON Membre.adresse_mail = Utilisateur.adresse_mail ; 

-- Liste de toutes les sanctions d’un adhérent par son adresse mail 
CREATE VIEW Sanction_Adherent (Utilisateur, Numéro_Pret) AS 
SELECT Utilisateur.adresse_mail, Sanction.id_pret FROM Sanction JOIN Pret 
ON Pret.id_pret = Sanction.id_pret JOIN Utilisateur ON Utilisateur.adresse_mail = Pret.adresse_mail; 
--WHERE Utilisateur.adresse_mail ='adresse4@gmail.com';  -- entrer ici l’adresse mail voulue

-- liste des dégradations 
CREATE VIEW vDegradations (utilisateur, num_pret, Remboursement) AS 
SELECT Utilisateur.adresse_mail, Degradation.id_pret, Degradation.remboursement FROM Degradation 
JOIN Pret ON Pret.id_pret = Degradation.id_pret JOIN Utilisateur ON Utilisateur.adresse_mail = Pret.adresse_mail; 
--WHERE Utilisateur.adresse_mail = 'adresse3@gmail.com'; -- entrer ici l’adresse mail voulue 

-- liste des retards 
CREATE VIEW Retards (Utilisateur, Num_prêt, nombre_de_jours) AS
SELECT Utilisateur.adresse_mail, Retard.id_pret, Retard.nb_jours FROM Retard 
JOIN Pret ON Pret.id_pret = Retard.id_pret JOIN Utilisateur ON Utilisateur.adresse_mail = Pret.adresse_mail; 
--WHERE Utilisateur.adresse_mail = 'adresse3@gmail.com'; -- entrer ici l’adresse mail voulue 

--affichage du nombre de prêt par membre (Utilisation group by)
CREATE VIEW Pret_par_Membre (Membre, nombre) AS
SELECT Pret.adresse_mail, COUNT(id_pret)
FROM Pret
GROUP BY Pret.adresse_mail; 

--nombre d’exemplaires par ressource 
CREATE VIEW Nombre_exemplaires(Ressource, nombre) AS 
SELECT Exemplaire.ressource, COUNT(code)
FROM Exemplaire
GROUP BY Exemplaire.ressource; 

-- liste utilisateurs blacklistés 
CREATE VIEW Adherents_Blacklistés (Nom, Prénom, Date_Naissance) AS 
SELECT nom, prenom, date_naissance FROM Utilisateur u 
JOIN Adherent a ON u.adresse_mail = a.adresse_mail 
WHERE a.blackliste = TRUE; 

-- liste des exemplaires neuf ou en bon état d’une ressource
CREATE VIEW vExemplaire_Bon (ressource) AS
SELECT Exemplaire.code, Exemplaire.etat, titre, date_apparition, editeur, genre, code_classification
FROM Ressource JOIN Exemplaire ON Exemplaire.ressource = Ressource.code;
--WHERE id_pret IS NULL AND (Exemplaire.etat = 'bon' OR Exemplaire.etat = 'neuf');

-- liste des exemplaires compris dans un prêt
CREATE VIEW vPret AS
SELECT Exemplaire.code, Exemplaire.etat, titre, date_apparition, editeur, genre, code_classification
FROM Exemplaire NATURAL JOIN Pret
JOIN Ressource ON Exemplaire.ressource = Ressource.code;
-- WHERE id_pret = 1; -- a remplacer avec l’id_pret recherché

-- liste des auteurs d'un livre
CREATE VIEW vContributeur_Livre AS
SELECT id_contributeur, nom_artiste
FROM Auteur NATURAL JOIN Contributeur
JOIN Ressource ON Auteur.code = Ressource.code
JOIN Livre ON Livre.ressource = Ressource.code; 
-- WHERE Livre.ressource = 511; -- a remplacer
  
-- liste des interprètes et compositeurs d'une oeuvre musicale
CREATE VIEW vContributeur_Oeuvre_Musicale1 AS
SELECT id_contributeur, nom_artiste
FROM Oeuvre_Musicale NATURAL JOIN Compositeur
NATURAL JOIN Contributeur 
UNION 
SELECT id_contributeur, nom_artiste
FROM Oeuvre_Musicale NATURAL JOIN Interprete
NATURAL JOIN Contributeur; 
-- WHERE Oeuvre_Musicale.code = 1; -- a remplacer

-- liste des réalisateurs et acteurs d'un film
CREATE VIEW vContributeur_Film AS
SELECT id_contributeur, nom_artiste
FROM Film JOIN Acteur ON Film.ressource = Acteur.code 
NATURAL JOIN Contributeur 
UNION 
SELECT id_contributeur, nom_artiste
FROM Film JOIN Realisateur ON Realisateur.code = Film.ressource
NATURAL JOIN Contributeur; 
-- WHERE Film.ressource  = 460903; -- a remplacer

-- liste des ressources dans lesquels on retrouve un contributeur
CREATE VIEW vRessource_Contributeur AS
SELECT code, titre, date_apparition, editeur, genre, code_classification
FROM Contributeur NATURAL JOIN Acteur 
NATURAL JOIN Ressource WHERE Contributeur.nom_artiste = 'PC' -- a remplacer
UNION 
SELECT code, titre, date_apparition, editeur, genre, code_classification
FROM Contributeur NATURAL JOIN Interprete
NATURAL JOIN Ressource WHERE Contributeur.nom_artiste = 'PC' -- a remplacer
UNION
SELECT code, titre, date_apparition, editeur, genre, code_classification
FROM Contributeur NATURAL JOIN Compositeur 
NATURAL JOIN Ressource WHERE Contributeur.nom_artiste = 'PC' -- a remplacer
UNION 
SELECT code, titre, date_apparition, editeur, genre, code_classification
FROM Contributeur NATURAL JOIN Realisateur 
NATURAL JOIN Ressource WHERE Contributeur.nom_artiste = 'PC' -- a remplacer
UNION 
SELECT code, titre, date_apparition, editeur, genre, code_classification
FROM Contributeur NATURAL JOIN Auteur 
NATURAL JOIN Ressource WHERE Contributeur.nom_artiste = 'PC'; -- a remplacer
