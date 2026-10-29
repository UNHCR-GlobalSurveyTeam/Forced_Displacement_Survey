# EGRISS - IRRS first level indicators (classificatory variable): 

####Relationship to the HH Head; composition of the household


HH_relationship <- HHroster %>%
  as_survey_design(
    strata = samp_strat,
    weights = wgh_samp_pop_restr,
    nest = TRUE
  ) %>%
  group_by(HH_03) %>%
  summarise(
    population = survey_total(),
    proportion = survey_mean(vartype = c("ci", "se"))
  )