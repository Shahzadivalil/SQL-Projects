SELECT * FROM `global youtube statistics`;

-- 1a. Top continets in the YT space; Uploads, views, earnings and Subs
SELECT 

CASE
 when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,

sum(subscribers) AS total_subs, 
sum(uploads) AS total_uploads, 
(`video views`) AS total_views, 
round(sum(highest_yearly_earnings),0) AS total_earnings,
COUNT(Youtuber) as num_of_youtubers

FROM youtube.`global youtube statistics`
GROUP BY continents
ORDER BY 5 DESC;


-- 2. top 8 countries,pct pay

With pct_pay AS(
SELECT 

CASE
 when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,


round(sum(highest_yearly_earnings),0) AS total_earnings


FROM youtube.`global youtube statistics`
GROUP BY 1
ORDER BY 2 DESC
)
SELECT
SUM(total_earnings) AS total_earnings,

ROUND(1.0 * SUM(case when continents = 'Africa' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_africa,
ROUND(1.0 * SUM(case when continents = 'Asia' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_Asia,
ROUND(1.0 * SUM(case when continents = 'North_America' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_Nprth_America,
ROUND(1.0 * SUM(case when continents = 'Europe' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_Europe,
ROUND(1.0 * SUM(case when continents = 'South_America' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_South_America,
ROUND(1.0 * SUM(case when continents = 'Australia_and_Oceania' then total_earnings else 0 end)/NULLIF(SUM(total_earnings),0) *100,2) AS pct_earnings_Australia_and_Oceania

FROM pct_pay;

-- 3. Top 8 Channel type,count views

With country_pct AS ( 
SELECT
country,
ROUND(SUM(highest_yearly_earnings),0) AS total_earnings
FROM Youtube.`global youtube statistics`
GROUP BY 1
ORDER BY 2 DESC

)
SELECT 
SUM(total_earnings) as total_earnings,
round(1.0*SUM(CASE WHEN country ='United States' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_us,

round(1.0*SUM(CASE WHEN country ='India' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_india,

round(1.0*SUM(CASE WHEN country ='Brazil' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_Brazil,

round(1.0*SUM(CASE WHEN country ='South Korea' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_southkorea,

round(1.0*SUM(CASE WHEN country ='United Kingdom' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_uk,

round(1.0*SUM(CASE WHEN country ='Pakisthan' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_pakisthan,

round(1.0*SUM(CASE WHEN country ='Argentina' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_argentina,
round(1.0*SUM(CASE WHEN country ='Russia' THEN total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) AS pct_russia

FROM country_pct;

# 3. Top 8 Channel type,count views

SELECT
channel_type,
SUM(`video views`) as total_views
FROM Youtube.`global youtube statistics`
Group BY 1
ORDER BY 2 DESC
LIMIT 8;
