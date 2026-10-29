# ==============================================================================
# UNHCR Forced Displacement Survey (FDS) - Standard Script
# Indicator: Dependency Ratio
# Reference: World Bank Standards (https://data.worldbank.org/indicator/SP.POP.DPND)
# ==============================================================================

# 1. Classify Household Composition (Dependency Ratio) -------------------------
hh_comp <- HHroster %>%
  group_by(ID) %>%
  summarise(
    # Dependents: children under 15 & elderly 65 and above
    num_dependents  = sum(age < 15 | age >= 65, na.rm = TRUE),
    # Working-age members: 15 to 64
    num_working_age = sum(age >= 15 & age < 65, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    # Calculate ratio and replace Infinite/NaN with NA (e.g., 0 working-age members)
    dependency_ratio = num_dependents / num_working_age,
    dependency_ratio = ifelse(is.infinite(dependency_ratio) | is.nan(dependency_ratio), NA, dependency_ratio)
  )

# 2. Merge back to Main Household Dataset --------------------------------------
main <- main %>%
  left_join(
    hh_comp %>% select(ID, dependency_ratio),
    by = "ID"
  )

# 3. Calculate Weighted Distribution -------------------------------------------

HH_dependency <- main %>%
  as_survey_design(
    strata = samp_strat,
    weights = wgh_samp_pop_restr,
    nest = TRUE
  ) %>%
  # Grouping by population group or region since dependency_ratio is continuous
  group_by(pop_group) %>%  # Replace 'pop_group' with your standard grouping variable
  summarise(
    num_obs_uw = unweighted(n()),
    mean_dep   = survey_mean(dependency_ratio, vartype = c("ci", "se"), na.rm = TRUE),
    median_dep = survey_median(dependency_ratio, na.rm = TRUE)
  )

# Print results table
print(HH_dependency)
