#ScProtec01_1 -	In the past 12 months while living in [host country], have you or anyone in your household received any food assistance? Please think of any type of food assistance: food products, money to buy food or food vouchers. 
#ScProtec01_2	-	In the past 12 months while living in [host country], have you or anyone in your household received any items that are not food as part of an assistance programme? For instance, seeds, fertilizers, school items, cookstoves, solar panels, etc.
#ScProtec01_3	- In the past 12 months while living in [host country], have you or anyone in your household received any cash support? Please do not consider cash from food assistance programmes. 
#ScProtec01_4	-	In the past 12 months while living in [host country], have you or anyone in your household received any other form of assistance? Please think of any assistance that we have not mentioned so far.



#Then asked for each programme if any assistance received
## ScProtec04 - From whom have you or anyone in your household received the assistance provided by [programme name]?


main <- main %>%
  rowwise() %>%
  mutate(
    Any_Assistance = case_when(
      any(c_across(c(
        ScProtec01_1,
        ScProtec01_2,
        ScProtec01_3,
        ScProtec01_4
      )) == 1, na.rm = TRUE) ~ 1,
      
      all(c_across(c(
        ScProtec01_1,
        ScProtec01_2,
        ScProtec01_3,
        ScProtec01_4
      )) == 2, na.rm = TRUE) ~ 0,
      
      TRUE ~ NA_real_
    )
  ) %>%
  ungroup()

table(main$Any_Assistance)


FDS_main <- main %>%
  as_survey_design(
    strata = samp_strat,
    weights = wgh_samp_pop_restr,
    nest = TRUE
  )

Any_Assistance_Result <- FDS_main %>%
  summarise(
    estimate = survey_mean(
      Any_Assistance,
      vartype = c("ci", "se"),
      na.rm = TRUE
    )
  )
