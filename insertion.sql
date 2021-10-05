INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (1, 'Guytoune', 2020, 'D or et de platine', 'rap', 890);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (449, 'Cremoso', 2019, 'D or et de platine', 'rap', 279);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (511, '50 nuances de Grecs', 2020, 'Bordas', 'Bande dessinée', 779);
INSERT INTO Ressource(code, titre, date_apparition, editeur, genre, code_classification) VALUES (209, 'Stupeur et tremblements', 2008, 'Edition spinelle', 'Roman', 650);
INSERT INTO Ressource VALUES (10203, 'Comment avoir A sans réviser', 2021, 'Bor', 'Philosophie', 08);
INSERT INTO Ressource VALUES (460903, 'KillBill', 2003, 'Miramax', 'Action', 1234);


INSERT INTO Contributeur VALUES (666, 'Acab', 'Quentin', 'AQ du tieks', '1946-09-03', 'Liechtensteinois');
INSERT INTO Contributeur VALUES (404, 'Lussier', 'Benjamin', 'Benji du 07', '1990-07-10', 'Américain'); 
INSERT INTO Contributeur VALUES (111, 'Thurman', 'Uma', 'Uma Thurman', '1970-05-29', 'Américaine'); 
INSERT INTO Contributeur VALUES (438, 'Pepin', 'Charles', 'PC', '1989-03-11', 'Français');
INSERT INTO Contributeur VALUES (5903, 'Amelie', 'Nothomb', 'Amelie Nothomb', '101-07-01', 'Belge');
INSERT INTO Contributeur VALUES (59, 'Julien', 'Mari', 'JUL', '1990-06-02', 'Marseillais');

INSERT INTO Oeuvre_musicale VALUES (1, 4.3);
INSERT INTO Oeuvre_musicale VALUES (449, 3.28);

INSERT INTO Livre VALUES (511, 3, 'La mythologie grecque en satire contemporaine tout ceci raconté en bande dessinée'); 
INSERT INTO Livre VALUES (209, 5, 'L’histoire se déroule dans un aéroport… ou est-ce dans sa tête ?');
INSERT INTO Livre VALUES (10203, 10, 'Le titre explicite de cette oeuvre ne nécessite pas plus de développement');

INSERT INTO Film VALUES (460903, 125, 'Beatrix Kiddo a soif de vengeance après avoir été laissée pour morte dans le désert le jour de son mariage'); 

INSERT INTO Auteur VALUES (10203, 404);
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse_mail@gmail.com', 'Victorino', 'Alessandro', '01/01/1985', 'Quelque part');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse2@gmail.com', 'Zhang', 'Aline', '01/01/2000', 'Autre part');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse3@gmail.com', 'Cazic', 'Boris', '02/02/2000', '');
INSERT INTO Utilisateur (adresse_mail, nom, prenom, date_naissance, adresse) VALUES ('adresse4@gmail.com', 'Debette', 'Eugénie', '03/03/2000', '');

INSERT INTO Compte_utilisateur VALUES ('ed', 'coucou', 'adresse_mail@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('zhangali', '1234', 'adresse2@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('cazicbor', 'abcd', 'adresse3@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('debettee', 'motdepasse', 'adresse4@gmail.com');
INSERT INTO Compte_utilisateur VALUES ('jolegran', 'test', 'adresse5@gmail.com');

INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse_mail@gmail.com', 0, TRUE);
INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse2@gmail.com', 0, FALSE);
INSERT INTO Adherent (adresse_mail, nombre_emprunts, blackliste) VALUES ('adresse5@gmail.com', 0, FALSE);

INSERT INTO Membre (adresse_mail) VALUES ('adresse3@gmail.com');
INSERT INTO Membre (adresse_mail) VALUES ('adresse4@gmail.com');
INSERT INTO Pret VALUES ('03/05/2021', '09/05/2021', 'adresse3@gmail.com');
INSERT INTO Pret VALUES ('02/05/2021', '10/05/2021', 'adresse4@gmail.com');
INSERT INTO Pret VALUES ('01/05/2021', '09/05/2021', 'adresse3@gmail.com');

INSERT INTO Exemplaire (code, disponible, etat, ressource) VALUES (1, FALSE, 'abime', 1);
INSERT INTO Exemplaire (code, disponible, etat, ressource) VALUES (2, TRUE, 'bon', 449);
INSERT INTO Exemplaire (code, disponible, etat, ressource) VALUES (3, TRUE, 'bon', 449);
INSERT INTO Exemplaire (code, id_pret, disponible, etat, ressource) VALUES (4, 1, FALSE, 'neuf', 460903);
INSERT INTO Exemplaire (code, id_pret, disponible, etat, ressource) VALUES (5, 2, FALSE, 'bon', 511);
INSERT INTO Exemplaire (code, id_pret, disponible, etat, ressource) VALUES (6, 3, FALSE, 'neuf', 209);

INSERT INTO Sanction VALUES (1);
INSERT INTO Sanction VALUES (2);
INSERT INTO Sanction VALUES (3);

INSERT INTO Retard VALUES (1, 3);

INSERT INTO Degradation VALUES (2, FALSE);
INSERT INTO Degradation VALUES (3, TRUE);
INSERT INTO Realisateur VALUES (460903, 666);
INSERT INTO Acteur VALUES (460903, 111);
INSERT INTO Auteur VALUES (511, 438);
INSERT INTO Auteur VALUES (209, 5903);
INSERT INTO Interprete VALUES (1, 59);
INSERT INTO Compositeur VALUES (1, 59); 
INSERT INTO Interprete VALUES (449, 59);
INSERT INTO Compositeur VALUES (449, 59); 
