-- 

with calc as (
  select
    count(case when product_category_name is null then 1 end)/count(*) as null_percent
  FROM `ae-capstone-raw.ecommerce.products` 
)

select * from calc
where null_percent > 0.02