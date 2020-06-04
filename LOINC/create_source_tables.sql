/**************************************************************************
* Copyright 2016 Observational Health Data Sciences and Informatics (OHDSI)
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
* 
* Authors: Timur Vakhitov, Christian Reich
* Date: 2017
**************************************************************************/

DROP TABLE IF EXISTS SOURCES.LOINC;
CREATE TABLE SOURCES.LOINC
(
  LOINC_NUM                  VARCHAR(10),
  COMPONENT                  VARCHAR(255),
  PROPERTY                   VARCHAR(255),
  TIME_ASPCT                 VARCHAR(255),
  SYSTEM                     VARCHAR(255),
  SCALE_TYP                  VARCHAR(255),
  METHOD_TYP                 VARCHAR(255),
  CLASS                      VARCHAR(255),
  VERSIONLASTCHANGED         VARCHAR(255),
  CHNG_TYPE                  VARCHAR(255),
  DEFINITIONDESCRIPTION      TEXT,
  STATUS                     VARCHAR(255),
  CONSUMER_NAME              VARCHAR(255),
  CLASSTYPE                  VARCHAR(255),
  FORMULA                    TEXT,
  SPECIES                    VARCHAR(20),
  EXMPL_ANSWERS              TEXT,
  SURVEY_QUEST_TEXT          TEXT,
  SURVEY_QUEST_SRC           VARCHAR(50),
  UNITSREQUIRED              VARCHAR(1),
  SUBMITTED_UNITS            VARCHAR(30),
  RELATEDNAMES2              TEXT,
  SHORTNAME                  VARCHAR(100),
  ORDER_OBS                  VARCHAR(15),
  CDISC_COMMON_TESTS         VARCHAR(1),
  HL7_FIELD_SUBFIELD_ID      VARCHAR(50),
  EXTERNAL_COPYRIGHT_NOTICE  TEXT,
  EXAMPLE_UNITS              VARCHAR(255),
  LONG_COMMON_NAME           VARCHAR(255),
  UNITSANDRANGE              TEXT,
  EXAMPLE_UCUM_UNITS         VARCHAR(255),
  EXAMPLE_SI_UCUM_UNITS      VARCHAR(255),
  STATUS_REASON              VARCHAR(9),
  STATUS_TEXT                TEXT,
  CHANGE_REASON_PUBLIC       TEXT,
  COMMON_TEST_RANK           VARCHAR(20),
  COMMON_ORDER_RANK          VARCHAR(20),
  COMMON_SI_TEST_RANK        VARCHAR(20),
  HL7_ATTACHMENT_STRUCTURE   VARCHAR(15),
  EXTERNAL_COPYRIGHT_LINK    VARCHAR(255),
  PANELTYPE                  VARCHAR(50),
  ASKATORDERENTRY            VARCHAR(255),
  ASSOCIATEDOBSERVATIONS     VARCHAR(255),
  VERSIONFIRSTRELEASED       VARCHAR(255),
  VALIDHL7ATTACHMENTREQUEST  VARCHAR(255),
  DISPLAYNAME                TEXT,
  VOCABULARY_DATE            DATE,
  VOCABULARY_VERSION         VARCHAR (200)
);

DROP TABLE IF EXISTS SOURCES.MAP_TO;
CREATE TABLE SOURCES.MAP_TO
(
  LOINC           VARCHAR(10),
  MAP_TO          VARCHAR(10),
  MAP_TO_COMMENT  TEXT
);

DROP TABLE IF EXISTS SOURCES.SOURCE_ORGANIZATION;
CREATE TABLE SOURCES.SOURCE_ORGANIZATION
(
  ID            INT4,
  COPYRIGHT_ID  VARCHAR(255),
  NAME          VARCHAR(255),
  COPYRIGHT     TEXT,
  TERMS_OF_USE  TEXT,
  URL           VARCHAR(255)
);

