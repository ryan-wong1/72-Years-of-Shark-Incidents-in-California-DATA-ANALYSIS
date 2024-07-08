72 Years of Shark Incidents in California 1950 - 2022

Data source from 'California Department of Fish and Wildlife (CDFW)':
https://catalog.data.gov/dataset/shark-incident-database-california-56167

This github respository contains the code used for the data cleaning and exploratory process as well as the original and cleaned datasets sourced from 'Shark Incident Database - California' which can be viewed at the link above.

This respository contains two folders: 

Data Cleaning:

- SharkIncidents Data Cleaning.sql = Code used during the data cleaning process. Note that this code is with Moons.csv and SharkIncidents joined together. Final cleaned code and further details can be viewed at the Kaggle link below.

- SharkIncidents Data Exploration.sql = Code used during the data exploration process to address critical questions needed for analysis. My Tableau dashboard (linked below) can be viewed if wanting to learn more.

Dataset Files:

- SharkIncidents.csv = The main dataset used for analysis. This is the raw data directly downloaded from the CDFW data source on data.gov.

- Moons.csv = This is the secondary datasaet used for analysis. This is the raw data directly downloaded from the CDFW data source on data.gov.

- SharkIncidents Cleaned.csv = SharkIncidents.csv and Moons.csv joined together on a common key to create this. Note that this combined dataset has already been cleaned using the code from SharkIncidents Data Cleaning.sql. The Kaggle link below contains all the contents from this csv file but in a much more readable format.

Cleaned dataset:
https://www.kaggle.com/datasets/ryanwong1/shark-incidents-in-california-1950-2022/data

I have created a Tableau dashboard visualizing and addressing critical questions relating to shark encounters if ever wanting to visit California waters for beach activities. Many of these questions were also determined in the data exploratory process which you can further view in the code I have included in this respository (Data Cleaning Folder > SharkIncidents Data Exploration.sql).
https://public.tableau.com/app/profile/ryanw/viz/sharkincidents11111/DASHBOARD
