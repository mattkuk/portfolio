# Load necessary libraries
install.packages("ggtext")
library(ggplot2)
library(scales)
library(ggtext)

#read in data
data <- read.csv("/Users/mattkukulich/Documents/STAT 3204/Data/DoubleDigitSeeds.csv")

nil_year <- "2021"
portal_year <- "2018"


#alternate colors between red and blue
colors <- rep(c("red", "blue"), length.out = nrow(data))

#create side by side bar chart
ggplot(data, aes(x = factor(Year), y = Teams, fill = Round)) +
  geom_bar(stat = "identity", position = "dodge", show.legend = FALSE) +
  scale_fill_manual(values = colors) +
  scale_y_continuous(breaks = seq(0, max(data$Teams), by = 2), labels = number_format(accuracy = 1)) + 
  theme_minimal() +
  theme(panel.grid = element_blank()) + 
  scale_x_discrete(expand = expansion(mult = c(0.1, 0.1))) +
  labs(title = "NIL and the Transfer Portal: Ruining the Cinderella",
       subtitle= "The Number of Double Digit Seeds in the <span style='color:red;'>Round of 32</span> and <span style='color:blue;'>Sweet 16</span> in March Madness in the last 10 tournaments <br> is on a downward trend since the introduction of NIL and the Transfer Portal",
       x = "Year",
       y = NULL) +
  theme(plot.subtitle = element_markdown()) + 
  geom_segment(aes(x = nil_year, xend = nil_year, y = 0, yend = max(data$Teams)), 
               linetype = "dashed", color = "black") +
  geom_segment(aes(x = portal_year, xend = portal_year, y = 0, yend = max(data$Teams)), 
               linetype = "dashed", color = "black") +
  annotate("text", x = nil_year, y = max(data$Teams) * 0.9, 
           label = "July 1, 2021: The start of NIL", hjust = -0.05, size = 4, color = "black") +
  annotate("text", x = portal_year, y = max(data$Teams), 
           label = "October 15, 2018: The start of the Transfer Portal", hjust = -0.05, size = 4, color = "black")
