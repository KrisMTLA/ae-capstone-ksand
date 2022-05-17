select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from `ae-capstone-transformed`.`dbt_ksand_dbt_test__audit`.`source_null_value_threshold_ec_b2b211e70f4889562df00de8b7bbadbb`
    
      
    ) dbt_internal_test