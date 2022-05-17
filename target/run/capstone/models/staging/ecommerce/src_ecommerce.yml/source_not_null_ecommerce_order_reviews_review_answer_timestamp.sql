select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select review_answer_timestamp
from `ae-capstone-raw`.`ecommerce`.`order_reviews`
where review_answer_timestamp is null



      
    ) dbt_internal_test