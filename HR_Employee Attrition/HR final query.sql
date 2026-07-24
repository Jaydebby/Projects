-- KPI --
SELECT * FROM project1.hr_employee_attrition;
SELECT COUNT(*) AS total_number_of_Employees FROM project1.hr_employee_attrition;
-- total number of employee 1470 --

SELECT AVG(MonthlyIncome) AS Total_Income FROM project1.hr_employee_attrition;
-- Average total income of overall employees --

SELECT DISTINCT (JobRole) AS Unique_Jobrole FROM project1.hr_employee_attrition;
-- showing the jobrole of employee (9) --

-- Average monthly income by Attrition (Yes) --
SELECT Attrition, round(AVG(MonthlyIncome), 2) as avg_income
FROM project1.hr_employee_attrition 
GROUP BY Attrition
ORDER BY Attrition;
-- Those who left the company have the lowest average monthly income than who stayed --
-- income appear to influence on attrition --

-- chart for visualization -- 
-- 1 Basic Attrition Overview --
-- 1.1 count the number of employee who left vs stayed --
SELECT Attrition, COUNT(*) AS total_num_employees
FROM project1.hr_employee_attrition
GROUP BY Attrition;
-- 237 left the company and 1233 stayed --
-- This gives us the baseline: how many employees left (Yes) vs stayed (No)

-- 2 Helps identify categorical factors that may influence attrition.
-- Attrition by Gender --
SELECT Gender, Attrition, COUNT(*) as total FROM project1.hr_employee_attrition
GROUP BY Gender, Attrition
ORDER BY Gender, Attrition;
-- Male and Female left the company but Male has the total number (150), gender dont influence attrition --

-- Attrition By department--
SELECT DISTINCT Department, Attrition, COUNT(*)AS total FROM project1.hr_employee_attrition
GROUP BY Department, Attrition
ORDER BY Department, Attrition;
-- employee who left from each department are way low than who stayed so
-- department dont influence employees to leave

-- 3 
-- Attrition by JobRole --
SELECT JobRole, Attrition, COUNT(*) AS total FROM project1.hr_employee_attrition
GROUP BY JobRole, Attrition
ORDER BY JobRole, Attrition;
-- Job roles dont influence why people the company because people who left and way low than who stayed --

-- Attrition by Maritial Status --
SELECT MaritalStatus, Attrition, COUNT(*) as total FROM project1.hr_employee_attrition
GROUP BY MaritalStatus, Attrition
ORDER BY MaritalStatus, Attrition;
-- Marital status dont influence attrition because people who stayed are way than who left --


-- Attrition by Overtime --
SELECT OverTime, Attrition, COUNT(*) as total FROM project1.hr_employee_attrition
GROUP BY OverTime, Attrition
ORDER BY OverTime, Attrition;
-- Overtime dont influence attrition but employee who left that did overtime(Yes) is higher than who dont do overtime(No) --

-- Shows trends: e.g., employees who left may live farther from work or have lower income
-- Compare averages of numeric columns by attrition
SELECT Attrition, AVG(Age) AS Avg_age,
AVG(Distance) AS avg_distance,
AVG(MonthlyIncome) AS avg_income,
AVG(YearsAtCompany) AS avg_years_at_company,
AVG(TotalWorkingYears) AS avg_working_years
FROM project1.hr_employee_attrition GROUP BY Attrition;

-- Avgerage Tenure --
SELECT Attrition, round(AVG(YearsAtCompany), 0) AS Avg_Tenure
FROM project1.hr_employee_attrition GROUP BY Attrition;
-- Employees who left typically had shorter tenures, suggesting early-stage disengagement --

SELECT JobSatisfaction, COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employee_left,
COUNT(*) AS Total_employees,
ROUND((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100/ COUNT(*)), 2) AS Attrition_rate
FROM project1.hr_employee_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
--  Lower job satisfaction scores correlate strongly with higher attrition rates, a key actionable insight for HR engagement programs.
-- Average monthlyincome by level --
SELECT AVG(MonthlyIncome), COUNT(*) as total,  CASE WHEN Education = 1 THEN 'Level 1'
WHEN Education = 2 THEN 'Level 2' WHEN Education = 3 THEN 'Level 3' 
WHEN Education = 4 THEN 'Level 4' ELSE 'Level 5'END AS Education_Level
FROM project1.hr_employee_attrition
WHERE Attrition = 'Yes' 
GROUP BY Education
ORDER BY Education;

SELECT Department, Attrition,
COUNT(*) AS Total_employees
FROM project1.hr_employee_attrition
GROUP BY Department, Attrition
ORDER BY Department;

SELECT Attrition,  WorkLifeBalance, COUNT(*) as total,
CASE WHEN WorkLifeBalance = 1 THEN 'Poor'
WHEN WorkLifeBalance = 2 THEN 'Fair'
WHEN WorkLifeBalance = 3 THEN 'Good'
ELSE 'Excellent' END AS WorkLife
FROM project1.hr_employee_attrition
GROUP BY Attrition, WorkLifeBalance
ORDER BY Attrition, WorkLifeBalance;

-- 6 Attrition by Job satisfaction --
SELECT Attrition, YearsSinceLastPromotion, 
CASE WHEN YearsSinceLastPromotion BETWEEN 0 AND 1 THEN 'Less 1yrs' 
WHEN YearsSinceLastPromotion BETWEEN 1 AND 5 THEN '1-5yrs' 
WHEN YearsSinceLastPromotion BETWEEN 6 AND 10 THEN '6-10yrs'  
WHEN YearsSinceLastPromotion BETWEEN 11 AND 15 THEN '11-15yrs'
END AS PromotionGroup, COUNT(*) as total
FROM project1.hr_employee_attrition
WHERE Attrition = 'Yes' 
GROUP BY Attrition,  YearsSinceLastPromotion
ORDER BY Attrition,  YearsSinceLastPromotion;

SELECT * FROM project1.hr_employee_attrition;