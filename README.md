# EMPLOYEE ATTRITION REPORT


## PROJECT OVERVIEW
This project was done to shed more light on the intricacies of the various causes of attrition and possible solutions that could be adopted to aid in the organization's retention of its workers.


### ANALYSIS APPROACH
I used Microsoft SQL server to answer the  following questions which can be considered key business questions that can give insight to the primary cause of Employee attrition in the organization.

	
*	What are the Key Performance Indicators and this includes the Total number of Employees, Number of active employees, no of in-active employees , Retention rate, average length of time an employee stays in the company , Number of male and Female workers.


*	How does the frequency of business travel impact attrition rates?


*	What is the correlation between age and attrition?


*	How is attrition influenced by gender?

*	How is attrittion influenced by Departments?


*	How does the intersection of age category and gender impact attrition rates?


*	What are the attrition rates broken down by gender?


*	Does the field of education have any discernible impact on attrition rates?


*	In what ways do job roles affect attrition rates?


*	How does overtime affect job roles in relation to attrition?


*	How do marital status and overtime relate to attrition rates?


*	Does the extent of employee training influence their likelihood of leaving the company?


*	What is the correlation between overtime, job satisfaction, and attrition rates?


*	How does job level correlate with attrition rates?


*	What is the association between job satisfaction and attrition rates?


*	Is there a connection between education level and attrition rates?


*	How does environmental satisfaction relate to attrition rates?


*	What is the link between job involvement and attrition rates?


*	How do job level and job involvement together relate to attrition rates?


*	What is the correlation between job satisfaction and attrition rates?


*	How does the income range of employees impact attrition?


*	How does the combination of income range and job role affect attrition rates?


*	Does the number of previous employers affect attrition rates?


*	What is the relationship between attrition rates and tenure at the organization?


*	How do work-life balance and attrition rates correlate?


*	What is the connection between years in the current role and attrition rates?


*	How does the duration since last promotion relate to attrition rates?


*	What is the correlation between years with the current manager and attrition rates?

#### DATA VISUALIZATION AND REPORTING

I utilized Power BI to visually represent my findings on the HR dashboard, effectively illustrating the various factors contributing to attrition within the organization.

![Employee Attrition Dashboard](images/Employee Attrition Dashboard.jpg)



#### SQL SCRIPT FOR COMPLEX QUESTIONS:


1.	How is Attrition influenced by OverTime?
	
~~~
SELECT [Over_Time], 
       COUNT() AS TotalEmployees,  
       SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,  
       SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,  
       (SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT() AS AttritionRate        
FROM [dbo].[HR Data]  
GROUP BY [Over_Time]
ORDER BY AttritionRate DESC;
~~~

Result :

| Over_Time | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate |
| --------- | -------------- | ------------------- | ---------------- | ------------- |
| 1         | 416            | 127                 | 289              | 30.53         |
| 0         | 1054           | 110                 | 944              | 10.44         |


2. How does the marital status of the employees and their participating in overtime relate to attrition rates?

~~~
SELECT[Marital_Status], [Over_Time],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Marital_Status] ,[Over_Time]
ORDER BY AttritionRate DESC
~~~
Result: 

| Marital_Status | Over_Time | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate |
|----------------|-----------|----------------|----------------------|------------------|---------------|
| Single         | 1         | 131            | 65                   | 66               | 49.62         |
| Married        | 1         | 186            | 43                   | 143              | 23.12         |
| Divorced       | 1         | 99             | 19                   | 80               | 19.19         |
| Single         | 0         | 339            | 55                   | 284              | 16.22         |
| Married        | 0         | 487            | 41                   | 446              | 8.42          |
| Divorced       | 0         | 228            | 14                   | 214              | 6.14          |

3. How does the income range of employees impact attrition?

  - A column for income range was first created using the salary column

   ~~~
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
 ~~~
After which , the new column income range was used to investigate the effect on Attrition.

