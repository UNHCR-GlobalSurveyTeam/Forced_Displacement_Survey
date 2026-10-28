############################################################
# SDG 1.3.1d
# Disability benefits
############################################################

source("00_setup.R")

main <- main %>%
  mutate(
    Disability_Benefit = case_when(
      ScProtec16c == 1 &
        has_disability == 1 ~ 1,
      
      ScProtec16c %in% c(2,98,99) &
        has_disability == 1 ~ 0,
      
      TRUE ~ NA_real_
    )
  )

svy <- survey_design(main)

C010301d <- svy %>%
  filter(!is.na(Intro_07)) %>%
  group_by(Intro_07) %>%
  summarise(
    var_name = "SDG 1.3.1d",
    num_obs_uw = unweighted(n()),
    denominator = survey_total(),
    mean_value = survey_mean(
      Disability_Benefit,
      vartype = c("ci","se"),
      na.rm = TRUE
    )
  )

plot_popgroup(
  C010301d,
  "SDG 1.3.1d",
  "Persons with Disabilities Receiving Benefits"
)