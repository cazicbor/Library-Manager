# TODO Trouver un truc plus ergonomique pour la liste des sanctions
# TODO Rassembler des fonctions


def menu_affichage(conn):
    choice = '1'
    choices = list(range(1, 7))
    choices = ['%s' % n for n in choices]
    while choice in choices:
        print("\nMENU AFFICHAGE")
        print("\nPersonnes")
        print("1 : noms, prénoms des adhérents")
        print("2 : liste sanctions d'un adhérent")
        print("3 : liste adhérents blacklistes")
        print("4 : noms, prénoms des membres")
        print("5 : Afficher tous les utilisateurs")

        print("\nRessources")
        print("6 : Liste des exemplaires empruntés")

        print("\n\nPour revenir au menu précédent, entrez autre chose")
        choice = input()

        if choice == '1':
            print_utilisateurs(conn, groupe="Liste_Adherents")

        if choice == '2':
            mail = input("Mail de l'adhérent?")
            # TODO Gestion des erreurs
            print_sanctions_adherent(conn, mail)

        if choice == '3':
            print_blacklisted(conn)

        if choice == '4':
            print_utilisateurs(conn, groupe="Liste_Membres")

        if choice == '5':
            print_utilisateurs(conn)

        if choice == '6':
            print_view(conn, 'vPret')


def quote(s):
    if s:
        return '\'%s\'' % s
    else:
        return 'NULL'


def print_table(cur, sql):
    cur.execute(sql)
    lst = cur.fetchall()
    for row in lst:
        print(row)


def print_utilisateurs(con, groupe="Utilisateur"):
    cur = con.cursor()
    sql = "SELECT * FROM " + groupe
    print_table(cur, sql)


def print_sanctions_adherent(con, mail):
    cur = con.cursor()
    condition = " WHERE utilisateur =" + quote(mail)
    sql = "SELECT * FROM Sanction_Adherent" + condition
    print_table(cur, sql)


def print_blacklisted(con):
    cur = con.cursor()
    sql = "SELECT Nom, Prénom FROM Adherents_Blacklistés"
    print_table(cur, sql)


def print_view(con, view):
    cur = con.cursor()
    sql = "SELECT * FROM " + view
    print_table(cur, sql)
