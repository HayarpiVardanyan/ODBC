# ODBC Project
This project demonstrates how to use ODBC (Open Database Connectivity) with C++ to connect to a PostgreSQL database and execute queries.

### INSTALLING AND CONFIGURING UBUNTU ODBC DRIVERS FOR POSTGRESQL DATABASE

Link used:
 https://medium.com/@murat.bilal/installing-and-configuring-ubuntu-odbc-drivers-for-postgresql-database-c67500e87eadh 

The unixODBC driver manager reads information about drivers from an odbcinst.ini file and about data sources from an odbc.ini file. 

```bash
root/etc$ cat odbcinst.ini
[PostgreSQL ANSI]
Description=PostgreSQL ODBC driver (ANSI version)
Driver=psqlodbca.so
Setup=libodbcpsqlS.so
Debug=0
CommLog=1
UsageCount=2

[PostgreSQL Unicode]
Description=PostgreSQL ODBC driver (Unicode version)
Driver=psqlodbcw.so
Setup=libodbcpsqlS.so
Debug=0
CommLog=1
UsageCount=2
```

 You can determine the location of the configuration files on your system by entering the following command into a terminal:

```bash
odbcinst -j
unixODBC 2.3.6
DRIVERS............: /etc/odbcinst.ini
SYSTEM DATA SOURCES: /etc/odbc.ini
FILE DATA SOURCES..: /etc/ODBCDataSources
USER DATA SOURCES..: /home/hayarpi/.odbc.ini
SQLULEN Size.......: 8
SQLLEN Size........: 8
SQLSETPOSIROW Size.: 8
```

### PostgreSQL Database Setup
Follow these steps to set up your PostgreSQL database for the project:

Log in to your PostgreSQL server:

```bash
sudo su postgres
psql
CREATE USER hospital WITH PASSWORD '123';
ALTER USER hospital CREATEDB;
CREATE DATABASE hospital_network;
GRANT ALL PRIVILEGES ON DATABASE hospital_network TO hospital;
\c hospital_network
```

[HOSPITAL DATABASE](Hospital.sql)


### Compilation
To compile the project, use the following command:

```bash
g++ odbc_test.cpp -o my_program -lodbc
```

### Running the Program
```bash
./my_program
```