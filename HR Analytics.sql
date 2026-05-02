SELECT 
	*
FROM "IBM_HR".wa_fn_usec wfu 
LIMIT 10;

SELECT 
	wfu."Attrition" ,
	count(*)
FROM "IBM_HR".wa_fn_usec wfu 
GROUP BY 1;

SELECT 
	DISTINCT wfu."Department" 
FROM "IBM_HR".wa_fn_usec wfu ;

SELECT 
	min(wfu."Age" ),
	max(wfu."Age" ),
	min(wfu."MonthlyIncome"  ),
	max(wfu."MonthlyIncome"  )
FROM "IBM_HR".wa_fn_usec wfu ;

--Basic KPI
SELECT 
	count(*) AS total_employees,
	count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END) as attrition_count,
	round((count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate,
	round(avg(wfu."MonthlyIncome"),2) avg_monthly_income,
	round(avg(wfu."Age"),0) avg_age,
	round(avg(wfu."YearsAtCompany"),0) avg_years_at_company
FROM "IBM_HR".wa_fn_usec wfu ;

--GROUP_BY_Department
SELECT 
	wfu."Department",
	count(*) AS total_employees,
	count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM "IBM_HR".wa_fn_usec wfu 
GROUP BY wfu."Department";

--GROUP_BY_Age
WITH Age_groups as(
	SELECT 
	*,
	CASE 
		WHEN wfu."Age" BETWEEN 18 AND 30 THEN '18-30'
		WHEN wfu."Age" BETWEEN 31 AND 40 THEN '31-40'
		WHEN wfu."Age" BETWEEN 41 AND 50 THEN '41-50'
		WHEN wfu."Age" >= 51 THEN '51+'
	END AS Age_group
	FROM "IBM_HR".wa_fn_usec wfu 
)
SELECT 
	Age_group,
	count(*) AS total_employees,
	count(CASE WHEN "Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN "Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM Age_groups
GROUP BY Age_group
ORDER BY Age_group;

--GROUP_BY_Selery
WITH Selery_groups as(
	SELECT 
	*,
	CASE 
		WHEN wfu."MonthlyIncome" <= 3000 THEN 'Low'
		WHEN wfu."MonthlyIncome" BETWEEN 3001 AND 7000 THEN 'Medium'
		WHEN wfu."MonthlyIncome" BETWEEN 7001 AND 12000 THEN 'Higt'
		WHEN wfu."MonthlyIncome" >= 12001 THEN 'Very High'
	END AS Selery_group
	FROM "IBM_HR".wa_fn_usec wfu 
)
SELECT 
	Selery_group,
	count(*) AS total_employees,
	count(CASE WHEN "Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN "Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM Selery_groups
GROUP BY Selery_group
ORDER BY Selery_group;

--OverTime
SELECT 
	wfu."OverTime" ,
	count(*) AS total_employees,
	count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM "IBM_HR".wa_fn_usec wfu 
GROUP BY wfu."OverTime";

--JobSatisfaction
SELECT 
	wfu."JobSatisfaction" ,
	count(*) AS total_employees,
	count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM "IBM_HR".wa_fn_usec wfu 
GROUP BY wfu."JobSatisfaction";

--JobRole
SELECT 
	wfu."JobRole"  ,
	count(*) AS total_employees,
	count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END) AS attrition_count,
	round((count(CASE WHEN wfu."Attrition" = 'Yes' THEN 1 END)::numeric / count(*)) * 100 ,2) AS attrition_rate
FROM "IBM_HR".wa_fn_usec wfu 
GROUP BY wfu."JobRole"
ORDER BY attrition_rate desc;

--final
SELECT
    *,
    CASE
        WHEN "Age" BETWEEN 18 AND 30 THEN '18-30'
        WHEN "Age" BETWEEN 31 AND 40 THEN '31-40'
        WHEN "Age" BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+'
    END AS age_group,
    CASE
        WHEN "MonthlyIncome" <= 3000 THEN 'Low'
        WHEN "MonthlyIncome" BETWEEN 3001 AND 7000 THEN 'Medium'
        WHEN "MonthlyIncome" BETWEEN 7001 AND 12000 THEN 'High'
        ELSE 'Very High'
    END AS salary_group
FROM "IBM_HR".wa_fn_usec;