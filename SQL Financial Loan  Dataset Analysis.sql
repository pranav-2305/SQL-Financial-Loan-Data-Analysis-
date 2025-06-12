create database company_loan;
use company_loan;




create table loan_data (
id int,
address_state varchar(2),
application_type varchar(20),
emp_lenght varchar(20),
emp_title varchar(100),
grade char(1),
home_ownership varchar(20),
issue_data varchar(20),
last_credit_pull_date varchar(20),
last_payment_date varchar(20),
loan_status varchar(20),
next_payment_date varchar(20),
member_id bigint,
purpose varchar(20),
sub_grade varchar(5),
term varchar(20),
verfication_status varchar(50),
annual_income int,
dti decimal (6,4),
installment decimal(10,2),
int_rate decimal(6,4),
loan_ammount int,
total_acc int,
total_payment decimal(10,2)
);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/financial_loan.csv'
into table loan_data
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;








-- TOTAL LOAN APPLICATIONS

select count(*) as total_loan_applications
from loan_data;





-- state wise loan applications

select address_state,count(*) as total_applications
from loan_data
group by address_state
order by total_applications desc;






--  most of the applicatons in CA,NY

-- grade wise loan applictions

select grade,count(*) as total_applications
from loan_data
group by grade
order by grade;







-- loan-status wise loan applications

select loan_status, count(*) as total_applications
from loan_data
group by loan_status
order by total_applications desc;








-- pupose wise loan applications

select purpose, count(*) as total_applications
from loan_data
group by purpose
order by total_applications desc;






-- verifications status - wise total_applications

select verfication_status, count(*) as total_applications
from loan_data
group by verfication_status
order by total_applications desc;   -- most of applicatons is not verified 16464





-- home ownership wise total_applications

select home_ownership,count(*) as total_applications
from loan_data
group by home_ownership
order by total_applications desc;








-- emp_lenght wise loan applications

select emp_lenght, count(*) as total_applications
from loan_data
group by emp_lenght
order by total_applications desc;






-- avg loan amount by grade
select grade,avg(loan_ammount) as avg_loan_ammount
from loan_data
group by grade
order by grade;







-- avg interest rate by sub-grade

SELECT 
    sub_grade,
    ROUND(AVG(int_rate) * 100, 2) AS avg_int_rate_percentage
FROM
    loan_data
GROUP BY sub_grade
ORDER BY sub_grade;








-- default rate by state

SELECT 
    address_state,
    COUNT(*) AS total_loans,
    SUM(CASE
        WHEN loan_status = 'Charged off' THEN 1
        ELSE 0
    END) AS defaults,
    ROUND(SUM(CASE
                WHEN loan_status = 'Charged_off' THEN 1
                ELSE 0
            END) / COUNT(*) * 100,
            2) AS default_rate_percentage
FROM
    loan_data
GROUP BY address_state
ORDER BY defaults DESC;








-- average dti by emp_length
select emp_lenght,round(avg(dti),4) as avg_dti
from loan_data
group by emp_lenght
order by avg_dti desc;













-- top 5 emp with most loans

select emp_title, count(*) as total_loans
from loan_data
 group by emp_title
 order by total_loans desc
 limit 5;





-- total payment vs loan ammount

select id, loan_ammount, total_payment,
round(total_payment - loan_ammount,2) as profit_or_loss
from loan_data
order by profit_or_loss desc
limit 10;










-- loan purpose with highest avg income

select purpose, round(avg(annual_income),2) as avg_income
from loan_data
group by purpose
order by avg_income desc;








-- term wise default loans
select term,
count(*) as total_loans,
sum(case when loan_status = 'Charged off' then 1 else 0 end) as charged_off
from loan_data
group by term;









-- monthly installment burden vs income ratio

select id, annual_income,installment,
round((installment * 12 )/annual_income * 100,2) as yearly_installment_ratio
from loan_data
order by yearly_installment_ratio desc
limit 10;


