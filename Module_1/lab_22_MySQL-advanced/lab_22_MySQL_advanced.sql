# step 1

use publications;
create temporary table step_1 ( 
select titleauthor.au_id as Author_ID,
titleauthor.title_id as Title_ID,
titles.advance * titleauthor.royaltyper/100 as Advance,
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from titleauthor
join titles on titles.title_id = titleauthor.title_id
join sales on sales.title_id = titles.title_id
);
select * from step_1;

# step 2 
create temporary table step_2 (
select author_id, title_id, sum(sales_royalty) as aggregated_royalty, sum(advance) as aggregated_advance
from step_1
group by author_id, title_id
order by aggregated_royalty desc
);
select* from step_2;

# step 3
create temporary table step_3 (
select author_id, aggregated_royalty + aggregated_advance as total_profits
from step_2
order by total_profits desc
limit 3
);
select* from step_3;


# challenge 2 --> done that right away have to ask how to do it with sunqueries, always recieve wrongly aggregated ad ordered results hen doing subqueries

## well one more try before asking kseniia ...

select author_id, title_id, aggregated_royalty,aggregated_advance
from (
author_id, title_id, sum(sales_royalty) as aggregated_royalty, sum(advance) as aggregated_advance
from step_1) as step_2_1
group by author_id, title_id
order by aggregated_royalty desc
);
select* from step_2;

# ???

# challenge 3 save data in permanent data

create table most_profiting_authors as
select author_ID,
total_profits as Profits
from step_3
order by total_profits desc
;
select * from most_profiting_authors;

