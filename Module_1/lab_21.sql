## challenge 1

use publications;
select authors.au_id as author_ID,
authors.au_lname as Author_lastname,
authors.au_fname as authors_firstname,
titles.title as Title,
publishers.pub_name as publisher
from authors
join titleauthor on authors.au_id = titleauthor.au_id
join titles on titles.title_id = titleauthor.title_id
join publishers on publishers.pub_id = titles.pub_id
order by authors_firstname;


## challenge 2
# second approach

select authors.au_id as author_ID,
authors.au_lname as Author_lastname,
authors.au_fname as authors_firstname,
publishers.pub_name as publisher,
count(titles.title_id) as total_titles_per_author
from authors
join titleauthor on authors.au_id = titleauthor.au_id
join titles on titles.title_id = titleauthor.title_id
join publishers on publishers.pub_id = titles.pub_id
group by author_id, publisher
order by author_id desc;



## challenge 3
select authors.au_id as author_ID,
authors.au_lname as Author_lastname,
authors.au_fname as authors_firstname,
count(titleauthor.title_id) as Total_titles
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
group by authors.au_id
order by total_titles desc
limit 3;

## challenge 4

select authors.au_id as author_ID,
authors.au_lname as Author_lastname,
authors.au_fname as authors_firstname,
count(titleauthor.title_id) as Total_titles
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
group by authors.au_id
order by total_titles desc;






