drop table if exists client cascade;
create table client (
    id_client serial primary key,
    nom char(50) not null,
    prenom char(50) not null,
    mail varchar(254) not null,
    telephone integer not null,
    numero_adresse int, 
    rue_adresse text,
    ville text, 
    code_postal text,
    pays text,
    date_naissance date, 
    date_inscription timestamp default current_timestamp,
    unique (mail)
);

drop table if exists produit cascade;
create table produit (
    id_produit serial primary key,
    nom text not null,
    prix float(2) not null,
    image text,
    poids float(2),
    synopsis text
);

drop table if exists commande cascade;
create table commande(
    id_commande serial primary key,
    id_client int,
    date_commande timestamp default current_timestamp,
    adresse_facturation text not null,
    foreign key(id_client) references client(id_client)
);

drop table if exists fournisseur cascade;
create table fournisseur(
    id_fournisseur serial primary key,
    nom char (50) not null,
    ville char (50),
    pays char (50),
    telephone int not null,
    mail char (150) not null
);

drop table if exists disponible cascade;
create table disponible(
    id_produit serial not null,
    quantite int not null,
    foreign key (id_produit) references produit(id_produit)
 );
-- constraint id_produit check (id_produit not in (select id_produit from indisponible))

drop table if exists indisponible cascade;
create table indisponible(
    id_produit serial not null,
    date_reaprovisionement date,
    foreign key (id_produit) references produit(id_produit)
);
-- constraint id_produit check (id_produit not in (select id_produit from disponible))

drop table if exists panier cascade;
create table panier(
    id_panier serial primary key,
    id_client integer, 
    foreign key(id_client) references client(id_client)
);

drop table if exists panier_contenu cascade;
create table panier_contenu(
    id_panier integer,
    id_produit integer,
    quantite integer default 1,
    foreign key(id_panier) references panier(id_panier),
    foreign key(id_produit) references produit(id_produit)
);

drop table if exists achat cascade;
drop type if exists achat_status cascade;
create type achat_status as enum('in progress','in preparation','in delivery','delivered');
create table achat(
    id_achat serial primary key,
    id_commande int,
    id_produit int,
    prix float(2),
    date timestamp default current_timestamp,
    status achat_status default 'in progress',
    foreign key (id_commande) references commande(id_commande),
    foreign key (id_produit) references produit(id_produit)
);

drop table if exists paiement cascade;
drop type if exists type_card cascade;
drop type if exists paiement_status cascade;
create type type_card as enum ('visa', 'mastercard', 'americanexpress');
create type paiement_status as enum ('accepted','in progress','canceled');
create table paiement(
    id_paiement serial primary key,
    id_commande int,
    type_carte type_card not null,
    num_carte varchar(16) not null,
    status paiement_status default 'in progress',
    foreign key (id_commande) references commande(id_commande)
);

drop table if exists avis cascade;
create table avis(
    id_avis serial primary key,
    id_produit int,
    id_client int,
    id_achat int not null,
    commentaire text,
    note float(1),
    foreign key (id_achat) references achat(id_achat),
    foreign key(id_client) references client(id_client)
);
-- constraint id_achat check(id_achat in (select id_achat from achat where id_produit = avis.id_produit)

drop table if exists livraison cascade;
drop type if exists name_comp cascade;
create type name_comp as enum ('UPS', 'DHL', 'COLISSIMO');
create table livraison(
id_livraison serial primary key,
compagnie name_comp not null,
telephone int,
adresse text not null
);

drop table if exists retour cascade;
drop type if exists retour_status cascade;
create type retour_status as enum('in progress', 'received');
create table retour(
id_retour serial primary key,
id_achat int,
id_produit int,
motif text,
status retour_status default 'in progress',
foreign key (id_achat) references achat(id_achat),
foreign key(id_produit) references produit(id_produit)
);

drop table if exists categorie cascade;
create table categorie(
id_categorie serial primary key,
nom text, 
id_produit int,
foreign key (id_produit) references produit(id_produit)
);

drop table if exists historique_prix cascade;
create table historique_prix(
id_produit int,
prix float(2),
date timestamp default current_timestamp,
foreign key (id_produit) references produit(id_produit)
);


