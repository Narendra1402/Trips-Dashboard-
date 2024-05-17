#Total trips in Trips Table  ?
SELECT count(*) FROM trips;
#Total trips in Trips_details4 Table  ?
SELECT count(*) FROM trips_details4 WHERE end_ride = 1;

#How many total trips in Day ?
SELECT count(DISTINCT tripid) FROM trips_details4;

#check duplicate of trip id
SELECT tripid, count(tripid) cnt FROM trips_details4
GROUP BY tripid
having count(tripid)>1;

#Total Number of Drivers?  
SELECT count(DISTINCT driverid) FROM trips;

#Total Earning ?
SELECT sum(fare) FROM trips;

#Total Completed trips ?
SELECT count(DISTINCT tripid) FROM trips;

#Total Searches?
SELECT sum(searches) FROM trips_details4;

#Total searches which got estimate?
SELECT sum(searches_got_estimate) FROM trips_details4;

#Total searches for quote?
SELECT sum(searches_for_quotes) FROM trips_details4;

#Total searches which got quotes?
SELECT sum(searches_got_quotes)  FROM trips_details4;

#Total driver cancelled ?
SELECT count(*) -sum(driver_not_cancelled) FROM trips_details4;

#Total otp entered ?
SELECT sum(otp_entered) FROM trips_details4;

#Total End ride ?
SELECT sum(end_ride) FROM trips_details4;

#Total cancelled bookings by customer?
SELECT count(*)- sum(customer_not_cancelled) FROM trips_details4;

#average distance per trip?
SELECT round(avg(distance)) FROM trips;

#average fare per trip?
SELECT avg(fare) FROM trips;

#distance travelled
SELECT sum(distance) FROM trips;

#which is the most used payment method??

SELECT a.method FROM payment a inner join 
(SELECT faremethod, count(DISTINCT tripid )cnt FROM trips 
GROUP BY faremethod
ORDER BY count(DISTINCT tripid) DESC limit 1) b
on a.id=b.faremethod
;

#The highest payment was made through which instrument?

SELECT a.method FROM payment a inner join 
(SELECT * FROM trips
ORDER BY fare DESC limit 1 ) b
on a.id=b.faremethod
;

# which two locations had the most trips?
SELECT * FROM 
(SELECT* ,dense_RANK() OVER ( ORDER BY trip DESC) rnk 
FROM 
(SELECT loc_from,loc_to,count(DISTINCT tripid) trip FROM trips
GROUP BY loc_from,loc_to)a)b
WHERE rnk=1;

#Top 5 earning drivers ?
SELECT * FROM 
(SELECT* ,dense_RANK() OVER ( ORDER BY fare DESC) rnk 
FROM 
(SELECT driverid, sum(fare) fare FROM trips
GROUP BY driverid)b)c
WHERE rnk<6;

#which duration had more trips?
SELECT * FROM 
(SELECT *,RANK() OVER(ORDER BY cnt DESC) rnk FROM
(SELECT duration, count( DISTINCT tripid) cnt FROM trips
GROUP BY duration )b)c
WHERE rnk=1;

#which driver , customer pair had more orders ?
SELECT * FROM 
(SELECT *,RANK() OVER(ORDER BY cnt DESC) rnk FROM
(SELECT  driverid,custid, count(DISTINCT tripid) cnt FROM trips
GROUP BY driverid,custid)c)d
WHERE rnk=1 ;

#search to estimate rate?
SELECT sum(searches_got_estimate)*100.0/sum(searches) FROM trips_details4;

#estimate to search for quote rates?
SELECT sum(searches_for_quotes)*100.0/sum(searches_got_estimate) FROM trips_details4;

#quote acceptance rate?
SELECT sum(searches_got_quotes)*100.0/sum(searches_for_quotes) FROM trips_details4;

#quote to booking rate?
SELECT sum(customer_not_cancelled)*100.0/sum(searches_got_quotes) FROM trips_details4;

#which area got highest trips in which duration?
SELECT * FROM
(SELECT *, RANK() OVER(partition by duration ORDER BY cnt DESC) rnk FROM
(SELECT duration,loc_from,count(DISTINCT tripid)cnt FROM trips
GROUP BY duration,loc_from)a)c
WHERE rnk=1;

#which duration got highest trips in which location?
SELECT * FROM
(SELECT *, RANK() OVER(partition by loc_from ORDER BY cnt DESC) rnk FROM
(SELECT duration,loc_from,count(DISTINCT tripid)cnt FROM trips
GROUP BY duration,loc_from)a)c
WHERE rnk=1;

#which area got the highest fares, cancellations,trips ?
SELECT * FROM (SELECT * ,RANK() OVER (ORDER BY fare DESC)rnk FROM 
(SELECT loc_from,sum(fare) fare FROM trips
GROUP BY loc_from)b)c
WHERE rnk=1;

#which area got the higest cancellation FROM driver side?
SELECT * FROM (SELECT * ,RANK() OVER (ORDER BY can DESC)rnk FROM
(SELECT loc_from,count(*)-sum(driver_not_cancelled) can
FROM trips_details4
GROUP BY loc_from)b)c
WHERE rnk=1;

#which area got the higest cancellation FROM customer side?
SELECT * FROM (SELECT * ,RANK() OVER (ORDER BY can DESC)rnk FROM
(SELECT loc_from,count(*)-sum(customer_not_cancelled) can
FROM trips_details4
GROUP BY loc_from)b)c
WHERE rnk=1;


