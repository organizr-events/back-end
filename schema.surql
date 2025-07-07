-- ------------------------------
-- OPTION
-- ------------------------------

OPTION IMPORT;

-- ------------------------------
-- ACCESSES
-- ------------------------------

DEFINE ACCESS user ON DATABASE TYPE RECORD SIGNUP (CREATE user SET username = $username, email = $email, password = $password) SIGNIN (SELECT * FROM user WHERE username = $username AND crypto::argon2::compare(password, $password)) DURATION FOR TOKEN 1h, FOR SESSION NONE;

-- ------------------------------
-- TABLE: attends
-- ------------------------------

DEFINE TABLE attends TYPE RELATION IN user OUT event SCHEMAFULL PERMISSIONS NONE;

DEFINE FIELD in ON attends TYPE record<user> PERMISSIONS FULL;
DEFINE FIELD out ON attends TYPE record<event> PERMISSIONS FULL;



-- ------------------------------
-- TABLE: event
-- ------------------------------

DEFINE TABLE event TYPE NORMAL SCHEMAFULL PERMISSIONS NONE;

DEFINE FIELD end ON event TYPE datetime DEFAULT time::now() + 1d ASSERT $value >= start PERMISSIONS FULL;
DEFINE FIELD name ON event TYPE string DEFAULT 'Event' ASSERT string::len($value) > 0 PERMISSIONS FULL;
DEFINE FIELD start ON event TYPE datetime DEFAULT time::now() ASSERT $value <= end PERMISSIONS FULL;
DEFINE FIELD wallet ON event TYPE record<wallet> DEFAULT (CREATE wallet)[0].id PERMISSIONS FULL;



-- ------------------------------
-- TABLE: user
-- ------------------------------

DEFINE TABLE user TYPE NORMAL SCHEMAFULL PERMISSIONS FOR select, create FULL, FOR update, delete WHERE id = $auth.id;

DEFINE FIELD email ON user TYPE string ASSERT string::is::email($value) PERMISSIONS FOR select, update WHERE user = $auth.id, FOR create FULL;
DEFINE FIELD password ON user TYPE string VALUE crypto::argon2::generate($value) PERMISSIONS FOR select, create NONE, FOR update WHERE user = $auth.id;
DEFINE FIELD username ON user TYPE string ASSERT string::len($value) > 0 PERMISSIONS FOR select, create FULL, FOR update WHERE user = $auth.id;

DEFINE INDEX email ON user FIELDS email UNIQUE;
DEFINE INDEX username ON user FIELDS username UNIQUE;


-- ------------------------------
-- TABLE: wallet
-- ------------------------------

DEFINE TABLE wallet TYPE NORMAL SCHEMAFULL PERMISSIONS NONE;




