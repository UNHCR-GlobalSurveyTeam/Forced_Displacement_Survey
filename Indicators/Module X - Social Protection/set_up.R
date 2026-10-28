############################################################
# SDG 1.3.1
# Common setup
############################################################

library(dplyr)
library(srvyr)
library(survey)
library(ggplot2)
library(unhcrthemes)
library(scales)

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