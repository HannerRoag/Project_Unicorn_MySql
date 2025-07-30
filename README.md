
<h1> Unicorn Academy Project - Formule One SQL <h1>
 <img src="https://raw.githubusercontent.com/HannerRoag/Project_Unicorn_Python/refs/heads/main/svg/made-with-jupyter---sql.svg" alt="Made with Jupyter">
 <img src="https://raw.githubusercontent.com/HannerRoag/Project_Unicorn_Python/refs/heads/main/svg/guided-project-unicorn-academy.svg" alt="Guided Project"> <br/>
<br/>
<h3>1. Data source</h3> 
 Formula 1 World Championship (1950 - 2024) 
 
 URL: https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020
 
### 2. Objectives
#### 2.1 Main objective
- Using external information, development knowledge using SQL.
#### 2.2. Specific objetives 
- Answer business questions that Formula 1 management was asking.
- Using methods as SELECT, FROM, WHERE, JOIN, LIMIT, GROUP BY, ORDER BY, STORE PROCEDURE, CASE.

### 3. Tecnologies
![SQL](https://img.shields.io/badge/-Sql-f29111?style=for-the-badge&logo=mysql)


### 4. Key question
#### Part I - Answer for business questions.
1. How many diferents circuits exist in the dataset?
2. How many pilots have compited in F1 history?
3. Which are the teams with the most victorys in the history?
4. What has been the laptime average in each circuit?
5. Which pilot has the most quantity of fast laps?
6. How many races has been realized in each season?
7. What has been the pits strategy more effective?
8. Which pilot has obteined more pudiums in the history?
9. Which have been the 5 pilots with the best average in finals positions?
10. Which team has reached much quantity poles position?
11. How many points have reached each team in a specific season?
12. What is the circuit where it has produced more retirements?
13. Which pilot has improved more positions since the departure in grid?
14. Which are the teams with the largest quantity of doubles (1st and 2nd lap race)?
15. Which have been the 5 GP with less difference between 1st and 2nd place?
16. How many pilots have participated in each season?
17. Ranking of 5 best pilots with more points in a season.
18. Obtain the final position for each pilot in each race.
19. How many points has obtained each team?
20. Determine a driver's classification in a race.
#### Part II - Automatization
1. Create a view that translate the race status in spanish.
2. Create a Stored Procedure (SP) that calculate the victorys numbers for a team in a given year.


### 5. Development
#### 5.1 Tables explorations
Tables reviews
1. Circuits table has 9 columns as CircuitId, CircuitRef, Name, Location, Country, lat, lng, alt, url
2. Constructor_results table has 5 columns as constructorResultsId, raceId, ConstructorId, points, status
3. Constructor table has 5 columns as ConstructorId, ConstructorRef, name, nationality and url.
4. Constructor_Standings table has 7 columns as contructorStandingsId, raceId, ConstructorId, points, position, positionText, wins.
5. Drivers table has 9 columns as driverId, driverRef, number, code, forename, surname, dob, nationality, url.
6. Drivers_Standings table has 7 columns as driversStandingsId, raceId, driverId, points, position, positionText, wins.
7. Pit_stops table has 7 columns as raceIde, driverId, stop, lap, time, duration, milliseconds.
8. Qualifying table has 9 columns as qualifyId, raceId, driverId, constructorId, number position, q1, q2, q3.
9. Race table has 18 columns as raceId, year, round, circuitId, name, date, time, url, fp1_date, fp1_time, fp2_date, fp2_time, fp3_date, fp3_time, quali_date, quali_time, spring_date, spring_time.
10. Results table has 18 columns as resultId, raceId, driversId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fatestlap, rankvalue, fastestlaptime, fastestlapspeed, statusId.
11. Seasons table has 2 columns as year, url.
12. Sprint_results has 16 columns as resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestlap, fastestlaptime, statusId.
13. Status table has 2 columns as statusId, status.

#### 5.2 Commands used
Development of each questions that it use some commands:
1. SELECT: Query and retrieve data from database tables.
2. COUNT: Return the number of rows that matches a specified criterion.
3. JOIN: Combine rows from two more tables based an related columns.
4. FROM: used to specify which table to select or delete data from.
5. WHERE: used to filter records.
6. GROUP BY: regroup rows that have the same values into summary rows.
7. ORDER BY: used to sort the result-set in ascending or descending.
8. LIMIT: used in several context to restrict the amount or scope of something.
9. MIN(): function returns the smallest value of the select column.
10. MAX(): function returns the largest value of the select column.
11. ROUND(): used to round a number to a specified number of decimal places or to the nearest integer.
12. AVG(): function returns a number to a specified numberof decimal places or to the nearest integer.
13. DESC: used to sort the data returned in descending order.
14. ASC: used to sort the data returned in ascending order.
15. FORMAT(): function to formant date/time values in a list.
16. COALESCE(): function returns the first non-null value in a list.
17. RANK(): function to specify rank for individual fields as per the categorizations.
18. DENSE_RANK(): computes the rank of a row in an ordered group of rows and returns the rank as a number.
19. CASE: The CASE expression goes through conditions and returns a value when the first condition is met (like on if-then-else statement).
20. DELIMITER: used to specify a custom delimiter character that is used to mark the end of a SQL statement.
21. Stored proceduree (sp): It is a prepared SQL code that you can save, so the code can be reused over and over again.
22. SHOW ERRORS: Diagnostic statement.
    

### 6. Conclusions of development
This project involved extracting information from an external data source and integrating it into a local environment using Jupyter. I was able to clean, modify, and adapt the data to answer key questions. I observed variation within the Spanish community over time. <br/>
During the process, I encountered some challenges: the data was not in a clean format, and I had to manage the diversity of the datasets. I included both evident and less evident demographic information, such as gender, age, and customer type.<br/>
I worked with three main data groups: total population, male population, and female population. I first analyzed overall population trends and then focused on gender-specific variations.<br/>
Although I validated the data using semiannual values, I faced some interpretation challenges—typical in analytical work. Eventually, I decided to restructure the data using decades instead of semiannual periods to make the insights clearer.<br/>
After data cleaning, manipulation, analysis, and interpretation, I began to think about long-term improvements. If this data could be uploaded to a collaborative database, it would allow other users to work with clean, structured data. It's important to create backup files so users can return to specific stages of analysis. In the end, I transformed the dataset into a lightweight CSV archive for easier sharing and use.<br/>
Finally, after checking the graph, I observed that from 1970 to 1980, there was a noticeable upward slope, indicating a faster growth rate. It was a period of strong growth, with the population rising from around 34 million to approximately 38 million—this was also confirmed numerically.<br/>
Then, I noticed that the growth rate began to slow down. From 1980 to 1990, when analyzing by decade, the vertical change was minimal, showing almost no variation. This trend continued in the following decade, from 1990 to 2000. I also confirmed these patterns using the numerical data series.<br/>
Later, I identified subtle nuances in the data, which helped me better understand the overall trend. It's important that graphs are always supported by numerical values, and vice versa—numbers should also be visualized through graphs.<br/>
After the year 2000, I noticed a significant increase in growth. However, before 2010, the growth rate began to slow again, with the slope becoming less steep. Then, around 2020, the growth rate increased once more, and the slope became steeper again.

### 7. Acknowledgements
Almudena Alcázar de Velasco, Jesús Adraz, Cristian Lavia, Yohana Lopez, Caterina Abanoni and Unicorn Academy team.
