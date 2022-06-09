with customers as (

    select
        *
    from {{ source('ecommerce', 'customers')}}

)

select * from customers
