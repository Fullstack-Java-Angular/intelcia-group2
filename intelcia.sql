-- Role
DROP TABLE IF EXISTS "role";
CREATE TABLE IF NOT EXISTS "role" (
    _numero SERIAL PRIMARY KEY,
    nom varchar(255)
);

-- Addresse
DROP TABLE IF EXISTS addresse;
CREATE TABLE IF NOT EXISTS addresse (
    _numero SERIAL PRIMARY KEY,
    code_postal varchar(255),
    ville varchar(255),
    pays varchar(255)
);

-- Division
DROP TABLE IF EXISTS division;
CREATE TABLE IF NOT EXISTS division (
    _numero SERIAL PRIMARY KEY,
    nom varchar(255),
    CA double precision,
    addresse SERIAL REFERENCES addresse(_numero)
);

-- Pole de Competence
DROP TABLE IF EXISTS pole_competence;
CREATE TABLE IF NOT EXISTS pole_competence(
    _numero SERIAL PRIMARY KEY,
    nom varchar(255),
    nb_salarie integer
);

-- Salarie
DROP TABLE IF EXISTS salarie;
CREATE TABLE IF NOT EXISTS salarie(
    _matricule bigint PRIMARY KEY,
    prenom varchar(255),
    nom varchar(255),
    salaire integer,
    comission double precision,
    "role" SERIAL REFERENCES role(_numero),
    addresse SERIAL REFERENCES addresse(_numero),
    pole_competence_id SERIAL NOT NULL REFERENCES pole_competence(_numero),
    division_id SERIAL NOT NULL REFERENCES division(_numero)
);

-- Chef
DROP TABLE IF EXISTS Chef;
CREATE TABLE IF NOT EXISTS Chef (
    salaries_id bigint NOT NULL REFERENCES salarie(_matricule)
) INHERITS (salarie);

-- IT
DROP TABLE IF EXISTS IT;
CREATE TABLE IF NOT EXISTS IT (
    -- Columns
) INHERITS (salarie);

-- RH
DROP TABLE IF EXISTS RH;
CREATE TABLE IF NOT EXISTS RH (
    -- Columns
) INHERITS (salarie);

-- Materiel
DROP TABLE IF EXISTS materiel;
CREATE TABLE IF NOT EXISTS materiel(
    _numero SERIAL PRIMARY KEY,
    nom varchar(255),
    m_type varchar(255),
    reference_constructeur varchar(255),
    contient SERIAL REFERENCES materiel(_numero),
    salarie_matricule bigint REFERENCES salarie(_matricule)
);

-- Tache
DROP TABLE IF EXISTS tache;
CREATE TABLE IF NOT EXISTS tache(
    _numero SERIAL PRIMARY KEY,
    nom varchar(255),
    cout double precision
);

-- Salarie_Tache
DROP TABLE IF EXISTS salarie_tache;
CREATE TABLE IF NOT EXISTS salarie_tache(
    salarie_matricule bigint NOT NULL REFERENCES  salarie(_matricule),
    tache_numero SERIAL NOT NULL REFERENCES tache(_numero),
    d_debut date,
    d_fin date,
    PRIMARY KEY(salarie_matricule,tache_numero)
);

-- Projet
DROP TABLE IF EXISTS projet;
CREATE TABLE IF NOT EXISTS projet(
    _numero SERIAL PRIMARY KEY,
    appellation varchar(255),
    theme varchar(255),
    d_debut date,
    d_fin date

);

-- Client
DROP TABLE IF EXISTS client;
CREATE TABLE IF NOT EXISTS client(
    _numero SERIAL PRIMARY KEY,
    activite varchar(255),
    addresse SERIAL REFERENCES addresse(_numero),
    nom varchar(255),
    fonction varchar(255),
    email varchar(255),
    telephone varchar(255),
    fax varchar(255)
);
-- Client_Projet
DROP TABLE IF EXISTS client_projet;
CREATE TABLE IF NOT EXISTS client_projet(
    client_numero SERIAL NOT NULL REFERENCES client(_numero),
    projet_numero SERIAL NOT NULL REFERENCES projet(_numero),
    PRIMARY KEY (client_numero,projet_numero),
     date_echeance date
);