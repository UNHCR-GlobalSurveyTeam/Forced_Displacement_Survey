############################################################
# SDG 1.3.1a
# Population covered by at least one social protection benefit
############################################################

source("00_setup.R")

main <- main %>%
  rowwise() %>%
  mutate(
    Social_Benefit = case_when(
      any(
        c_across(starts_with("ScProtec16")) == 1,
        na.rm = TRUE
      ) ~ 1,
      
      all(
        c_across(starts_with("ScProtec16")) == 2,
        na.rm = TRUE
      ) ~ 0,
      
      TRUE ~ 0
    )
  ) %>%
  ungroup()

svy <- survey_design(main)

C010301a <- svy %>%
  filter(!is.na(Intro_07)) %>%
  group_by(Intro_07) %>%
  summarise(
    var_name = "SDG 1.3.1a",
    num_obs_uw = unweighted(n()),
    denominator = survey_total(),
    mean_value = survey_mean(
      Social_Benefit,
      vartype = c("ci","se"),
      na.rm = TRUE
    )
  )

plot_popgroup(
  C010301a,
  "SDG 1.3.1a",
  "Population Covered by at Least One Social Protection Benefit"
)
