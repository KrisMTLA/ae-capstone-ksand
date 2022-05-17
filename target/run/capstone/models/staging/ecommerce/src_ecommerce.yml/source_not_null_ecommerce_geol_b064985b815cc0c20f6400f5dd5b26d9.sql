select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select geolocation_zip_code_prefix
from `ae-capstone-raw`.`ecommerce`.`geolocations`
where geolocation_zip_code_prefix is null



      
    ) dbt_internal_test