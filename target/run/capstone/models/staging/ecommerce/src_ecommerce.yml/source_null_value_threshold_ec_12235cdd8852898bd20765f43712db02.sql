select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      



--Ensure that null values in a given column do not exceed a given percentage.

with calc as (
  select
    count(case when product_category_name is null then 1 end)/count(*) as null_percent
  FROM `ae-capstone-raw`.`ecommerce`.`products` 
)

select * from calc
where null_percent > 0.01


      
    ) dbt_internal_test