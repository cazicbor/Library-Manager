#!/usr/bin/python3
import psycopg2
from affichage import menu_affichage
from insertion import menu_insertion
from affichage import quote


def authentification(conn, groupe):
    cur = conn.cursor()
    login_valide = -1
    tentatives = 0
    while (login_valide == -1) and tentatives < 3:
        login = quote(input("\nEntrez votre login %s : " % groupe.lower()))
        sql = "SELECT login, mdp, Compte_utilisateur.adresse_mail FROM (Utilisateur INNER JOIN Compte_utilisateur ON " \
              "Utilisateur.adresse_mail = Compte_utilisateur.adresse_mail) INNER JOIN %s g ON g.adresse_mail = " \
              "Utilisateur.adresse_mail WHERE Compte_utilisateur.login = %s" % (groupe, login)
        cur.execute(sql)
        row = cur.fetchone()
        if not row:
            print("login invalide")
            tentatives += 1
        else:
            login_valide = row[2]

    if not login_valide:
        conn.close()
        exit("Erreur : plus de 3 tentatives")
        return -1

    mdp_valide = False
    while not mdp_valide and tentatives < 3:
        mdp = input("\nEntrez votre mot de passe : ")
        print(row, row[1], mdp)
        if mdp == row[1]:
            mdp_valide = True
        else:
            tentatives += 1
            print("Mot de passe incorrect, reessayez")

    if not mdp_valide:
        conn.close()
        exit("Erreur : plus de 3 tentatives")
        return -1

    login_valide = row[2]
    if (groupe == "Adherent"):
        cur2 = conn.cursor()
        sql2 = "SELECT blackliste FROM Adherent WHERE adresse_mail = %s" % (quote(login_valide))
        cur2.execute(sql2)
        row2 = cur2.fetchone()
        if (row2[0] == "True"):
            exit("Erreur: Vous avez été blacklisté.")
        else:
            print("Authentification reussie")
            return login_valide

def menu_membre(conn):

    mail_membre = authentification(conn, 'Membre')

    choice = '1'
    choices = ['1', '2']
    while choice in choices:
        print("\nBienvenue dans l'espace reserve aux membres du personnel")
        print("\nChoisissez la rubrique correspondant a votre requete : ")
        print("1 : Menu affichage")
        print("2 : Menu insertion")

        print("Pour sortir, entrez autre chose")
        choice = input()

        if choice == '1':
            menu_affichage(conn)

        if choice == '2':
            menu_insertion(conn)
