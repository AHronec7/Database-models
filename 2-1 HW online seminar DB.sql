USE master 
 IF (SELECT COUNT(*) FROM sys.sysdatabases WHERE NAME = 'OnlineSeminar') > 0
 BEGIN
	DROP DATABASE [OnlineSeminar]
END

	CREATE DATABASE [OnlineSeminar]
GO

USE [onlineSeminar]
GO




--------create table statements----------



--created a new table "pricing"
CREATE TABLE pricing
(
	planID     INT         not null IDENTITY(1,1),
	plantype    VARCHAR(20) not null,
	planprice   MONEY       not null,
	PRIMARY KEY (planID)

)


CREATE TABLE Subscriptions
(
	subscriptionID    INT         not null IDENTITY (1,1),
	subscriptiontype  VARCHAR(25) not null,
	stillactive       BIT         not null,
	subscriptionprice SMALLMONEY  not null,
	joineddate        DATETIME    not null,
	PRIMARY KEY       (subscriptionID)
)



	


CREATE TABLE Members
(
	memberID		 INT		   not null,
	firstname		 VARCHAR(30)   not null,
	middlename		 VARCHAR(30)   not null,
	lastname		 VARCHAR(30)   not null,
	gender			 VARCHAR(8)    not null,
	currentflag		 BIT           null,
	birthdate		 DATETIME      not null,
	subscriptionID   INT		   not null,
	planID           INT           not null,
	PRIMARY   KEY    (memberID),
	CONSTRAINT fk_subcriptionID  FOREIGN KEY (subscriptionID) REFERENCES Subscriptions (subscriptionID),
	CONSTRAINT fk_planID    FOREIGN KEY  (planID) REFERENCES pricing (planID)
)
	





CREATE TABLE Memberinterests
(
	memberinterestID    INT         not null IDENTITY (1,1),
	memberID            INT         not null,
	interest1           VARCHAR(30) null,
	interest2           VARCHAR(30) null,
	interest3           VARCHAR(30) null,
	PRIMARY KEY    (memberinterestID),
	CONSTRAINT fk_memberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)





CREATE TABLE [Address]
(
	addressID         INT            not null IDENTITY(1,1),
	memberID          INT            not null,
	addressline1      VARCHAR(30)    not null,
	addressline2      VARCHAR(30)    null,
	city              VARCHAR(30)    not null,
	[state]           VARCHAR(25)    not null,
	zipcode           VARCHAR(8)     not null,
	PRIMARY KEY       (addressID),
	CONSTRAINT fk_address_memberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)






CREATE TABLE Contactinfo
(
	contactID     INT		   not null IDENTITY(1,1),
	memberID      INT		   not null,
	email         VARCHAR(40)  not null,
	phonenumber   VARCHAR(12)  not null,
	PRIMARY KEY   (contactID),
	CONSTRAINT fk_contact_memberID  FOREIGN KEY (memberID) REFERENCES Members (memberID)
)



--created a new table "passwords"
CREATE TABLE Passwords
(
	passwordID		    INT		     not null IDENTITY(1,1),
	memberID			INT		     not null,
	[password]          VARCHAR(80)  not null,
	passwordchangedate  DATETIME     not null,
	PRIMARY KEY         (passwordID),
	CONSTRAINT fk_password_member FOREIGN KEY (memberID) REFERENCES Members (memberID)
)







CREATE TABLE [events]
(
	eventID      INT         not null IDENTITY(1,1),
	eventtitle   VARCHAR(35) not null,
	eventspeaker VARCHAR(20) not null,
	eventdate    DATETIME    not null,
	PRIMARY KEY  (eventID)
)







CREATE TABLE Eventmembers
(
	memberID     INT        not null,
	eventID      INT        not null,
	attendance   BIT        not null,
	PRIMARY KEY (memberID, eventID),  -------creates a composite primary key
	CONSTRAINT  fk_eventmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID),
	CONSTRAINT  fk_eventmemberevent FOREIGN KEY (eventID) REFERENCES [Events] (eventID)
	
) 





