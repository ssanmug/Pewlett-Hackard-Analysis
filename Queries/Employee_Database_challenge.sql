-- Creating the "Retirement Titles" table
SELECT e.emp_no,
       e.first_name, 
       e.last_name, 
       t.title, 
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Creating the "Unique Titles" table using Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, 
                               rt.first_name, 
                               rt.last_name, 
                               rt.title
INTO unique_titles
FROM retirements_titles AS rt
ORDER BY emp_no, to_date DESC;

-- Creating the "Retiring Titles" table
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT (ut.title)

-- Creating the "Mentorship Eligibility" table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
                              e.first_name, 
                              e.last_name, 
                              e.birth_date, 
                              de.from_date,
                              de.to_date,
                              t.title
INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_emp as de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- Creating a query for Results
SELECT ut.emp_no, 
	   ut.title,
	   de.dept_no,
	   d.dept_name
FROM unique_titles AS ut
	INNER JOIN dept_emp AS de
		ON (ut.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE ut.title = ('Manager')

-- Creating a query for Summary
SELECT ut.emp_no,
	   ut.first_name,
	   ut.last_name,
	   ut.title,
	   de.to_date
INTO query_one
FROM unique_titles AS ut
	INNER JOIN dept_emp AS de
		ON (ut.emp_no = de.emp_no)
WHERE de.to_date = ('9999-01-01')
ORDER BY ut.emp_no ASC;

SELECT COUNT (query_one.emp_no)
FROM query_one;

SELECT * FROM query_one;
