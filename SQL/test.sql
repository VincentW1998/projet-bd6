\! echo "Requete 1 : la plus vieille date de naissance";
SELECT min(date_naissance) 
FROM client;

\! echo "Requete 1.5 : la plus jeune date de naissance";
SELECT max(date_naissance)
FROM client;

\! echo "Requete 2 : la personne qui a depensé la plus grosse somme d'argent";
SELECT nom, SUM(prix) AS max
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY max DESC
LIMIT 1;

\! echo "Requete 2.5 : la personne qui a depensé la plus petite somme d'argent";
SELECT nom, SUM(prix) AS min
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom
ORDER BY min ASC 
LIMIT 1;

\! echo "Requete 3 : la somme du prix depense lors d'achats pour chaque client";
SELECT nom, SUM(prix) as somme_depense
FROM achat NATURAL JOIN commande NATURAL JOIN client
GROUP BY nom;


\! echo "Requete 4 : la liste des clients qui ont acheté plus de 10 produits";
SELECT nom, prenom
FROM client NATURAL JOIN commande NATURAL JOIN achat
GROUP BY nom, prenom
HAVING count(id_produit) >= 10;

\! echo "Requete 5 : le prix d'achat moyen sur le site ";
SELECT ROUND(CAST(AVG(prix) AS NUMERIC), 2) FROM achat;

\! echo "Requete 6 : le chiffre d'affaire par mois toutes annees confondues sur le site ";
SELECT cast(extract (MONTH FROM date_commande) AS int) AS Mois, sum(prix)
FROM commande NATURAL JOIN achat 
GROUP BY Mois 
ORDER BY Mois;
