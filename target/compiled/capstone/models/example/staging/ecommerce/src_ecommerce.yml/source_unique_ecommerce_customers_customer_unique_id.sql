
    
    

with dbt_test__target as (

  select customer_unique_id as unique_field
  from `ae-capstone-raw`.`ecommerce`.`customers`
  where customer_unique_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1

