SELECT *
FROM dbo.CarSalesData

--Ordered the table by date to get a clearer picture

SELECT *
FROM dbo.CarSalesData
ORDER BY 'Date'

--Realized the date has a redundant time string
--Created a new column called Date_Only that only displays the date

SELECT CONVERT(DATE, Date) AS Date_Only
FROM dbo.CarSalesData

ALTER TABLE dbo.CarSalesData
ADD Date_Only DATE

UPDATE dbo.CarSalesData
SET Date_Only = CONVERT(DATE, Date)

--The Car_Make and Car_Model columns display incorrect data, i.e, "Nissan F-150" or "Ford Civic"
--Counted the distinct Car_Model names in preparation for correction

SELECT COUNT(DISTINCT Car_Model) AS Car_Models
FROM dbo.CarSalesData

--There are only 5 distinct Car_Model names in this dataset, "Altima", "F-150", "Civic", "Silverado" and "Corolla"
--That gives me an idea how to clean the dataset using my knowledge of the car industry
--The following are the steps that are done

UPDATE dbo.CarSalesData
SET
Car_Make = 'Ford',
Car_Model = 'F-150'

WHERE
Car_Make = 'Nissan' AND
Car_Model = 'F-150'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Ford',
Car_Model = 'F-150'

WHERE
Car_Make = 'Honda' AND
Car_Model = 'F-150'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Ford',
Car_Model = 'F-150'

WHERE
Car_Make = 'Toyota' AND
Car_Model = 'F-150'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Ford',
Car_Model = 'F-150'

WHERE
Car_Make = 'Chevrolet' AND
Car_Model = 'F-150'

--Now all Ford F-150's are correctly listed as Ford F-150 in the Car_Make and Car_Model columns respectively

UPDATE dbo.CarSalesData
SET
Car_Make = 'Chevrolet',
Car_Model = 'Silverado'

WHERE
Car_Make = 'Nissan' AND
Car_Model = 'Silverado'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Chevrolet',
Car_Model = 'Silverado'

WHERE
Car_Make = 'Toyota' AND
Car_Model = 'Silverado'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Chevrolet',
Car_Model = 'Silverado'

WHERE
Car_Make = 'Honda' AND
Car_Model = 'Silverado'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Chevrolet',
Car_Model = 'Silverado'

WHERE
Car_Make = 'Ford' AND
Car_Model = 'Silverado'

--2nd Car_Make and Car_Model corrected, Chevrolet Silverado

UPDATE dbo.CarSalesData
SET
Car_Make = 'Toyota',
Car_Model = 'Corolla'

WHERE
Car_Make = 'Nissan' AND
Car_Model = 'Corolla'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Toyota',
Car_Model = 'Corolla'

WHERE
Car_Make = 'Honda' AND
Car_Model = 'Corolla'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Toyota',
Car_Model = 'Corolla'

WHERE
Car_Make = 'Ford' AND
Car_Model = 'Corolla'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Toyota',
Car_Model = 'Corolla'

WHERE
Car_Make = 'Chevrolet' AND
Car_Model = 'Corolla'

--3rd Car_Make and Car_Model corrected, Toyota Corolla

UPDATE dbo.CarSalesData
SET
Car_Make = 'Honda',
Car_Model = 'Civic'

WHERE
Car_Make = 'Nissan' AND
Car_Model = 'Civic'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Honda',
Car_Model = 'Civic'

WHERE
Car_Make = 'Toyota' AND
Car_Model = 'Civic'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Honda',
Car_Model = 'Civic'

WHERE
Car_Make = 'Ford' AND
Car_Model = 'Civic'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Honda',
Car_Model = 'Civic'

WHERE
Car_Make = 'Chevrolet' AND
Car_Model = 'Civic'

--4th Car_Make and Car_Model corrected, Honda Civic

UPDATE dbo.CarSalesData
SET
Car_Make = 'Nissan',
Car_Model = 'Altima'

