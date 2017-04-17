speed <- read.csv("Speed Dating Data.csv")
speed$condtn <- as.factor(speed$condtn)
speed$gender <- as.factor(speed$gender)
speed$match <- as.factor(speed$match)
speed$field_cd <- as.factor(speed$field_cd)
levels(speed$field_cd) <- c("Law","Math","SocScie/Psych", "MedSci", "Engineering", "English", "History", "Business", "Education", "Bio","SocialWork","Undergrad", "PoliSci", "Film","FineArts","Lang","Architecture","Other")
speed$race <- as.factor(speed$race)
speed$goal <- as.factor(speed$goal)
levels(speed$goal) <- c("FunNightOut", "MeetNewPpl", "GetADate","SRSRelationship", "ToSayIDidIt","Other")
speed$date <- as.factor(speed$date)
levels(speed$date) <- c("SVRL/Week","2/Week","1/Week","2/Month", "1/Month", "SVRL/Year", "AlmostNever")
speed$go_out <- as.factor(speed$go_out)
levels(speed$go_out) <- c("SVRL/Week","2/Week","1/Week","2/Month", "1/Month", "SVRL/Year", "AlmostNever")
speed$career_c <-as.factor(speed$career_c)
levels(speed$career_c) <- c("Lawyer","Academic/Research","Psychologist","DocMed", "Engineer", "Entertainment", "Banking/Consulting", "RealEstate","IntlAffairs","Undecided","SocialWork","SpeechPath","Politics", "ProSports", "Other", "Journalism", "Architecture")
speed$race_o <-as.factor(speed$race_o) 
speed$dec_o <- as.factor(speed$dec_o)
speed$samerace <- as.factor(speed$samerace)

sd2 <- speed

sdrandom <- sd2[sample(nrow(sd2), nrow(sd2)),] #Get a random sample since the data is organized by participant

sdclean <- na.omit(sdrandom) #Remove rows with NA values to create a "clean" set
write.csv(sdclean, "sdclean.csv")
