with customers as  (
    select * from {{ ref('stg_customers' )}}
),

final as (

    select
    -- primary key
        customers.customer_id,
    -- foreign keys
        customers.customer_unique_id,
    -- dimensions
        customers.customer_zip_code_prefix,
        customers.customer_city,
        customers.customer_state,
    -- database
        current_timestamp() as dbt_updated_at

    from customers
)

select * from final