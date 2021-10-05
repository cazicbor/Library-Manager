import psycopg2

from affichage import quote


def menu_insertion(conn):
    choice = '1'
    choices = ['1']
    while choice in choices:
        print("\nMENU INSERTION")
        print("1 : ajouter un adhérent")
        print("2 : ajouter une ressource")
        print("Pour revenir au menu précédent, entrez autre chose")
        choice = input()

        if choice == '1':
            add_adherent(conn)

        if choice == '2':
            add_ressource(conn)


def add_compte(conn, mail):
    login = quote(input("login?").lower())
    mdp = quote(input("mdp?"))
    sql = "INSERT INTO Compte_utilisateur VALUES (%s, %s, %s)" \
              % (login, mdp, mail)

    return sql


def add_utilisateur(conn, adresse_mail, nom, prenom, date_naissance, adresse):

    sql_util = "INSERT INTO Utilisateur VALUES (%s, %s, %s, %s, %s)" % (adresse_mail,
                                                                       nom,
                                                                       prenom,
                                                                       date_naissance,
                                                                       adresse)
    # Creation requête du compte
    sql_compte = add_compte(conn, adresse_mail)
    if sql_compte == -1:
        print("Insertion annulée, retour au menu")
        return -1

    return sql_compte, sql_util


def add_adherent(conn):
    nom = quote(input('nom?').upper())
    prenom = quote(input('prenom?'))
    nom = nom[0].upper() + nom[1:].lower()
    prenom = prenom[0].upper() + prenom[1:].lower()
    adresse_mail = quote(input('adresse mail?'))
    date_naissance = quote(input('date_naissance?'))
    adresse = quote(input('adresse?'))

    sql_compte, sql_util = add_utilisateur(conn, adresse_mail, nom, prenom, date_naissance, adresse)
    if sql_compte == -1 or sql_util == -1:
        print("Aucun adhérent n'a été ajouté")
        return -1
    cur = conn.cursor()
    try:
        sql_adherent = "INSERT INTO Adherent VALUES (%s, 0, FALSE)" % adresse_mail
        cur.execute(sql_util)
        cur.execute(sql_compte)
        cur.execute(sql_adherent)
        conn.commit()
    except psycopg2.DataError as e:
        print("Erreur lors de l'insertion de l'adherent :", e)
    except psycopg2.errors.UniqueViolation as e:
        print("L'utilisateur est déjà présent dans la base de données")
        print("Message système : ", e)


def add_ressource(conn):
    code = int(input("Code?"))
    titre = quote(input("Titre?"))
    date_apparition = int(input("Année d'apparition?"))
    editeur = quote(input("Editeur?"))
    genre = quote(input("Genre?"))
    code_classification = quote(input("Code de classification?"))
    cur = conn.cursor()

    sql = "INSERT INTO Ressource VALUES (%i, %s, %s, %s, %s, %s)" % (code,
                                                                     titre,
                                                                     date_apparition,
                                                                     editeur,
                                                                     genre,
                                                                     code_classification)

    choice = '1'
    choices = ['1', '2', '3']
    while choice in choices:
        print("\nType de ressource?")
        print("1 : Livre")
        print("2 : Film")
        print("3 : Oeuvre musicale")

        choice = input()

        if choice == '1':
            isbn = int(input("isbn?"))
            resume = quote(input("Résumé?"))
            try:
                sql_2 = "INSERT INTO Livre VALUES (%i, %i, %s)" % (code,
                                                                   isbn,
                                                                   resume)
                cur.execute(sql)
                cur.execute(sql_2)
            except psycopg2.DataError as e:
                print("Erreur lors de l'insertion du livre :", e)
                return -1

            except psycopg2.errors.UniqueViolation as e:
                print("Le livre existe déjà")
                print("Message système : ", e)
                return -1

            choice = -1
            conn.commit()

        if choice == '2':
            longueur = int(input("longueur (en min)?"))
            synopsis = quote(input("Résumé?"))
            try:
                sql_2 = "INSERT INTO Film VALUES (%i, %i, %s)" % (code,
                                                                  longueur,
                                                                  synopsis)
                cur.execute(sql)
                cur.execute(sql_2)
                # conn.commit()
            except psycopg2.DataError as e:
                print("Erreur lors de l'insertion du film :", e)
                return -1

            except psycopg2.errors.UniqueViolation as e:
                print("Le film existe déjà")
                print("Message système : ", e)
                return -1

            choice = -1
            conn.commit()

        if choice == '3':
            longueur = int(input("longueur (en min)?"))

            try:
                sql_2 = "INSERT INTO Oeuvre_musicale VALUES (%i, %i)" % (code,
                                                                         longueur)
                cur.execute(sql)
                cur.execute(sql_2)
            except psycopg2.DataError as e:
                print("Erreur lors de l'insertion de l'oeuvre musicale :", e)
                return -1

            except psycopg2.errors.UniqueViolation as e:
                print("L'oeuvre existe déjà")
                print("Message système : ", e)
                return -1

            choice = -1
            conn.commit()
