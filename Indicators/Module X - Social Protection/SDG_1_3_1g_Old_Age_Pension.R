############################################################
# SDG 1.3.1g
# Old-age pension
############################################################

source("00_setup.R")

main <- main %>%
  mutate(
    old_age_pension = case_when(
      has_old_age == 1 &
        ScProtec16g == 1 ~ 1,
      
      has_old_age == 1 &
        ScProtec16g == 2 ~ 0,
      
      TRUE ~ NA_real_
    )
  )

svy <- survey_design(main)

C010301g <- svy %>%
  filter(!is.na(Intro_07)) %>%
  group_by(Intro_07) %>%
  summarise(
    var_name = "SDG 1.3.1g",
    num_obs_uw = unweighted(n()),
    denominator = survey_total(),
    mean_value = survey_mean(
      old_age_pension,
      vartype = c("ci","se"),
      na.rm = TRUE
    )
  )

plot_popgroup(
  C010301g,
  "SDG 1.3.1g",
  "Older Persons Receiving a Pension"
)