CREATE TABLE transactions
(   
	transID          INT	    not null IDENTITY(1,1),
	memberID         INT		not null,
	transactiondate  DATETIME   not null,
	charges          SMALLMONEY not null,
	approved         BIT       null,
	PRIMARY KEY     (transID),
	CONSTRAINT fk_transmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)






CREATE TABLE paymentinfo
(
	creditcardID     INT        not null IDENTITY (1,1),
	transID          INT        not null,
	memberID         INT        not null,
	cardtype       VARCHAR(20)  not null,
	cardnumber     VARCHAR(50)  not null,
	expdate        DATETIME    not null,
	PRIMARY KEY   (creditcardID),
	CONSTRAINT  fk_transID FOREIGN KEY (transID) REFERENCES transactions (transID),
	CONSTRAINT fk_paymentmemberID FOREIGN KEY (memberID) REFERENCES Members (memberID)
)







--------Inserts-------------

---insert into pricing
INSERT INTO pricing
			( plantype, planprice)
VALUES      (' 2 year', '189.00'),
			('1 year', '99.00'),
			('Quarterly', '27.00'),
			('Monthly', '9.99'),
			('Free',    '0.00')




 ----subscription insert

 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '4-7-2017')
 ------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '11-29-2017')
 ----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '2-26-2017')
----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '11-5-2017')
----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '1-15-2016')
-------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '3-13-2017')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '8-9-2017')
-----------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '9-9-2016')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '0', '11-21-2016')
--------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '12-22-2017')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '3-19-2017')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('quarterly', '$27.00', '1', '4-25-2016')
------------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('yearly', '$99.00', '1', '3-21-2016')
-----------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '1', '1-27-2017')
---------------------------------------------------------------------------
 INSERT INTO Subscriptions
			(subscriptiontype, subscriptionprice, stillactive, joineddate)
VALUES      ('monthly', '$9.99', '0', '10-6-2017')





--insert into members

