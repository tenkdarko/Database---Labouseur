--Functional Dependencies

--CONTACTS TABLE
PID -> First_name, Last_name, Phone_num, Address

CREATE TABLE contacts(
	Pid int not null,
	First_name char(40) not null,
	Last_name char(40) not null, 
	Phone_Num char(40) not null, 
	Address varchar(100),
	Primary Key (PID)
	);
 
--PLAYERS TABLE
PLID -> PID, TID

CREATE TABLE players(
	Plid int not null,
	PID int references contacts(pid) not null,
	TID int references team_table(tid) not null, 
	Primary Key (PlID)
	);
 
--COACHES TABLE
CID -> PID, years_coaching

CREATE TABLE coaches(
	Cid int not null,
	PID int references contacts(pid) not null,
	Years_coaching int not null, 
	Primary Key (cid)
	);
 
--HEAD_Coaches Table
HID -> CID

	CREATE TABLE head_coaches(
	Hid int not null,
	PID int references contacts(pid) not null,
	Years_coaching int not null, 
	Primary Key (Hid)
	);

--ASS_Coaches table
AID -> CID

CREATE TABLE head_coaches(
	Aid int not null,
	PID int references contacts(Aid) not null,
	Years_coaching int not null, 
	Primary Key (Aid)
	);
 
--TEAM_ASS_COACHES
(AID, TID) ->

CREATE TABLE Team_ass_coahces(
	PID int references contacts(Aid) not null,
TID int references contacts(Tid) not null,
	Primary Key (Aid,Tid)
	);
 
--TEAM_Table
TID -> HID, LID

CREATE TABLE Team_table(
	Tid int not null, 
	PID int references contacts(Hid) not null,
TID int references contacts(Lid) not null,
	Primary Key (Tid)
	);
 
--sLEAGUES TABLE
LID -> age_group

CREATE TABLE League_table(
	Lid int not null, 
	Age_group int not null,
	Primary Key (Lid)
	);