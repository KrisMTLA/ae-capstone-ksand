with products as (

    select
        *
    from {{ source('ecommerce', 'products')}}

)

select * from products