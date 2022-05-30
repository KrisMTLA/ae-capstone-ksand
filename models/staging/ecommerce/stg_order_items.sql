with order_items as (

    select
        {{ dbt_utils.surrogate_key(['order_item_id', 'order_id']) }} as order_item_sk, 
        *
    from {{ source('ecommerce', 'order_items')}}

)

select * from order_items