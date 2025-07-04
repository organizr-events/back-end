-- ------------------------------
-- OPTION
-- ------------------------------

OPTION IMPORT;

-- ------------------------------
-- TABLE: user
-- ------------------------------

DEFINE TABLE user TYPE NORMAL SCHEMAFULL PERMISSIONS NONE;

DEFINE FIELD email ON user TYPE string ASSERT string::is::email($value) PERMISSIONS FULL;
DEFINE FIELD password ON user TYPE string PERMISSIONS FULL;
DEFINE FIELD username ON user TYPE string ASSERT string::len($value) > 0 PERMISSIONS FULL;

DEFINE INDEX email ON user FIELDS email UNIQUE;
DEFINE INDEX username ON user FIELDS username UNIQUE;