~~~
SELECT[IncomeRange],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  (SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[IncomeRange]
ORDER BY AttritionRate DESC
~~~

RESULT:
| Income Range       | Total Employees | Non-Active Employees | Active Employees | Attrition Rate |
|--------------------|-----------------|----------------------|------------------|----------------|
| Low Income         | 749             | 163                  | 586              | 21.76          |
| High Income        | 148             | 20                   | 128              | 13.51          |
| Moderate Income    | 440             | 49                   | 391              | 11.14          |
| Very High Income   | 133             | 5                    | 128              | 3.76           |
 
4. How does the combination of income range and job role affect attrition rates?
~~~
SELECT[IncomeRange],[Education],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
      ROUND ((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Education],[IncomeRange]
ORDER BY AttritionRate DESC
~~~
RESULT:
| IncomeRange      | Education         | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate |
|------------------|-------------------|----------------|---------------------|------------------|---------------|
| Low Income       | Bachelor's Degree | 300            | 69                  | 231              | 23.00         |
| Low Income       | High School       | 108            | 24                  | 84               | 22.22         |
| Low Income       | Master's Degree   | 177            | 38                  | 139              | 21.47         |
| High Income      | Doctoral Degree   | 5              | 1                   | 4                | 20.00         |
| Low Income       | Associates Degree | 150            | 30                  | 120              | 20.00         |
| High Income      | Master's Degree   | 44             | 8                   | 36               | 18.18         |
| Moderate Income  | Associates Degree | 88             | 13                  | 75               | 14.77         |
| Low Income       | Doctoral Degree   | 14             | 2                   | 12               | 14.29         |
| High Income      | Bachelor's Degree | 63             | 8                   | 55               | 12.70         |
| Moderate Income  | Bachelor's Degree | 158            | 19                  | 139              | 12.03         |
| High Income      | High School       | 17             | 2                   | 15               | 11.76         |
| Moderate Income  | High School       | 35             | 4                   | 31               | 11.43         |
| Very High Income | High School       | 10             | 1                   | 9                | 10.00         |
| Moderate Income  | Doctoral Degree   | 20             | 2                   | 18               | 10.00         |
| Moderate Income  | Master's Degree   | 139            | 11                  | 128              | 7.91          |
| Very High Income | Bachelor's Degree | 51             | 3                   | 48               | 5.88          |
| High Income      | Associates Degree | 19             | 1                   | 18               | 5.26          |
| Very High Income | Master's Degree   | 38             | 1                   | 37               | 2.63          |
| Very High Income | Associates Degree | 25             | 0                   | 25               | 0.00          |
| Very High Income | Doctoral Degree   | 9              | 0                   | 9                | 0.00          |


5. What is the association between job satisfaction and attrition rates?
   
~~~
SELECT[Job_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
      ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Satisfaction]
ORDER BY AttritionRate DESC
~~~

RESULT:
| Job_Satisfaction | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate       |
|------------------|----------------|---------------------|------------------|---------------------|
| 1                | 289            | 66                  | 223              | 22.84               |
| 3                | 442            | 73                  | 369              | 16.52               |
| 2                | 280            | 46                  | 234              | 16.43               |
| 4                | 459            | 52                  | 407              | 11.33               |


6. How does job level correlate with attrition rates?
   
~~~
SELECT[Job_Level],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
      ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Level]
ORDER BY AttritionRate DESC
~~~

RESULT:
| Job_Level | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate |
| --------- | -------------- | ------------------- | ---------------- | -------------- |
| 1         | 543            | 143                 | 400              | 26.34          |
| 3         | 218            | 32                  | 186              | 14.68          |
| 2         | 534            | 52                  | 482              | 9.74           |
| 5         | 69             | 5                   | 64               | 7.25           |
| 4         | 106            | 5                   | 101              | 4.72           |

7.What is the link between job involvement and attrition rates?

~~~
SELECT[Job_Involvement],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Involvement]
ORDER BY AttritionRate DESC
~~~

