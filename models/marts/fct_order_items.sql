with order_items as  (
    select * from {{ ref('stg_order_items' )}}
),

orders as  (
    select * from {{ ref('stg_orders' )}}
),

order_payments as  (
    select * from {{ ref('stg_order_payments' )}}
),

reviews as (
    select * from {{ ref('stg_order_reviews') }}
),

final as (

    select
    -- primary key
        order_items.order_item_sk,
    -- foreign keys
        order_items.order_id,
        order_items.product_id,
        order_items.seller_id,
        orders.customer_id,
    -- timestamps
        orders.order_purchase_timestamp as ordered_at,
        orders.order_approved_at as approved_at,
        orders.order_delivered_carrier_date as delivered_carrier_at,
        orders.order_delivered_customer_date as delivered_customer__at,
        orders.order_estimated_delivery_date as estimated_delivery_at,
    -- dimensions
        order_items.price,
        order_items.freight_value,
        orders.order_status,
        order_payments.payment_type,
        order_payments.payment_installments as payment_installments,
        order_payments.payment_value as payment_amount,
        reviews.review_score as order_review_score,
    -- booleans
        case when order_payments.payment_installments > 1 then 1 
            else 0 end as is_paid_with_installments,
        case when reviews.review_score is not null then 1 
            else 0 end as is_reviewed,
    -- database
        current_timestamp() as dbt_updated_at

    from order_items
    left join orders 
        using (order_id)
    left join order_payments 
        using (order_id)
    left join reviews 
        using (order_id)
)

select * from final