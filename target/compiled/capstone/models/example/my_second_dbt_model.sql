-- Use the `ref` function to select from other models

select *
from `ae-capstone-transformed`.`dbt_ksand`.`my_first_dbt_model`
where id = 1