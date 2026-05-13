###Skills related indicators on individual level

#Load Packages 
if(!require(pacman)) install.packages('pacman')

pacman::p_load(
  tidyverse, dplyr, tidyr, rlang, purrr, magrittr, expss, srvyr,
  readr,labelled,pastecs,psych,tableone, outbreaks, ggplot2, unhcrthemes,
  scales, gt,webshot2, sjlabelled, waffle, writexl,remotes, haven, here,
  extrafont,here)

###Load Cameroon data

## Unweighted
HHroster <- read_rds(here("Cameroon","data", "HHroster.rds"))
main <- read_rds(here("Cameroon","data", "main.rds"))
RA_adult <- read_rds(here("Cameroon","data", "RA_adult.rds"))
RA_woman <- read_rds(here("Cameroon","data", "RA_woman.rds"))
RA_caregiver <- read_rds(here("Cameroon","data", "RA_caregiver.rds"))


## Create survey objects to do analysis by population groups on a national level----
FDS_CMR_2024_main <- main %>%
  as_survey_design(
    strata=samp_strat,
    weights = wgh_samp_pop_restr, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters )
  )

FDS_CMR_2024_HHroster <- HHroster %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )

FDS_CMR_2024_RA_adult <- RA_adult %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_resp, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )

FDS_CMR_2024_RA_caregiver <- RA_caregiver %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_u5, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )


FDS_CMR_2024_RA_woman <- RA_woman %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_w, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )



##Load Zambia data


## Unweighted
HHroster <- read_rds(here("Zambia","data", "HHroster.rds"))
main <- read_rds(here("Zambia","data", "main.rds"))
RA_adult <- read_rds(here("Zambia","data", "RA_adult.rds"))
RA_woman <- read_rds(here("Zambia","data", "RA_woman.rds"))
RA_caregiver <- read_rds(here("Zambia","data", "RA_caregiver.rds"))

## Survey objects
#FDS_ZAM_2025_HHroster <- read_rds(here("data", "Survey objects", "FDS_ZAM_2025_HHroster.rds"))
FDS_ZAM_2025_main <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_main.rds"))
FDS_ZAM_2025_RA_adult <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_adult.rds"))
FDS_ZAM_2025_RA_woman <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_woman.rds"))
FDS_ZAM_2025_RA_caregiver <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_caregiver.rds"))
FDS_ZAM_2025_HHroster <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_HHroster_strat.rds"))

FDS_ZAM_2025_HHroster_strat <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_HHroster_strat.rds"))
FDS_ZAM_2025_main_strat <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_main_strat.rds"))
FDS_ZAM_2025_RA_adult_strat <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_adult_strat.rds"))
FDS_ZAM_2025_RA_woman_strat <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_woman_strat.rds"))
FDS_ZAM_2025_RA_caregiver_strat <- read_rds(here("Zambia","data", "Survey objects", "FDS_ZAM_2025_RA_caregiver_strat.rds"))

##Load Pakistan data


#Import 5 datasets. Here we are using FDS Pakistan dataset

## Unweighted
HHroster <- read_rds(here("Pakistan", "data", "HHroster.rds"))
main <- read_rds(here("Pakistan","data", "main.rds"))
RA_adult <- read_rds(here("Pakistan","data", "RA_adult.rds"))
RA_woman <- read_rds(here("Pakistan","data", "RA_woman.rds"))
RA_caregiver <- read_rds(here("Pakistan","data", "RA_caregiver.rds"))

## Create survey objects to do analysis by population groups on a national level----

FDS_PAK_2024_main <- main %>%
  as_survey_design(
    strata=samp_strat,
    weights = wgh_samp_pop_restr, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters )
  )

FDS_PAK_2024_HHroster <- HHroster %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )

FDS_PAK_2024_RA_adult <- RA_adult %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_resp, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )

FDS_PAK_2024_RA_caregiver <- RA_caregiver %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_u5, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )


FDS_PAK_2024_RA_woman <- RA_woman %>%
  as_survey_design(
    strata = samp_strat,           # Specify the column with cluster IDs
    weights = wgh_samp_pop_restr_w, # Specify the column with survey weights
    nest = TRUE              # Use TRUE if PSUs are nested within clusters (optional, based on your survey design)
  )
