############################################################
# SDG 1.3.1
# Common setup
############################################################


#ScProtec16: In the last 12 months, have you or anyone in your household received any of the following payments from the host country government?  
table(main$ScProtec16a)#Social protection cash benefit
table(main$ScProtec16b)#Parental/Maternity benefit
table(main$ScProtec16c)#Disability benefit
table(main$ScProtec16d)#Unemployment benefit
table(main$ScProtec16e)#Employment injury benefit
table(main$ScProtec16f)#Sickness benefit
table(main$ScProtec16g)#Old-age pension
table(main$ScProtec16h)#Other vulnerability benefit
table(main$ScProtec16i)#Social assistance cash benefit




survey_design <- function(data){
  
  data %>%
    as_survey_design(
      strata = samp_strat,
      weights = wgh_samp_pop_restr,
      nest = TRUE
    )
}

plot_popgroup <- function(data,
                          indicator_name,
                          title_text,
                          ymax = 1){
  
  ggplot(data,
         aes(x = Intro_07,
             y = mean_value,
             fill = Intro_07)) +
    
    geom_bar(
      stat = "identity",
      position = "dodge",
      width = 0.7
    ) +
    
    geom_errorbar(
      aes(
        ymin = mean_value - mean_value_se,
        ymax = mean_value + mean_value_se
      ),
      width = 0.2
    ) +
    
    geom_text(
      aes(label = round(mean_value,2)),
      vjust = -0.5
    ) +
    
    scale_y_continuous(
      limits = c(0,ymax),
      expand = c(0,0)
    ) +
    
    labs(
      title = title_text,
      x = "Population Groups",
      y = "Proportion"
    ) +
    
    scale_fill_unhcr_d() +
    theme_unhcr() +
    
    theme(
      axis.text.x = element_text(
        angle = 45,
        hjust = 1
      )
    ) +
    
    scale_x_discrete(
      labels = scales::wrap_format(15)
    )
}