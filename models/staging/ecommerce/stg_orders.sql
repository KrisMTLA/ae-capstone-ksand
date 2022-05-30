with orders as (

    select
        *
    from {{ source('ecommerce', 'orders')}}

)

select * from orders