use airbnb;
/*Get the name and last name of guests who has at least 1 infant as dependent*/

SELECT dependents.infants as Infants,
guests.id as Guest_ID,
guests.first_name as First_Name,
guests.last_name as Last_Name
FROM airbnb.guests, dependents
where dependents.infants >=1
and dependents.guest_id=guests.id