WHERE
Car_Make = 'Honda' AND
Car_Model = 'Altima'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Nissan',
Car_Model = 'Altima'

WHERE
Car_Make = 'Toyota' AND
Car_Model = 'Altima'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Nissan',
Car_Model = 'Altima'

WHERE
Car_Make = 'Ford' AND
Car_Model = 'Altima'

UPDATE dbo.CarSalesData
SET
Car_Make = 'Nissan',
Car_Model = 'Altima'

WHERE
Car_Make = 'Chevrolet' AND
Car_Model = 'Altima'

--5th Car_Make and Car_Model corrected, Nissan Altima
--Now all Car_Make and Car_Model columns and rows are displaying the correct car make and model names

--Decided to now change the Commission_Rate from decimals to percentage
--To gain a better understanding on the correlation between commission percentage and number of sales

SELECT CONCAT((Commission_Rate * 100), '%') AS percentage
FROM dbo.CarSalesData

ALTER TABLE dbo.CarSalesData
ADD Commission_Percentage VARCHAR(100)

UPDATE dbo.CarSalesData
SET Commission_Percentage = CONCAT((Commission_Rate * 100), '%')

--Created a new column called Commission_Percentage that displays the commission rates in percentage form

--Checking for potential nulls in the table
--After realizing this should be checked at the beginning

SELECT *
FROM dbo.CarSalesData
WHERE Commission_Earned IS NULL

--No nulls found in the table after checking all the columns

--Created a new table called CleanedCarSalesData to compile all the cleaned columns and rows from CarSalesData

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CleanedCarSalesData
FROM dbo.CarSalesData

SELECT *
FROM CleanedCarSalesData
ORDER BY 'Date_Only'

--Saved the CleanedCarSalesData table as csv file in the database

--Splitting CleanedCarSalesData table into smaller tables by financial quarter

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataQ22022
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-05-01' AND Date_Only <= '2022-06-30'

SELECT *
FROM CarSalesDataQ22022
ORDER BY 'Date_Only'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataQ32022
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-07-01' AND Date_Only <= '2022-09-30'

SELECT *
FROM CarSalesDataQ32022
ORDER BY 'Date_Only'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataQ42022
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-10-01' AND Date_Only <= '2022-12-31'

SELECT *
FROM CarSalesDataQ42022
ORDER BY 'Date_Only'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataQ12023
FROM CleanedCarSalesData
WHERE Date_Only >= '2023-01-01' AND Date_Only <= '2023-03-31'

SELECT *
FROM CarSalesDataQ12023
ORDER BY 'Date_Only'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataQ22023
FROM CleanedCarSalesData
WHERE Date_Only >= '2023-04-01' AND Date_Only <= '2023-05-01'

SELECT *
FROM CarSalesDataQ22023
ORDER BY 'Date_Only'

--Splitting tables resulted in 5 tables according to their respective financial quarters
--However the dataset provided is incomplete therefore the tables "CarSalesDataQ22022" and "Q2CarSalesData2023" are missing few months of data

--Executed the following command to check created tables

SELECT name
FROM sys.tables

--The following command is used to count how many salesperson are in the whole dealership

SELECT COUNT(DISTINCT Salesperson) AS Salesperson_Distinct
FROM dbo.CleanedCarSalesData

--The results show that there are 518657 salesperson from this car dealership franchise
--This information would be beneficial for analysis

--Saved the smaller financial quarter tables as separate csv files

SELECT *
FROM CleanedCarSalesData
WHERE Salesperson LIKE '%DDS%'

