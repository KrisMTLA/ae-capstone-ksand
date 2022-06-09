with products as  (
    select * from {{ ref('stg_products') }}
),

product_category_name_translation as  (
    select * from {{ ref('stg_product_category_name_translation') }}
),

final as (

    select
    -- primary key
        products.product_id,
    -- dimensions
        coalesce(product_category_name_translation.string_field_1, 'other') as product_category,
        products.product_photos_qty,
        products.product_weight_g,
        products.product_length_cm,
        products.product_height_cm,
        products.product_width_cm,
    -- database
        current_timestamp() as dbt_updated_at

    from products
    left join product_category_name_translation 
        on products.product_category_name = product_category_name_translation.string_field_0
)

select * from final
