
    
    

with dbt_test__target as (

  select geolocation_zip_code_prefix as unique_field
  from `ae-capstone-raw`.`ecommerce`.`geolocations`
  where geolocation_zip_code_prefix is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


