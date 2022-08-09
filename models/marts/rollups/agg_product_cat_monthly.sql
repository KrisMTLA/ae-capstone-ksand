with

orders as (

    select 
        *,
        timestamp_trunc(reviewed_at, month) as date_month 
    
    from {{ ref('fct_order_items') }}

),

products as ( 

    select * from {{ ref('dim_products') }}

),

product_cat_mean_avg as (

    select distinct
        orders.date_month,
        products.product_category,
        percentile_cont(orders.review_score, 0.5) 
            over (partition by orders.date_month, products.product_category) as median_review_score,
        avg(orders.review_score) 
            over (partition by orders.date_month, products.product_category) as average_review_score

    from orders
    left join products 
        on orders.product_id = products.product_id
    --only include reviewed orders for average and median metrics
    where orders.is_reviewed = 1
),

product_cat_scores as (

    select 
        orders.date_month,
        products.product_category,
        count(distinct(orders.order_item_sk)) as count_ordered_items,
        count(distinct(
            case
                when is_reviewed = 1 then orders.order_id
            end)) as count_category_w_review,
        count(distinct(
            case
                when is_reviewed = 1 and orders.review_score = 1 then orders.order_id
            end)) as count_category_1_score,
        count(distinct(
            case
                when is_reviewed = 1 and orders.review_score = 5 then orders.order_id
            end)) as count_category_5_score

    from orders
    left join products 
        on orders.product_id = products.product_id
    group by 1, 2

),

population_scores as (

    select 
        orders.date_month,
        count(distinct(
            case
                when is_reviewed = 1 then orders.order_id
            end)) as count_total_w_review,
        count(distinct(
            case
                when is_reviewed = 1 and orders.review_score = 1 then orders.order_id
            end)) as count_total_1_score,
        count(distinct(
            case
                when is_reviewed = 1 and orders.review_score = 5 then orders.order_id
            end)) as count_total_5_score

    from orders
    group by 1

),

final as (

    select
        --primary_key
        {{ dbt_utils.surrogate_key([
            'product_cat_scores.date_month', 
            'product_cat_scores.product_category'
        ]) }} as agg_product_cat_monthly_sk,
        product_cat_scores.date_month,
        product_cat_scores.product_category,

        --dimensions
        product_cat_scores.count_ordered_items,
        product_cat_scores.count_category_w_review,
        product_cat_scores.count_category_1_score,
        product_cat_scores.count_category_5_score,
        safe_divide(product_cat_scores.count_category_1_score, product_cat_scores.count_category_w_review) as cat_score_freq_1,
        safe_divide(product_cat_scores.count_category_5_score, product_cat_scores.count_category_w_review) as cat_score_freq_5,
        product_cat_mean_avg.median_review_score,
        product_cat_mean_avg.average_review_score,
        population_scores.count_total_w_review,
        population_scores.count_total_1_score,
        population_scores.count_total_5_score,
        safe_divide(population_scores.count_total_1_score, population_scores.count_total_w_review) as pop_score_freq_1,
        safe_divide(population_scores.count_total_5_score, population_scores.count_total_w_review) as pop_score_freq_5,

    from product_cat_scores
    left join population_scores
        on product_cat_scores.date_month = population_scores.date_month
    left join product_cat_mean_avg
        on product_cat_scores.date_month = product_cat_mean_avg.date_month
        and product_cat_scores.product_category = product_cat_mean_avg.product_category
)

select * from final