INSERT INTO members
			(memberID, firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (1,'otis', 'Brooke', 'Fallon', 'Male', '6-29-1971', '1', 1, '4')

------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (2,'katee', 'Virgie', 'Gepp', 'Female', '4-3-1972', '1', 2, '4')

---------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (3,'Lilla', 'Charmion', 'Eattok', 'female', '12-13-1975', '1', 3, '3')

------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (4,'Ddene', 'Shelba', 'Clapperton', 'female', '2-19-1997', '1', 4, '3')
----------------------------------------------------------------------------------------------

INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (5,'Audrye', 'Agathe', 'Dawks', 'female', '2-7-1989', '1', 5, '4')

--------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (6,'Fredi', 'Melisandra', 'Burgyn', 'female', '5-31-1956', '1', 6, '2')

-----------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (7,'Dimitri', 'Francisco', 'Bellino', 'Male', '10-12-1976', '1', 7, '4')

-------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (8,'Enrico', 'Cleve', 'Seeney', 'Male', '2-29-1988', '1', 8, '2')

----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (9,'Marylinda', 'Jennie', 'Osiaghail', 'female', '2-6-1965', '0', 9, '4')

----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (10,'Luce', 'Codi', 'Kovalksi', 'Male', '3-31-1978', '1', 10, '4')

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (11,'Claiborn', 'Shadow', 'Baldinotti', 'Male', '12-26-1991', '1', 11, '4')

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (12,'Isabelle', 'Betty', 'Glossop', 'female', '2-17-1965', '1', 12, '3')

-----------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (13,'Davina', 'Lira', 'Wither', 'female', '12-16-1957', '1', 13, '2')

------------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (14,'Panchito', 'Hashim', 'DeGregorio', 'Male', '10-14-1964', '1', 14, '4')

-------------------------------------------------------------------------------------------------
INSERT INTO members
			(memberID,firstname, middlename, lastname, gender, birthdate, currentflag, subscriptionID, planID)
VALUES      (15,'Rowen', 'Arvin', 'Birdfield', 'Male', '1-9-1983', '0', 15, '4')





--insert into memberinterests

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (1, 'acting', 'video games', 'crossword puzzles')

-----------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (2, 'caligraphy', NULL, NULL)

--------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (3, 'movies', 'restaurants', 'woodworking')

--------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (4, 'juggling', 'quilting', NULL)

---------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (5, 'electronics', NULL, NULL)

--------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (6, 'sewing', 'cooking', 'movies')

------------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (7, 'botany', 'skating', NULL)
-----------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (8, 'dancing', 'coffee', 'foreign laungauges')
------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (9, 'fashion',NULL, NULL)
---------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (10, 'woodworking', NULL, NULL)
--------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (11, 'homebrewing', 'genelology', 'movies, scapbooking')

-------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (12, 'surfing', 'amateur radio',NULL)

------------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (13, 'computers',NULL, NULL)
--------------------------------------------------------------------

INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (14, 'writing', 'singing',NULL)

-----------------------------------------------------------------
INSERT INTO memberinterests
			( memberiD, interest1, interest2, interest3)
VALUES      (15, 'reading', 'pottery', NULL)




--insert into address

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(1,  '020 New Castle Way', NULL, 'Port Washington', 'New York', '11054')
----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(2,  '8 Corry Parkway', 'PO Box 7088', 'Newton', 'Massachusetts', '2458')
-----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(3,  '39426 Stone Corner Drive', NULL, 'Peoria', 'illinois', '61605')
-----------------------------------------------------------------------------------------

INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(4,  '921 Granby Junction', NULL, 'Oklahoma city', 'Oklahoma', '73173')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(5,  '77 Butternut Drive', NULL, 'Saint Paul', 'Minnesota', '55146')

-----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(6,  '821 Ilene Drvie', NULL, 'Odessa', 'Texas', '79764')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(7,  '1110 Johnson Court', NULL, 'Rochester', 'New York', '14624')

-----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(8,  '6 Canary Hill', 'PO Box 225', 'Tallahassee', 'Florida', '32309')

------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(9,  '9 Buhler Lane', NULL, 'Bismarck', 'North Dakota', '58505')

---------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(10,  '99 Northwestern Pass', NULL, 'Midland', 'Texas', '79710')

----------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(11,  '69 Spenser Hill', NULL, 'Provo', 'Utah', '84605')


--------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(12,  '3234 Kings Court', 'PO Box 1233', 'Tacoma', 'Washington', '98424')

-------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(13,  '3 Lakewood Gardens Circle', NULL, 'Columbia', 'South Carolina', '29225')

------------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(14,  '198 Muir Parkway', NULL, 'Fairfax', 'Virginia', '22036')

---------------------------------------------------------------------------------------------
INSERT INTO [Address]
			(memberID, addressline1, addressline2, city, [state], zipcode)
VALUES		(15,  '258 Jenna Drive', NULL, 'Pensacola', 'Florida', '32520')




--insert into contactinfo

INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (1,     'bfallon@artisteer.com', '818-873-3863')
---------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (2,     'vgepp1@nih.gov', '503-689-8066')
-------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (3,     'ceatttok2@google.com', '210-426-7426')
---------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (4,     'sclapperton3@mapquest.com', '716-674-1640')
-------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (5,     'adawks4@mlb.com', '305-415-9419')
----------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (6,     'mburgyn5@cbslocal.com', '214-650-9837')
-------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (7,     'fbellino6@devhub.com', '937-971-1026')
----------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (8,     'cseeney7@macromedia.com', '407-445-6895')
------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (9,     'josiaghail8@tuttocitta.it', '206-484-6850')
--------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (10,     'ckovalski9@facebook.com', '253-159-6773')
----------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (11,     'sbaldinottia@discuz.net', '253-141-4314')
------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (12,     'bglossopb@msu.edu', '412-646-5145')
--------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (13,     'lwitherc@smugmug.com', '404-495-3676')
------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (14,     'hdegregoriod2a8.net', '484-717-6750')
------------------------------------------------------------------------------
INSERT INTO Contactinfo
			(memberID, email, phonenumber)
VALUES      (15,     'abirdfielde@over-blog.com', '915-299-3451')





----insert into password----
INSERT INTO Passwords
			(memberID, [password], passwordchangedate)
VALUES      (1,     'RTES',		'2/15/2018'),
			(2,     'REKSK',    '2/23/2018'),
			(3,     'B6184',    '2/28/2018'),
			(4,     'AB1D957',  '3/3/2018'),
			(5,     '9BE6BC1',  '3/12/2018'),
			(6,     '4F01B7',   '3/15/2018'),
			(7,     'B7CB98',   '3/28/2018'),
			(8,     '204E60',   '4/1/2018'),
			(9,     'CA90C2',   '4/8/2018'),
			(10,    'D8946C511D8','4/15/2018'),
			(11,     'A37FF2CF','4/20/2018'),
			(12,     'FASSSRT', '5/15/2018'),
			(13,     'RTSR8',   '5/30/2018'),
			(14,     'FIOPP5',  '2/15/2018'),
			(15,     'VBESR5',  '2/15/2018')




--insert into events

INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('The History Of Human Emotions', 'Tiffany Watt Smith', '1-12-2017')
------------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('How Great Leaders Inspire Actions', 'Simon Sinek', '2-22-2017')
---------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('The Puzzle of Motivation', 'Dan Pink', '3-5-2017')
-----------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('Your Elusive Creative Genius', 'Elizabeth Gilbert', '4-16-2017')
---------------------------------------------------------------------------------
INSERT INTO [Events]
			(eventtitle, eventspeaker, eventdate)
VALUES      ('Why Are Programmers So Smart?', 'Andrew Comeau', '5-1-2017')



--insert into eventmembers



INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    1,     0)

