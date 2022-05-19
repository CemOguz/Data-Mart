use airbnb;

/*Get the reservations of 2020 with price higher than 150 Euros*/

SELECT
reservations.listing_id as Listing_ID,
listing.host_id as Host_ID,
reservations.guest_id as Guest_ID,
price as Price,
Rented_at as Rented_At

FROM airbnb.listing
JOIN airbnb.reservations ON reservations.listing_id=airbnb.listing.id
Where price>150 and
(reservations.rented_at > '2020-01-01' and reservations.rented_at<'2020-12-31')
order by price;