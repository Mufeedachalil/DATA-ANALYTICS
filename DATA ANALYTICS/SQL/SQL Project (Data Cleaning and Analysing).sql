USE company_db;
SELECT * FROM students_placements;

# DATA CLEANING
# Check Null Values

SELECT
 SUM(sl_no IS NULL) AS sl_no_nulls,
 SUM(gender IS NULL) AS gender_nulls,
 SUM(ssc_p IS NULL) AS ssc_p_nulls,
 SUM(ssc_b IS NULL) AS ssc_b_nulls,
 SUM(hsc_p IS NULL) AS hsc_p_nulls,
 SUM(hsc_b IS NULL) AS hsc_b_nulls,
 SUM(hsc_s IS NULL) AS hsc_s_nulls,
 SUM(degree_p IS NULL) AS degree_p_nulls,
 SUM(degree_t IS NULL) AS degree_t_nulls,
 SUM(workex IS NULL) AS workex_nulls,
 SUM(etest_p IS NULL) AS etest_p_nulls,
 SUM(specialisation IS NULL) AS specialisation_nulls,
 SUM(mba_p IS NULL) AS mba_p_nulls,
 SUM(status IS NULL) AS status_nulls,
 SUM(salary IS NULL) AS salary_nulls
 FROM students_placements;
 
 # Checking for Empty Values
 
 SELECT COUNT(*) AS empty_values
 FROM students_placements
 WHERE salary ='';
 
 # Checking for Duplicates records 
 
SELECT COUNT(*) - COUNT(DISTINCT CONCAT(
    sl_no, gender, ssc_p, ssc_b, hsc_p, hsc_b, hsc_s,
    degree_p, degree_t, workex, etest_p, specialisation,
    mba_p, status, salary
)) AS duplicate_count
FROM students_placements;

# Checking Unique values in gender column

SELECT DISTINCT gender
FROM students_placements;

# Checking Unique values in ssc_b column
SELECT DISTINCT ssc_b
FROM students_placements;

# Checking Unique values in hsc_b column
SELECT DISTINCT hsc_b
FROM students_placements;

# Checking Unique values in hsc_s column
SELECT DISTINCT hsc_s
FROM students_placements;

# Checking Unique values in degree_t column
SELECT DISTINCT degree_t
FROM students_placements;

# Checking Unique values in workex column
SELECT DISTINCT workex
FROM students_placements;

# Checking Unique values in specialisation column
SELECT DISTINCT specialisation
FROM students_placements;

 # Checking Unique values in status column
SELECT DISTINCT status
FROM students_placements;

# Check Empty Salary with Status
SELECT status, COUNT(*) AS count
FROM students_placements
WHERE salary = ''
GROUP BY status;

# Handling Empty Salary Values
SET SQL_SAFE_UPDATES = 0;

UPDATE
students_placements
SET salary = 0
WHERE salary ='';


# Verifying Updated Values
SELECT COUNT(*) AS empty_values
 FROM students_placements
 WHERE salary ='';
 
 SELECT * FROM students_placements;
 
 
 # DATA ANALYSIS
 # Placement status Distribution
 SELECT
 status,
 COUNT(*) AS total_students,
 ROUND(
	COUNT(*) * 100.0/
    (SELECT COUNT(*) FROM
    students_placements),
    2)AS percentage
    FROM students_placements
    GROUP BY status;
    
