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
        orders.ordered_at,
        orders.order_approved_at as approved_at,
        orders.order_delivered_carrier_date as delivered_carrier_at,
        orders.order_delivered_customer_date as delivered_customer_at,
        orders.order_estimated_delivery_date as estimated_delivery_at,
        reviews.reviewed_at,
    -- dimensions
        order_items.price,
        order_items.freight_value,
        case 
            when order_payments.payment_type is null then 'returned'
            else orders.order_status 
        end as order_status,
        coalesce(order_payments.payment_type, 'returned') as payment_type,
        coalesce(order_payments.payment_installments, 0) as payment_installments,
        coalesce(order_payments.payment_value, 0) as payment_amount,
        reviews.review_score,
        timestamp_diff(orders.order_delivered_carrier_date, orders.ordered_at, day) as days_from_ordered_to_carrier,
        timestamp_diff(orders.order_delivered_customer_date, orders.ordered_at, day) as days_from_ordered_to_delivered,
        timestamp_diff(orders.order_delivered_customer_date, orders.order_delivered_carrier_date, day) as days_from_carrier_to_delivered,
        case
            when orders.order_status = 'delivered' 
                and extract(day from orders.order_delivered_customer_date) = extract(day from orders.order_estimated_delivery_date) then 'on time'
            when orders.order_status = 'delivered' 
                and extract(day from orders.order_delivered_customer_date) > extract(day from orders.order_estimated_delivery_date) then 'late'
            when orders.order_status = 'delivered' 
                and extract(day from orders.order_delivered_customer_date) < extract(day from orders.order_estimated_delivery_date) then 'early'
        end as order_delivery_status,

    -- booleans
        case 
            when order_payments.payment_installments > 1 then 1 
            else 0 
        end as is_paid_with_installments,
        case 
            when reviews.review_score is not null then 1 
            else 0 
        end as is_reviewed,
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
