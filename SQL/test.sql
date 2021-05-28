\! echo "Requete 1 : nom prenom des personnes ayant achetes le livre 'Air Force ONe'";
SELECT client.nom , client.prenom
FROM client, commande NATURAL JOIN 
    (achat JOIN produit ON achat.id_produit = produit.id_produit 
    and  produit.nom = 'Air Force ONe') 
WHERE client.id_client = commande.id_client;

\! echo "Requete 2 : moyenne d'age des clients";
SELECT cast (avg(extract(year FROM age(date_naissance))) AS int) 
FROM client;

\! echo "Requete 3 : nombre d'achat par categorie";
SELECT nom, count(id_produit) AS total_achat 
FROM achat NATURAL JOIN categorie 
GROUP BY nom 
ORDER BY total_achat DESC;

\! echo "Requete 4 : categorie de livre le plus acheté pour chaque client";
SELECT id_client, max(c.nom) 
FROM commande NATURAL JOIN achat a JOIN categorie c ON (c.id_produit = a.id_produit) 
GROUP BY id_client 
ORDER BY id_client;

\! echo "Requete 5 : nombre de client n'ayant jamais rien acheté";
SELECT count(id_client) 
FROM client 
WHERE id_client NOT IN 
    (SELECT DISTINCT id_client 
     FROM commande);

\! echo "Requete 6 : quels pays ont le plus de clients";
SELECT pays ,count(id_client) AS nombre_clients 
FROM client 
GROUP BY pays 
ORDER BY nombre_clients desc;

\! echo "Requete 7 : quels pays commandent le plus";
SELECT pays , count(id_commande) nombre_commande 
FROM client NATURAL JOIN commande 
GROUP BY pays 
ORDER BY nombre_commande desc;

\! echo "Requete 8 : la date de naissance la plus ancienne";
SELECT min(date_naissance) 
FROM client;

\! echo "Requete 9 : la date de naissance la plus recente";
SELECT max(date_naissance)
FROM client;

\! echo "Requete 10 : la personne qui a depensé la plus grosse somme d'argent";
SELECT nom, SUM(prix) AS max
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY max DESC
LIMIT 1;

\! echo "Requete 11 : la personne qui a depensé la plus petite somme d'argent";
SELECT nom, SUM(prix) AS min
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY min ASC 
LIMIT 1;

\! echo "Requete 12 : la somme du prix depense lors d'achats pour chaque client";
SELECT nom, SUM(prix) as somme_depense
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom;


\! echo "Requete 13 : la liste des clients qui ont acheté plus de 10 produits";
SELECT nom, prenom
FROM client NATURAL JOIN commande NATURAL JOIN achat
GROUP BY nom, prenom
HAVING count(id_produit) >= 10;

\! echo "Requete 14 : le prix d'achat moyen sur le site ";
SELECT ROUND(CAST(AVG(prix) AS NUMERIC), 2) FROM achat;

\! echo "Requete 15 : le chiffre d'affaire par mois toutes annees confondues sur le site ";
SELECT cast(extract (MONTH FROM date_commande) AS int) AS Mois, sum(prix)
FROM commande NATURAL JOIN achat 
GROUP BY Mois 
ORDER BY Mois;

\! echo "Requete 16 : les fournisseurs qui ont au moins 2 retour";
SELECT nom, count(id_produit)
FROM fournisseur NATURAL JOIN retour 
GROUP BY nom HAVING count(id_produit) > 1;

\! echo "Requete 17 : les 5 articles les mieux notés"; 
SELECT nom as NomProduit, avg(note) as noteMoyenne, count(id_avis) as nombreAvis FROM produit NATURAL JOIN avis
GROUP BY nom 
ORDER BY noteMoyenne DESC, nombreAvis DESC
LIMIT 5;

-- \! echo "Requete 18 : la somme de..."
-- SELECT sum(montant)
-- FROM (
--     SELECT prix as montant
--     FROM produit
--     WHERE id.produit = 2
-- ) as T