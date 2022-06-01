with sellers as  (
    select * from {{ ref('stg_sellers' )}}
),

final as (

    select
    -- primary key
        sellers.seller_id,
    -- dimensions
        sellers.seller_zip_code_prefix,
        sellers.seller_city,
        sellers.seller_state,
    -- database
        current_timestamp() as dbt_updated_at

    from sellers
)

select * from final