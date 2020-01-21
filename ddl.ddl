-- Généré par Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   à :        2020-01-22 00:11:48 WET
--   site :      Oracle Database 11g
--   type :      Oracle Database 11g



CREATE USER moto IDENTIFIED BY yassine
    ACCOUNT UNLOCK;

CREATE OR REPLACE TYPE "list type" IS
    VARRAY(1) OF unknown;
/

CREATE TABLE moto.admin (
    id_admin       NUMBER NOT NULL,
    nom_admin      VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    prenom_admin   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    email_admin    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    login_admin    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    mot_pass       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL
)
LOGGING;

ALTER TABLE moto.admin ADD CONSTRAINT admin_pk PRIMARY KEY ( id_admin );

CREATE TABLE moto.agent_maintenance (
    id_agent_maintance   NUMBER NOT NULL,
    nom_agent            VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    prenom_agent         VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    email_agent          VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    login                VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    mot_pass             VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL
)
LOGGING;

ALTER TABLE moto.agent_maintenance ADD CONSTRAINT agent_maintenance_pk PRIMARY KEY ( id_agent_maintance );

CREATE TABLE moto.client (
    id_client   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    nom         VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    email       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    prenom      VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    login       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    mot_pass    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL
)
LOGGING;

ALTER TABLE moto.client ADD CONSTRAINT client_pk PRIMARY KEY ( id_client );

CREATE GLOBAL TEMPORARY TABLE location_temp (
    locale              mdsys.sdo_geometry,
    client_id_client    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    scooter_matricule   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE UNIQUE INDEX location_temp__idx ON
    location_temp (
        client_id_client
    ASC );

CREATE UNIQUE INDEX location_temp__idxv1 ON
    location_temp (
        scooter_matricule
    ASC );

ALTER TABLE location_temp ADD CONSTRAINT location_temp_pk PRIMARY KEY ( client_id_client,
                                                                        scooter_matricule );

CREATE TABLE moto.louer (
    scooter_matricule   VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    client_id_client    VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    depart              mdsys.sdo_geometry NOT NULL,
    arrive              mdsys.sdo_geometry NOT NULL,
    heur_depart         DATE NOT NULL,
    heur_arrive         DATE NOT NULL,
    prix                NUMBER(10, 3),
    traget              mdsys.sdo_geometry
)
LOGGING;

ALTER TABLE moto.louer ADD CONSTRAINT louer_pk PRIMARY KEY ( scooter_matricule,
                                                             client_id_client );

CREATE TABLE moto.preparer (
    scooter_matricule                      VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    agent_maintenance_id_agent_maintance   NUMBER NOT NULL
)
LOGGING;

ALTER TABLE moto.preparer ADD CONSTRAINT preparer_pk PRIMARY KEY ( scooter_matricule,
                                                                   agent_maintenance_id_agent_maintance );

CREATE TABLE moto.scooter (
    matricule        VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    niveau_batteri   NUMBER NOT NULL,
    disponiblite     CHAR(1) NOT NULL,
    localisation     mdsys.sdo_geometry NOT NULL
)
LOGGING;

ALTER TABLE moto.scooter ADD CHECK ( niveau_batteri BETWEEN 0 AND 100 );

GRANT ALL PRIVILEGES ON moto.scooter TO moto WITH GRANT OPTION;

ALTER TABLE moto.scooter ADD CONSTRAINT scooter_pk PRIMARY KEY ( matricule );

ALTER TABLE location_temp
    ADD CONSTRAINT location_temp_client_fk FOREIGN KEY ( client_id_client )
        REFERENCES moto.client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE location_temp
    ADD CONSTRAINT location_temp_scooter_fk FOREIGN KEY ( scooter_matricule )
        REFERENCES moto.scooter ( matricule )
    NOT DEFERRABLE;

ALTER TABLE moto.louer
    ADD CONSTRAINT louer_client_fk FOREIGN KEY ( client_id_client )
        REFERENCES moto.client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE moto.louer
    ADD CONSTRAINT louer_scooter_fk FOREIGN KEY ( scooter_matricule )
        REFERENCES moto.scooter ( matricule )
    NOT DEFERRABLE;

ALTER TABLE moto.preparer
    ADD CONSTRAINT preparer_agent_maintenance_fk FOREIGN KEY ( agent_maintenance_id_agent_maintance )
        REFERENCES moto.agent_maintenance ( id_agent_maintance )
    NOT DEFERRABLE;

ALTER TABLE moto.preparer
    ADD CONSTRAINT preparer_scooter_fk FOREIGN KEY ( scooter_matricule )
        REFERENCES moto.scooter ( matricule )
    NOT DEFERRABLE;



-- Rapport récapitulatif d'Oracle SQL Developer Data Modeler : 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             2
-- ALTER TABLE                             14
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   1
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  23
-- WARNINGS                                 0
