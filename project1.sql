create database MUSICSTORE;
use MUSICSTORE;

-- employee table creation
Create table employee(employee_id int auto_increment,last_name varchar(15),first_name varchar(15) ,
title varchar(50) ,reports_to int ,levels varchar(2),birth_date text ,hiredate text , address varchar(50) ,
city varchar(15) ,state varchar(2) , country varchar(15) ,postal_code varchar(7),phone varchar(17) , fax varchar(17) , 
email varchar(30),primary key(employee_id));

-- customer table
create table customer(customer_id int ,first_name text,last_name text,company text,address text,city text,state text,
country text,postal_code text,phone text,fax text,email text,support_rep_id int,primary key(customer_id),foreign key(support_rep_id) 
references employee(employee_id) on update cascade on delete cascade);

-- invoice table
create table invoice(invoice_id int auto_increment,customer_id int,invoice_date text,billing_address text,
billing_city text,billing_state text,billing_country text,billing_postal_code text,total float,
primary key(invoice_id),foreign key(customer_id) references customer(customer_id) 
on update cascade on delete cascade );


-- invoice line
create table invoice_line(invoice_line_id int ,invoice_id int,track_id int,unit_price float,
quantity int, primary key(invoice_line_id), foreign key(invoice_id ) 
references invoice(invoice_id),foreign key(track_id ) 
references track(track_id) on update cascade on delete cascade);



-- media type
create table media_type(media_type_id int , Name_ varchar(30) , primary key(media_type_id));

-- genre type
create table genre(genre_id int , Name_ varchar(30) , primary key(genre_id));

-- track 
create table track(track_id int ,name_ varchar(80) , album_id int ,
media_type_id int ,genre_id int ,composer varchar(100) ,milliseconds int ,bytes int ,
unit_price float , primary key(track_id),foreign key(media_type_id) references media_type(media_type_id),
foreign key(genre_id) references genre(genre_id)
on update cascade on delete cascade);

-- playlist
CREATE TABLE playlist (
    playlist_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);


-- Playlist_track
CREATE TABLE Playlist_track (
  playlist_id int NOT NULL,
  track_id int NOT NULL,
  CONSTRAINT fk_playlist_id FOREIGN KEY (playlist_id) 
    REFERENCES Playlist(playlist_id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
  CONSTRAINT pk_playlist_track PRIMARY KEY (playlist_id, track_id)
);

-- Album
CREATE TABLE Album(
  album_id int PRIMARY KEY,
  title varchar(255) NOT NULL,
  artist_id int NOT NULL,
  FOREIGN KEY (artist_id) 
  REFERENCES artist(artist_id) 
);

-- artist
CREATE TABLE artist (
  artist_id int PRIMARY KEY,
  name varchar(255) NOT NULL
);

select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;
select * from track;