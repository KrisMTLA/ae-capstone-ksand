select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select string_field_0
from `ae-capstone-raw`.`ecommerce`.`product_category_name_translation`
where string_field_0 is null



      
    ) dbt_internal_test