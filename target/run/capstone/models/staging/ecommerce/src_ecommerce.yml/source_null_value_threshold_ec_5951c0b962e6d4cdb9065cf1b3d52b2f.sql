select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from `ae-capstone-transformed`.`dbt_ksand_dbt_test__audit`.`source_null_value_threshold_ec_5951c0b962e6d4cdb9065cf1b3d52b2f`
    
      
    ) dbt_internal_test