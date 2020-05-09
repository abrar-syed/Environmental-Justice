# INFO-257-Final-Project
Environmental Justice Database Management System

## Details:
ca_cap_trade.sql -  SQL file containing create table commands and load data commands.

webapp-ENV - folder containing the flask applications files.

## STEPS TO RUN
1. Install docker, DataGrip and clone the https://github.com/munners17/INFO-257-Sp2020 repository.

2.Go to https://github.com/munners17/INFO257-Sp2020/tree/master/lectures/01-30 for detailed description of how to proceed with creating a container in docker and connecting it with your database on Datagrip.

3 Now, clone this repository and put all the .csv files in path - '/Documents/Github/docker/datadir'

4. Run the .sql file  excluding the 'LOAD DATA LOCAL INFILE..' statememts on Datagrip console to create schema of your database. Make sure that you are connected to docker at the point and the container is up and running. To start your container , type in terminal - docker start mariadb-diveshop where mariadb-diveshop is your container name.

5. Now we need to load our data. So go to terminal and type 'docker exec -it mariadb-diveshop bash'

  Then do 'cd home'
  
  Now type -  mysql -u root -p and it will prompt for a password . Enter the password which you set while making docker         container.
  
6.You are successfully connected to MySQL Command Client . Type in the command 'use CA_CAP_TRADE;'

7. You can type in SHOW TABLES if you like to know what the schema is .

8. At this point , open the .sql file and down below you will find some statements starting with 'LOAD DATA LOCAL INFILE..

9. Copy these statements onto the MySQL Command Client and run it one by one for each table.

10. You must have now loaded all the data .

11. Now open the app.py file and change the password field to your password for docker container.

12. Now go into terminal into the directory and type 'python app.py'

$ webapp-ENV> python app.py

13. The server should be up and running on localhost. Open it up on the browser and go ahead to test our app.
