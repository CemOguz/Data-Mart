use airbnb;

/*Get the Number of Reviews and Average Review Score for all Guests*/

SELECT
guests.id AS Guest_ID,
CONCAT(guests.first_name, " ", guests.last_name) as Guest_Name_Surname,
count(guests.id) as Number_of_Reviews,
round(avg(reviews_guests.stars),1) as Review_Avg

from reviews_guests, guests
where guests.id=reviews_guests.guest_id
group by guests.id
order by guests.id asc;