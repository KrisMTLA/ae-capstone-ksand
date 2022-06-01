with order_payments as (

    select
        order_id,
        payment_sequential,
        coalesce(payment_type, 'other') as payment_type,
        case when payment_installments < 1 then 1
            when payment_installments is null then 1
            else payment_installments end as payment_installments,
        payment_value
    from {{ source('ecommerce', 'order_payments')}}

)

select * from order_payments