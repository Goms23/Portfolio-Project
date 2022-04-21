SELECT *
FROM PortfolioProject..covid_deaths$
and continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject..Covid_vaccinations$
--order by 3,4

/* select data that we need to use for this project*/

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..covid_deaths$
order by 1,2

/* Total cases Vs Total Deaths
Total Covid Death count in India 
*/

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..covid_deaths$
where location like '%India%'
and continent is not null
order by 1,2

/* Total cases Vs Population
*/
SELECT location, date, total_cases, population, (total_cases/population)*100 as CovidPercentage
FROM PortfolioProject..covid_deaths$
where location like '%India%'
and continent is not null
order by 1,2

--Countries with highest covid infection count

SELECT location, population, MAX(total_cases) as highestinfectioncount, MAX((total_cases/population))*100 as CovidinfectedPercentage
FROM PortfolioProject..covid_deaths$
group by location, population
order by CovidinfectedPercentage desc

--Countries with the Highest Covid death count

SELECT location, MAX(cast(total_deaths as int)) as totaldeathcount
FROM PortfolioProject..covid_deaths$
where continent is not null
group by location
order by totaldeathcount desc

/* break data by continent wise*/
/*continents with highest death counts*/

SELECT continent, MAX(cast(total_deaths as int)) as totaldeathcount
FROM PortfolioProject..covid_deaths$
where continent is not null
group by continent
order by totaldeathcount desc

/*Global Covid Count*/

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as globalcovidcount
FROM PortfolioProject..covid_deaths$
where continent is not null
--group by date
order by 1,2


/*COVID VACCINATIONS Data*/


select *
from PortfolioProject..Covid_vaccinations$

/*Joined Covid Deaths Table with Covid Vaccinations Table*/

select *
 from PortfolioProject..covid_deaths$ dea
 join PortfolioProject..Covid_vaccinations$ vac
 On dea.location = vac.location
 and dea.date = vac.date

 /* Total population vs Total vaccinated*/

 select dea.date, dea.location, dea.continent, vac.new_vaccinations
 from PortfolioProject..covid_deaths$ dea
 join PortfolioProject..Covid_vaccinations$ vac
 On dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 2,3

