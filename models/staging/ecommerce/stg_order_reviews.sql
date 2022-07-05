with order_reviews as (

    select
        *
    from {{ source('ecommerce', 'order_reviews')}}

)

select * from order_reviews