-----------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    2,     0)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    3,     1)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    4,     1)

-------------------------------------------------------------------------


INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (1,    5,     1)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    1,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    2,     0)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    3,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    4,     1)


-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (2,    5,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    1,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    2,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    3,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    4,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (3,    5,     1)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    1,     1)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    2,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    3,     1)


-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    4,     1)

----------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (4,    5,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    1,     1)

------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    2,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    3,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    4,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (5,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    1,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    2,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    3,     1)


----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    4,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (6,    5,     0)


----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    1,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    2,     1)
-------------------------------------------------------------------------------



INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    3,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    4,     1)
--------------------------------------------------------------------------------


INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (7,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    1,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    2,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    3,     1)

--------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    4,     1)

-----------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (8,    5,     0)

------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    1,     0)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    2,     1)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    3,     1)

---------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    4,     1)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (9,    5,     0)

-------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    1,     1)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    2,     1)

--------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    3,     0)

-----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    4,     0)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (10,    5,     0)

-----------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    1,     1)

-------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    2,     1)

---------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    3,     0)

-------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    4,     0)

--------------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (11,    5,     0)

------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    1,     1)
------------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    2,     0)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    3,     1)

-------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    4,     1)

----------------------------------------------------------------------------

INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (12,    5,     1)

-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    1,     1)

-----------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    2,     1)

---------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    3,     0)

----------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    4,     0)

------------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (13,    5,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    1,     0)
-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    2,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    3,     1)

---------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    4,     1)

-------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (14,    5,     0)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    1,     1)

-----------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    2,     1)

--------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,   3,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    4,     1)

------------------------------------------------------------------------------
INSERT INTO eventmembers
			(memberID, eventID, attendance)
VALUES      (15,    5,     0)
------------------------------------------------------------------------------









--insert into transactions

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2016', '$9.99', '1')
-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '2/15/2016', '$9.99', '1')
-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '3/15/2016', '$9.99', '1')
-----------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(13,     '3/21/2016', '$99.00', '1')
----------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '4/15/2016', '$9.99', '1')
----------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(13,     '4/21/2016', '$99.00', '1')

--------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '4/25/2016', '$27.00', '1')

---------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '5/15/2016', '$9.99', '1')

------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '6/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '7/15/2016', '$9.99', '1')

--------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2016', '$9.99', '1')

--------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '7/25/2016', '$27.00', '1')
-----------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '8/15/2016', '$9.99', '1')

---------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(8,     '9/9/2016', '$99.00', '1')

-----------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '9/15/2016', '$9.99', '1')

------------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '10/15/2016', '$9.99', '1')

------------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '10/25/2016', '$27.00', '1')

-----------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '11/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(9,     '11/21/2016', '$99.00', '1')
--------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '12/15/2016', '$9.99', '1')

