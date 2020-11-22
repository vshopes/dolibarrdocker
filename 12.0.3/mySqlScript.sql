create user dbuser@'%' identified by 'dbpass';
grant all privileges on *.* to dbuser@'%';
flush privileges;
create database dolibarr;
quit
