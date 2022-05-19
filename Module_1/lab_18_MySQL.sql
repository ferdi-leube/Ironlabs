use applestore;
select * from applestore;
select prime_genre from applestore;
select prime_genre, sum(rating_count_tot) from applestore
group by prime_genre
order by sum(rating_count_tot) desc;
select prime_genre, count(ï»¿id) from applestore
group by prime_genre
order by count(ï»¿id) desc;
select prime_genre, count(ï»¿id) from applestore
group by prime_genre
order by count(ï»¿id) asc;
## looking for the top 10 apps with the highest amounts of ratings
select track_name, rating_count_tot from applestore
order by rating_count_tot desc
limit 10; 
## looking for the top 10 best rated apps
select track_name, user_rating from applestore
order by user_rating desc
limit 10; 
## Question 7: apps which have the highest amounts of ratings are most likely to have the highest amount of users, the more users the more people who are ready to comment on the app
## Question 8: gives us the top 10 best rated apps, just because they are best rated doesn't mean they are popular or that good, if only one person gives a 5 star rating, the app will appear as rated with 5 stars, or the app is so unpopular, unsatisfied users won't even care to comment
select track_name, rating_count_tot, user_rating from applestore
order by rating_count_tot desc
limit 10; 
## Question 9: shows you that the most rated/most popular apps are not necesarily the best rated and the other way around
select track_name, rating_count_tot, user_rating from applestore
order by user_rating desc, rating_count_tot desc
limit 3; 
select track_name, rating_count_tot, user_rating from applestore
where user_rating = 5
order by  rating_count_tot desc
limit 3; 
## Question 11: do people care about the price of an app?
## here we will use logic, the higher the amount of ratings the higher the amount of users for an app
## what does caring mean --> the higher the price, the less users because it is too expensive, caring --> are people ready to pay a certain price for the app
select price, avg(user_rating), rating_count_tot from applestore
group by price
order by price desc;
#generally the higher the price the lower the amount of users, but only if we look at it very broadly
#but it also depends on what genre the app is in, for some genres people are ready to pay more
select prime_genre, avg(price), avg(rating_count_tot) from applestore
group by prime_genre
order by avg(price) desc;
## here you can see it really depends what kind of an app it is we are taling about, for approxemtly 5 euros, a lot more people are ready to pay those for book related apps than for medical related apps
## we can go one deeper, inside the genre, do people there care about price