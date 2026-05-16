DROP SCHEMA IF EXISTS parcoursup CASCADE;
CREATE SCHEMA parcoursup;
SET search_path TO parcoursup;


CREATE TABLE _formation (cod_aff_form VARCHAR(5), filiere_libelle_detaille VARCHAR(350), coordonnees_gps VARCHAR(35), list_com VARCHAR(50), concours_commun_banque_epreuve VARCHAR(105), url_formation VARCHAR(100), tri VARCHAR(30) ,
CONSTRAINT formation_pk PRIMARY KEY(cod_aff_form));


CREATE TABLE _session (session_annee INTEGER,
CONSTRAINT session_pk PRIMARY KEY(session_annee));


CREATE TABLE _filiere (filiere_id INTEGER, filiere_libelle VARCHAR(285), filiere_libelle_tres_abrege VARCHAR(25), filiere_libelle_abrege VARCHAR(75), filiere_libelle_detaille_bis VARCHAR(125),
CONSTRAINT filiere_pk PRIMARY KEY(filiere_id));


CREATE TABLE _academie (academie_nom VARCHAR(25),
CONSTRAINT academie_pk PRIMARY KEY (academie_nom));

CREATE TABLE _etablissement (etablissement_code_uai VARCHAR(9), etablissement_nom VARCHAR(150), etablissement_statut VARCHAR(40),
CONSTRAINT etablissement_pk PRIMARY KEY(etablissement_code_uai));

CREATE TABLE _commune(commune_nom VARCHAR(35),
CONSTRAINT commune_pk PRIMARY KEY(commune_nom));

CREATE TABLE _departement (departement_code VARCHAR(3), departement_nom VARCHAR(30),
CONSTRAINT departement_pk PRIMARY KEY(departement_code));

CREATE TABLE _region (region_nom VARCHAR(60),
CONSTRAINT region_pk PRIMARY KEY(region_nom));

CREATE TABLE _type_bac (type_bac VARCHAR(20),
CONSTRAINT type_bac_pk PRIMARY KEY(type_bac));

CREATE TABLE _mention_bac (libelle_mention VARCHAR(40),
CONSTRAINT mention_pk PRIMARY KEY(libelle_mention));


CREATE TABLE _regroupement (libelle_regroupement VARCHAR(75),
CONSTRAINT regroupement_pk PRIMARY KEY(libelle_regroupement));


CREATE TABLE _rang_dernier_appele_selon_regroupement (cod_aff_form VARCHAR(50), libelle_regroupement VARCHAR(50), session_annee INTEGER, rang_dernier_appele INTEGER,
CONSTRAINT rang_dernier_appele_pk PRIMARY KEY( cod_aff_form, libelle_regroupement, session_annee),
CONSTRAINT rang_dernier_appele_fk_formation FOREIGN KEY ( cod_aff_form) REFERENCES _formation(cod_aff_form),
CONSTRAINT rang_dernier_appele_fk_regroupement FOREIGN KEY ( libelle_regroupement) REFERENCES _regroupement(libelle_regroupement),
CONSTRAINT rang_dernier_appele_fk_session_annee FOREIGN KEY ( session_annee) REFERENCES _session(session_annee));

CREATE TABLE _admissions_generalites (cod_aff_form VARCHAR(50), session_annee INTEGER, selectivite VARCHAR(25), capacite INTEGER,effectif_total_candidats INTEGER, effectif_total_candidates INTEGER,
CONSTRAINT admission_gen_pk PRIMARY KEY (cod_aff_form, session_annee),
CONSTRAINT admission_gen_fk_formation FOREIGN KEY ( cod_aff_form) REFERENCES _formation(cod_aff_form),
CONSTRAINT admission_gen_fk_session FOREIGN KEY ( session_annee) REFERENCES _session(session_annee));

