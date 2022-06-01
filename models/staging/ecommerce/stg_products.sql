with products as (

    select
        product_id,
        product_category_name,
        coalesce(product_name_lenght, 0) as product_name_lenght,
        coalesce(product_description_lenght, 0) as product_description_lenght,
        coalesce(product_photos_qty, 0) as product_photos_qty,
        coalesce(product_weight_g, 0) as product_weight_g,
        coalesce(product_length_cm, 0) as product_length_cm,
        coalesce(product_height_cm, 0) as product_height_cm,
        coalesce(product_width_cm, 0) as product_width_cm
    from {{ source('ecommerce', 'products')}}

)

select * from products