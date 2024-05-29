SELECT * 
FROM [dbo].[HR Data]

---KPIs
---Total Number of Employees
SELECT COUNT(*) AS TotalEmployees
FROM [dbo].[HR Data]

---Total number of Active Employees
SELECT
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS ActiveEmployees
FROM [dbo].[HR Data]

---Total number of Inactive Employees
SELECT
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS InactiveEmployees
FROM [dbo].[HR Data]

---Retention Rate
SELECT
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS ActiveEmployees,
	  COUNT(*) AS TotalEmployees,
	  CAST((SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) / COUNT(*)) AS DECIMAL(10,4)) AS RetentionRate
FROM [dbo].[HR Data]

---Average length of time an employee stays in the organization
SELECT AVG([Years_At_Company]) AS AvglengthOfTime
FROM [dbo].[HR Data]

---Number of Male Workers
SELECT COUNT([Gender]) AS NoofMaleWorkers
FROM [dbo].[HR Data]
WHERE [Gender] = 'Male'

---Number of Female Workers
SELECT COUNT([Gender]) AS No_Of_Female_Workers
FROM [dbo].[HR Data]
WHERE [Gender] = 'Female'

---Create a new conditional column  called Income Range to show the diversity of monthly income earned.
ALTER TABLE [dbo].[HR Data]
ADD IncomeRange VARCHAR(50)

UPDATE [dbo].[HR Data]
SET [IncomeRange] =
    CASE
	    WHEN [Monthly_Income] BETWEEN 0 AND 5000 THEN 'low Income'
		WHEN [Monthly_Income] BETWEEN 5001 AND 10000 THEN 'Moderate Income'
		WHEN [Monthly_Income] BETWEEN 10001 AND 15000 THEN 'High Income'
		WHEN [Monthly_Income] > 15000 THEN 'Very High Income'
		ELSE 'Unknown'
	END

---Relationship between Attrition and Business Travel
SELECT [Business_Travel],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Business_Travel]

---The attrition rate by Age category.
SELECT [CF_age_band],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [CF_age_band]

---The attrition rate in relation to age category and gender
SELECT [CF_age_band],[Gender],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [CF_age_band],[Gender]
ORDER BY AttritionRate DESC
---From this, the workers under 25 and female are the most likely to leave as more than half of the
---population typically leaves.

--- Attrition rate by Gender
SELECT [Gender],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Gender]
ORDER BY AttritionRate DESC



--- Attrition rate by department
SELECT [Department],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Department]
ORDER BY AttritionRate DESC

---Attrition rate by Education Field
SELECT[Education_Field] ,
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Education_Field]
ORDER BY AttritionRate DESC

--- DisplayAttrition rate by Job roles in relation to Education Field
SELECT [Department] ,[Job_Role],[Education_Field],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Department], [Job_Role],[Education_Field]
ORDER BY AttritionRate DESC

---Display Attrition Rate in relation to Job role
SELECT[Department] , [Job_Role],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Department],[Job_Role]
ORDER BY AttritionRate DESC

---Display the relationship between Marital Status and Attrition
SELECT[Marital_Status],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Marital_Status]
ORDER BY AttritionRate DESC


---Attrition rate by marital status in conjunction with Gender and overtime
SELECT[Marital_Status],[Gender],[Over_Time],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Marital_Status],[Gender],[Over_Time]
ORDER BY AttritionRate DESC


---Display the relationship between Attrition and Overtime
SELECT[Over_Time],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Over_Time]
ORDER BY AttritionRate DESC
---There is definitely a relationship between overtime and attrition as workers partaking in overtime
--have a higher chance of leaving the organization.

---The relationship between Attrition, Marital Status and Overtime
SELECT[Marital_Status],[Over_Time],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Marital_Status] ,[Over_Time]
ORDER BY AttritionRate DESC
---Note: It is safe to say the singles leave the organization faster than any other statuses and participating in overtime
--increases their chances of leaving.

---The relationship between Marital Status, Age group and Gender
SELECT[Marital_Status], [CF_age_band],[Gender],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Marital_Status] ,[CF_age_band],[Gender]
ORDER BY AttritionRate DESC
---The singles under 25 had the highest attrition rate

---The relationship between Attrition and The number of Training times during the last year
SELECT[Training_Times_Last_Year],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Training_Times_Last_Year]
ORDER BY [Training_Times_Last_Year] DESC
---There seems to be no relationship but it is important to note that the workers that attended trainings 
--6 times had the least attrition rate while the highest attrition  rate belonged to the people with no training 
--I suspect that this might have something to do with the number of years worked and the job level of the worker.
--- There is also an obvious outlier for those that trained four times

