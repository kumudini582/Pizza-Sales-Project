create database pizza_sales
use pizza_sales

select * from pizza

--What days and times do we tend to be busiest?--

select datename(weekday,order_date) days,count(distinct order_id) total_order,(count(distinct order_id)/count(distinct order_date)) avg_order_daily from pizza
group by datename(weekday,order_date)
order by (count(distinct order_id)/count(distinct order_date)) desc

select concat(format((datepart(hour,order_time) +11) %12 + 1,'00'),
		' ', iif(datepart(hour,order_time)<12,'AM','PM')) hours,count(distinct order_id) total_order from pizza
group by concat(format((datepart(hour,order_time) +11) %12 + 1,'00'),
		' ', iif(datepart(hour,order_time)<12,'AM','PM'))
order by count(distinct order_id) desc

select format((datepart(hour, order_time) +11) %12 +1,'00')
--Total Revenue--
select round(sum(total_price),0) Total_amount from pizza

--Average Order Value--
select round(sum(total_price)/count(distinct order_id),2) avg_order_value from pizza

--Total Pizzas Sold--
select count(quantity) Total_pizza_sold from pizza

--Daily Trend for Total Orders--
select day(order_date) days,count(order_id) no_of_orders from pizza
group by day(order_date)
order by day(order_date)

--Total Orders--
select count(distinct order_id) Total_orders from pizza

--Average Pizzas Per Order--
select round(sum(total_price)/count(pizza_id),2) avg_pizza_per_order from pizza

--Monthly Trend for Orders--
select datename(month,order_date) Months,count(distinct order_id) Total_orders from pizza
group by datename(month,order_date)
order by count(distinct order_id) desc

--% of Sales by Pizza Category--
select pizza_category,round(sum(total_price),0) total_price,round(sum(total_price)*100/(select(sum(total_price))from pizza),2) percentages from pizza
group by pizza_category
order by round(sum(total_price)*100/(select(sum(total_price))from pizza),2) desc

--best selling pizza--
select top 3 pizza_name,sum(quantity) Pizza_sold from pizza
group by pizza_name
order by sum(quantity) desc

--worst selling pizza--
select top 3 pizza_name,sum(quantity) Pizza_sold from pizza
group by pizza_name
order by sum(quantity) 

--Percentage of Sales by pizza size--
select pizza_size,
round(sum(total_price),0) Total_price,round(sum(total_price)*100/(select(sum(total_price)) from pizza),0) percentage_of_sales from pizza
group by pizza_size
order by round(sum(total_price)*100/(select(sum(total_price))from pizza),0) desc

select * from pizza

-- Total pizza sold by pizza category--
select pizza_category,sum(quantity) Total_quantity from pizza
group by pizza_category 
order by sum(quantity) desc

-- Total orders by pizza category--
select pizza_category,count(distinct order_id) total_order from pizza
group by pizza_category
order by count(distinct order_id) desc

-- Top 5 and bottom 5 pizzas by revenue, quantity, and orders--

-- Top 5 pizzas by quantity--
select top 5 pizza_name,sum(quantity) total_quantity from pizza
group by pizza_name
order by 2 desc

-- Top 5 pizzas by revenue--
select top 5 pizza_name,sum(total_price) total_price from pizza
group by pizza_name
order by 2 desc

-- Top 5 pizzas by order--
select top 5 pizza_name,count(order_id) total_orders from pizza
group by pizza_name
order by 2 desc

-- bottom 5 pizzas by quantity--
select top 5 pizza_name,sum(quantity) total_quantity from pizza
group by pizza_name
order by 2 

-- bottom 5 pizzas by revenue--
select top 5 pizza_name,round(sum(total_price),0) total_price from pizza
group by pizza_name
order by 2

-- bottom 5 pizzas by order--
select top 5 pizza_name,count(distinct order_id) total_order from pizza
group by pizza_name
order by 2 
