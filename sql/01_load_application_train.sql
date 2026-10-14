-- 01_load_application_train.sql
-- Home Credit Default Risk: load the main application table into MySQL.
-- Before running: copy application_train.csv into the folder shown by
--   SELECT @@secure_file_priv;
-- and fix the path in the LOAD DATA line below if yours is different.

USE home_credit;

DROP TABLE IF EXISTS application_train;

CREATE TABLE application_train (
    SK_ID_CURR           INT PRIMARY KEY,   -- one row per loan application
    TARGET               TINYINT,           -- 1 = client had payment difficulties (default), 0 = did not
    NAME_CONTRACT_TYPE   VARCHAR(20),
    CODE_GENDER          VARCHAR(5),
    FLAG_OWN_CAR         CHAR(1),
    FLAG_OWN_REALTY      CHAR(1),
    CNT_CHILDREN         INT,
    AMT_INCOME_TOTAL     DECIMAL(15,2),
    AMT_CREDIT           DECIMAL(15,2),
    AMT_ANNUITY          DECIMAL(15,2) NULL,
    AMT_GOODS_PRICE      DECIMAL(15,2) NULL,
    NAME_INCOME_TYPE     VARCHAR(30),
    NAME_EDUCATION_TYPE  VARCHAR(40),
    NAME_FAMILY_STATUS   VARCHAR(30),
    NAME_HOUSING_TYPE    VARCHAR(30),
    DAYS_BIRTH           INT,               -- negative: days before application
    DAYS_EMPLOYED        INT,               -- negative; 365243 is a placeholder (see cleaning step)
    OCCUPATION_TYPE      VARCHAR(40) NULL,
    CNT_FAM_MEMBERS      DECIMAL(5,1) NULL,
    REGION_RATING_CLIENT TINYINT,
    ORGANIZATION_TYPE    VARCHAR(60),
    EXT_SOURCE_1         DOUBLE NULL,
    EXT_SOURCE_2         DOUBLE NULL,
    EXT_SOURCE_3         DOUBLE NULL
);

-- The CSV has 122 columns; we keep 24 and park the rest in @skip.
-- Blank cells become NULL (NULLIF) instead of 0 or an error.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.6/Uploads/application_train.csv'
INTO TABLE application_train
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    SK_ID_CURR, TARGET, NAME_CONTRACT_TYPE, CODE_GENDER, FLAG_OWN_CAR, FLAG_OWN_REALTY,
    CNT_CHILDREN, AMT_INCOME_TOTAL, AMT_CREDIT, @annuity, @goods, @skip,
    NAME_INCOME_TYPE, NAME_EDUCATION_TYPE, NAME_FAMILY_STATUS, NAME_HOUSING_TYPE, @skip, DAYS_BIRTH,
    DAYS_EMPLOYED, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @occ, @fam,
    REGION_RATING_CLIENT, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, ORGANIZATION_TYPE, @e1,
    @e2, @e3, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip, @skip, @skip, @skip, @skip,
    @skip, @skip
)
SET AMT_ANNUITY     = NULLIF(@annuity, ''),
    AMT_GOODS_PRICE = NULLIF(@goods, ''),
    OCCUPATION_TYPE = NULLIF(@occ, ''),
    CNT_FAM_MEMBERS = NULLIF(@fam, ''),
    EXT_SOURCE_1    = NULLIF(@e1, ''),
    EXT_SOURCE_2    = NULLIF(@e2, ''),
    EXT_SOURCE_3    = NULLIF(@e3, '');

-- Checks: expect about 307,511 rows and a default rate of about 8%
SELECT COUNT(*) AS total_rows FROM application_train;
SELECT ROUND(100 * AVG(TARGET), 2) AS default_rate_pct FROM application_train;
USE home_credit;