--Realized that data cleaning is not finished, rookie mistake
--There are duplicate names with Mr., Mrs., Ms., Dr., MD, DVM, DDS and PhD in Salesperson and Customer_Name columns
--Commenced cleaning the names data on CleanedCarSalesData table's Salesperson column

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, ' MD', '')
WHERE Salesperson LIKE '% MD'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, ' PhD', '')
WHERE Salesperson LIKE '% PhD'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, 'Mr. ', '')
WHERE Salesperson LIKE 'Mr.%'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, 'Ms. ', '')
WHERE Salesperson LIKE 'Ms.%'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, 'Mrs. ', '')
WHERE Salesperson LIKE 'Mrs.%'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, 'Dr. ', '')
WHERE Salesperson LIKE 'Dr.%'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, ' DVM', '')
WHERE Salesperson LIKE '% DVM'

UPDATE CleanedCarSalesData
SET Salesperson = REPLACE(Salesperson, ' DDS', '')
WHERE Salesperson LIKE '% DDS'

--Cleaned names in CleanedCarSalesData Salesperson column, next is Customer_Name column

SELECT *
FROM CleanedCarSalesData
WHERE Customer_Name LIKE '%Dr.%'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, ' MD', '')
WHERE Customer_Name LIKE '% MD'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, ' PhD', '')
WHERE Customer_Name LIKE '% PhD'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, ' DVM', '')
WHERE Customer_Name LIKE '% DVM'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, ' DDS', '')
WHERE Customer_Name LIKE '% DDS'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, 'Mr. ', '')
WHERE Customer_Name LIKE 'Mr. %'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, 'Ms. ', '')
WHERE Customer_Name LIKE 'Ms. %'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, 'Mrs. ', '')
WHERE Customer_Name LIKE 'Mrs. %'

UPDATE CleanedCarSalesData
SET Customer_Name = REPLACE(Customer_Name, 'Dr. ', '')
WHERE Customer_Name LIKE 'Dr. %'

--Dropping tables: CarSalesDataQ22022, CarSalesDataQ32022, CarSalesDataQ42022, CarSalesDataQ12023 and CarSalesDataQ22023
--Due to these tables had the uncleaned names in Salesperson and Customer_Name columns

DROP TABLE CarSalesDataQ22022

DROP TABLE CarSalesDataQ32022

DROP TABLE CarSalesDataQ42022

DROP TABLE CarSalesDataQ12023

DROP TABLE CarSalesDataQ22023

--Re-splitting the CleanedCarSalesData table into it's respective financial quarter

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesData2022Q2
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-05-01' AND Date_Only <= '2022-06-30'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesData2022Q3
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-07-01' AND Date_Only <= '2022-09-30'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesData2022Q4
FROM CleanedCarSalesData
WHERE Date_Only >= '2022-10-01' AND Date_Only <= '2022-12-31'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesData2023Q1
FROM CleanedCarSalesData
WHERE Date_Only >= '2023-01-01' AND Date_Only <= '2023-03-31'

SELECT Date_Only, Salesperson, Customer_Name, Car_Make, Car_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesData2023Q2
FROM CleanedCarSalesData
WHERE Date_Only >= '2023-04-01' AND Date_Only <= '2023-05-01'

--Saved the financial quarter tables as csv files to analyze in Excel

--The following lines are for concatenating the Car_Make and Car_Model columns in the CleanedCarSalesData table
--Due to not being able to do it in Excel like the financial quarter tables
--This is for use later in Tableau

ALTER TABLE CleanedCarSalesData
ADD Car_Make_and_Model VARCHAR(255)

UPDATE dbo.CleanedCarSalesData
SET Car_Make_and_Model = CONCAT(Car_Make, ' ', Car_Model)

SELECT *
FROM CleanedCarSalesData

--Created an updated table to reflect the changes in CleanedCarSalesData

SELECT Date_Only, Salesperson, Customer_Name, Car_Make_and_Model, Car_Year, Sale_Price, Commission_Percentage, Commission_Earned
INTO CarSalesDataforTableau
FROM dbo.CleanedCarSalesData

SELECT *
FROM CarSalesDataforTableau

--Exporting the new CarSalesDataforTableau to a CSV file format for visualizing in Tableau