CREATE TABLE _admissions_selon_type_neo_bac (cod_aff_form VARCHAR(15), type_bac VARCHAR(200), session_annee INTEGER, effectif_neo_bac_classes INTEGER,
CONSTRAINT admissions_neo_bac_pk PRIMARY KEY( cod_aff_form, type_bac, session_annee),
CONSTRAINT admissions_neo_bac_fk_formation FOREIGN KEY ( cod_aff_form) REFERENCES _formation(cod_aff_form),
CONSTRAINT admissions_neo_bac_fk_type_bac FOREIGN KEY (type_bac) REFERENCES _type_bac(type_bac),
CONSTRAINT admissions_neo_bac_fk_session FOREIGN KEY ( session_annee) REFERENCES _session(session_annee));

CREATE TABLE _effectif_selon_mention (cod_aff_form VARCHAR(15), libelle_mention VARCHAR(25), session_annee INTEGER, effectif_admis_neo_bac_selon_mention INTEGER,
CONSTRAINT effectif_mention_pk PRIMARY KEY(cod_aff_form, libelle_mention, session_annee),
CONSTRAINT effectif_mention_fk_formation FOREIGN KEY ( cod_aff_form) REFERENCES _formation(cod_aff_form),
CONSTRAINT effectif_mention_fk_mention_bac FOREIGN KEY (libelle_mention) REFERENCES _mention_bac(libelle_mention),
CONSTRAINT effectif_mention_fk_session FOREIGN KEY ( session_annee) REFERENCES _session(session_annee));

CREATE TABLE _filiere_formation (filiere_id INTEGER, cod_aff_form VARCHAR(5), 
CONSTRAINT filiere_formation_pk PRIMARY KEY (filiere_id, cod_aff_form),
CONSTRAINT filiere_formation_fk_filiere FOREIGN KEY (filiere_id) REFERENCES _filiere(filiere_id),
CONSTRAINT filiere_formation_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form));

CREATE TABLE _academie_formation (academie_nom VARCHAR(25), cod_aff_form VARCHAR(5), 
CONSTRAINT academie_formation_pk PRIMARY KEY (academie_nom, cod_aff_form),
CONSTRAINT academie_formation_fk_academie FOREIGN KEY (academie_nom) REFERENCES _academie(academie_nom),
CONSTRAINT academie_formation_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form));

CREATE TABLE _etablissement_formation (etablissement_code_uai VARCHAR(9), cod_aff_form VARCHAR(5), 
CONSTRAINT etablissement_formation_pk PRIMARY KEY (etablissement_code_uai, cod_aff_form),
CONSTRAINT etablissement_formation_fk_etablissement FOREIGN KEY (etablissement_code_uai) REFERENCES _etablissement(etablissement_code_uai),
CONSTRAINT etablissement_formation_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form));

CREATE TABLE _commune_formation (commune_nom VARCHAR(35), cod_aff_form VARCHAR(5), 
CONSTRAINT commune_formation_pk PRIMARY KEY (commune_nom, cod_aff_form),
CONSTRAINT commune_formation_fk_commune FOREIGN KEY (commune_nom) REFERENCES _commune(commune_nom),
CONSTRAINT commune_formation_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form));

CREATE TABLE _commune_departement (commune_nom VARCHAR(35), departement_code VARCHAR(3), 
CONSTRAINT commune_departement_pk PRIMARY KEY (commune_nom, departement_code),
CONSTRAINT commune_departement_fk_etablissement FOREIGN KEY (commune_nom) REFERENCES _commune(commune_nom),
CONSTRAINT commune_departement_fk_departement FOREIGN KEY (departement_code) REFERENCES _departement(departement_code));

CREATE TABLE _region_departement (region_nom VARCHAR(60), departement_code VARCHAR(3), 
CONSTRAINT region_departement_pk PRIMARY KEY (region_nom, departement_code),
CONSTRAINT region_departement_fk_region FOREIGN KEY (region_nom) REFERENCES _region(region_nom),
CONSTRAINT region_departement_fk_departement FOREIGN KEY (departement_code) REFERENCES _departement(departement_code));
