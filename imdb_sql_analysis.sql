-- Question 1: Top 10 Highest rated movies
	SELECT
		TOP 10 *
		FROM imdb_top_1000_clean
		ORDER BY IMDB_Rating DESC

-- Question 2: Top 10 movies with the highest metascore
	SELECT TOP 10 *
		FROM imdb_top_1000_clean
		ORDER BY Meta_score DESC

-- Question 3: How many movies per certificate
	SELECT
		Certificate, COUNT(*) AS movie_count
		FROM imdb_top_1000_clean
		GROUP BY Certificate

-- Question 4: Average IMDB Rating for each certificate
	SELECT
		Certificate, (ROUND(AVG(IMDB_Rating), 2)) Avg_Imdb_Rating_each_Certificate
		FROM imdb_top_1000_clean
		GROUP BY Certificate

-- Question 5: Average IMDB Rating per genre
	SELECT
		Genre, (ROUND(AVG(IMDB_Rating), 2)) AS Avg_Imdb_Rating_By_Genre
		FROM imdb_top_1000_clean
		GROUP BY Genre
		ORDER BY (ROUND(AVG(IMDB_Rating), 2)) DESC

-- Question 6: Average IMDB Rating for each director

	SELECT 
		Director, (ROUND(AVG(IMDB_Rating), 2)) AS Avg_Imdb_Rating_Each_Director, COUNT(*) AS Movie_Count
		FROM imdb_top_1000_clean
		GROUP BY Director
		HAVING COUNT(*) >= 3
		ORDER BY (ROUND(AVG(IMDB_Rating), 2)) DESC

-- Question 7: Number of movies per decade
	SELECT
		(Released_Year/10) * 10 AS Decade,
		COUNT(*) Movie_Count
		FROM imdb_top_1000_clean
		GROUP BY (Released_Year/10) * 10
		ORDER BY Decade DESC

-- Question 8: Average IMDB_Rating per decade
	SELECT
		(Released_Year/10)  * 10 AS Decade,
		(ROUND(AVG(IMDB_Rating), 2)) AS Avg_Imdb_Rating_Per_Decade
		FROM imdb_top_1000_clean
		GROUP BY (Released_Year/10) * 10
		ORDER BY (ROUND(AVG(IMDB_Rating), 2)) DESC

-- Question 9: Number of movies per genre
	SELECT 
		Genre,
		COUNT(*) AS Movie_Per_Genre
		FROM imdb_top_1000_clean
		GROUP BY Genre
		ORDER BY Movie_Per_Genre DESC

-- Question 10: Top 10 movies with highest votes
	SELECT 
		TOP 10
		Series_Title,
		No_of_Votes
		FROM imdb_top_1000_clean
		ORDER BY No_of_Votes DESC

-- Question 11: Which movies have an IMDb rating of at least 8 point 0 and more than 1 million votes?
	SELECT
		Series_Title,
		ROUND(IMDB_Rating, 2) IMDB_Rating,
		No_of_Votes
		FROM imdb_top_1000_clean
		WHERE IMDB_Rating >= 8 AND No_of_Votes > 1000000

-- Question 12: Which directors have at least two movies in the dataset and what's their average IMDb rating?
	SELECT 
		Director,
		ROUND(AVG(IMDB_Rating), 2) AS Avg_Imdb_Rating_Each_Director
		FROM imdb_top_1000_clean
		GROUP BY Director
		HAVING COUNT(Director) >= 2
		ORDER BY Avg_Imdb_Rating_Each_Director DESC

-- Question 13: Which release years have the highest average IMDb rating, considering only years with at least 5 movies?
	SELECT
		Released_Year,
		COUNT(*) AS Movie_Count_Year,
		ROUND(AVG(IMDB_Rating), 2) AS Avg_Imdb_Rating_Per_Year
		FROM imdb_top_1000_clean
		GROUP BY Released_Year
		HAVING COUNT(*) >= 5
		ORDER BY Avg_Imdb_Rating_Per_Year DESC

--  Question 14: Which 10 movies have the highest IMDb ratings among movies released after 2000?
	SELECT
		TOP 10
		Series_Title,
		Released_Year,
		ROUND(IMDB_Rating, 2) AS Imdb_Rating
		FROM imdb_top_1000_clean
		WHERE Released_Year > 2000
		ORDER BY Imdb_Rating DESC

-- Question 15: Which directors has the top 10 gihest IMDb Rating who also has at least 3 movies in the data set
	SELECT 
		TOP 10
		Director,
		ROUND(AVG(IMDB_Rating), 2) AS Avg_Imdb_Rating_Director
		FROM imdb_top_1000_clean
		GROUP BY Director
		HAVING COUNT(*) >= 3
		ORDER BY Avg_Imdb_Rating_Director DESC

-- Question 16: Which genres have the highest IMDb rating, considering only genres with at least 10 movies?
	SELECT
		Genre,
		COUNT(*) AS Number_of_Movies_Genre,
		ROUND(AVG(IMDB_Rating), 2) AS Avg_Rating_Genre
		FROM imdb_top_1000_clean
		GROUP BY Genre
		HAVING COUNT(*) >= 10
		ORDER BY Avg_Rating_Genre DESC

-- Question 17: Which movies have an IMDb rating higher than the overall rating of all movies in the data set?
	SELECT
		Series_Title,
		IMDb_Rating
		FROM imdb_top_1000_clean
		WHERE IMDB_Rating > (SELECT AVG(IMDB_Rating) FROM imdb_top_1000_clean)

-- Question 18: Which movies have an IMDb rating higher than the average IMDb rating of their genre?
	SELECT
		Series_Title,
		Genre,
		IMDB_Rating
		FROM imdb_top_1000_clean AS m
		WHERE IMDB_Rating > (
		SELECT AVG(m2.IMDB_Rating)
		FROM imdb_top_1000_clean AS m2
		WHERE m2.Genre = m.Genre
		)
		ORDER BY IMDB_Rating DESC;