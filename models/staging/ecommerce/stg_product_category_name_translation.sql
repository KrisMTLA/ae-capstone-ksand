with product_category_name_translation as (

    select
        *
    from {{ source('ecommerce', 'product_category_name_translation')}}

)

select * from product_category_name_translation
