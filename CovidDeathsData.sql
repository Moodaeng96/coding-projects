-- FROM CovidDeaths Table
SELECT * 
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date

-- the main data we're using 
SELECT 
location, 
date, 
total_cases,
new_cases, 
total_deaths,
population  
FROM  coviddeaths
ORDER BY location, date

--Overall of the countries with the Highest Infection Rate compared to Population
SELECT 
location, 
population, 
MAX(total_cases) as HighestInfectionTotal,
MAX(total_cases/population)*100 AS InfectedRate 
FROM  coviddeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY InfectedRate DESC

-- Across the world cases
SELECT
    total_case,
    total_death,
    total_death / total_case * 100 AS GlobalDeath
FROM
    (SELECT
        SUM(CAST(new_cases AS INT)) AS total_case,
        SUM(CAST(new_deaths AS INT)) AS total_death
    FROM
        CovidDeaths
    WHERE
        continent IS NOT NULL) AS subquery;

-- Break things down by continent
-- continents with the highest death count
SELECT
continent,
MAX(cast(total_deaths as int)) AS TotalDeath
FROM CovidDeaths
WHERE continent IS  NOT NULL   -- is accurate in data
GROUP BY continent
ORDER BY TotalDeath DESC


-- Break things down by countries

-- Countries with the highest death count per population
SELECT
location,
MAX(cast(total_deaths as int)) AS TotalDeath
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeath DESC

-- Especially in Thailand
-- Total cases vs Total deaths specifically in Thailand
SELECT 
location, 
date, 
total_cases, 
total_deaths, 
(total_deaths/total_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location = "Thailand" AND date >= "2020-03-01" -- when the first death happened 
ORDER BY date

-- Total cases vs population
--What percentage of population got COVID in Thailand
SELECT
location, 
date, 
total_cases, 
population, 
(total_cases/population)*100 AS CovidPercentage
FROM coviddeaths
WHERE location = "Thailand" 
ORDER BY date 

--The highest death count per population in Thailand
SELECT 
date,
location, 
population, 
MAX(total_deaths) as HighestDeathTotal,
MAX(total_deaths/population)*100 AS DeathRate 
FROM  coviddeaths
WHERE location = "Thailand"
GROUP BY location, population
ORDER BY DeathRate DESC




