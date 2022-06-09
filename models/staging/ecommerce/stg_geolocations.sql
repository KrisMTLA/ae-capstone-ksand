with geolocations as (

    select
        *
    from {{ source('ecommerce', 'geolocations')}}

)

select * from geolocations
