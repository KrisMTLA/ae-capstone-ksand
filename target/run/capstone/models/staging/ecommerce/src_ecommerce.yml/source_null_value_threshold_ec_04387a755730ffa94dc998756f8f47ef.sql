select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from `ae-capstone-transformed`.`dbt_ksand_dbt_test__audit`.`source_null_value_threshold_ec_04387a755730ffa94dc998756f8f47ef`
    
      
    ) dbt_internal_test