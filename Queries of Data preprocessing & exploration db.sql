show databases;
use ecomm;
select * from customer_churn;
select * from customer_returns;


-- Handling Missing Values and Outliers:
/* 1) Impute mean for the following columns, and round off to the nearest integer if
      required: WarehouseToHome, HourSpendOnApp, OrderAmountHikeFromlastYear,
      DaySinceLastOrder*/
     
   select avg(WareHouseToHome),            
		  avg(HourSpendOnApp),              
		  avg(OrderAmountHikeFromlastYear), 
		  avg(DaySinceLastOrder)            
   from customer_churn;       
     -- round off              
   select round(15.6399), 
	        round(2.9315),  
	        round(15.7079), 
            round(4.5435);  

   update customer_churn
   set WareHouseToHome = 16
   where WareHouseToHome is null ;

   update customer_churn
   set HourSpendOnApp = 3
   where HourSpendOnApp  is null ;

   update customer_churn
   set OrderAmountHikeFromlastYear = 16
   where OrderAmountHikeFromlastYear is null ;

   update customer_churn
   set DaySinceLastOrder = 5
   where DaySinceLastOrder is null ;

-- 2) Impute mode for the following columns: Tenure, CouponUsed, OrderCount
   select Tenure, count(*) as Total_Count
   from customer_churn
   group by Tenure
   order by Total_Count desc;  
     
   select CouponUsed, count(*) as Total_Count
   from customer_churn
   group by CouponUsed
   order by Total_Count desc;  
       
   select OrderCount, count(*) as Total_Count
   from customer_churn
   group by OrderCount
   order by Total_Count desc;   
     
   update customer_churn
   set Tenure = 1
   where Tenure is null;
     
   update customer_churn
   set CouponUsed = 1
   where CouponUsed is null;
     
   update customer_churn
   set  OrderCount = 2
   where OrderCount is null;
     
/* 3) Handle outliers in the 'WarehouseToHome' column by deleting rows where the
      values are greater than 100 */
	delete from customer_churn
	where WareHouseToHome > 100;
     
     
     
-- DEALING WITH INCONSISTENCIES
/* 1) Replace occurrences of “Phone” in the 'PreferredLoginDevice' column and
	 'Mobile' in the 'PreferedOrderCat' column with “Mobile Phone” to ensure
	  uniformity */
   select distinct PreferredPaymentMode from  customer_churn;

   update customer_churn
   set PreferredLoginDevice = "Mobile Phone"
   where PreferredLoginDevice in ("Phone");
     
   update customer_churn
   set PreferedOrderCat = "Mobile Phone"
   where PreferedOrderCat in ("Mobile");
     
/* 2) Standardize payment mode values: Replace "COD" with "Cash on Delivery" and
      "CC" with "Credit Card" in the PreferredPaymentMode column*/
   update customer_churn
   set PreferredPaymentMode= "Cash on Delivery"
   where PreferredPaymentMode in ("COD");
     
   update customer_churn
   set PreferredPaymentMode= "Credit Card"
   where PreferredPaymentMode in ("CC");
 


-- DATA TRANSFORMATION

/* 1) Column Renaming:
      Rename the column "PreferedOrderCat" to "PreferredOrderCat".
      Rename the column "HourSpendOnApp" to "HoursSpentOnApp" */
   alter table customer_churn
   rename column
   PreferedOrderCat to PreferredOrderCat;

   alter table customer_churn
   rename column
   HourSpendOnApp to HourSpentOnApp;
     
/* 2) Creating New Columns:
      Create a new column named ‘ComplaintReceived’ with values "Yes" if the
      corresponding value in the ‘Complain’ is 1, and "No" otherwise.
   
      Create a new column named 'ChurnStatus'. Set its value to “Churned” if the
      corresponding value in the 'Churn' column is 1, else assign “Active” */
   alter table customer_churn
   add column ComplaintReceived varchar(30)
   after Complain;
     
   update customer_churn
   set  ComplaintReceived = Case 
   when Complain = 1 then "Yes"
   when Complain = 0 then "No"
   end;
     
   alter table customer_churn
   add column ChurnStatus varchar(30)
   after Churn;

   update customer_churn
   set  ChurnStatus = Case 
   when Churn = 1 then "Churned"
   when Churn = 0 then "Active"
   end;
     
 -- 3) Drop the columns "Churn" and "Complain" from the table.
   alter table customer_churn
   drop column Churn; 
   alter table customer_churn
   drop column Complain;
     
     
     
-- DATA EXPLORATION AND ANALYSIS

-- 1) Retrieve the count of churned and active customers from the dataset.
   select ChurnStatus, count(*)  
   from customer_churn           
   group by ChurnStatus;
     
-- 2) Display the average tenure and total cashback amount of customers who churned.
   select sum(CashBackAmount) from  customer_churn   
   where ChurnStatus in ("Churned");    
 
   select avg(Tenure) from  customer_churn   
   where ChurnStatus in ("Churned");         
   select round(3.1762);
  
  -- 3) Determine the percentage of churned customers who complained. 
   select ChurnStatus, count(*)   
   from customer_churn            
   group  by ChurnStatus;
   
   select ChurnStatus, count(*)    
   from customer_churn   
   where ComplaintReceived in ("Yes")  
   group  by ChurnStatus;
   select 508/948 * 100 as Churned_customers_who_complainted;  
      
