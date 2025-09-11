require(fdi4R)

asfis = readr::read_csv("https://raw.githubusercontent.com/fdiwg/fdi-codelists/refs/heads/main/global/cwp/cl_asfis_species.csv")

cl = parallel::makeCluster(8)
asfis$AphiaID = unlist(get_WoRMS_AphiaIDs(asfis$definition, parallel = FALSE)) #parallelization returns very few matching results
asfis$isscaap_div_code = sapply(asfis$isscaap_group_code, substr,1,1)
asfis$has_AphiaID = !is.na(asfis$AphiaID)
table(asfis[,c("isscaap_div_code", "has_AphiaID")])