


DROP DATABASE IF EXISTS CA_CAP_TRADE;
CREATE DATABASE CA_CAP_TRADE;

USE CA_CAP_TRADE;

--
-- Table structure for table `RACE`
--

DROP TABLE IF EXISTS `RACE`;
CREATE TABLE `RACE` (
	`Census_ID` tinyint(11) NOT NULL,
	`Total_pop` int(12) default NULL,
	`White` int(12) default NULL,
	`Black` int(12) default NULL,
	`American_indian` int(12) default NULL,
	`Asian` int (12) default NULL,
	`Hawaiian` int(12) default NULL,
	`Hispanic` int(12) default NULL,
	`Other` int(12) default NULL,
	`Two_or_more` int(12) default NULL,
	PRIMARY KEY (`Census_ID`)
	KEY `CENSUS` (`Census_ID`));
--
-- Table structure for table `POVERTY`
--

DROP TABLE IF EXISTS `POVERTY`;
CREATE TABLE `POVERTY` (
	`Census_ID` tinyint(11) NOT NULL,
	`Total_pop` int(12) default NULL,
	`Poverty` int(12) default NULL,
	PRIMARY KEY (`Census_ID`),
	KEY `CENSUS` (`Census_ID`));

--
-- Table structure for table `FACILITY_GHG_EMISSIONS`
--

DROP TABLE IF EXISTS `FACILITY_GHG_EMISSIONS`;
CREATE TABLE `FACILITY_GHG_EMISSIONS` (
	`CARB_ID` tinyint(6) NOT NULL,
	`Facility` varchar(255) NOT NULL,
	`Year` char(4) NOT NULL,
	`Total_co2` float(25) default NULL,
	`Covered_Emissions` float(25) default NULL,
	`Non-Covered Emissions` float(25) default NULL,
	`City` varchar(255) default NULL,
	`State` varchar(255) default NULL,
	`Zip` char(5) default NULL,
	`Class_ID` tinyint(6) default NULL,
	PRIMARY KEY (`CARB_ID`),
	KEY `GHG_OFFSET_CREDITS` (`CARB_ID`),
	KEY `FACILITY_CLASS` (`Class_ID`));

--
-- Table structure for table `FACILITY_CLASS`
--

DROP TABLE IF EXISTS `FACILITY_CLASS`;
CREATE TABLE `FACILITY_CLASS` (
	`Class_ID` tinyint(6) NOT NULL,
	`Class` varchar(255) NOT NULL,
	`Industry` varchar(255) NOT NULL, 
	PRIMARY KEY (`Class_ID`));

--
-- Table structure for table `CES`
--

DROP TABLE IF EXISTS `CES`;
CREATE TABLE `CES` (
	`CES_ID` tinyint(11) NOT NULL AUTO_INCREMENT,
	`Indicator` varchar(255) NOT NULL,
	`Value` float(6) NOT NULL,
	`Percentile` float(6) NOT NULL,
	`Census_ID` tinyint(11) NOT NULL,
	PRIMARY KEY (`CES_ID`),
	KEY `CENSUS` (`Census_ID`));

--
-- Table structure for table `CES_INDICATOR`
--

DROP TABLE IF EXISTS `CES_INDICATOR`;
CREATE TABLE `CES_INDICATOR` (
	`Indicator` varchar(255) NOT NULL,
	`Description` varchar(255) NOT NULL,
	`Sub_Component` varchar(255) NOT NULL,
	`Component` varchar(255) NOT NULL,
	PRIMARY KEY (`Indicator`),
	KEY `CES` (`Indicator`));

--
-- Load RACE data
--

LOAD DATA LOCAL INFILE 'race_table.csv'
INTO TABLE RACE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Total_pop, White, Black, American_indian, Asian, Hawaiian, Hispanic, Other, Two_or_more, Census_ID);

--
-- Load POVERTY data
--

LOAD DATA LOCAL INFILE 'poverty_table.csv'
INTO TABLE POVERTY
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Total_pop, Poverty, Census_ID);

--
-- Load FACILITY_GHG_EMISSIONS data
--

LOAD DATA LOCAL INFILE 'facility_table.csv'
INTO TABLE FACILITY_GHG_EMISSIONS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

--
-- Load FACILITY_CLASS data
--

LOAD DATA LOCAL INFILE 'facility_class_table.csv'
INTO TABLE FACILITY_CLASS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Class, Industry, Class_ID);

--
-- Load CES data
--

LOAD DATA LOCAL INFILE 'ces_table_final.csv'
INTO TABLE CES
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Census_ID, Indicator, Value, Percentile);

--
-- Load CES_INDICATOR data
--

LOAD DATA LOCAL INFILE 'CES_Components.csv'
INTO TABLE CES_INDICATOR
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;






