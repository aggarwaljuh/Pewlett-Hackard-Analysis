--deliverable 1
SELECT e.emp_no, e.first_name,
e.last_name, ti.title, ti.from_date, ti.to_date
into retirement_titles
from employees as e
JOIN titles as ti
on (e.emp_no=ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY ti.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows (unique titles)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date= '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

--retiring_titles

SELECT count (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
group by ut.title
ORDER BY count (ut.title) DESC;

SELECT DISTINCT ON (de.emp_no) e.emp_no, e.first_name,
e.last_name, ti.title, de.from_date, de.to_date
into mentorship_eligibilty
from employees as e
join dept_emp as de
ON (de.emp_no = e.emp_no)
JOIN titles as ti
on (e.emp_no=ti.emp_no)
WHERE de.to_date= '9999-01-01'
and (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY de.emp_no ASC;

SELECT * FROM public.mentorship_eligibilty
