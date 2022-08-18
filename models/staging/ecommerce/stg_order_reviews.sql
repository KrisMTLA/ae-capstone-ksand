with order_reviews as (

    select
        --primary key
        review_id,

        --foreign keys
        order_id,

        --timestamps
        review_creation_date as reviewed_at,
        review_answer_timestamp as review_answered_at,

        --dimensions
        review_score

    from {{ source('ecommerce', 'order_reviews')}}

)

select * from order_reviews