---The relationship between attrition, training times the last year and job satisfaction
SELECT[Job_Satisfaction],[Training_Times_Last_Year],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Satisfaction],[Training_Times_Last_Year]
ORDER BY [Training_Times_Last_Year] DESC

---The relationship between attrition and Job satisfaction
SELECT[Job_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  Round((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Satisfaction]
ORDER BY AttritionRate DESC

---The relationship between attrition and Job level
SELECT[Job_Level],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  Round((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Level]
ORDER BY AttritionRate DESC
--- Workers at level 4 have the lowest attrition rate while 1 has the highest

---The relationship between attrition and Education
SELECT[Education],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  Round((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Education]
ORDER BY AttritionRate DESC
--- Workers with Doctoral Degrees have the lowest attrition rate indicating they probably enjoy more benefits 
--than the workers with high school diplomas

---The relationship between attrition and Environmental Satisfaction
SELECT[Environment_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Environment_Satisfaction]
ORDER BY AttritionRate DESC
---From the data genearted, the difference between the attriton rate of those who ticked 4,3 and 2 is 
--not so significant to take environmental satisafction as a key factor in Attrition 

---The relationship between attrition and Job Involvement
SELECT[Job_Involvement],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Involvement]
ORDER BY AttritionRate DESC
--- Workers with the highest form of Job involvement(4) have the lowest attrition rate so this might 
--actaully play a key role in attrition

---The relationship between attrition and Job Involvement and Job level
SELECT[Job_Level],[Job_Involvement],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	 ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Level],[Job_Involvement]
ORDER BY AttritionRate DESC

---This proves  that Job Involvement is very Key to attrition

---The relationship between attrition and Job Satisfaction
SELECT[Job_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Satisfaction]
ORDER BY AttritionRate DESC
--Workers rating 1 as their level of Job Satisfaction have the highest Attrition rate


---Display the relationship between attrition and Income Range
SELECT[IncomeRange],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[IncomeRange]
ORDER BY AttritionRate DESC
--Low Income have the highest attrition rate and suprisingly followed by High Income.

---The relationship between attrition ,Income Range and Job Satisfaction
SELECT[IncomeRange],[Job_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[IncomeRange],[Job_Satisfaction]
ORDER BY AttritionRate DESC

---The relationship between attrition ,Income Range and Job Role
SELECT[IncomeRange],[Education],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  Round((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Education],[IncomeRange]
ORDER BY AttritionRate DESC
---It is important to note that the outlier of high come been the secong highest in attrition rate 
--is mostly because workers with doctoral degree and Masters degree are looking for better opportunities 
--and higher income

---The relationship between Attrition and the number of companies worked
SELECT[Num_Companies_Worked],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Num_Companies_Worked]
ORDER BY AttritionRate DESC
---This does not seem to be a factor as to why people leave  the company

---The relationship between Attrition and the number of companies worked
SELECT[Percent_Salary_Hike],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Percent_Salary_Hike]
ORDER BY AttritionRate DESC
---There seems to be no relationship between percentage salart hike and Attrition

---The relationship between Attrition and Work Life Balance
SELECT[Work_Life_Balance],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Work_Life_Balance]
ORDER BY AttritionRate DESC
--- No apparent relationship between Work Life balance and Attrition

---The relationship between Attrition and Years at Company
SELECT[Years_At_Company],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Years_At_Company]
ORDER BY AttritionRate DESC
---No apparent relationship between Years at Company and Attrition

---The relationship between Attrition and Years In current Role
SELECT[Years_In_Current_Role],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Years_In_Current_Role]
ORDER BY AttritionRate DESC
--- Zero number of years came on top with the highest attrition rate but aside from that there is no 
--clear visible pattern


---The relationship between Attrition and Years Since last promotion
SELECT[Years_Since_Last_Promotion],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Years_Since_Last_Promotion]
ORDER BY AttritionRate DESC
---No clear visible pattern to suggest there is a relationship

---The relationship between Attrition and Years with current Manager
SELECT[Years_With_Curr_Manager],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Years_With_Curr_Manager]
ORDER BY AttritionRate DESC
---No clear visible pattern to suggest there is a relationship and with no data on the manager, it is 
--not possible to further investigate.