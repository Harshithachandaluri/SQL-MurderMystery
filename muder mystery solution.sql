use Murder_Mystery;
show tables;

/* Different Tables available */

select *from drivers_license;

describe facebook_event_checkin;

select *from facebook_event_checkin;

select *from crime_scene_report;
 
select *from get_fit_now_check_in;
   
select *from get_fit_now_member;
   
select *from income;
   
select *from interview;
     
select *from person;

/*1.  Retrieve Crime Scene Report:
 Run a query to retrieve the crime scene report for the murder that occurred on Jan.15, 2018, in SQL City. Gather all available details from the report.
*/
select *from crime_scene_report  where date =20180115 and
city ='SQL City' and type = 'murder' ;

/*2. Witness Personal Details:
Check the personal details of witnesses involved in the case. Retrieve their names, addresses, and any other relevant information.
*/

select *from person where address_street_name='Northwestern Dr'
order by address_number DESC LIMIT 1;

select *from person where 
address_street_name='Franklin Ave' and name like '%Annabel%';

/*3.View Witness Interviews:
 Access the recorded interviews of witnesses conducted after the murder. Gather insights into their statements and potential clues
*/

select *from interview where person_id = 14887;

select *from interview where person_id = 16371;

select *from interview where person_id in
(select id from person 
where address_street_name='Franklin Ave' and name like '%Annabel%');

/*
4. Check Gym Database:
Investigate the gym database using details obtained from the crime
 scene report and witness interviews. 
Look for any gym-related information that might be relevant.
*/

select *from get_fit_now_check_in;
   
select *from get_fit_now_member;
   

select * from get_fit_now_check_in where 
check_in_date=20180109 and  membership_id like '48Z%';

select *from get_fit_now_member where id ='48Z7A' or id='48Z55'
and membership_status='gold';


/*
5. Check Car Details:
Examine the car details associated with the crime scene.
 Retrieve information about the vehicles present during the 
 incident.
*/

select *from drivers_license where plate_number like '%H42W%' ;

/*6. Personal Details:
Identify and collect personal details mentioned in the previous 
query. This includes names, addresses, and any additional details.
*/

select *from person where license_id in
 (select id from drivers_license where plate_number like '%H42W%');
 
 /*
 7. Membership Status at the Gym:
Determine who is identified in the previous query as a 
member of the gym. Utilize the gym database to confirm their 
membership status.
*/

select *from get_fit_now_member where id ='48Z7A' or id='48Z55'
and membership_status='gold';

/*
8. Analyze and Draw Conclusions:
Analyze the collected data, including crime scene reports, 
witness interviews, gym records, and car details.
 Draw conclusions or hypotheses based on the information available.
*/
with cte1 as
(select *from person where license_id in
 (select id from drivers_license where plate_number like '%H42W%')),
cte2 as
(select person_id,name,membership_status
from get_fit_now_member where id ='48Z7A' or id='48Z55'
and membership_status='gold')
select cte1.id,cte1.name,cte2.membership_status
from cte1,cte2 where cte1.id=cte2.person_id;

/*Finally, found the murderer - Jeremy Bowers*/
 
 /*
 After reading the transcript of the murderer*/
 
select *from interview where person_id=67318;

/*
The mastermind/real villian of this whole mystry*/
SELECT p.name,d.height,d.hair_color,d.car_make,d.car_model,
d.gender FROM person as p
JOIN drivers_license as d
ON p.license_id=d.id
WHERE d.height BETWEEN 65 AND 67 AND d.hair_color='red' AND 
gender='female'AND car_make='Tesla' AND car_model='Model S'
AND p.id IN 
(SELECT f.person_id FROM facebook_event_checkin as f WHERE 
F.event_name='SQL Symphony Concert');

/* The mastermind/real villian of this whole mystry - Miranda Priestly*/
 