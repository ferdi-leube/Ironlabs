#lab 19
#1
select order_id, max(price) as highest_price from order_items;
#2
select datediff(max(shipping_limit_date),min(shipping_limit_date)) from order_items;
#3
select customer_state as States, count(customer_id) as Number_of_customers from customers
group by customer_state
order by count(customer_id) desc;
#4
select customer_city as city, count(customer_id) as number_of_customers from customers
where customer_state = 'SP'
group by customer_city
order by count(customer_id) desc;
#5
select count(distinct(business_segment)) as distint_business_segments from closed_deals
where business_segment is not null;
#6
select business_segment, sum(declared_monthly_revenue) from closed_deals
group by business_segment
order by sum(declared_monthly_revenue) desc
limit 3;
#7
select count(distinct(review_score)) as Review_scores from order_reviews;
#8
create table new_column2 as 
SELECT *, count(review_score),
CASE WHEN review_score = '1' THEN 'Terrible'
WHEN review_score = '2' THEN 'Bad'
WHEN review_score = '3' THEN 'Acceptable'
WHEN review_score = '4' THEN 'Good'
ELSE 'Very Good!'
END AS Description_review
FROM olist.order_reviews
GROUP BY review_score
ORDER BY count(review_score) DESC;
select* from new_column2;
#9 
select review_score, count(review_id) as frequency_of_most_frequent_reviewscore from order_reviews
group by review_score
order by count(review_id) desc
limit 1;