-------------------------------------------------------------------------------------------



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2017', '$9.99', '1')
-------------------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '1/25/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '1/27/2017', '$9.99', '1')
---------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '2/15/2017', '$9.99', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '2/26/2017', '$27.00', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '2/27/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(6,     '3/13/2017', '$99.00', '1')
----------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '3/15/2017', '$9.99', '1')
------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '3/19/2017', '$9.99', '1')

---------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '3/27/2017', '$9.99', '1')
-------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '4/7/2017', '$9.99', '1')

-------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '4/15/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '4/19/2017', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '4/25/2017', '$27.00', '1')
----------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '4/27/2017', '$9.99', '1')

-----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '5/7/2017', '$9.99', '1')


---------------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '5/15/2017', '$9.99', '1')

----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '5/19/2017', '$9.99', '1')
-------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '5/26/2017', '$27.00', '1')

---------------------------------------------------------------------------



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '5/27/2017', '$9.99', '1')
-------------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '6/7/2017', '$9.99', '0')

---------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '6/8/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '6/15/2017', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '6/19/2017', '$9.99', '1')
----------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '6/27/2017', '$9.99', '1')

------------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '7/7/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '7/15/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '7/19/2017', '$9.99', '0')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '7/20/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '7/25/2017', '$27.00', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '7/27/2017', '$9.99', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '8/7/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '8/9/2017', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '8/15/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '8/19/2017', '$9.99', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '8/26/2017', '$27.00', '1')

-----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '8/27/2017', '$9.99', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '9/9/2017', '$9.99', '1')

----------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(8,     '9/9/2017', '$99.00', '1')

------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '9/15/2017', '$9.99', '1')
------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '9/19/2017', '$9.99', '1')
---------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '9/27/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(15,     '10/6/2017', '$9.99', '0')


-----------------------------------------------------------------
INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '10/7/2017', '$9.99', '1')

---------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '10/9/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5  ,   '10/15/2017', '$9.99', '1')
-------------------------------------------------------------------


INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '10/19/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '10/25/2017', '$27.00', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '10/27/2017', '$9.99', '1')

-----------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(4,     '11/5/2017', '$27.00', '1')

------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '11/7/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '11/9/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '11/15/2017', '$9.99', '1')

-------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '11/19/2017', '$9.99', '1')

-----------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '11/26/2017', '$27.00', '1')

----------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(3,     '11/27/2017', '$27.00', '1')

-------------------------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '11/27/2017', '$9.99', '1')

--------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(2,     '11/29/2017', '$9.99', '1')

------------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '12/7/2017', '$9.99', '1')

-------------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '12/9/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '12/15/2017', '$9.99', '1')

---------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '12/19/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(10,     '12/22/2017', '$9.99', '1')

--------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14  ,   '12/27/2017', '$9.99', '1')

-------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(2,     '12/29/2017', '$9.99', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(1,     '1/7/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(7,     '1/9/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(5,     '1/15/2018', '$9.99', '1')

------------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(11,     '1/19/2018', '$9.99', '1')

----------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(10,     '1/22/2018', '$9.99', '1')



INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(12,     '1/25/2018', '$27.00', '1')

--------------------------------------------------------------------

INSERT INTO transactions
			(memberID, transactiondate, charges, approved)  
VALUES		(14,     '1/27/2018', '$9.99', '1')





--insert into payment info

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES      ('1'  , '1',      'Discover', '337941553240515', '9/1/2019')
----------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('2',   '2',     'americanexpress', '4041372553875903', '1/1/2020')
----------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('3',   '3',     'Visa', '4041593962566', '3/1/2019')

----------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('4',   '4',     'americanexpress', '3571066026049076', '4/1/2019')

--------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)

VALUES		('5',   '5',     'Giftcard', '30423652701879', '6/1/2018')

------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('6',   '6',     'Visa', '3532950215393858', '5/1/2018')
----------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('7',   '7',     'americanexpress', '337941553240515', '2/1/2019')
-------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('8',   '8',     'American Express', '3569709859937370', '3/1/2019')

-----------------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('9',   '9',     'americanexpress', '3529188090740670', '5/1/2019')
---------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('10',   '10',     'Discover', '3530142576111598', '11/1/2019')
------------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('11',   '11',     'Mastercard', '5108756299877313', '7/1/2018')
---------------------------------------------------------------------------------

INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate) 
VALUES		('12',   '12',     'americanexpress', '3543168150106220', '6/1/2018')

