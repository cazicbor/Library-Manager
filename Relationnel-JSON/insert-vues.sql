DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS v_adresses CASCADE;
DROP TABLE IF EXISTS v_noms_utilisateurs CASCADE;
DROP TABLE IF EXISTS v_prenoms CASCADE;

CREATE TABLE Utilisateur(
adresse_mail VARCHAR(320) PRIMARY KEY,
nom VARCHAR(30) NOT NULL,
prenom JSON NOT NULL,
date_naissance DATE NOT NULL,
adresse JSON,
compte_utilisateur JSON NOT NULL
);


INSERT INTO Utilisateur VALUES (
'eugénie.debette@free.fr',
'Debette',
'["Eugénie", "Thelma"]',
'25/06/1999',
'{"numéro" : 18, "rue" : "St Fiacre", "cp" : 60200, "ville" : "Compiègne"}',
'{"login" : "edebette", "mdp" : "jadorelerelationnel"}'
);

INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse, compte_utilisateur)
VALUES (
'abcd@gmail.com',
'Olivier',
'["Claude", "Hong", "Jiayun"]',
'22/06/1975',
'{"numéro" : 2, "rue" : "Harlay", "cp" : 60200, "ville" : "Compiègne"}',
'{"login" : "oclaude", "mdp" : "jaimenf18"}'
);


-- vue affichant les adresses
CREATE VIEW v_adresses AS
SELECT nom, prenom, CAST(adresse->>'numéro' AS INTEGER) AS numéro, adresse->>'rue' AS rue, adresse->> 'cp' AS code_postal, adresse->>'ville' AS ville
FROM Utilisateur u;

-- vue affichant les comptes utilisateurs
CREATE VIEW v_noms_utilisateurs AS     
SELECT nom, prenom, compte_utilisateur->> 'login' AS User 
FROM Utilisateur u;

-- vue affichant les prenoms 
CREATE VIEW v_prenoms AS
SELECT nom, a.*
FROM Utilisateur u, JSON_ARRAY_ELEMENTS(u.prenom) a ; 
