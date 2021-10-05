#!/usr/bin/env python
import psycopg2

def stats_bibli(conn):
    choice = '1'
    choices = ['1', '2', '3']
    while choice in choices:
        print("\n Statistiques sur la bibliotheque ")
        print("1 : Affichage age moyen des adhérents ")
        print("2 : Affichage de la ressource la plus populaire")
        print("3 : Nombre total de prêts")

        print("Pour sortir, entrez autre chose")
        choice = input()

        if choice == '1':
            Age_moyen_adherent(conn)

        if choice == '2':
            Ressource_populaire(conn)
        
        if choice == '3':
            Nb_total_prets(conn)

def Age_moyen_adherent(conn):

    cur = conn.cursor()
    sql ='SELECT AVG(age(Utilisateur.date_naissance)) AS age_moy FROM Utilisateur'
    cur.execute(sql)
    row = cur.fetchone()
    print("\n> Age moyen des adhérents :", row[0]);


def Ressource_populaire(conn): #affiche la ressource la plus populaire

#affichage de la liste de toutes les ressources avec leurs nombres de prets
    cur = conn.cursor()
    sql = "SELECT id, nombre_emprunts FROM Emprunts_par_ressource"
    cur.execute(sql)
    raw = cur.fetchone()
    id = raw[0]
    nombre_emprunts = raw[1]
#CREATE VIEW Emprunts_par_ressource (id, nombre_emprunts) AS
#SELECT Ressource.code, COUNT(Pret.id_pret)
#FROM Ressource JOIN Exemplaire ON Ressource.code = Exemplaire.ressource JOIN Pret ON Exemplaire.id_pret = Pret.id_pret
#GROUP BY (Ressource.code);

#affichage du code de la ressource la plus populaire + nombre de prets
    sql = "SELECT id, nombre_emprunts FROM Emprunts_par_ressource WHERE nombre_emprunts = (SELECT MAX(nombre_emprunts) FROM Emprunts_par_ressource)"
    cur.execute(sql)
    row = cur.fetchone()
    id = row[0]
    nombre_emprunts = row[1]
    print("\n> La ressource la plus populaire est", id, "avec un nombre de prets de", nombre_emprunts);

#CREATE VIEW populaire (id, nombre) AS
#SELECT id, nombre_emprunts FROM Emprunts_par_ressource WHERE nombre_emprunts = (SELECT MAX(nombre_emprunts) FROM Emprunts_par_ressource) ;


def Nb_total_prets(conn): #affiche le nombre total de prets pour la bibliotheque
    cur = conn.cursor()
    sql ='SELECT COUNT(id_pret) AS nb_pret FROM Pret'
    cur.execute(sql)
    row = cur.fetchone()
    print("\n> Nombre total de prets :", row[0]);


  


  
