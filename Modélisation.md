Voici notre modélisation :
===========

![](Images/mod.png)


## Client

L'entité client contient toutes les informations du client.
Possède une relation avec les entités suivantes :
* Panier
* Commande
* avis

## Panier

Contient les informations sur le panier du client.
Son contenant permettra de remplir les produits d'une commande.

## Commande

Cette entité contient les informations sur les commandes du client.
Possède une relation avec les entités suivantes :
* Client
* Livraison
* Produit

## Paiement

Information sur le paiement. 
Son statut peut etre soit : 
* annulé en cas de probleme lors du paiement
* en cours lors de son traitement
* accepté

## Livraison

Information sur les livraisons
la livraison survient apres la validation de la commande

## Retour

Information sur le retour.
Un retour est initié a partir d'une commande.

## Produit

Information sur les produits.
Un produit decrit ses caracteristiques physiques tels que sa taille, sa couleur ou son poids.
le produit indiquera aussi son fournisseur.

## Fournisseur

Information sur les fournisseurs
Permetera par ailleurs de connaitre le pays d'origine

## Avis

Les avis sur les produits.
L'avis depend d'un produit et d'un client.

## Catégorie

Catégorie des produits


