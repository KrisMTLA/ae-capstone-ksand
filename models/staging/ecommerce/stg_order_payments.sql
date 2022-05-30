with order_payments as (

    select
        *
    from {{ source('ecommerce', 'order_payments')}}

)

select * from order_payments