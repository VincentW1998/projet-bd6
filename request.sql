\! echo "1) nom prenom des personnes ayant achetes le livre 'Air Force One'";
select client.nom , client.prenom
from client, commande natural join (achat join produit on achat.id_produit = produit.id_produit and  produit.nom = 'Air Force One') where client.id_client = commande.id_client

\! echo "2) moyenne d'age des clients"
select cast (avg(extract(year from age(date_naissance))) as int) from client

\! echo "3) nombre d'achat par categorie"
select nom, count(id_produit) as total_achat from achat natural join categorie group by nom order by total_achat DESC

\! echo "4) categorie de livre le plus acheté pour chaque client"
select id_client, max(c.nom) 
from commande natural join achat a join categorie c on (c.id_produit = a.id_produit) 
group by id_client order by id_client

\! echo "5) nombre de client n'ayant jamais rien acheté"
select count(id_client) from client where id_client not in (select distinct id_client from commande)

\! echo "6) quels pays ont le plus de clients"
select pays ,count(id_client) as nombre_clients 
from client group by pays order by nombre_clients desc

\! echo "7) quels pays commande le plus"
select pays , count(id_commande) nombre_commande from client natural join commande 
group by pays order by nombre_commande desc
