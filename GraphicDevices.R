# Graphic Devices

library(datasets)
with(faithful, plot(eruptions, waiting)) # plot appear on screen device
title(main = "Old Faithful Geyser data") # annotate with a title

pdf(file = "myplot.pdf") # open pdf device; create myplot.pdf in working directory
with(faithful, plot(eruptions, waiting)) # create plot and send to a file
title(main = "Old Faithful Geyser data") # annotate with a title, nothing on screen
dev.off() # close pdf file device, now can view the pdf on computer


# copying plot
with(faithful, plot(eruptions, waiting)) # plot appear on screen device
title(main = "Old Faithful Geyser data") # annotate with a title
dev.copy(png, file = "geyserplot.png") # copy plot to png file
dev.off() # close the png device