############################################################
# SDG 1.3.1e
# Unemployment benefits
############################################################

source("00_setup.R")

RA_adult <- RA_adult %>%
  mutate(
    employed = case_when(
      
      EMP01 == 1 ~ 1,
      
      EMP02 == 1 &
        EMP06b == 3 ~ 1,
      
      EMP03 == 1 &
        EMP06b == 3 ~ 1,
      
      EMP04 == 1 ~ 1,
      
      EMP05 == 1 &
        EMP06a == 3 ~ 1,
      
      EMP02 == 1 &
        EMP06b %in% c(1,2) &
        EMP06c %in% c(1,2) ~ 1,
      
      EMP05 == 1 &
        EMP06a %in% c(1,2) &
        EMP06c %in% c(1,2) ~ 1,
      
      TRUE ~ 0
    ),
    
    unemployed = case_when(
      employed == 0 &
        (EMP25a == 1 | EMP25aa == 1) &
        EMP29 == 1 ~ 1,
      TRUE ~ 0
    )
  )

main <- main %>%
  left_join(
    RA_adult %>%
      select(uuid, unemployed),
    by = "uuid"
  ) %>%
  mutate(
    Unemployment_Benefit = case_when(
      unemployed == 1 &
        ScProtec16d == 1 ~ 1,
      
      unemployed == 1 &
        ScProtec16d != 1 ~ 0,
      
      TRUE ~ NA_real_
    )
  )

svy <- survey_design(main)

C010301e <- svy %>%
  filter(!is.na(Intro_07)) %>%
  group_by(Intro_07) %>%
  summarise(
    var_name = "SDG 1.3.1e",
    num_obs_uw = unweighted(n()),
    denominator = survey_total(),
    mean_value = survey_mean(
      Unemployment_Benefit,
      vartype = c("ci","se"),
      na.rm = TRUE
    )
  )

plot_popgroup(
  C010301e,
  "SDG 1.3.1e",
  "Unemployed Persons Receiving Benefits"
)
