use musicstore;
-- 1) Who is the senior most employee based on job title?
select concat(first_name,' ',last_name) as Names_, title from employee order by levels desc limit 1;

-- 2)Which countries have the most Invoices?
select count(*) as no_invoice, billing_country from invoice
 group by billing_country order by no_invoice desc;
 
  -- 3) What are top 3 values of total invoice?
 select count(*) as top3_invoice, billing_country from invoice
 group by billing_country order by top3_invoice desc limit 3;
 
 /*4) Which city has the best customers? 
 We would like to throw a promotional Music Festival in the city we made the most money. 
 Write a query that returns one city that has the highest sum of invoice totals.
 Return both the city name & sum of all invoice totals*/
 
 SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;

/*5) Who is the best customer?
 The customer who has spent the most money will be declared the best customer. 
 Write a query that returns the person who has spent the most money*/
 
SELECT concat(c.first_name,' ',c.last_name) as NAME_ ,c.customer_id, SUM(i.total) AS total_spending
FROM customer AS C  JOIN invoice AS I ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total_spending DESC
LIMIT 1;

-- Write query to return the email, 
-- first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A

SELECT c.email,c.first_name,c.last_name,g.Name_ from customer c join genre g on 
c.customer_id = g.genre_id where g.Name_ ='Rock' and email like 'A%';

SELECT DISTINCT c.email AS Email,c.first_name AS FirstName, c.last_name AS LastName, g.name_ AS Name_
FROM customer as c
JOIN invoice ON invoice.customer_id = c.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre as g ON g.genre_id = track.genre_id
WHERE g.name_ = 'Rock'
ORDER BY c.email;

/* Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands*/

SELECT a.artist_id, a.name,COUNT(a.artist_id) AS count_of_songs
FROM track as t
JOIN album ON album.album_id = t.album_id
JOIN artist as a ON a.artist_id = album.artist_id
JOIN genre as g ON g.genre_id = t.genre_id
WHERE g.name_ LIKE 'Rock'
GROUP BY a.artist_id
ORDER BY count_of_songs DESC
LIMIT 10;

/*Return all the track names that have a song length longer than the
  average song length. Return the Name and Milliseconds for each track. 
  Order by the song length with the longest songs listed first */
 
 select name_,milliseconds  from track  where milliseconds > 
 (select avg(milliseconds) as songlength from track)
 order by milliseconds desc
 limit 1;
 
 /*Find how much amount spent by each customer on artists?
 Write a query to return customer name, artist name and total spent*/

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;



/*We want to find out the most popular music Genre for each country.
 We determine the most popular genre as the genre with the highest amount of purchases. 
 Write a query that returns each country along with the top Genre.
 For countries where the maximum number of purchases is shared return all Genres.*/
 
 select g.name_,c.country,count(g.genre_id) as Purchase_per_genre 
from customer as c join invoice as i on c.customer_id=i.customer_id
join invoice_line as inv on inv.invoice_id=i.invoice_id
join track as t on t.track_id=inv.track_id
join genre as g on g.genre_id=t.genre_id
group by c.country,g.name_
order by purchase_per_genre desc
;
 /*Write a query that determines the customer that has spent the most on music for each country. 
 Write a query that returns the country along with the top customer and how much they spent. 
 For countries where the top amount spent is shared, provide all customers who spent this amount.*/

select i.billing_country,c.country,c.first_name,c.last_name,sum(i.total) as amount_spent from customer as c join invoice as i on 
c.customer_id=i.customer_id
group by i.billing_country,c.country,c.first_name,c.last_name 
order by amount_spent desc
;
 
 
 

