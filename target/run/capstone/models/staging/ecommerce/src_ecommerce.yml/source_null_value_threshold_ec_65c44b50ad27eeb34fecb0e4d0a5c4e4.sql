select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from `ae-capstone-transformed`.`dbt_ksand_dbt_test__audit`.`source_null_value_threshold_ec_65c44b50ad27eeb34fecb0e4d0a5c4e4`
    
      
    ) dbt_internal_test