DROP TABLE IF EXISTS SOURCES.LOINC_FORMS;
CREATE TABLE SOURCES.LOINC_FORMS
(
    PARENTID                      INT4,
    PARENTLOINC                   VARCHAR (10),
    PARENTNAME                    VARCHAR (1000),
    ID                            INT4,
    LSEQUENCE                     INT4,
    LOINC                         VARCHAR (10),
    LOINCNAME                     VARCHAR (1000),
    DISPLAYNAMEFORFORM            VARCHAR (1000),
    OBSERVATIONREQUIREDINPANEL    VARCHAR (10),
    OBSERVATIONIDINFORM           VARCHAR (100),
    SKIPLOGICHELPTEXT             VARCHAR (1000),
    DEFAULTVALUE                  VARCHAR (1000),
    ENTRYTYPE                     VARCHAR (10),
    DATATYPEINFORM                VARCHAR (1000),
    DATATYPESOURCE                VARCHAR (1000),
    ANSWERSEQUENCEOVERRIDE        VARCHAR (1000),
    CONDITIONFORINCLUSION         VARCHAR (1000),
    ALLOWABLEALTERNATIVE          VARCHAR (1000),
    OBSERVATIONCATEGORY           VARCHAR (1000),
    CONTEXT                       TEXT,
    CONSISTENCYCHECKS             VARCHAR (4000),
    RELEVANCEEQUATION             VARCHAR (1000),
    CODINGINSTRUCTIONS            VARCHAR (4000),
    QUESTIONCARDINALITY           VARCHAR (1000),
    ANSWERCARDINALITY             VARCHAR (1000),
    ANSWERLISTIDOVERRIDE          VARCHAR (1000),
    ANSWERLISTTYPEOVERRIDE        VARCHAR (1000),
    EXTERNAL_COPYRIGHT_NOTICE     VARCHAR (4000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_CLASS;
CREATE TABLE SOURCES.LOINC_CLASS
(
  CONCEPT_ID        INT,
  CONCEPT_NAME      VARCHAR(256),
  DOMAIN_ID         VARCHAR(200),
  VOCABULARY_ID     VARCHAR(20),
  CONCEPT_CLASS_ID  VARCHAR(20),
  STANDARD_CONCEPT  VARCHAR(1),
  CONCEPT_CODE      VARCHAR(40),
  VALID_START_DATE  DATE,
  VALID_END_DATE    DATE,
  INVALID_REASON    VARCHAR(1)
);

DROP TABLE IF EXISTS SOURCES.CPT_MRSMAP;
CREATE TABLE SOURCES.CPT_MRSMAP
(
  MAPSETCUI  CHAR(8),
  MAPSETSAB  VARCHAR(40),
  MAPID      VARCHAR(50),
  MAPSID     VARCHAR(50),
  FROMEXPR   VARCHAR(4000),
  FROMTYPE   VARCHAR(50),
  REL        VARCHAR(4),
  RELA       VARCHAR(100),
  TOEXPR     VARCHAR(4000),
  TOTYPE     VARCHAR(50),
  CVF        INT,
  FILLER     INT
);

DROP TABLE IF EXISTS SOURCES.SCCCREFSET_EXPRESSIONASSOCIATION_INT;
CREATE TABLE SOURCES.SCCCREFSET_EXPRESSIONASSOCIATION_INT
(
   ID                      VARCHAR (256) NOT NULL,
   EFFECTIVETIME           VARCHAR (256) NOT NULL,
   ACTIVE                  INT4 NOT NULL,
   MODULEID                INT4,
   REFSETID                INT4,
   REFERENCEDCOMPONENTID   VARCHAR (256) NOT NULL,
   MAPTARGET               VARCHAR (256) NOT NULL,
   EXPRESSION              VARCHAR (256),
   DEFINITIONSTATUSID      VARCHAR (256),
   CORRELATIONID           VARCHAR (256),
   CONTENTORIGINID         VARCHAR (256)
);

DROP TABLE IF EXISTS SOURCES.SCCCREFSET_MAPCORRORFULL_INT;
CREATE TABLE SOURCES.SCCCREFSET_MAPCORRORFULL_INT
(
   ID                      VARCHAR (256) NOT NULL,
   EFFECTIVETIME           VARCHAR (256) NOT NULL,
   ACTIVE                  INT4 NOT NULL,
   MODULEID                INT4,
   REFSETID                INT4,
   REFERENCEDCOMPONENTID   VARCHAR (256) NOT NULL,
   MAPTARGET               VARCHAR (256) NOT NULL,
   ATTRIBUTEID             VARCHAR (256),
   CORRELATIONID           VARCHAR (256),
   CONTENTORIGINID         VARCHAR (256)
);

DROP TABLE IF EXISTS SOURCES.LOINC_HIERARCHY;
CREATE TABLE SOURCES.LOINC_HIERARCHY
(
  PATH_TO_ROOT      VARCHAR(256),
  SEQUENCE          VARCHAR(256),
  IMMEDIATE_PARENT  VARCHAR(256),
  CODE              VARCHAR(256),
  CODE_TEXT         VARCHAR(256)
);

DROP TABLE IF EXISTS SOURCES.LOINC_ANSWERSLIST;
CREATE TABLE SOURCES.LOINC_ANSWERSLIST
(
  ANSWERLISTID                     VARCHAR(1000),
  ANSWERLISTNAME                   VARCHAR(1000),
  ANSWERLISTOID                    VARCHAR(1000),
  EXTDEFINEDYN                     VARCHAR(1000),
  EXTDEFINEDANSWERLISTCODESYSTEM   VARCHAR(1000),
  EXTDEFINEDANSWERLISTLINK         VARCHAR(1000),
  ANSWERSTRINGID                   VARCHAR(1000),
  LOCALANSWERCODE                  VARCHAR(1000),
  LOCALANSWERCODESYSTEM            VARCHAR(1000),
  SEQUENCENUMBER                   VARCHAR(1000),
  DISPLAYTEXT                      VARCHAR(1000),
  EXTCODEID                        VARCHAR(1000),
  EXTCODEDISPLAYNAME               VARCHAR(1000),
  EXTCODESYSTEM                    VARCHAR(1000),
  EXTCODESYSTEMVERSION             VARCHAR(1000),
  EXTCODESYSTEMCOPYRIGHTNOTICE     VARCHAR(4000),
  SUBSEQUENTTEXTPROMPT             VARCHAR(1000),
  DESCRIPTION                      VARCHAR(1000),
  SCORE                            VARCHAR(1000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_ANSWERSLISTLINK;
CREATE TABLE SOURCES.LOINC_ANSWERSLISTLINK
(
  LOINCNUMBER         VARCHAR(1000),
  LONGCOMMONNAME      VARCHAR(1000),
  ANSWERLISTID        VARCHAR(1000),
  ANSWERLISTNAME      VARCHAR(1000),
  ANSWERLISTLINKTYPE  VARCHAR(1000),
  APPLICABLECONTEXT   VARCHAR(1000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_DOCUMENTONTOLOGY;
CREATE TABLE SOURCES.LOINC_DOCUMENTONTOLOGY
(
  LOINCNUMBER         VARCHAR(1000),
  PARTNUMBER          VARCHAR(1000),
  PARTTYPENAME        VARCHAR(1000),
  PARTSEQUENCEORDER   INT4,
  PARTNAME            VARCHAR(1000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_GROUP;
CREATE TABLE SOURCES.LOINC_GROUP
(
  PARENTGROUPID         VARCHAR(10),
  GROUPID               VARCHAR(10),
  LGROUP                VARCHAR(1000),
  ARCHETYPE             VARCHAR(10),
  STATUS                VARCHAR(100),
  VERSIONFIRSTRELEASED  VARCHAR(100)
);

DROP TABLE IF EXISTS SOURCES.LOINC_PARENTGROUPATTRIBUTES;
CREATE TABLE SOURCES.LOINC_PARENTGROUPATTRIBUTES
(
  PARENTGROUPID         VARCHAR(10),
  LTYPE                 VARCHAR(100),
  LVALUE                VARCHAR(4000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_GROUPLOINCTERMS;
CREATE TABLE SOURCES.LOINC_GROUPLOINCTERMS
(
  CATEGORY              VARCHAR(1000),
  GROUPID               VARCHAR(10),
  ARCHETYPE             VARCHAR(10),
  LOINCNUMBER           VARCHAR(10),
  LONGCOMMONNAME        VARCHAR(1000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_PARTLINK;
CREATE TABLE SOURCES.LOINC_PARTLINK
(
  LOINCNUMBER           VARCHAR(10),
  LONGCOMMONNAME        VARCHAR(1000),
  PARTNUMBER            VARCHAR(1000),
  PARTNAME              VARCHAR(1000),
  PARTCODESYSTEM        VARCHAR(1000),
  PARTTYPENAME          VARCHAR(1000),
  LINKTYPENAME          VARCHAR(1000),
  PROPERTY              VARCHAR(1000)
);

DROP TABLE IF EXISTS SOURCES.LOINC_PART;
CREATE TABLE SOURCES.LOINC_PART
(
  PARTNUMBER            VARCHAR(1000),
  PARTTYPENAME          VARCHAR(1000),
  PARTNAME              VARCHAR(1000),
  PARTDISPLAYNAME       VARCHAR(1000),
  STATUS                VARCHAR(100)
);

DROP TABLE IF EXISTS SOURCES.LOINC_RADIOLOGY;
CREATE TABLE SOURCES.LOINC_RADIOLOGY
(
  LOINCNUMBER           VARCHAR(10),
  LONGCOMMONNAME        VARCHAR(1000),
  PARTNUMBER            VARCHAR(1000),
  PARTTYPENAME          VARCHAR(1000),
  PARTNAME              VARCHAR(1000),
  PARTSEQUENCEORDER     VARCHAR(1000),
  RID                   VARCHAR(1000),
  PREFERREDNAME         VARCHAR(1000),
  RPID                  VARCHAR(1000),
  LONGNAME              VARCHAR(1000)
);

CREATE OR REPLACE FUNCTION vocabulary_pack.GetLoincPrerelease ()
RETURNS TABLE (
  created_on date,
  loinc text,
  long_common_name text
) AS
$body$
BEGIN
  set local search_path to devv5;
  perform http_set_curlopt('CURLOPT_TIMEOUT', '30');
  set local http.timeout_msec to 30000;
  return query 
  select s0.created_on, s0.loinc, s0.long_common_name from (
    with loinc_table as (
        select replace(replace(substring(content,'<table id="prereleasetable".*?(<tbody>.*</tbody>)'),'&','&amp;'),' <= ',' &lt;= ')::xml xmlfield from devv5.http_get('https://loinc.org/prerelease')
    )
    select
      to_date((xpath('./td/text()',sections))[1]::text,'yyyy-mm-dd') as created_on,
      unnest(xpath('./td/a/text()',sections))::text as loinc,
      devv5.py_unescape((xpath('./td/text()',sections))[2]::text) as long_common_name,
      unnest(xpath('./td/i/@title',sections))::text as special_use
    from loinc_table i,
    unnest(xpath('/tbody/tr', i.xmlfield)) sections
  ) as s0 where s0.special_use is not null;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY DEFINER
COST 100 ROWS 100;