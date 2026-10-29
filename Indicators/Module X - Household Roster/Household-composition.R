# Household nucleus type


hh_comp <- HHroster %>%
  group_by("ID") %>%
  summarise(
    num_hhhead   = sum(HH_03 == 1, na.rm = TRUE),
    num_partner  = sum(HH_03 == 2, na.rm = TRUE),
    num_biochild = sum(HH_03 == 3, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    nucleus_type = factor(
      case_when(
        num_hhhead == 1 & num_partner > 0 & num_biochild > 0 ~ "Parental",
        num_hhhead == 1 & num_partner == 0 & num_biochild > 0 ~ "Single parent",
        num_hhhead == 1 & num_partner > 0 & num_biochild == 0 ~ "Conjugal",
        num_hhhead == 1 & num_partner == 0 & num_biochild == 0 ~ "Non-family"
      ),
      levels = c("Parental", "Single parent", "Conjugal", "Non-family")
    )
  )

# Merge to household dataset
main <- main %>%
  left_join(
    hh_comp %>% select(ID, nucleus_type),
    by = "ID"
  )

# Weighted distribution
HH_relationship <- main %>%
  as_survey_design(
    strata = samp_strat,
    weights = wgh_samp_pop_restr,
    nest = TRUE
  ) %>%
  group_by(nucleus_type) %>%
  summarise(
    num_obs_uw = unweighted(n()),
    population = survey_total(),
    proportion = survey_mean(vartype = c("ci", "se"), na.rm = TRUE)
  )


