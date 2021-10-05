DROP VIEW IF EXISTS Liste_Adherents;
DROP VIEW IF EXISTS Liste_Membres;
DROP VIEW IF EXISTS Sanction_Adherent;
DROP VIEW IF EXISTS Adherents_Blacklistés;
DROP VIEW IF EXISTS Dégradations;
DROP VIEW IF EXISTS Retards;

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
CREATE VIEW Dégradations (utilisateur, num_pret, Remboursement) AS 
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
CREATE VIEW vExemplaire_Bon AS
SELECT Exemplaire.code, Exemplaire.etat, titre, date_apparition, editeur, genre, code_classification
FROM Ressource JOIN Exemplaire ON Exemplaire.ressource = Ressource.code
WHERE id_pret IS NULL AND (Exemplaire.etat = 'bon' OR Exemplaire.etat = 'neuf');

-- liste des exemplaires compris dans un prêt
CREATE VIEW vPret AS
SELECT Exemplaire.code, Exemplaire.etat, titre, date_apparition, editeur, genre, code_classification
FROM Exemplaire NATURAL JOIN Pret
JOIN Ressource ON Exemplaire.ressource = Ressource.code
--WHERE adresse_mail = 'adresse_mail@gmail.com'; -- a remplacer avec l’id_pret recherché

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

