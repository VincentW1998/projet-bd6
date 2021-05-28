\! echo "Requete 1 : la plus vieille date de naissance";
SELECT min(date_naissance) 
FROM client;

\! echo "Requete 2 : la plus jeune date de naissance";
SELECT max(date_naissance)
FROM client;

\! echo "Requete 3 : la personne qui a depensé la plus grosse somme d'argent";
-- SELECT nom, prix
-- FROM achat JOIN commande ON (achat.id_commande = commande.id_commande) 
--     JOIN client ON (commande.id_client = client.id_client)
-- WHERE min(prix);


\! echo "Requete 4 : la personne qui a depensé la plus petite somme d'argent";

\! echo "Requete 5 : la somme du prix depense lors d'achats pour chaque client";
SELECT nom, SUM(prix) as somme_depense 
FROM achat JOIN commande ON (achat.id_commande = commande.id_commande) 
    JOIN client ON (commande.id_client = client.id_client)
GROUP BY nom;

\! echo "Requete 6 : le prix d'achat moyen sur le site ";



\! echo "Requete 7 : la liste des clients qui ont acheté plus de 10 produits";
SELECT nom, prenom
FROM client NATURAL JOIN commande NATURAL JOIN achat
GROUP BY nom, prenom
HAVING count(id_produit) >= 10;

