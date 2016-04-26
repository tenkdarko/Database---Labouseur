CREATE TABLE IF NOT EXISTS user_account(
	user_id SERIAL NOT NULL UNIQUE,
	F_name VARCHAR(50) NOT NULL,
	L_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (user_id)
);

INSERT INTO user_account(f_name, l_name)
VALUES('user', 'one');

INSERT INTO user_account(f_name, l_name)
VALUES('user', 'two');

--SELECT * FROM user_account;


CREATE TABLE IF NOT EXISTS Profiles(
	Profile_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Bio VARCHAR(200),
	PRIMARY KEY (profile_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

INSERT INTO Profiles(user_id, bio)
VALUES (1, 'new user!');

INSERT INTO Profiles(user_id, bio)
VALUES (2, 'The second user of the best social network ever');


CREATE TABLE IF NOT EXISTS contacts(
	Contact_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Added_on DATE NOT NULL,
	Email_address VARCHAR(30) NOT NULL,
	Phone_num VARCHAR(10),
	Other_details VARCHAR(100),
	PRIMARY KEY(contact_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

INSERT INTO contacts(user_id, added_on, email_address)
VALUES(1, '4/4/2016', 'email1@email.net');


CREATE TABLE IF NOT EXISTS user_messages(
	User_id INTEGER NOT NULL,
	Contact_id INTEGER NOT NULL,
	msg_date DATE NOT NULL,
	Msg_text VARCHAR(500) NOT NULL,
	PRIMARY KEY(user_id, contact_id, msg_date)
	FOREIGN KEY user_id REFERENCES user_account(user_id)
);

INSERT INTO user_messages(user_id, contact_id, msg_date, msg_text)
VALUES (1, 1, '4/4/2016', 'first-message');

CREATE TABLE IF NOT EXISTS Location(
	loc_id SERIAL NOT NULL UNIQUE,
	place_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (loc_id)
);

INSERT INTO location(place_name)
VALUES ('Marist');

CREATE TABLE checked_in(
	user_id INTEGER NOT NULL,
	loc_id INTEGER NOT NULL,
	PRIMARY KEY(user_id, loc_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id),
	FOREIGN KEY (loc_id) REFERENCES location(loc_id)
);

INSERT INTO checked_in (user_id, loc_id)
VALUES (1, 1);

CREATE TABLE IF NOT EXISTS  Videos(
	Video_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Playing_time INTEGER NOT NULL,
	Video_format VARCHAR(4) NOT NULL,
	Video_desc VARCHAR(100),
	Video_date DATE,
	PRIMARY KEY(video_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

INSERT INTO videos(user_id, playing_time, video_format, video_desc)
VALUES (1, 100, 'mp4', 'Tom and Jerry');

CREATE TABLE IF NOT EXISTS Music(
	Music_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Artist_name VARCHAR(50) NOT NULL,
	Track_name VARCHAR(100) NOT NULL,
	Track_format VARCHAR(4) NOT NULL,
	rating INTEGER,
	PRIMARY KEY (music_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

INSERT INTO music(user_id, artist_name, track_name, track_format)
VALUES (1, 'Flatbush Zombies', 'Palm Trees', 'mp3');

CREATE TABLE IF NOT EXISTS Photos(
	Photo_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Photo_title VARCHAR(50) NOT NULL,
	Photo_filename VARCHAR(100) NOT NULL,
	Photo_date DATE NOT NULL,
	PRIMARY KEY(Photo_id),
	FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

INSERT INTO photos(user_id, photo_title, photo_filename, photo_date)
VALUES (1, 'phototitle1', 'phototitle1.jpg', '10/10/2014');


CREATE TABLE Profile_photos(
	Profile_id INTEGER NOT NULL,
	Photo_id INTEGER NOT NULL,
	PRIMARY KEY(profile_id, photo_id),
	FOREIGN KEY (profile_id) REFERENCES profiles(profile_id),
	FOREIGN KEY (photo_id) REFERENCES photos(photo_id)
);

INSERT INTO Profile_photos(profile_id, photo_id)
VALUES (1, 1);

CREATE TABLE IF NOT EXISTS favorites(
	Fav_id SERIAL NOT NULL UNIQUE,
	profile_id INTEGER NOT NULL,
	Photo_id INTEGER,
	Video_id INTEGER,
	Music_id INTEGER,
	PRIMARY KEY (fav_id),
	FOREIGN KEY (profile_id) REFERENCES profiles(profile_id),
	FOREIGN KEY (photo_id) REFERENCES photos(photo_id),
	FOREIGN KEY(video_id) REFERENCES videos(video_id),
	FOREIGN KEY (music_id) REFERENCES music(music_id)
);

INSERT INTO favorites(profile_id, photo_id)
VALUES (1,1);

INSERT INTO favorites(profile_id, music_id)
VALUES (1,1);

INSERT INTO favorites(profile_id, video_id)
VALUES (1,1);

CREATE TABLE IF NOT EXISTS Notifications(
	Notification_id SERIAL NOT NULL UNIQUE,
	User_id INTEGER NOT NULL,
	Notification_header VARCHAR(20) NOT NULL, 
	Notification_details VARCHAR(200) NOT NULL,
	PRIMARY KEY (Notification_id),
	FOREIGN KEY (User_id) REFERENCES user_account(user_id)
);


--Takes video id and profile id as parameters, and adds the corresponding information to the notifications table
CREATE OR REPLACE FUNCTION videoNotification(vid int, pid int)
RETURNS void AS $$
DECLARE
Usr_id INTEGER;
FavUser_name TEXT;
Fav_name VARCHAR(100);
Fav_type VARCHAR(20);
BEGIN
Usr_id := (
SELECT user_id
FROM videos
WHERE video_id = vid);
Fav_name := (
SELECT video_desc
FROM videos
WHERE video_id = vid);
Fav_type := 'Video';

FavUser_name := (
SELECT (F_name || ' ' || L_name) AS full_name
FROM user_account
WHERE user_id = (SELECT user_id
			FROM profiles
			WHERE profile_id = pid)
);

INSERT INTO notifications(user_id, notification_header, notification_details)
VALUES (usr_id, fav_type || ' favorited', favUser_name || ' has favorited ' || fav_name);
END;
$$ LANGUAGE plpgsql;


--Takes music id and profile id as parameters, and adds the corresponding information to the notifications table
CREATE OR REPLACE FUNCTION musicNotification(mid int, pid int)
RETURNS void AS $$
DECLARE
Usr_id INTEGER;
FavUser_name TEXT;
Fav_name VARCHAR(100);
Fav_type VARCHAR(20);
BEGIN
Usr_id := (
SELECT user_id
FROM music
WHERE music_id = mid);
Fav_name := (
SELECT track_name
FROM music
WHERE music_id = mid);
Fav_type := 'Music';

FavUser_name := (
SELECT (F_name || ' ' || L_name) AS full_name
FROM user_account
WHERE user_id = (SELECT user_id
			FROM profiles
			WHERE profile_id = pid)
);

INSERT INTO notifications(user_id, notification_header, notification_details)
VALUES (usr_id, fav_type || ' favorited', favUser_name || ' has favorited ' || fav_name);
END;
$$ LANGUAGE plpgsql;


--Takes photo id and profile id as parameters, and adds the corresponding information to the notifications table
CREATE OR REPLACE FUNCTION photoNotification(phid int, pid int)
RETURNS void AS $$
DECLARE
Usr_id INTEGER;
FavUser_name TEXT;
Fav_name VARCHAR(100);
Fav_type VARCHAR(20);
BEGIN
Usr_id := (
SELECT user_id
FROM photos
WHERE photo_id = phid);
Fav_name := (
SELECT photo_title
FROM photos
WHERE photo_id = phid);
Fav_type := 'Photo';

FavUser_name := (
SELECT (F_name || ' ' || L_name) AS full_name
FROM user_account
WHERE user_id = (SELECT user_id
			FROM profiles
			WHERE profile_id = pid)
);

INSERT INTO notifications(user_id, notification_header, notification_details)
VALUES (usr_id, fav_type || ' favorited', favUser_name || ' has favorited ' || fav_name);
END;
$$ LANGUAGE plpgsql;


--Identifies the type of favorite, then calls the appropriate notification function to notify the music/video/photo's user(owner)
CREATE OR REPLACE FUNCTION notify()
RETURNS trigger AS $$
BEGIN
IF NEW.photo_id IS NULL 
AND NEW.video_id IS NULL THEN
EXECUTE musicNotification(NEW.music_id, NEW.profile_id);
ELSIF NEW.music_id IS NULL 
AND NEW.video_id IS NULL THEN
EXECUTE photoNotification(NEW.photo_id, NEW.profile_id);
ELSIF NEW.photo_id IS NULL
AND NEW.music_id IS NULL THEN
EXECUTE videoNotification(NEW.video_id, NEW.profile_id);
END IF;
RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--DROP TRIGGER Notification ON favorites;
CREATE TRIGGER notifcation AFTER INSERT OR UPDATE ON favorites
FOR EACH ROW EXECUTE PROCEDURE notify();

INSERT INTO favorites(profile_id, music_id)
VALUES(1,1);


--admin user
CREATE ROLE admin;
GRANT ALL ON ALL TABLES
IN SCHEMA PUBLIC
TO admin;

--social network user, cannot insert new users or profiles, but can access other tables
CREATE ROLE user;
GRANT SELECT, INSERT, UPDATE ON location, user_messages, profile_photos, favorites, photos, videos, music, contacts, checked_in
TO user;
GRANT SELECT, UPDATE ON users, profiles
TO user;

--Show all user checkins
CREATE VIEW userCheckins AS
SELECT u.user_id, u.f_name, u.l_name, l.place_name
FROM user_account u, checked_in c, location l
WHERE u.user_id = c.user_id
AND l.loc_id = c.loc_id
ORDER BY u.user_id;

--Show all user photo favorites
CREATE VIEW profilePhotoFavorites AS
SELECT u.user_id, u.f_name, u.l_name, p.photo_title
FROM user_account u, photos p, profiles pr, favorites f
WHERE pr.user_id = u.user_id
AND pr.profile_id = f.profile_id
AND f.photo_id = p.photo_id
ORDER BY u.user_id, u.f_name, u.l_name;

--Show all user video favorites
CREATE VIEW profileVideoFavorites AS
SELECT u.user_id, u.f_name, u.l_name, v.video_desc
FROM user_account u, videos v, profiles pr, favorites f
WHERE pr.user_id = u.user_id
AND pr.profile_id = f.profile_id
AND f.video_id = v.video_id
ORDER BY u.user_id, u.f_name, u.l_name;

--Show all user music favorites
CREATE VIEW profileMusicFavorites AS
SELECT u.user_id, u.f_name, u.l_name, m.track_name
FROM user_account u, music m, profiles pr, favorites f
WHERE pr.user_id = u.user_id
AND pr.profile_id = f.profile_id
AND f.music_id = m.music_id
ORDER BY u.user_id, u.f_name, u.l_name;