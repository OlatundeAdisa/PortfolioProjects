USE PortfolioProject

Select *
From PortfolioProject..CovidDeaths$
Where continent is not null
Order By 3,4

--Select *
--From PortfolioProject..CovidVaccinations$
--Order By 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
Order By 1,2 


-- Looking at the total cases vs total deaths
-- Shows the likelihood of dying if you contract covid in your country
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where location like 'Nigeria'
Order By 1,2 


-- Looking at the Total Cases vs Population
-- Shows what percentage of population got covid
Select location, date, population, total_cases, (total_cases/population)*100 as PopulationPercentageInfected
From PortfolioProject..CovidDeaths$
--Where location like 'Nigeria'
Order By 1,2 


-- Looking at countries with highest infection rate compared to Population
Select location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PopulationPercentageInfected
From PortfolioProject..CovidDeaths$
--Where location like 'Nigeria'
Group by location, population
Order By PopulationPercentageInfected DESC


--Showing Countries with Higest Death Count per population
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by location
Order By TotalDeathCount DESC


-- LETS BREAK THINGS DOWN BY CONTINENT

-- Showing the continent with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by continent
Order By TotalDeathCount DESC

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is null
Group by location
Order By TotalDeathCount DESC

-- GLOBAL NUMBERS
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by date
Order By 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
--Group by date
Order By 1,2

-- Looking at Total Population vs Vaccinations

Select *
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date


Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
where DEA.continent IS NOT NULL
Order By 2,3


Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CONVERT(INT,VAC.new_vaccinations)) over (Partition by DEA.location Order by DEA.location, DEA.Date) as 
RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
where DEA.continent IS NOT NULL
Order By 2,3


-- USE CTE (number of columns has to be the same)
With POPvsVAC (Continent, location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CONVERT(INT,VAC.new_vaccinations)) over (Partition by DEA.location Order by DEA.location, DEA.Date) as 
RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
where DEA.continent IS NOT NULL
--Order By 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From POPvsVAC



-- TEMP TABLE

Create Table #PercentPopulationVaccinated
(
Continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CONVERT(INT,VAC.new_vaccinations)) over (Partition by DEA.location Order by DEA.location, DEA.Date) as 
RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
where DEA.continent IS NOT NULL

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar (255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CONVERT(INT,VAC.new_vaccinations)) over (Partition by DEA.location Order by DEA.location, DEA.Date) as 
RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
--where DEA.continent IS NOT NULL

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualisations


Create View PercentPopulationVaccinated as
Select DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations,
SUM(CONVERT(INT,VAC.new_vaccinations)) over (Partition by DEA.location Order by DEA.location, DEA.Date) as 
RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ DEA
JOIN PortfolioProject..CovidVaccinations$ VAC
On DEA.location = VAC.location
and DEA.date = VAC.date
where DEA.continent IS NOT NULL


Select *
From PercentPopulationVaccinated