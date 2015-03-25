#Getting reprice information
#C. B. Salling 2015-01-05

# Get working directory ----
setwd('/Users/claire/Documents/5-R Tools/fare_reprice_log_data')

# Load and format data ----
fares <- read.table('reprice_data.csv', sep = ',', header = TRUE)

# Get min and max fares by members_bends id ----
min_fares <- ddply(fares, 'member_bends_id', function(x){min(x$amadeus_price)})
names(min_fares)[2] <- 'min_fare'

max_fares <- ddply(fares, 'member_bends_id', function(x){max(x$amadeus_price)})
names(max_fares)[2] <- 'max_fare'

# Get initial fares ----
initial_fare_id <- ddply(fares, 'member_bends_id', function(x){min(x$id)})
names(initial_fare_id)[2] <- 'id'

temp <- merge(initial_fare_id, fares, by = 'id', all.x = TRUE)
initial_fares <- temp[c('member_bends_id.x', 'amadeus_price')]

names(initial_fares) <- c('member_bends_id', 'initial_fare')

# Get final fares ----
final_fare_id <- ddply(fares, 'member_bends_id', function(x){max(x$id)})
names(final_fare_id)[2] <- "id"

temp <- merge(final_fare_id, fares, by = "id", all.x = TRUE)
final_fares <- temp[c('member_bends_id.x',
                      'amadeus_price',
                      'status',
                      'client_id')]

names(final_fares) <- c('member_bends_id','final_fare','status','client_id')

# Merge all datasets and create new columns for fare changes ---- 
temp <- merge(max_fares, min_fares, by = 'member_bends_id', all = TRUE)
temp <- merge(temp, initial_fares, by = 'member_bends_id', all = TRUE)
fare_stats <- merge(temp, final_fares, by = 'member_bends_id', all = TRUE)

fare_stats$diff <- fare_stats$final_fare - fare_stats$initial_fare
fare_stats$change <- fare_stats$diff != 0
fare_stats$increase <- fare_stats$diff > 0
fare_stats$decrease <- fare_stats$diff < 0

# Overall summaries ----
perc_change <- round((sum(fare_stats$change) / length(fare_stats$change)) * 100, 2)
perc_increase <- round((sum(fare_stats$increase) / length(fare_stats$increase)) * 100, 2)
perc_decrease <- round((sum(fare_stats$decrease) / length(fare_stats$decrease)) * 100, 2)

print(paste(perc_change, '% of all fares changed'))
print(paste(perc_increase,'% of all fares increased'))
print(paste(perc_decrease, '%of all fares decreased'))

# Summaries for all A purchases ----
fare_stats_A <- subset(fare_stats, fare_stats$client_id == 1)

perc_change_A <- round((sum(fare_stats_A$change) / length(fare_stats_A$change)) * 100, 2)
perc_increase_A <- round((sum(fare_stats_A$increase) / length(fare_stats_A$increase)) * 100, 2)
perc_decrease_A <- round((sum(fare_stats_A$decrease) / length(fare_stats_A$decrease)) * 100, 2)

print(paste(perc_change_A, '% of all A fares changed'))
print(paste(perc_increase_A,'% of all A fares increased'))
print(paste(perc_decrease_A, '%of all A fares decreased'))
# Summaries for all exercised A purchases ----
fare_stats_A_exc <- subset(fare_stats, (fare_stats$client_id == 1) & (fare_stats$status == 'AT')) 

perc_change_A_exc <- round((sum(fare_stats_A_exc$change) / length(fare_stats_A_exc$change)) * 100, 2)
perc_increase_A_exc <- round((sum(fare_stats_A_exc$increase) / length(fare_stats_A_exc$increase)) * 100, 2)
perc_decrease_A_exc <- round((sum(fare_stats_A_exc$decrease) / length(fare_stats_A_exc$decrease)) * 100, 2)

print(paste(perc_change_A_exc,'% of all exercised A fares changed'))
print(paste(perc_increase_A_exc,'% of all exercised A fares increased'))
print(paste(perc_decrease_A_exc, '%of all exercised A fares decreased'))

# Summaries for all B Purchases ----
fare_stats_B <- subset(fare_stats, fare_stats$client_id == 2)

perc_change_B <- round((sum(fare_stats_B$change) / length(fare_stats_B$change)) * 100, 2)
perc_increase_B <- round((sum(fare_stats_B$increase) / length(fare_stats_B$increase)) * 100, 2)
perc_decrease_B <- round((sum(fare_stats_B$decrease) / length(fare_stats_B$decrease)) * 100, 2)

print(paste(perc_change_B,'% of all B fares changed'))
print(paste(perc_increase_B,'% of all B fares increased'))
print(paste(perc_decrease_B, '% of all B fares decreased'))
# Summaries for all exercised B Purchases ----
fare_stats_B_exc <- subset(fare_stats, (fare_stats$client_id == 2) & (fare_stats$status == 'AT'))

perc_change_B_exc <- round((sum(fare_stats_B_exc$change) / length(fare_stats_B_exc$change)) * 100, 2)
perc_increase_B_exc <- round((sum(fare_stats_B_exc$increase) / length(fare_stats_B_exc$increase)) * 100, 2)
perc_decrease_B_exc <- round((sum(fare_stats_B_exc$decrease) / length(fare_stats_B_exc$decrease)) * 100, 2)

print(paste(perc_change_B_exc,'% of all exercised B fares changed'))
print(paste(perc_increase_B_exc,'% of all exercised B fares increased'))
print(paste(perc_decrease_B_exc, '%of all exercised B fares decreased'))

# Summaries for all C purchases ----
fare_stats_C <- subset(fare_stats, fare_stats$client_id == 3)

perc_change_C <- round((sum(fare_stats_C$change) / length(fare_stats_C$change)) * 100, 2)
perc_increase_C <- round((sum(fare_stats_C$increase) / length(fare_stats_C$increase)) * 100, 2)
perc_decrease_C <- round((sum(fare_stats_C$decrease) / length(fare_stats_C$decrease)) * 100, 2)

print(paste(perc_change_C,'% of all C fares changed'))
print(paste(perc_increase_C,'% of all C fares increased'))
print(paste(perc_decrease_C, '%of all C fares decreased'))
# Summaries for all exercised C purchases ----
fare_stats_C_exc <- subset(fare_stats, (fare_stats$client_id == 3) & (fare_stats$status == 'AT'))

perc_change_C_exc <- round((sum(fare_stats_C_exc$change) / length(fare_stats_C_exc$change)) * 100, 2)
perc_increase_C_exc <- round((sum(fare_stats_C_exc$increase) / length(fare_stats_C_exc$increase)) * 100, 2)
perc_decrease_C_exc <- round((sum(fare_stats_C_exc$decrease) / length(fare_stats_C_exc$decrease)) * 100, 2)

print(paste(perc_change_exp_exc, '% of all exercised C fares changed'))
print(paste(perc_increase_exp_exc,'% of all exercised C fares increased'))
print(paste(perc_decrease_exp_exc, '%of all exercised C fares decreased'))

