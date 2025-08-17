create database HEALTH_CARE
use HEALTH_CARE
select * from dbo.healthcare_dataset


--1) Counting Total Record in Database
select count(*) [Total_record] from healthcare_dataset


--2)Finding maximum age of patient admitted.
select name, age from healthcare_dataset
where age = (select max(age) as 'Maximum age' from healthcare_dataset);

--3) Finding Average age of hospitalized patients.
select avg(age) as 'average age' from healthcare_dataset


--4) Calculating Patients Hospitalized Age-wise from Maximum to Minimum
select * from healthcare_dataset
order by (age)desc;


--5) Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.
 select age,
 count(name)as 'count' 
 from healthcare_dataset
 group by age
 order by (age)desc;


--6) Ranking Age on the number of patients Hospitalized 
select age, 
count(age)as 'total',
DENSE_RANK() 
over 
(order by age asc)as 'Ranked' 
from healthcare_dataset
group by age;


--7) Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
select medical_condition, count(Medical_Condition) as 'total no of partient' 
from healthcare_dataset
group by Medical_Condition
order by [total no of partient]desc;


--8) Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.    
select Medication, 
count(*) as 'Total_Medication',
row_number() 
over 
(order by count(*) desc) as 'Priority_By_Rank'
from healthcare_dataset
group by Medication
order by Total_Medication desc;


--9) Most preffered Insurance Provide  by Patients Hospatilized
select 
insurance_provider, count(name)as 'list of partients hospatilzed' 
from healthcare_dataset
group by Insurance_Provider
order by [list of partients hospatilzed]desc;


--10) Finding out most preffered Hospital 
select top(1)
Hospital ,count(hospital) as 'most preffered hospital' 
From healthcare_dataset
group by Hospital
order by [most preffered hospital]desc;


--11) Identifying Average Billing Amount by Medical Condition.
select
Medical_Condition,
round(avg(Billing_Amount),2) as 'Average_Billing Amount' 
from healthcare_dataset
group by Medical_Condition


--12) Finding Billing Amount of patients admitted and number of days spent in respective hospital.
select name, 
round(billing_amount,2) as 'billing_amount', 
datediff(day,date_of_admission,discharge_date) as 'no of days' 
from healthcare_dataset


--13) Finding Total number of days sepend by patient in an hospital for given medical condition
select 
name,
Medical_Condition, 
datediff(dd,Date_of_Admission,Discharge_Date) as 'no_of_total_days_spend_in_Hospital',
FLOOR(sum(billing_amount))as 'Total_billing_amount'
from healthcare_dataset
group by
name,
medical_condition,
datediff(dd,Date_of_Admission,Discharge_Date)
order by no_of_total_days_spend_in_Hospital desc;


--14) Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to Normal
select  Hospital,
Test_Results, 
datediff(day,Date_of_Admission,Discharge_Date) as 'no of days' 
from healthcare_dataset
where Test_Results ='normal'


--15) Calculate number of blood types of patients which lies between age 20 to 45
select Blood_Type, 
count(blood_type) as 'No_of_blood' 
from healthcare_dataset
where age between 20 and 45
group by Blood_Type;


--16) Provide a list of hospitals along with the count of patients admitted in the year 2024 AND 2025?
select count(*) from healthcare_dataset
where year(date_of_admission) between '2022' and '2023'
 

--17) Find the average, minimum and maximum billing amount for each insurance provider?
select insurance_provider,
round(avg(billing_amount),2) as 'avg',
round(min(billing_amount),2) as 'min',
round(max(billing_amount),2) as 'max'
from healthcare_dataset
group by Insurance_Provider

--18) Create a new column that categorizes patients as high, medium, or low risk based on their medical condition.
select name,
age,
Medical_Condition, 
iif(medical_condition in('asthma','diabetes'),'Low Risk',iif(medical_condition in
('hypertension','arthritis'),'Medium Risk','High Risk'))as'Risk' from healthcare_dataset


--19) Find the total patient of each blood group
select Blood_Type,
count(name) as 'total patients' 
from healthcare_dataset
group by Blood_Type
order by [total patients]asc;

--20) Total amount by the insurance provider 
select insurance_provider,
round(sum(billing_amount),2)as 'total amount' 
from healthcare_dataset
group by Insurance_Provider
order by [total amount];


--21) Write a SQL query to generate a summary report that shows the total number of patients for each unique combination of medical condition and blood type. The report should be sorted alphabetically by medical condition and then by blood type."
select 
Medical_Condition, 
Blood_Type,
count(name) as 'Total_patients'
from healthcare_dataset
group by Medical_Condition,
Blood_Type
order by Medical_Condition asc, 
Blood_Type asc.


--22) Total amount by the insurance provider 
select 
Insurance_Provider, 
round(sum(billing_amount),2) as 'Total_Billing_Amount'
from healthcare_dataset
group by Insurance_Provider
order by Total_Billing_Amount asc;


--22) Average Billing by Admission Type & Gender
select 
Admission_Type,
gender, 
Round(avg(billing_amount),2)as 'Avg_Billing_Amount'
from healthcare_dataset
group by Admission_Type,Gender
order by Admission_Type asc, gender asc;


--23) Doctor Performance: Most Patients & Highest Billing
select top(10)
Doctor, 
count(name) as 'Total_patient',
round(sum(billing_amount),2) as 'Total_Billing_Amount'
from healthcare_dataset
group by Doctor
order by Total_patient desc


--24) Write a SQL query to list the top 25 hospital-year combinations based on total revenue generated. For each result, display the hospital name, the year of admission, the total number of patients admitted, and the total revenue (rounded down to the nearest whole number). Sort the results by revenue in descending order."
select top (25) Hospital,
datepart(yyyy,Date_of_Admission) as 'Adimted_Year',
count(name)as 'Total_Patients', 
floor(sum(billing_amount))as 'Total_Revenue' 
from healthcare_dataset
group by Hospital, 
datepart(yyyy,Date_of_Admission)
order by Total_Revenue desc;


--25) Hospital Billing Trends
select  
Distinct(hospital) as Hospital,
datename(mm,date_of_admission) as Admited_month, 
datepart(YYYY,date_of_admission) as Admited_Years,
datename(mm,discharge_date) as Dischage_month, 
datepart(yyyy,discharge_date) as Discharge_Years,
count(name) as Total_Patient,
round(sum(billing_amount),2)as Total_Billing_Amount
from
healthcare_dataset 
group by Hospital,
datename(mm,date_of_admission),
datepart(yyyy,Date_of_Admission),
datename(mm,Discharge_Date),
datepart(yyyy,discharge_date)
order by 
 Admited_month asc,
 Dischage_month asc,
 Admited_Years asc, 
 Discharge_Years asc;


--26) Average Length of Stay By Medical_Conedition(Discharge Date – Admission Date)
select Medical_Condition, 
avg(datediff(day,date_of_admission, discharge_date))as 'Avg_days' 
from healthcare_dataset
group by Medical_condition 


--27) Find patients who had both Normal and Abnormal test results in different admissions.
select
name, 
count(Test_Results) as 'Test_results', 
string_agg(test_results,',') as 'Result'
from healthcare_dataset
group by name
having count(test_results) > 1;


