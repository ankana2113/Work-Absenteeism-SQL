--select * from Absenteeism_at_work
--select * from compensation
--select * from Reasons

--join compensation table
select * from Absenteeism_at_work
left join dbo.compensation on Absenteeism_at_work.ID = compensation.ID
left join dbo.Reasons on Absenteeism_at_work.Reason_for_absence = Reasons.Number

--healthy employees eligible for bonus
select * from Absenteeism_at_work
where Social_drinker=0 and Social_smoker=0 and Body_mass_index between 18.5 and 24.5
and Absenteeism_time_in_hours<(select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

--compensation rate increase for non-smokers
--budget = $983,221
--68% increase/hour
--$1,414.4 increase/hour
select COUNT(*) as nonsmokers from Absenteeism_at_work where Social_smoker=0

--optimizing the final query
select Absenteeism_at_work.ID,  
Body_mass_index,
case when Month_of_absence in (12, 1, 2) then 'Winter'
	 when Month_of_absence in (3, 4, 5) then 'Spring'
	 when Month_of_absence in (6, 7, 8) then 'Summer'
	 when Month_of_absence in (9, 10, 11) then 'Fall'
	 else 'UNKNOWN' end as Season_names,
Reasons.Reason,
case when Body_mass_index<18.5 then 'Underweight'
	 when Body_mass_index between 18.5 and 24.5 then 'Normal'
	 when Body_mass_index between 24.5 and 30.5 then 'Overweight'
	 when Body_mass_index>30.5 then 'Obese'
	 else 'Unknown' end as BMI_category,
Month_of_absence, 
Day_of_the_week, 
Seasons, 
Transportation_expense, 
Age, 
Work_load_Average_day, 
Disciplinary_failure, 
Education, 
Son, 
Social_drinker, 
Social_smoker, 
Pet, 
Absenteeism_time_in_hours
from Absenteeism_at_work
left join dbo.compensation on Absenteeism_at_work.ID = compensation.ID
left join dbo.Reasons on Absenteeism_at_work.Reason_for_absence = Reasons.Number