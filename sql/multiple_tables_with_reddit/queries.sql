SELECT * 
FROM users
LIMIT 5;

SELECT * 
FROM posts
LIMIT 5;

SELECT * 
FROM subreddits
LIMIT 5;

SELECT COUNT(*) AS 'subreddits_count'
FROM subreddits;

SELECT username, MAX(score) AS 'Top User'
FROM users;

SELECT title, MAX(score) AS 'Top Post'
FROM posts;

SELECT name, subscriber_count
FROM subreddits
ORDER BY subscriber_count DESC
LIMIT 5;
SELECT users.username, COUNT(posts.user_id) AS 'posts_made'
FROM users
LEFT JOIN posts
  ON users.id = posts.user_id
GROUP BY users.id
ORDER BY 2 DESC
LIMIT 5;

SELECT *
FROM posts
INNER JOIN users
  ON posts.user_id = users.id
LIMIT 5;

SELECT * FROM posts
UNION
SELECT * FROM posts2
LIMIT 5;


WITH popular_posts AS (
  SELECT *
  FROM posts
  WHERE score >= '5000'
)
SELECT subreddits.name AS 'Subreddit', popular_posts.title AS 'Post', popular_posts.score AS 'Score'
FROM subreddits
INNER JOIN popular_posts
  ON subreddits.id = popular_posts.subreddit_id
ORDER BY popular_posts.score DESC
LIMIT 5;

SELECT posts.title AS 'Title', 
  subreddits.name AS 'Subreddit', 
  MAX(posts.score) AS 'Highest Score'
FROM posts
INNER JOIN subreddits
  ON posts.subreddit_id = subreddits.id
GROUP BY subreddits.id
LIMIT 5;

SELECT subreddits.name AS 'Subreddit', 
  AVG(posts.score) AS 'Scores'
FROM subreddits
INNER JOIN posts
ON posts.subreddit_id = subreddits.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;



