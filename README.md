## Envrionmental Justice Project

## Details:

* `ca_cap_trade.sql` : SQL file containing create table commands and LOAD DATA commands.

* `webapp-ENV` : Folder containing the flask application files.

## STEPS TO RUN

* Install docker, DataGrip and clone the https://github.com/munners17/INFO-257-Sp2020 repository.

* Go to https://github.com/munners17/INFO257-Sp2020/tree/master/lectures/01-30 for detailed description of how to proceed
with creating a container in docker and connecting it with your database on Datagrip.

* Now, clone this repository and put all the `.csv` files in path: `/Documents/Github/docker/datadir`

* Run the `.sql` file  excluding the `LOAD DATA LOCAL INFILE` statememts on Datagrip console to create schema of your database. Make sure that you are connected to docker at the point and the container is up and running. 

* To start your container, type in terminal `docker start mariadb-diveshop` where `mariadb-diveshop` is your container name.

* Now we need to load our data. So go to terminal and type : `docker exec -it mariadb-diveshop bash` 

* Now type : `cd home`
  
* Now type : `mysql -u root -p` and it will prompt for a password . 
  * Enter the password which you set while making docker container.

* You are successfully connected to MySQL Command Client . Type in the command `use CA_CAP_TRADE;`

* You can type in `SHOW TABLES` if you like to know what the schema looks like.

* At this point , open the `.sql` file and down below you will find some statements starting with `LOAD DATA LOCAL INFILE`

* Copy these statements onto the MySQL Command Client and run it one by one for each table.
  * `MariaDB[CA_CAP_TRADE]> LOAD DATA LOCAL INFILE ....`

* You must have now loaded all the data and you can see on Datagrip.

* Now open the `app.py` file and change the password field to your password for docker container.

* Now go into terminal into the directory and type `python app.py`
  * `$ Environmental-Justice-master/webapp-ENV> python app.py`

* The server should be up and running on localhost. Open it up on the browser and go ahead to test our app.
