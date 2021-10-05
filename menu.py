#!/usr/bin/python3
import psycopg2
from membre import menu_membre
from adherent import menu_adherent
from bibli import Age_moyen_adherent
from bibli import Ressource_populaire
from bibli import Nb_total_prets
from bibli import stats_bibli
# from insertion import menu_insertion
# from insertion import add_adherent

HOST = "tuxa.sme.utc"
USER = "nf18p009"
PASSWORD = "WeFaRq8C"
DATABASE = "dbnf18p009"

conn = psycopg2.connect("host=%s dbname=%s user=%s password=%s" % (HOST, DATABASE, USER, PASSWORD))

choice = '1'
choices = ['1', '2', '3']
while choice in choices:
    print("\nMENU PRINCIPAL")
    print("1 : Espace Membre")
    print("2 : Espace Adherent")
    print("3 : Statistiques bibliothèque")

    print("Pour sortir, entrez autre chose")
    choice = input()

    if choice == '1':
        menu_membre(conn)

    if choice == '2':
        menu_adherent(conn)
    
    if choice == '3':
        stats_bibli(conn)

conn.close()


