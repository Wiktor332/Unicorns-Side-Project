select * from unicorn3;

delete from unicorn3
where Company = Null


--Private companies with valuation over $1 billion as of March 2022, including each companys's current valuation, funding, country of origin, industry, select investors, and the years founded and became unicorns.

--QUESTIONS--

-- Number of companies in different industries, grouped by industry and ordered by the number 
select top 10
    Industry, count(Company) as number_of_unicorns
from unicorn3
group by Industry
order by number_of_unicorns desc
--COMMENT 
--At the first place we have unicorns operating in Fintech industry (224), then we have Internet software&services (205) and at the third place we have E-commerce & direct-to-consumer (111). At the fourth place we have Artificial Intelligence (84)
--then we have Health, Other, Supply chain, logistics&delivery, Cybersecurity, Data management & analytics and at the last place Mobile & telecommunications

--How Long does it usually take for a company to become a unicorn? Has it always been this way?
--CTE
with
    cte1
    as
    (
        select *, (Date_Joined) - (Year_Founded) as time_till_becoming_an_unicorn
        from unicorn3
    )
--Final Quary 
select round(avg(time_till_becoming_an_unicorn), 2) as average_time_till_becoming_unicorn
from cte1
--COMMENT--
--It takes a company on average 6 years to become an unicorn

--Which 10 unicorns have had the biggest return on investment and how many years it took them to become one?
select top 10  Company, Valuation, Industry, Year_Founded, Funding, round(((Valuation - Funding)/(Funding))*100, 2) as return_on_investment, (Date_Joined) - (Year_Founded) as time_till_becoming_an_unicorn
from unicorn3 
order by return_on_investment DESC;

--Top 10 Companies which became unicorns the slowest 
select top 10
    Company, Industry, (Date_Joined) - (Year_Founded) as time_till_becoming_an_unicorn, Date_Joined, Year_Founded
from unicorn3
where Year_Founded <= Date_Joined
order by time_till_becoming_an_unicorn desc;

--Companies with the least funding and biggest valuation 
Select top 10
    Company, min(Funding) as least_funding, max(Valuation) as companies_with_biggest_valuation
from unicorn3
group by Company
order by companies_with_biggest_valuation, least_funding


--Number of companies established between 1990 and 2021
--First CTE
with
    cte1
    as
    (
        select *,
            case 
    when Year_Founded >= 1990 and Year_Founded < 1995 then '1990-1995'
    when Year_Founded >= 1995 and Year_Founded < 2000 then '1995-2000'
    when Year_Founded >= 2000 and Year_Founded < 2005 then '2000-2005'
    when Year_Founded >= 2005 and Year_Founded < 2010 then '2005-2010'
    when Year_Founded >= 2010 and Year_Founded < 2015 then '2010-2015'
    when Year_Founded >= 2015 and Year_Founded < 2020 then '2015-2020'
    when Year_Founded >= 2020 and Year_Founded <= 2021 then '2020-2021'
else Null end as 'Decade_of_Establishment'
        from unicorn3
        where Year_Founded > 1984
    )
--3 records have been not icluded because i found them not usefull

--Final Query
select c1.Decade_of_Establishment, count(c1.Company) as number_of_unicorns
from cte1 as c1
group by c1.Decade_of_Establishment
order by number_of_unicorns desc

--Number of unicorns established in different continents and different countries goruped by continent, country and ordered by number of unicorns
select top 10
    Continent, Country, City, count(Company) as number_of_unicors
from unicorn3
group by Continent, Country, City
order by number_of_unicors desc











