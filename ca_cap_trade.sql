


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
	`Native` int(12) default NULL,
	`Asian` int (12) default NULL,
	`Hawaiian_islander` int(12) default NULL,
	`Other` int(12) default NULL,
	`Hispanic` int(12) default NULL,
	PRIMARY KEY (`Census_ID`)
	KEY `CENSUS` (`Census_ID`));
--
-- Table structure for table `INCOME`
--

DROP TABLE IF EXISTS `INCOME`;
CREATE TABLE `INCOME` (
	`Census_ID` tinyint(11) NOT NULL,
	`Q1` int(12) default NULL,
	`Q2` int(12) default NULL,
	`Q3` int(12) default NULL,
	`Q4` int(12) default NULL,
	`Q5` int (12) default NULL,
	PRIMARY KEY (`Census_ID`),
	KEY `CENSUS` (`Census_ID`));

--
-- Table structure for table `FACILITY_GHG_EMISSIONS`
--

DROP TABLE IF EXISTS `FACILITY_GHG_EMISSIONS`;
CREATE TABLE `FACILITY_GHG_EMISSIONS` (
	`CARB_ID` tinyint(6) NOT NULL,
	`Facility` varchar(255) NOT NULL,
	`Year` char(4) NOT NULL
	`Total_co2` int(10) default NULL,
	`City` varchar(255) default NULL,
	`State` varchar(255) default NULL,
	`Zip` char(5) default NULL,
	`County_ID` tinyint(5) NOT NULL,
	`Class_ID` tinyint(6) default NULL,
	PRIMARY KEY (`CARB_ID`),
	KEY `COUNTY` (`County_ID`),
	KEY `GHG_OFFSET_CREDITS` (`CARB_ID`),
	KEY `FACILITY_CLASS` (`Class_ID`));

--
-- Table structure for table `FACILITY_CLASS`
--

DROP TABLE IF EXISTS `FACILITY_CLASS`;
CREATE TABLE `FACILITY_CLASS` (
	`Class_ID` tinyint(6) NOT NULL,
	`Class` varchar(255) NOT NULL
	PRIMARY KEY (`Class_ID`));

--
-- Table structure for table `FACILITY_INDUSTRY`
--

DROP TABLE IF EXISTS `FACILITY_INDUSTRY`;
CREATE TABLE `FACILITY_INDUSTRY` (
	`Industry` varchar(255) NOT NULL,
	`Class_ID` tinyint(6) NOT NULL,
	PRIMARY KEY (`Industry`),
	KEY `FACILITY_CLASS` (`Class_ID`));

--
-- Table structure for table `CES`
--

DROP TABLE IF EXISTS `CES`;
CREATE TABLE `CES` (
	`Indicator` varchar(255) NOT NULL,
	`Value` float(6) NOT NULL,
	`Percentile` float(6) NOT NULL,
	`Census_ID` tinyint(11) NOT NULL,
	PRIMARY KEY (`Indicator`),
	KEY `CENSUS` (`Census_ID`));

--
-- Table structure for table `CES_INDICATOR`
--

DROP TABLE IF EXISTS `CES_INDICATOR`;
CREATE TABLE `CES_INDICATOR` (
	`Indicator` varchar(255) NOT NULL,
	`Description` varchar(255) NOT NULL,
	`Component` varchar(255) NOT NULL,
	PRIMARY KEY (`Indicator`),
	KEY `CES` (`Indicator`),
	KEY `CES_COMPONENT` (`Component`));

--
-- Table structure for table `CES_COMPONENT`
--

DROP TABLE IF EXISTS `CES_COMPONENT`;
CREATE TABLE `CES_COMPONENT` (
	`Component` varchar(255) NOT NULL,
	PRIMARY KEY (`Component`));













