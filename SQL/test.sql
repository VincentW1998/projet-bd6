\! echo "Requete 1 : la plus vieille date de naissance";
SELECT min(date_naissance) 
FROM client;

\! echo "Requete 2 : la plus jeune date de naissance";
SELECT max(date_naissance)
FROM client;

\! echo "Requete 3 : la personne qui a depensé la plus grosse somme d'argent";
SELECT nom, SUM(prix) AS max
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY max DESC
LIMIT 1;

\! echo "Requete 4 : la personne qui a depensé la plus petite somme d'argent";
SELECT nom, SUM(prix) AS min
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY min ASC 
LIMIT 1;

\! echo "Requete 5 : la somme du prix depense lors d'achats pour chaque client";
SELECT nom, SUM(prix) as somme_depense
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom;


\! echo "Requete 6 : la liste des clients qui ont acheté plus de 10 produits";
SELECT nom, prenom
FROM client NATURAL JOIN commande NATURAL JOIN achat
GROUP BY nom, prenom
HAVING count(id_produit) >= 10;

\! echo "Requete 7 : le prix d'achat moyen sur le site ";
SELECT ROUND(CAST(AVG(prix) AS NUMERIC), 2) FROM achat;

\! echo "Requete 8 : le chiffre d'affaire par mois toutes annees confondues sur le site ";
SELECT cast(extract (MONTH FROM date_commande) AS int) AS Mois, sum(prix)
FROM commande NATURAL JOIN achat 
GROUP BY Mois 
ORDER BY Mois;

\! echo "Requete 9 : les fournisseurs qui ont au moins 2 retour";
SELECT nom, count(id_produit)
FROM fournisseur NATURAL JOIN retour 
GROUP BY nom HAVING count(id_produit) > 1;

\! echo "Requete 10 : les 5 articles les mieux notés"; 
SELECT nom as NomProduit, avg(note) as noteMoyenne, count(id_avis) as nombreAvis FROM produit NATURAL JOIN avis
GROUP BY nom 
ORDER BY noteMoyenne DESC, nombreAvis DESC
LIMIT 5