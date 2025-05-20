SELECT a_origin.faa,
        a_dest.faa AS destination,
        a_origin.name AS origin_airport,
        a_origin.city AS origin_city,
        a_origin.country AS origin_country,
        a_dest.name AS destination_airport,
        a_dest.city AS destination_city,
        a_dest.country AS destination_country,
        COUNT(DISTINCT tail_number) AS num_unique_airplanes,
        COUNT(DISTINCT airline) AS num_unique_airlines,
        DATE_TRUNC('minute', AVG(actual_elapsed_time_interval)) AS avg_elapsed_time,
        DATE_TRUNC('minute', AVG(arr_delay_interval)) AS avg_arrival_delay,  
        MIN(arr_delay_interval) AS min_arrival_delay,
        MAX(arr_delay_interval) AS max_arrival_delay,
        SUM(cancelled) AS total_canceled,
        SUM(diverted) AS total_diverted
FROM
    {{ref('prep_flights')}} AS f
LEFT JOIN {{ref('prep_airports')}} AS a_dest ON
    f.dest = a_dest.faa
LEFT JOIN {{ref('prep_airports')}} AS a_origin ON 
    f.origin = a_origin.faa
GROUP BY a_origin.faa, a_origin.name, a_origin.city, a_origin.country, 
        a_dest.faa, a_dest.name, a_dest.city, a_dest.country