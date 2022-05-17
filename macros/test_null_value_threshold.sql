{% test null_value_threshold(model, column_name, threshold = 0.02) %}

{{ config(store_failures = true) }}

--Ensure that null values in a given column do not exceed a given percentage.

with calc as (
  select
    count(case when {{ column_name }} is null then 1 end)/count(*) as null_percent
  FROM {{ model }} 
)

select * from calc
where null_percent > {{ threshold }}

{% endtest %}