--------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('13',   '13',     'Mastercard', '3559166521684728', '10/1/2019')

-------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('14',   '14',     'Mastercard', '30414677064054', '6/1/2018')

-------------------------------------------------------------------------
INSERT INTO paymentinfo
			(transID, memberID, cardtype, cardnumber, expdate)
VALUES		('15',   '15',     'jcb', '35428280939385763', '3/1/2020')
GO



--------complete contact view
GO
CREATE VIEW viewcontactlist
AS
	SELECT m.firstname, m.lastname, a.addressline1, a.addressline2, a.city, a.[state], a.zipcode,
		   ci.email, ci.phonenumber
	FROM   Members m
	JOIN   Address a
	ON     m.memberID = a.memberID
	JOIN   Contactinfo ci
	ON     a.memberID = ci.memberID
GO

--select * from viewcontactlist

--If someone would frequently need to look up or see everyones complete address and contact
--info, if the entire address and contact info was always having to be retrieved, Its just 
--a select statements with some joins put into a "virtual table"
-- I inner joined on Members and address to get member names with their addresses.
--next, I inner joined on contactinfo to return their emails and phonenumbers as well.






--------------view on all emails
CREATE VIEW viewemail
AS
	SELECT m.firstname, m.lastname, ci.email
	FROM   members m
	JOIN   Contactinfo ci
	ON     ci.memberID = m.memberID

	--select * from viewemail

----If someone wanted to see the complete contact info for each member and see those 
----records, if you have to retreive a lot with this data, a view is a shortcut. I
----inner joined on contact info to get all members and their contact information.



-------------stored procedure on current month birthdays
GO
CREATE FUNCTION fn_birthday
(
	@birthdaymonth  DATETIME
)
	RETURNS TABLE
AS
	RETURN
	SELECT  firstname AS [firstname], birthdate AS [month of birth]
	FROM    Members
	WHERE   month(birthdate) = @birthdaymonth
GO	
	--select * FROM [fn_birthday] (2)
	--select * FROM [fn_birthday] (10)
	--It wanted to see a list of members who were celebrating their birthday during
	--a month, I created a function that instead of a scalar value function, its a
	--table value function. I passed a paramater of @birthday month in, then I returned
	--a table that selected the names. Then I set the birthdate equal to my paramater.




----------expired credit cards view 

CREATE VIEW viewexpcreditcards
AS
	SELECT expdate, memberID FROM paymentinfo 
	WHERE  expdate >= getdate()
GO

--select expdate from viewexpcreditcards

----A view that Shows all the expired credit cards, I used a getdate() function
----to show that the expdate must be greater then the getdate or the card is expired
----already, looks like there are no expired cards.









-------monthly income for a given time frame--------
CREATE PROCEDURE proc_monthlyincome

	@startdate  DATETIME,
	@enddate    DATETIME

AS

	SELECT SUM(charges)
	FROM   transactions
	WHERE  transactiondate BETWEEN @startdate AND @enddate AND approved <> 0  
	
	

	--EXEC proc_monthlyincome '2017-01-01', '2018-01-01'
	--I used a procedure to see the given income per month over specified dates, As a similar 
	--method as the first one, I used my paramaters of start and end date. I specified in my 
	--WHERE clause that the transaction date is between whatever dates that I specify. Returns 
	--a result for whatever Dates I put in.










------ new member sign up over a time frame
GO
 CREATE PROCEDURE proc_newmember
 (
	 @startdate  DATETIME,
	 @enddate    DATETIME 
)
AS
BEGIN
	SELECT COUNT(m.memberID) AS ' NewMembers' , CONCAT(DATENAME(MONTH,(MAX(s.joineddate))), ' ',DATEPART(YEAR, s.joineddate))
												 AS 'Month joined'
	FROM   Members m
	JOIN   Subscriptions s 
	ON     m.subscriptionID = s.subscriptionID
	WHERE  s.joineddate BETWEEN @startdate AND @enddate
	GROUP BY  DATEPART(MONTH,(s.joineddate)), DATEPART(YEAR,(s.joineddate)) 