/* 4) Identify the city tier with the highest number of churned customers whose
      preferred order category is Laptop & Accessory.*/
   select CityTier, count(*)  
   from customer_churn               
   where ChurnStatus in ("Churned")  
   and PreferredOrderCat in ("Laptop & Accessory")
   group  by CityTier;  
   
-- 5) Identify the most preferred payment mode among active customers.  
   select PreferredPaymentMode, count(*)   
   from customer_churn                    
   where ChurnStatus in ("Active")        
   group  by PreferredPaymentMode; 
   
/* 6) Calculate the total order amount hike from last year for customers who are single
      and prefer mobile phones for ordering. */
   select sum(OrderAmountHikeFromlastYear)  
   from customer_churn                       
   where MaritalStatus in ("single")        
   and PreferredOrderCat in ("Mobile Phone");
    
/* 7) Find the average number of devices registered among customers who used UPI as
      their preferred payment mode.*/  
   select avg(NumberOfDeviceRegistered) as avg_no_registered_device
   from customer_churn where PreferredPaymentMode in ("UPI");      
   select round(3.7174);                            

-- 8) Determine the city tier with the highest number of customers.
   select CityTier,count(*) as number_of_customers   
   from customer_churn                                  
   group by CityTier;


-- 9) Identify the gender that utilized the highest number of coupons.
   select Gender,count(CouponUsed) as coupons_used       
   from customer_churn                                  
   group by Gender;
      
/* 10) List the number of customers and the maximum hours spent on the app in each
       preferred order category.*/
   select PreferredOrderCat,sum(HourSpentOnApp)     
   as number_of_hours_spent from customer_churn     
   group by PreferredOrderCat;   
   
/* 11) Calculate the total order count for customers who prefer using credit cards and
       have the maximum satisfaction score.*/  
   select count(PreferredPaymentMode) from customer_churn                     
   where PreferredPaymentMode in ("Credit Card") and SatisfactionScore in (5);                                                                             
                                                                                
   
-- 12) What is the average satisfaction score of customers who have complained?
   select avg(SatisfactionScore) from customer_churn   
   where ComplaintReceived in ("Yes");                
   select round(2.9998);
   
-- 13) List the preferred order category among customers who used more than 5 coupons.
   select count(preferredOrderCat) from customer_churn
   where CouponUsed > 5 ;                            
													 
-- 14) List the top 3 preferred order categories with the highest average cashback amount.
   select PreferredOrderCat, avg(CashBackAmount)  
   as Categories from customer_churn              
   group by PreferredOrderCat                     
   order by Categories desc;                      
   
/* 15) Find the preferred payment modes of customers whose average tenure is 10
       months and have placed more than 500 orders. */
   select PreferredPaymentMode, round(avg(Tenure),0) as AvgTenure,    
   sum(OrderCount) as TotalOrders from customer_churn                 
   group by PreferredPaymentMode                                    
   having round(avg(Tenure),0) = 10 and SUM(OrderCount) > 500;
   
   
/* 16) Categorize customers based on their distance from the warehouse to home such
       as 'Very Close Distance' for distances <=5km, 'Close Distance' for <=10km,
	   'Moderate Distance' for <=15km, and 'Far Distance' for >15km. Then, display the
       churn status breakdown for each distance category. */
   alter table customer_churn
   add column Distance varchar(30)
   after WarehouseToHome;
   
   update customer_churn
   set Distance = case 
   when WarehouseToHome <= 5 then "Very Close Distance"
   when WarehouseToHome <= 10 then "Close Distance"
   when WarehouseToHome <= 15 then "Moderate Distance"  
   when WarehouseToHome > 15 then "Far Distance"        
   end;                                                 
   select Distance, count(*) as CountOfDistance        
   from customer_churn                            
   where ChurnStatus = "Churned"                  
   group by Distance;                            
   
/* 17) List the customer’s order details who are married, live in City Tier-1, and their
       order counts are more than the average number of orders placed by all
       customers. */ 
   select * from customer_churn
   where MaritalStatus = 'Married' and CityTier = 1
   and OrderCount > (select avg(OrderCount) 
   from customer_churn);


-- 18)
-- a) Create a ‘customer_returns’ table in the ‘ecomm’ database and insert the following data: 
   create table customer_returns(
             ReturnID int primary key auto_increment,
             CustomerID int unique,
             ReturnDate date,
             RefundAmount decimal(10,2)
             );
             
   alter table customer_returns
   auto_increment = 1001;            

   insert into customer_returns(CustomerID, ReturnDate, RefundAmount)
					  values(50022, "2023-01-01", 2130),
                            (50316, "2023-01-23", 2000),
                            (51099, "2023-02-14", 2290),
                            (52321, "2023-03-08", 2510),
                            (52928, "2023-03-20", 3000),
                            (53749, "2023-04-17", 1740),
                            (54206, "2023-04-21", 3250),
                            (54838, "2023-04-30", 1990);
   select * from customer_returns;                       
                            
	
/* b) Display the return details along with the customer details of those who have
      churned and have made complaints. */
   select *
   from customer_churn
   inner join customer_returns
   on customer_churn.CustomerID = customer_returns.CustomerID
   where customer_churn.ChurnStatus = 'Churned'
   and customer_churn.ComplaintReceived = 'Yes';

   
   
   
      
   
   
   
   