RESULT:
| Job_Involvement | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate |
|-----------------|----------------|---------------------|------------------|---------------|
| 1               | 83             | 28                  | 55               | 33.73         |
| 2               | 375            | 71                  | 304              | 18.93         |
| 3               | 868            | 125                 | 743              | 14.4          |
| 4               | 144            | 13                  | 131              | 9.03          |

8.How do job level and job involvement together relate to attrition rates?

~~~
SELECT[Job_Level],[Job_Involvement],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	 ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Level],[Job_Involvement]
ORDER BY AttritionRate DESC
~~~

RESULT:
| Job_Level | Job_Involvement | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate       |
|-----------|-----------------|----------------|---------------------|------------------|---------------------|
| 1         | 1               | 30             | 15                  | 15               | 50.000000000000    |
| 5         | 1               | 5              | 2                   | 3                | 40.000000000000    |
| 1         | 2               | 137            | 46                  | 91               | 33.580000000000    |
| 4         | 1               | 3              | 1                   | 2                | 33.330000000000    |
| 1         | 3               | 318            | 75                  | 243              | 23.580000000000    |
| 2         | 1               | 35             | 8                   | 27               | 22.860000000000    |
| 3         | 1               | 10             | 2                   | 8                | 20.000000000000    |
| 3         | 2               | 66             | 12                  | 54               | 18.180000000000    |
| 4         | 4               | 14             | 2                   | 12               | 14.290000000000    |
| 3         | 3               | 128            | 17                  | 111              | 13.280000000000    |
| 1         | 4               | 58             | 7                   | 51               | 12.070000000000    |
| 2         | 2               | 128            | 13                  | 115              | 10.160000000000    |
| 2         | 3               | 317            | 28                  | 289              | 8.830000000000     |
| 3         | 4               | 14             | 1                   | 13               | 7.140000000000     |
| 5         | 3               | 43             | 3                   | 40               | 6.980000000000     |
| 2         | 4               | 54             | 3                   | 51               | 5.560000000000     |
| 4         | 3               | 62             | 2                   | 60               | 3.230000000000     |
| 5         | 2               | 17             | 0                   | 17               | 0.000000000000     |
| 5         | 4               | 4              | 0                   | 4                | 0.000000000000     |
| 4         | 2               | 27             | 0                   | 27               | 0.000000000000     |


9. What is the correlation between job satisfaction and attrition rates?
    
~~~
SELECT[Job_Satisfaction],
      COUNT(*) AS TotalEmployees,
      SUM(CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
      SUM(CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
	  ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY[Job_Satisfaction]
ORDER BY AttritionRate DESC
~~~



RESULT:
| Job_Satisfaction | TotalEmployees | NonActive_Employees | Active_Employees | AttritionRate       |
|------------------|----------------|---------------------|------------------|---------------------|
| 1                | 289            | 66                  | 223              | 22.84               |
| 3                | 442            | 73                  | 369              | 16.52               |
| 2                | 280            | 46                  | 234              | 16.43               |
| 4                | 459            | 52                  | 407              | 11.33               |


10. How is the attrition rate influenced by the departments?

~~~
SELECT [Department],
       COUNT (*) AS TotalEmployees,
	   SUM( CASE WHEN [Attrition] = 0 THEN 1 ELSE 0 END) AS Active_Employees,
       SUM( CASE WHEN [Attrition] = 1 THEN 1 ELSE 0 END) AS NonActive_Employees,
       ROUND((SUM(CASE WHEN [Attrition] =1 THEN 1 ELSE 0 END) * 100.0)/ COUNT(*),2) AS AttritionRate
FROM [dbo].[HR Data]
GROUP BY [Department]
ORDER BY AttritionRate DESC
~~~

RESULT:

| Department | Total Employees | Active Employees | Non-Active Employees | Attrition Rate |
|------------|-----------------|------------------|----------------------|----------------|
| Sales      | 446             | 354              | 92                   | 20.63          |
| HR         | 63              | 51               | 12                   | 19.05          |
| R&D        | 961             | 828              | 133                  | 13.84          |