END
--EXEC proc_newmember '1/1/17', '1/1/18'
--EXEC proc_newmember '4/25/16', '3/13/17'
--EXEC proc_newmember '3/13/17', '1/1/18'

-- It wanted any new members who joined per month between any given dates, I created
--a procedure that counted the members for each month between any two given dates
--I specify. I used paramaters of startdate and enddate. I selected Then I joined on the 
--subscriptions table to get the joineddate and I specified the joineddate
--being between my two paramaters in my WHERE clause. Then I did the DATENAME function,
--which will return a name representation of DATEPART, then I did the MONTH
--I then specified DATEPART and YEAR to return the year as well. I added a CONCAT as well
--so the month and the year are returned in the same column.











------attendance over a time period
GO 
	CREATE PROCEDURE proc_attendance
	(
		@eventstartdate DATETIME,
		@eventenddate   DATETIME
	)
	AS
	
		SELECT count(em.memberID), MAX(e.eventtitle), e.eventdate
		FROM   Eventmembers em
		JOIN   events e
		ON     em.eventID = e.eventID
		WHERE  e.eventdate BETWEEN @eventstartdate AND @eventenddate AND em.attendance <> 0
		GROUP BY DATEPART(MONTH, e.eventdate), e.eventdate
		
		--EXEC proc_attendance '2017-01-01', '2018-01-01'
		-- EXEC proc_attendance '4/25/16', '3/13/17'

		--The procedure counts the memberID for each event and It gets the attendacne for each
		--member at each event. I innerjoined on eventmembers and events. I specified that the eventdate
		--be between my paramaters of what I specify, then I specified where the attendance is not 0
		









--creating a view on pricing
GO
CREATE VIEW viewpasswords
AS
	SELECT [passwordID], HASHBYTES('MD5', [password]) AS [passsword] FROM Passwords


	--select * from viewpasswords

	--HASHBYTES converts the text value passwords to a string so the password is more secure
	--that way, every password is converted to a hash










-----secure storage of passwords
GO
CREATE PROCEDURE proc_securepassword
(
	@passwordID     INT ,  
	@memberID       INT ,  
	@password      VARCHAR(50), 
	@passwordchangedate DATE , 
	@responsemessage  NVARCHAR(100) OUTPUT 
)
AS
BEGIN

	SET NOCOUNT ON

BEGIN TRY

	INSERT INTO passwords 
				(passwordID, memberID, password, passwordchangedate)
VALUES			(@passwordID, @memberID, HASHBYTES('MD5', @password), @passwordchangedate)

	SET @responsemessage = 'success'


END TRY
BEGIN CATCH
	SET @responsemessage = ERROR_MESSAGE()
END CATCH 
END




--This creates a secure storage of passwords and I took my variables and inserted them into the
--passwords table as values
GO
DECLARE @responsemessage VARCHAR(250)

EXEC proc_securepassword
	 @passwordID = '2',
	 @memberID   = '2',
	 @password   = 'REKSK',
	 @passwordchangedate ='2018-02-23',
	 @responsemessage = @responsemessage OUTPUT
GO

	 --This makes the password secure so it makes it difficult to encrypt and to cypher the 
	 --password



DECLARE @responsemessage VARCHAR(250)
 ----Correct Login

 EXEC proc_securepassword
	  @passwordID = '2',
	  @memberID   = '2',
	  @password   = 'REKSK',
	  @passwordchangedate = '2018-02-23',
	  @responsemessage = @responsemessage OUTPUT
GO



	








---view to determine the last time a password was changed
GO
CREATE VIEW passview
AS
	SELECT CONCAT(m.firstname, ',', m.lastname) AS 'members', p.passwordchangedate
	FROM         Passwords p
	JOIN         Members m
	ON           p.memberID = m.memberID
GO


--select * from passview

--This is a view that shows the member and the last time that they changed their password,
--I joined on members from passwords on the memberID