# Placement Rate by Work Experience
SELECT
    workex,
    COUNT(*) AS total_students,
    SUM(CASE WHEN status = 'Placed'
        THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        SUM(CASE WHEN status = 'Placed'
            THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS placement_percentage
FROM students_placements
GROUP BY workex;

# Placement Rate by Hsc Stream
SELECT
    hsc_s,
    COUNT(*) AS total_students,
    SUM(CASE WHEN status = 'Placed'
        THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        SUM(CASE WHEN status = 'Placed'
            THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS placement_percentage
FROM students_placements
GROUP BY hsc_s;

# Placement Rate by HSC Board
SELECT
    hsc_b,
    COUNT(*) AS total_students,
    SUM(CASE WHEN status = 'Placed'
        THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        SUM(CASE WHEN status = 'Placed'
            THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS placement_percentage
FROM students_placements
GROUP BY hsc_b;

# Placement Rate by Dgree Type
SELECT
degree_t,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS placement_percentage
FROM students_placements
GROUP BY degree_t;

# Placement Rate by MBA Specialisation
SELECT
specialisation,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS placement_percentage
FROM students_placements
GROUP BY specialisation;

# Placement Rate by SSC Percentage
SELECT
CASE
WHEN ssc_p < 50 THEN 'Below 50'
WHEN ssc_p < 60 THEN '50-59'
WHEN ssc_p < 70 THEN '60-69'
WHEN ssc_p < 80 THEN '70-79'
ELSE '80 and above'
END AS ssc_percentage_range,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS placement_percentage
FROM students_placements
GROUP BY ssc_percentage_range
ORDER BY ssc_percentage_range;

# Placement Rate by HSC Percentage
SELECT
CASE
WHEN hsc_p < 50 THEN 'Below 50'
WHEN hsc_p < 60 THEN '50-59'
WHEN hsc_p < 70 THEN '60-69'
WHEN hsc_p < 80 THEN '70-79'
ELSE '80 and above'
END AS hsc_percentage_range,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2
) AS placement_percentage
FROM students_placements
GROUP BY hsc_percentage_range
ORDER BY hsc_percentage_range;

# Placement rate by Degree Percentage
SELECT
CASE
WHEN degree_p < 50 THEN 'Below 50'
WHEN degree_p < 60 THEN '50-59'
WHEN degree_p < 70 THEN '60-69'
WHEN degree_p < 80 THEN '70-79'
ELSE '80 and above'
END AS degree_percentage_range,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2
) AS placement_percentage
FROM students_placements
GROUP BY degree_percentage_range
ORDER BY degree_percentage_range;

# Placement Rate by MBA Percentage
SELECT
CASE
WHEN mba_p < 50 THEN 'Below 50'
WHEN mba_p < 60 THEN '50-59'
WHEN mba_p < 70 THEN '60-69'
WHEN mba_p < 80 THEN '70-79'
ELSE '80 and above'
END AS mba_percentage_range,
COUNT(*) AS total_students,
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) AS placed_students,
ROUND(
SUM(CASE WHEN status = 'Placed'
THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2
) AS placement_percentage
FROM students_placements
GROUP BY mba_percentage_range
ORDER BY MIN(mba_p);

# Placement Rate by Employability Test Percentage
SELECT
CASE
WHEN etest_p < 50 THEN 'Below 50'
WHEN etest_p < 60 THEN '50-59'
WHEN etest_p < 70 THEN '60-69'
WHEN etest_p < 80 THEN '70-79'
ELSE '80 and above'
END AS etest_percentage_range,
COUNT(*) AS total_students,
SUM(CASE
WHEN status = 'Placed' THEN 1
ELSE 0
END) AS placed_students,
ROUND(
SUM(CASE
WHEN status = 'Placed' THEN 1
ELSE 0
END) * 100.0 / COUNT(*),2
) AS placement_percentage
FROM students_placements
GROUP BY etest_percentage_range
ORDER BY MIN(etest_p);

# Average Academic Scores by Placement Status
SELECT
    status,
    ROUND(AVG(ssc_p), 2) AS average_ssc_percentage,
    ROUND(AVG(hsc_p), 2) AS average_hsc_percentage,
    ROUND(AVG(degree_p), 2) AS average_degree_percentage,
    ROUND(AVG(mba_p), 2) AS average_mba_percentage
FROM students_placements
GROUP BY status;

# Average Employability Test Score by Placement Satatus
SELECT
status,
ROUND(AVG(etest_p), 2) AS average_etest_percentage
FROM students_placements
GROUP BY status;

# Average Salary of Placed Students
SELECT
COUNT(*) AS total_placed_students,
ROUND(AVG(salary), 2) AS average_salary,
ROUND(MIN(salary), 2) AS minimum_salary,
ROUND(MAX(salary), 2) AS maximum_salary
FROM students_placements
WHERE status = 'Placed'
AND salary > 0;

# Salary by Work Experience
SELECT
workex,
COUNT(*) AS placed_students,
ROUND(AVG(salary), 2) AS average_salary
FROM students_placements
WHERE status = 'Placed'
AND salary > 0
GROUP BY workex;

# Average Salary by MBA Specialisation
SELECT
specialisation,
COUNT(*) AS placed_students,
ROUND(AVG(salary), 2) AS average_salary
FROM students_placements
WHERE status = 'Placed'
AND salary > 0
GROUP BY specialisation;

# Placement Rate by SSC Board
SELECT
ssc_b,
COUNT(*) AS total_students,
SUM(CASE
WHEN status = 'Placed' THEN 1
ELSE 0
END) AS placed_students,
ROUND(
SUM(CASE
WHEN status = 'Placed' THEN 1
ELSE 0
END) * 100.0 / COUNT(*),2
) AS placement_percentage
FROM students_placements
GROUP BY ssc_b;

# Average Salary by Degree Type
SELECT
degree_t,
COUNT(*) AS placed_students,
ROUND(AVG(salary), 2) AS average_salary
FROM students_placements
WHERE status = 'Placed'
AND salary > 0
GROUP BY degree_t;

# Work Experience Distribution by Placement Status
SELECT
status,
workex,
COUNT(*) AS total_students,
ROUND(
COUNT(*) * 100.0 /
SUM(COUNT(*)) OVER (PARTITION BY status),2
) AS percentage
FROM students_placements
GROUP BY status, workex
ORDER BY status, workex;
