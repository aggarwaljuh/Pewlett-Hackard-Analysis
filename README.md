# Pewlett-Hackard-Analysis

## Purpose
The purpose of this analysis is to determine the number of empolyees which are retireing per title. The second part is to identify those who are eligible to participate in a mentorship program. This is done through postgres SQL.

## Results

### Deliverable 1: 
1. Of the people retiring Senior Engineer and Senior Staff have the highest number with over 24,000 employees retiring each.
2. Managers habe the lowest number retiring with 2 people.

### Deliverable 2:
1. A total of 1549 employees are elegible.
2. Of those elegible 426 are Senior Staff.

## Summary
### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Since a total of 72,458 employees are retiring. A minimum of 72,458 roles will need to be filled at the time of the "silver tsunami". 

A total of 167,666 were born between 1956 adn 1965. It would be smart to look forward and relaize that one would need to look forward and these employees will need to be replaced as well. 
```
SELECT e.emp_no, e.first_name,
e.last_name, ti.title, ti.from_date, ti.to_date
into non_retirement_titles
from employees as e
JOIN titles as ti
on (e.emp_no=ti.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '1965-12-31')
ORDER BY ti.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows (unique titles)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO non_unique_titles
FROM non_retirement_titles as rt
WHERE rt.to_date= '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

--retiring_titles

SELECT count (ut.title), ut.title
INTO non_retirement_title
FROM non_unique_titles as ut
group by ut.title
ORDER BY count (ut.title) DESC;
SELECT * FROM public.non_retirement_title
```
### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

There are only a total of 1549 employees that are currently elegibe to mentor the next generation. If over 70,000 need to be mentored then each mentor would need to mentor over 46 mentees. This is not feesable. 

We would suggest explanding the criteria for being in the mentoring program.
If you expand mentoring program to include those who were born between 1960-1965 you have 38,401 participants which can help as this would be a 2 mentee to 1 mentor ratio.

```
SELECT DISTINCT ON (de.emp_no) e.emp_no, e.first_name,
e.last_name, ti.title, de.from_date, de.to_date
into mentorship_eligibilty1963to1965
from employees as e
join dept_emp as de
ON (de.emp_no = e.emp_no)
JOIN titles as ti
on (e.emp_no=ti.emp_no)
WHERE de.to_date= '9999-01-01'
and (e.birth_date BETWEEN '1963-01-01' AND '1965-12-31')
ORDER BY de.emp_no ASC;
```
