SELECT airport_code,
        station_id,
        cw,
        ROUND(AVG(avg_temp_c), 2) AS avg_temp,
        MIN(min_temp_c) AS min_temp,
        MAX(max_temp_c) AS max_temp,
        SUM(precipitation_mm) AS total_precipitation,
        MAX(max_snow_mm) AS max_snow,
        ROUND(AVG(avg_wind_direction), 2) AS avg_wind_direction,
        ROUND(AVG(avg_wind_speed_kmh), 2) AS avg_wind_speed,
        MAX(wind_peakgust_kmh) AS max_wind_peakgust,
        ROUND(AVG(avg_pressure_hpa), 2) AS avg_pressure,
        SUM(sun_minutes) AS total_sun_min,
        month_name    
FROM {{ref('prep_weather_daily')}}    
GROUP BY airport_code, station_id, cw, month_name
ORDER BY cw