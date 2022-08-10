with customers as  (

    select * from {{ ref('stg_customers')}}

),

orders as  (

    select * from {{ ref('stg_orders') }}

),

customer_first_last_order_at as (

    select
        customer_id,
        first_value(orders.ordered_at) over (
            partition by orders.customer_id 
            order by orders.ordered_at asc
        ) as first_order_at,
        last_value(orders.ordered_at) over (
            partition by orders.customer_id 
            order by orders.ordered_at asc
        ) as last_order_at
    from orders
    --only consider complete (delivered) orders
    where orders.order_status = 'delivered'
),

days_since_first_last as (
    
    select
        customer_id,
        timestamp_diff(current_timestamp, customer_first_last_order_at.first_order_at, day) as days_since_first_order,
        timestamp_diff(current_timestamp, customer_first_last_order_at.last_order_at, day) as days_since_last_order,
        timestamp_diff(customer_first_last_order_at.last_order_at, customer_first_last_order_at.first_order_at, day) as days_between_first_last_order
    from customer_first_last_order_at
),

final as (

    select
    -- primary key
        customers.customer_id,
    -- foreign keys
        customers.customer_unique_id,
    -- dimensions
        customers.customer_zip_code_prefix,
        customers.customer_city,
        customers.customer_state,
        days_since_first_last.days_since_first_order,
        days_since_first_last.days_since_last_order,
        days_since_first_last.days_between_first_last_order,
    --boolean
        --customer considered active if they have made an order in the past 45 days
        case 
            when days_since_first_last.days_since_last_order <= 45 then true
            else false
        end as is_active,


    -- database
        current_timestamp() as dbt_updated_at

    from customers
    left join days_since_first_last
        on customers.customer_id = days_since_first_last.customer_id
)

select * from final
