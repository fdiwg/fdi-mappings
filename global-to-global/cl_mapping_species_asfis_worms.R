require(fdi4R)

asfis = readr::read_csv("https://raw.githubusercontent.com/fdiwg/fdi-codelists/refs/heads/main/global/cwp/cl_asfis_species.csv")

asfis$AphiaID = unlist(get_WoRMS_AphiaIDs(asfis$definition, parallel = FALSE)) #parallelization returns very few matching results

asfis_worms_mapping <- data.frame(
    src_code = asfis$code,
    trg_code = asfis$AphiaID,
    src_codingsystem = "asfis",
    trg_codingsystem = "worms"
)
readr::write_csv(asfis_worms_mapping, "D:/Documents/DEV/fdiwg/fdi-mappings/global-to-global/cl_mapping_species_asfis_worms.csv")

#check results
asfis$isscaap_div_code = sapply(asfis$isscaap_group_code, substr,1,1)
asfis$has_AphiaID = !is.na(asfis$AphiaID)
table(asfis$has_AphiaID)
table(asfis[,c("isscaap_div_code","has_AphiaID")])