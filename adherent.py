import psycopg2
from affichage import *
from membre import authentification
import stat
from pret import pret

def menu_adherent(conn):

    mail_adherent = authentification(conn, 'Adherent')
    print(mail_adherent)
    
    choice = '1'
    choices = ['1', '2', '3', '4']
    while choice in choices:
        print("Bienvenue dans l'espace Adherent")
        print("1 : Espace Ressources")
        print("2 : Consultation des emprunts")
        print("3 : Gestion des données personnelles")
        print("4 : Statistiques personnelles")

        print("Pour sortir, entrez autre chose")
        choice = input()

        if choice == '1':
            print("Liste des exemplaires disponibles:")
            print_ressources(conn)
            print("Souhaitez-vous faire un pret? (Y/N)")
            choix = input()
            if (choix == 'Y'):
                pret(conn, mail_adherent)
                       
        if choice == '2':
            print_pret(conn, mail_adherent)

        if choice == '3':
            print_donnees(conn)

        if choice == '4':
            print_stats(conn, mail_adherent)

def print_ressources(con):
    cur = con.cursor()
    condition = " WHERE id_pret IS NULL AND (Exemplaire.etat = 'bon' OR Exemplaire.etat = 'neuf')"
    sql = "SELECT * FROM vExemplaire_Bon"
    print_table(cur, sql)

def print_pret(con, mail):
    cur = con.cursor()
    condition = " WHERE adresse_mail =" + quote(mail)
    sql = "SELECT * FROM vPret" + condition
    print_table(cur, sql)
  
def print_stats(conn, mail_adherent):
    choice = '1'
    choices = ['1', '2']
    while choice in choices:
        print("\nMENU STATISTIQUES ADHERANT")
        print("1 : Affichage du nombre de prets")
        print("2 : Affichage du genre le plus populaire")

        print("Pour sortir, entrez autre chose")
        choice = input()

        if choice == '1':
            Nb_ressources(conn, mail_adherent)

        if choice == '2':
            Genre_populaire_par_adherent(conn, mail_adherent);

def Nb_ressources(conn, mail_adherent): #affiche le nombre de pret par adhérent

    cur = conn.cursor()
    sql = "SELECT Membre, nombre FROM Pret_par_Membre WHERE Membre='%s'" % mail_adherent
    cur.execute(sql)
    raw = cur.fetchone()
    Membre = raw[0]
    nombre = raw[1]
    print ("Le nombre d'emprunts pour", Membre,"est de", nombre)
    #return nombre


def Genre_populaire_par_adherent(conn, mail_adherent): #affiche le genre le plus emprunté par un adhérent

    cur = conn.cursor()
    sql = "SELECT Type, nombre FROM Emprunts_par_genre"
    cur.execute(sql)
    raw = cur.fetchone()
    Type = raw[0]
    nombre = raw[1]

    sql = "SELECT Type, nombre FROM Emprunts_par_genre WHERE nombre = (SELECT MAX(nombre) FROM Emprunts_par_genre)"
    cur.execute(sql)
    row = cur.fetchone()
    print("\n> Genre le plus populaire :", row[0]);

    
        





