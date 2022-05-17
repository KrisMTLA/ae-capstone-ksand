select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from `ae-capstone-transformed`.`dbt_ksand_dbt_test__audit`.`source_null_value_threshold_ec_587781ac3dc6f2b50abc8a3ddfec6778`
    
      
    ) dbt_internal_test