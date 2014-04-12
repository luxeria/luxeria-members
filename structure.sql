PRAGMA foreign_keys = ON;

CREATE TABLE Member (
    memberid     INTEGER PRIMARY KEY,       -- numerical member number
    lastname     VARCHAR(255) NOT NULL,
    firstname    VARCHAR(255) NOT NULL,
    nickname     VARCHAR(255),
    birthday     DATE,
    status       VARCHAR(255),
    function     VARCHAR(255),

    CHECK (status in ('Member', 'Junior'))
);

CREATE TABLE Address (
    memberid    INTEGER REFERENCES Member(memberid),
    address     VARCHAR(255) NOT NULL,
    zipcode     CHAR(10)     NOT NULL,      -- can be international
    city        VARCHAR(255) NOT NULL,
    isprimary   TINYINT(1)   NOT NULL DEFAULT 1,

    CHECK (isprimary in (0, 1))
);

CREATE TABLE Phone (
    memberid    INTEGER REFERENCES Member(memberid),
    phonenr     VARCHAR(255) PRIMARY KEY,
    type        CHAR(1)      NOT NULL,
    isprimary   TINYINT(1)   NOT NULL DEFAULT 1,

    CHECK (type in ('M', 'P', 'G')),
    CHECK (isprimary in (0, 1))
);

CREATE TABLE EMail (
    memberid    INTEGER REFERENCES Member(memberid),
    mail        VARCHAR(255) NOT NULL,
    isprimary   TINYINT(1)   NOT NULL DEFAULT 1

    CHECK (isprimary in (0, 1))
);

CREATE TABLE Website (
    memberid    INTEGER REFERENCES Member(memberid),
    website     VARCHAR(255) NOT NULL
);
