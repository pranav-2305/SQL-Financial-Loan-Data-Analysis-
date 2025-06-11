-- Average Dti by emp_length
 select emp_length ,round(avg(dti),4) as avg_dti
 from loan_data
 group by emp_length
 order by  avg_dti desc;