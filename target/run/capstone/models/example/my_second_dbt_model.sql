

  create or replace view `ae-capstone-transformed`.`dbt_ksand`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `ae-capstone-transformed`.`dbt_ksand`.`my_first_dbt_model`
where id = 1;

