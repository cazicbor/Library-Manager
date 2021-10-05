import psycopg2
import datetime
from affichage import quote

def pret(conn, mail):
    cur = conn.cursor()
    bon = -1
    if (compte_pret(conn, mail) > 10):
        print("Vous avez atteint le nombre max de prêts.")
    else:
        num = input("\nQuel est le code de l'exemplaire que vous voulez emprunter?")
        sql = "SELECT ressource FROM vExemplaire_Bon WHERE ressource =" +num;
        cur.execute(sql)
        row = cur.fetchone()
        if not row:
            print("L'exemplaire n'existe pas")
        else:
            cur2 = conn.cursor()
            date_pret = datetime.datetime.now()
            d = datetime.timedelta(weeks = 2)
            date_fin = date_pret + d
            sql2 = "INSERT INTO Pret (date_pret, date_fin, adresse_mail) VALUES (%s, %s, %s) RETURNING id_pret" % (quote(date_pret), quote(date_fin), quote(mail))
            cur2.execute(sql2)
            conn.commit()
            row1 = cur2.fetchone()
            cur3 = conn.cursor()
            sql3 = "UPDATE Exemplaire SET id_pret = %s, disponible = FALSE WHERE code = %s" % (row1[0], num)
            cur3.execute(sql3)
            conn.commit()
            print("Vous avez jusqu'au", date_fin, "pour rendre l'exemplaire.\n")                

    
def compte_pret(conn, mail_adherent): #affiche le nombre de pret par adhérent
  cur = conn.cursor()
  sql = "SELECT Membre, nombre FROM Pret_par_Membre WHERE membre='%s'" % mail_adherent
  cur.execute(sql)
  row = cur.fetchone()
  Membre = row[0]
  nombre = row[1]
  return nombre


            
            

            
           
            
    

    
