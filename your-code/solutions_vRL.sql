SOLUTIONS
#CHALLENGE 1
#STEP 1 = define Advance

SELECT titles.title_id, authors.au_id, (titles.advance * titleauthor.royaltyper) / 100 AS advance
FROM titles
JOIN titleauthor
ON titles.title_id = titleauthor.title_id
JOIN authors
ON titleauthor.au_id = authors.au_id
;

#STEP 2 = Aggregate the total royalties for each title and author


SELECT titles.title_id AS Title_ID, ((titles.price * sales.qty * titles.royalty )/ 100 * (titleauthor.royaltyper / 100)) AS royalty
FROM titles
JOIN
titleauthor
ON titles.title_id = titleauthor.title_id 
JOIN
sales
ON titles.title_id = sales.title_id;


#STEP 3: Calculate the total profits of each author

SELECT Title_ID, author_ID, SUM(royalties)
FROM
(SELECT titles.title_id AS Title_ID, authors.au_id AS author_ID, ((titles.price * sales.qty * titles.royalty) / 100 * (titleauthor.royaltyper) / 100) AS Royalties
FROM titles
JOIN
titleauthor
ON titles.title_id = titleauthor.title_id 
JOIN authors
ON titleauthor.au_id = authors.au_id
JOIN
sales
ON titles.title_id = sales.title_id
) AS Royalties
GROUP BY Title_ID, author_ID
;

#Challenge 2 - Alternative Solution

CREATE TEMPORARY TABLE most_profiting_authors
SELECT Title_ID, author_ID, SUM(royalties)
FROM
(SELECT titles.title_id AS Title_ID, authors.au_id AS author_ID, ((titles.price * sales.qty * titles.royalty) / 100 * (titleauthor.royaltyper) / 100) AS Royalties
FROM titles
JOIN
titleauthor
ON titles.title_id = titleauthor.title_id 
JOIN authors
ON titleauthor.au_id = authors.au_id
JOIN
sales
ON titles.title_id = sales.title_id
) AS Royalties
GROUP BY Title_ID, author_ID
;


#Challenge 3

CREATE TABLE most_profiting_authors
(SELECT author_ID, SUM(profits)
FROM
(SELECT titles.title_id AS Title_ID, authors.au_id AS author_ID, ((titles.price * sales.qty * titles.royalty) / 100 * (titleauthor.royaltyper) / 100) AS profits
FROM titles
JOIN
titleauthor
ON titles.title_id = titleauthor.title_id 
JOIN authors
ON titleauthor.au_id = authors.au_id
JOIN
sales
ON titles.title_id = sales.title_id
) AS profits
GROUP BY author_ID
);

