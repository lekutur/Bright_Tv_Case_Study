



SELECT
v.UserID,
p.Name,
p.Surname,
p.Email,
p.Gender,
p.Race,
p.Age,
p.Age_Group,
p.Province,
p.Social_Media_Handle,
v.Channel,
v.RecordDate_UTC,
v.RecordDate_CAT,
v.View_Date,
v.View_Time,
v.Duration_Seconds,
v.Duration_Minutes,
v.ID_Match_Flag,
DATE_FORMAT(v.View_Date, 'EEEE') AS Day_Name,
CASE
WHEN DAYOFWEEK(v.View_Date) IN (1, 7) THEN 'Weekend'
ELSE 'Weekday'
END AS Day_Type,
CASE
WHEN HOUR(v.RecordDate_CAT) BETWEEN 5 AND 11 THEN 'Morning'
WHEN HOUR(v.RecordDate_CAT) BETWEEN 12 AND 16 THEN 'Afternoon'
WHEN HOUR(v.RecordDate_CAT) BETWEEN 17 AND 21 THEN 'Evening'
ELSE 'Late Night'
END AS Time_Period
FROM tv_viewership_clean v
LEFT JOIN tv_userprofile_clean p
ON v.UserID = p.UserID;

---CREATE OR REPLACE TABLE brighttv_analysis_clean AS
SELECT COUNT(*) AS viewer_rows FROM tv_viewership_clean;
SELECT COUNT(*) AS profile_rows FROM tv_userprofile_clean;
SELECT COUNT(*) AS final_rows FROM bright_tv_analysis;


SELECT ID_Match_Flag, COUNT(*) AS rows
FROM tv_viewership_clean
GROUP BY ID_Match_Flag;
SELECT COUNT(*) AS zero_duration_rows
FROM tv_viewership_clean
WHERE Duration_Seconds = 0;

SELECT
Day_Name,
COUNT(*) AS Sessions,
ROUND(SUM(Duration_Minutes) / 60, 2) AS Total_Hours
FROM bright_tv_analysis
GROUP BY Day_Name
ORDER BY Total_Hours DESC;