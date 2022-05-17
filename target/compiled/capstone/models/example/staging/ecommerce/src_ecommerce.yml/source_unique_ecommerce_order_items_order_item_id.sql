
    
    

with dbt_test__target as (

  select order_item_id as unique_field
  from `ae-capstone-raw`.`ecommerce`.`order_items`
  where order_item_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1

