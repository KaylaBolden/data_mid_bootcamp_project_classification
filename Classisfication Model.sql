-- 1. Create a database called credit_card_classification.
create database credit_card_classification;
use credit_card_classification;

-- 2. Create a table credit_card_data with the same columns as given in the csv file. Please make sure you use the correct data types for each of the columns.
drop table if exists credit_card_data;
CREATE TABLE credit_card_data (
  `customer number` char(20) UNIQUE NOT NULL,
  `offer accepted` char(20) DEFAULT NULL,
  `purchase method` char(20) DEFAULT NULL,
  `mailer type` char(20) DEFAULT NULL,
  `income level` char(20) DEFAULT NULL,
  `bank accounts open` int(11) DEFAULT NULL,
  `overdraft protection` char(20) DEFAULT NULL,
  `credit rating` char(20) DEFAULT NULL,
  `credit cards held` int(11) DEFAULT NULL,
  `homes owned` int(11) DEFAULT NULL,
  `household size` int(11) DEFAULT NULL,
  `own your home` char DEFAULT NULL,
  `average balance` float DEFAULT NULL,
  `balance-q1` float DEFAULT NULL,
  `balance-q2` float DEFAULT NULL,
  `balance-q3` float DEFAULT NULL,
  `balance-q4` float DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (`customer number`)  -- constraint keyword is optional but its a good practice
);

-- 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. 
show variables like  'local_infile';
set global  local_infile=1;
SELECT @@GLOBAL.secure_file_priv;
load data local infile '/Users/kb/Ironhack/Labs/data_mid_bootcamp_project_classification/creditcardmarketing.csv'
into table credit_card_data
fields terminated by ',';

-- 4. Select all the data from table credit_card_data to check if the data was imported correctly.
select * from credit_card_data;

-- 5. Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
alter table credit_card_data
drop column `balance-q4`
;
select * 
from credit_card_data
limit 10;

-- 6. Use sql query to find how many rows of data you have.
select count(*) from credit_card_data;

-- 7.Now we will try to find the unique values in some of the categorical columns:
	-- What are the unique values in the column Offer_accepted?
    select distinct `offer accepted` from credit_card_data;
	-- What are the unique values in the column Reward? doesnt exist
    select distinct `Reward` from credit_card_data;
    -- What are the unique values in the column mailer_type?
    select distinct `mailer type` from credit_card_data;
	-- What are the unique values in the column credit_cards_held?
    select distinct `credit cards held` from credit_card_data;
	-- What are the unique values in the column household_size?
    select distinct `household size` from credit_card_data;

-- 8. Arrange the data in a decreasing order by the average_balance of the house. Return only the customer_number of the top 10 customers with the 
	-- highest average_balances in your data.
select
`customer number` from credit_card_data
order by `average balance` desc
limit 10;

-- 9. What is the average balance of all the customers in your data?
select
avg(`average balance`) from credit_card_data;
-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. 
	-- Note wherever average_balance is asked, please take the average of the column average_balance:

	-- What is the average balance of the customers grouped by Income Level? 
			-- The returned result should have only two columns, income level and Average balance of the customers. Use an alias to change the name of the second column.
            select `income level`
            , round(avg(`average balance`),2) as avg_balance 
            from credit_card_data
            group by `income level`;
	-- What is the average balance of the customers grouped by number_of_bank_accounts_open? 
			-- The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers. Use an alias to change the name of the second column.
			select `bank accounts open`
            , round(avg(`average balance`),2) as avg_balance 
            from credit_card_data
            group by `bank accounts open`;
	-- What is the average number of credit cards held by customers for each of the credit card ratings? 
			-- The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.
            select `credit rating`
            , round(avg(`credit cards held`),2) as avg_cnt_credit_cards  
            from credit_card_data
            group by `credit rating`;
	-- Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? 
			-- You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
            select `bank accounts open`
            , round(avg(`credit cards held`),2) as avg_cnt_credit_cards 
            from credit_card_data
            group by `bank accounts open`;
            
            #between 1&2 there is little to negative correlation, but from 1&2 to 3 there is a stronger positive correlation
            
-- 11. Your managers are only interested in the customers with the following properties:

	-- Credit rating medium or high
	-- Credit cards held 2 or less
	-- Owns their own home
	-- Household size 3 or more
	-- For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them? Can you filter the customers who accepted the offers here?
		select * from credit_card_data
        where `credit rating` in ('medium','high') 
        and `credit cards held`<=2
        and `own your home`='Y'
        and `household size` >=3
        ;
        #filtering for customers who aacepted the offer
		select * from credit_card_data
        where `credit rating` in ('medium','high') 
        and `credit cards held`<=2
        and `own your home`='Y'
        and `household size` >=3
        and `offer accepted`='Yes'
        ;
-- 12. Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem.
select `customer number` 
from credit_card_data
where `average balance`<(select avg(`average balance`) from credit_card_data);

-- 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
create or replace view below_avg_balance_customers as
select `customer number` 
from credit_card_data
where `average balance`<(select avg(`average balance`) from credit_card_data);
-- 14. What is the number of people who accepted the offer vs number of people who did not?
select `offer accepted`,count(*) as responce_cnt from credit_card_data
group by `offer accepted`;
-- 15. Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?
select 
round(avg(case 
when `credit rating` = 'high' then `average balance` else null end),2) as avg_balance_high_rating
,round(avg(case 
when `credit rating` = 'low' then `average balance` else null end),2) as avg_balance_low_rating
,round((avg(case 
when `credit rating` = 'high' then `average balance` else null end) 
-avg(case 
when `credit rating` = 'low' then `average balance` else null end)),2) as high_v_low_balance_difference
from credit_card_data
where `credit rating` <> 'medium';

-- 16. In the database, which all types of communication (mailer_type) were used and with how many customers?
select `mailer type`
, count(*) as customer_cnt 
from credit_card_data
group by `mailer type`;

-- 17. Provide the details of the customer that is the 11th least Q1_balance in your database.
select * from (select *,
dense_rank () over( order by `balance-q1` asc) as q1_rank
from credit_card_data)s1
where q1_rank =11;