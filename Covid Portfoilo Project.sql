
select *
from PortfolioProject..CovidDeath
where continent is not null
order by 3,4


select location, date, total_cases, new_cases,total_deaths, population
from PortfolioProject..CovidDeath
order by 1,2





-- Total cases vs Total Deaths (Death Percentage per Country)
select location, date, total_cases, new_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeath
order by 1,2


--total cases vs Total population 

select location, date, total_cases,population,(total_cases/population)*100 as InfectedPercentage
from PortfolioProject..CovidDeath
where location like '%Nigeria%'
order by 1,2


-- Countries with the highest infected Percentage

select location, population,max(total_cases)as HighestInfectionCount,max(total_cases/population)*100 as MaxInfectedPercentage
from PortfolioProject..CovidDeath
group by location,population
order by MaxInfectedPercentage desc


-- Countries with the highest death count

select location, max(total_deaths)as TotalDeathCount
from PortfolioProject..CovidDeath
where continent is not null
group by location
order by TotalDeathCount 



-- Continent with the highest death count

select continent, max(total_deaths)as TotalDeathCount
from PortfolioProject..CovidDeath
where continent is not null
group by continent
order by TotalDeathCount desc


-- Continent with the highest confifmed cases

select continent, max(total_cases)as TotalConfirmedCases
from PortfolioProject..CovidDeath
where continent is not null
group by continent
order by TotalConfirmedCases desc


-- Using the join function to combine two tables 
select *
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVac vac
on dea.location= vac.location
and dea.date=vac.date




-- sum of new vaccinations for each location using the SUM function.

select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert (float, vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as total_vac
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVac vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3



--CTE

with PopVac (continent, location, date, population, new_vaccinations,total_vac)
as
(
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert (float, vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as total_vac
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVac vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
)

select *, (total_vac/population)*100 as vacpercentge
from PopVac




-- Temp Table

drop table if exists #percentagepopvac
create table #percentagepopvac
(
continent nvarchar(300),
location nvarchar(300),
date datetime,
population numeric,
new_vaccinations numeric,
total_vac numeric,
)
insert into #percentagepopvac
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert (float, vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as total_vac
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVac vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

select *, (total_vac/population)*100 as vacpercentge
from #percentagepopvac




-- Creating a view

create view totalpopvac as
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert (float, vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as total_vac
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVac vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null