############################################################
# SDG 1.3.1c
# Maternity benefits
############################################################

source("00_setup.R")

main <- main %>%
  mutate(
    Parental_Benefit = case_when(
      ScProtec16b == 1 &
        has_mother_with_child == 1 ~ 1,
      
      ScProtec16b %in% c(2,98,99) &
        has_mother_with_child == 1 ~ 0,
      
      TRUE ~ NA_real_
    )
  )

svy <- survey_design(main)

C010301c <- svy %>%
  filter(!is.na(Intro_07)) %>%
  group_by(Intro_07) %>%
  summarise(
    var_name = "SDG 1.3.1c",
    num_obs_uw = unweighted(n()),
    denominator = survey_total(),
    mean_value = survey_mean(
      Parental_Benefit,
      vartype = c("ci","se"),
      na.rm = TRUE
    )
  )

plot_popgroup(
  C010301c,
  "SDG 1.3.1c",
  "Women Giving Birth Covered by Maternity Benefits",
  ymax = 0.3
)