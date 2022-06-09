with sellers as (

    select
        *
    from {{ source('ecommerce', 'sellers')}}

)

select * from sellers
