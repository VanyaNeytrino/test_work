SELECT date(date_day) as date_day , date, number, text, rating
FROM (select * from bash GROUP BY rating )
GROUP BY date_day
