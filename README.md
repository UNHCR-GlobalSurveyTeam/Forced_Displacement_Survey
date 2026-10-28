# Forced Displacement Survey (FDS)  Indicator Calculations

**Last Updated:** October 2026

This repository contains the standardized methodology and scripts used to calculate Sustainable Development Goal (SDG), EGRISS, ILO and other available indicators from the UNHCR Forced Displacement Survey (FDS).

## Documentation

- Previous documentation on SDG methodology: https://rstudio.unhcr.org/FDS_SDG/
- Repository: https://github.com/UNHCR-GlobalSurveyTeam/Forced_Displacement_Survey

## Required Datasets

The following datasets are required:

- `HHroster`
- `main`
- `RA_adult`
- `RA_caregiver`
- `RA_woman`

> Ensure datasets have been cleaned and survey weights have been applied before running calculations.

## About FDS

The [Forced Displacement Survey (FDS)](https://www.unhcr.org/what-we-do/reports-and-publications/data-and-statistics/forced-displacement-survey) is UNHCR's standardized household survey programme for collecting socioeconomic data on forcibly displaced and host populations.

The repository provides:

- Standardized indicator definitions
- Numerator and denominator specifications
- Variable mappings
- Indicator calculation scripts
- Reproducible methodologies


## Indicator Calculation

Percentage = \(\left(\frac{\text{Numerator}}{\text{Denominator}}\right) \times 100\)