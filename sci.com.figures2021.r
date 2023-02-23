###Communicating Science
###Making Figures in R
###BIOL 384
###SUNY GENESEO
###Gerringer, 2021


###This activity is designed to start at the very beginning and work up to some analyses and tools 
###you may use in your studies.

###Skip ahead as needed to match your comfort level and experience.

###The activity is divided into multiple parts. 
###PART I: Diving into R: The Basics. 
###PART II: Plotting in R: Making beautiful figures.  
###PART III: Map Making in R. 
###PART IV: Fun with R! 
###PART V: More! Advanced Figure Making Challenges

###PART I
####Diving in to R

####Define Variables, Write Functions and Make a Plot

###R lets us define any variable or function that we want and do the math we tell it. 
#Let's try it out. 

###We can pick any name we want for a variable, x, y, George, whatever. 

###Say we want to solve a word problem. If Hiroshi is 76 and  is 34, 
#how much older is Hiroshi than Hiroaki?

###We can do this in our heads, but let's write it out. 

#First, we define a few variables.
Hiroshi <- 76
Clarence <- 34

###The variables appear in the Environment to the right in RStudio. Are they there? 

###Now, we can do any math we want with the variables.
Hiroshi - Clarence
###The answer to life, the universe, and everything. 

##Try a different operation. 
Hiroshi^3 - 385*Clarence + pi^8

##Write your own operation using variables you define. 


###We can also work with large tables of data in R.

####We need to make a table of data to work with. In R, this is called a data frame.
###Define our data sequence, set our range of values.
my.data<- data.frame(t=seq(0, 2*pi, by=0.1))

###Look at the table we just made. 
#We have set the increments of observations for a variable we named 't'. 
#The function View() lets us see the table. 
View(my.data)

###Let's try defining some more functions and see if we can plot them.

###Define function 1 for the plot
xhrt.function <- function(t) 16*sin(t)^3

###Did it work? Check the output.
xhrt.function

####Try a value in our function. I've picked 2, 
#but go with whichever number floats your boat. 
xhrt.function(2)
###R has done the math for us!

###Great! Let's define another function. 
yhrt.function <- function(t) 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t)

###Write the code to check this function and test a value out, 
#just like we did before. Did it work?
yhrt.function
yhrt.function(5)

###Let's add these function outputs to our data frame and look at the numbers. 
#We can define data frame variables with the $. Dataframe$variable. 
###If the variable exists, we can call it using the name (Dataframe$variable). 
#We can also make new variables. 
my.data$y=yhrt.function(my.data$t)

my.data$x=xhrt.function(my.data$t)

###Write the code to look at your data frame now. Has it changed?

###Plot our data
with(my.data, plot(x,y, type="l"))

####Victory is ours!







###PART II 
###PLOTTING IN R

###Let's make beautiful plots in R

##Base R can plot data. This is ok, especially if you just want to quickly look at something.
##But sometimes, we want to make figures that are beautiful!

###First, let's load in some data. 
##Import the HOT_CTD data file. This is from the Hawaii Ocean Time Series dataset in 2016. 
##All these data were taken from a CTD. 
##Try using the Import Dataset function on the upper right side of the screen, in the Environment window.

##Did it work? View the dataframe. 
View(HOT_CTD)

##We can call any variable in our dataframe to plot it or look at it. 
HOT_CTD$density

##Sometimes that get's cumbersome, though, so let's just define 'density' as a variable
density <- HOT_CTD$density

##Check that it worked
density

##Define the other variables in this dataframe. 
##Do this for pressure, temperature, salinity, oxygen, density, cruise, and nitrate. 
##You can call the variables anything you want, but it's most useful to come up with a short and informative name. Ex: temp for temperature
pressure <-HOT_CTD$pressure
temp <- HOT_CTD$temp
salinity <- HOT_CTD$salinity
oxygen <- HOT_CTD$oxygen
nitrate <- HOT_CTD$nitrate
density <-HOT_CTD$density
cruise <- HOT_CTD$cruise

##Check that each of your variables were defined correctly. 
##Also check that they have shown up in the Environment window. 
pressure
temp
salinity
oxygen
nitrate
cruise
density

##Convert pressure to depth. How many dbar are in one meter again? 
##Define a new variable depth, based on the pressure data
depth <- pressure

###First, let's try the base plot function, just to check that the data were loaded in ok and make sense.

##Plot Temperature by Depth from the Hawaii Ocean Time Series CTD casts in 2016
plot(depth, temp)

###How does it look? Use the zoom function to look at the plot in detail. 

##Let's say we wanted to look at temperatures over the different cruises. 

##First, make a prediction, how would temperatures have changed throughout the year? 

###Make a plot to test your prediction. 
plot(depth, temp, col = cruise)

##The plot you've created is ok. It tells you what you need to know. 
##But, it's not very pretty, and also not complete. 
##A good plot in a presentation or paper needs to have units on the axes. 
##We also like depth profiles to have depth on the y-axis, looking like a cross-section of the ocean. 
##What if you want to use a different font or put in italics? 
##R can do this, but it's better to use a plotting package. 

##ggplot2 is one plotting package that can make lovely plots in R. 
##You can manipulate every aspect of the plot and make it look exactly how you want it to. 

##Load the ggplot2 package. 
library(ggplot2)

###Let's bring up the ggplot2 help file. We can always return to this if we get lost. 
?ggplot2

###Let's make the basic temperature-depth profile from these data. 

###First, we need to tell ggplot what data we want it to use. 
##We also need to tell it what to plot. We'll do this using the aes(), aesthetics function. 
##The plot format will start like this:
##ggplot(DATA, aes(x-axis variable, y-axis variable))
ggplot(HOT_CTD, aes(temp, depth))

###From there, we will add the different plot features.
##We haven't told it to add any points or lines yet, so we've just got an empty field. 
##Let's give it a prettier background theme. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic()

###Make sure to include a plus sign at the end of each line, so ggplot knows you're not done. 

###Now, let's add some data points. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point()

###Does that look right? Where are the warmest temperatures?

##If we like, we can color the profiles by cruise. This can help us see if there are any strange readings and what the trends look like throughout the year. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) 

##The cruise number legend is not very useful, let's get rid of that. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  theme(legend.position = 'none') 

##It would be nice if we could put in some better labels on those axes. We should include units, too!
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(legend.position = 'none')

###Starting to get the idea? 
##We can just keep adding lines to adjust every element.
##You can have complete control over the different elements of your plot, it's just about learning the language. 
###Next, let's make our depth profile look like an ocean cross-section. We need depth to start at zero and get deeper lower on the plot. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(legend.position = 'none') +
  scale_y_reverse()

##While we're at it, let's put in some more of those axis tick marks to help us orient. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20, 25))

###Just for fun, let's put on some finishing touches.
##Let's say we want a serif font like Times New Roman for our paper and that we wnat to adjust the axis and font sizes. 
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20, 25))

##You can try adjusting the different parameters to make the plot just how you like it!

###And that's our final plot! This code can now be applied to some of the other parameters. 
##Once you're more comfortable, you can run the whole plot code together, instead of building it up piece by piece like we've done above. 

###Don't like how something looks?
##Fix it! 
##Google is your friend. Search something like "use italics in ggplot title" to find what you need. 
##Someone has likely come across your problem before. Use the resources that are out there!

##Plot Temperature-Depth Profile
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20, 25))

###Now, try plotting the other parameters yourself! 
##As you go, think about why the profiles look the way they do. 
###Be sure to keep up with your axis labels!

##Plot beautiful depth profiles for salinity, density, oxygen, and nitrate.
##You'll need to adjust the range limits for the different datasets. 
##For example, for salinity, add the line:
#scale_x_continuous(limits = c(34, 35.5))
##instead of the scale_x_continuous term that was in before. 

###Plot Salinity-Depth Profile
ggplot(HOT_CTD, aes(salinity, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Salinity (ppm)')) +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(limits = c(34, 35.5))

##Plot Oxygen-Depth Profile
ggplot(HOT_CTD, aes(oxygen, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab('Oxygen (umol/kg)') +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(limits = c(0, 250))

##Plot Nitrate-Depth Profile
ggplot(HOT_CTD, aes(nitrate, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab('Nitrate (umol/kg)') +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(limits = c(1200, 0), breaks = c(0, 500, 1000, 1500)) +
  scale_x_continuous(limits = c(0, 60))

##Plot Density-Depth Profile
ggplot(HOT_CTD, aes(density, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab('Density (kg/m^3)') +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(breaks = c(0, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000)) +
  scale_x_continuous(limits = c(22, 29))

##Plot Temeprature-Depth Profile over the first 1000 m
ggplot(HOT_CTD, aes(temp, depth)) +
  theme_classic() +
  geom_point(aes(color = cruise)) +
  ylab('Depth (m)') +
  xlab(expression('Temperature ('*~degree*C*')')) +
  theme(axis.title.x = element_text(family = 'serif', size = 22))+
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(axis.title.y = element_text(family = 'serif', size = 22)) +
  theme(axis.text = element_text(family = 'serif', size = 20)) +
  theme(legend.position = 'none') +
  scale_y_reverse(limits = c(1000, 0)) +
  scale_x_continuous(breaks = c(0, 5, 10, 15, 20, 25))








###PART III
###MAP MAKING

##It's useful to make maps for presentations and figures. 
##There are lots of wonderful mapping tools out there.
##R gives us one way to make maps to fit our needs. 
##There are different ways to make maps in R, but here is one option. 

###Base R has a few useful functions written into it, but sometimes we need to do more. 
###There are many sets of functions that people have written to achieve certain tasks. 
###These are called 'packages' and can be loaded into R. 
###Install the necessary packages, then load them using the library function. 
###You can use the install function, or, if working in R Studio, go to Packages, Install, and search for the package you need. 
#install.packages(c("maps", "mapdata"))
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

###You'll need to load the packages you need each time you open R, but you'll only have to install them once. 
###You can also activate packages by checking the box next to them in the Packages tab. 

##Let's make a map. 
##First, we'll define our data. 
usa <- map_data("usa")

##What are the dimensions of our data frame? 
dim(usa)

##See the first few lines of data. 
head(usa)

##And the last few lines.
tail(usa)

##Define data for a world map, too. Look at the data frame in the same way. 
w2hr <- map_data("world2Hires")

dim(w2hr)

head(w2hr)

tail(w2hr)

###Use ggplot2 to make beautiful maps. 

##black map, usa
ggplot() +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group)) +
  coord_fixed(1.3) +
  theme_classic() +
  xlab("Longitude (°W)") +
  ylab("Latitude (°N)") +
  theme(axis.text.x = element_text(size = 18, family = 'serif')) +
  theme(axis.text.y = element_text(size = 16, family = 'serif')) +
  theme(axis.title.x = element_text(size = 20, family = 'serif')) +
  theme(axis.title.y = element_text(size = 20, family = 'serif')) +
  theme(axis.line.x = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(axis.ticks = element_blank())

###What are the different commands in this code doing? 
###What happens if you change some of the parameters? 

###Can you make an outline map only? Can you make the outline blue? 

ggplot() +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group), fill = NA, color = "blue") +
  coord_fixed(1.3) +
  theme_classic() +
  xlab("Longitude (°W)") +
  ylab("Latitude (°N)") +
  theme(axis.text.x = element_text(size = 18, family = 'serif')) +
  theme(axis.text.y = element_text(size = 16, family = 'serif')) +
  theme(axis.title.x = element_text(size = 20, family = 'serif')) +
  theme(axis.title.y = element_text(size = 20, family = 'serif')) +
  theme(axis.line.x = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(axis.ticks = element_blank())

###Where are we on this map? 
#Mark Geneseo with red dot

##First, define our coordinates. 
geneseo <- data.frame(
  long = c(-77.8169),
  lat = c(42.7959),
  names = c("Geneseo"),
  stringsAsFactors = FALSE
)

##Then, plot your map!
ggplot() +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group)) +
  coord_fixed(1.3) +
  theme_classic() +
  xlab("Longitude (°W)") +
  ylab("Latitude (°N)") +
  theme(axis.text.x = element_text(size = 18, family = 'serif')) +
  theme(axis.text.y = element_text(size = 16, family = 'serif')) +
  theme(axis.title.x = element_text(size = 20, family = 'serif')) +
  theme(axis.title.y = element_text(size = 20, family = 'serif')) +
  theme(axis.line.x = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(axis.ticks = element_blank()) +
  geom_point(data = geneseo, aes(x = long, y = lat), color = "red", size = 3)

###Define state boundaries. 
states <- map_data("state")

dim(states)

head(states)

tail(states)

ggplot() +
  geom_polygon(data = states, aes(x = long, y = lat, fill = region, group = group), color = "white") +
  coord_fixed(1.3) +
  guides(fill = FALSE) +
  theme_classic() +
  xlab("Longitude (°W)") +
  ylab("Latitude (°N)") +
  theme(axis.text.x = element_text(size = 18, family = 'serif')) +
  theme(axis.text.y = element_text(size = 16, family = 'serif')) +
  theme(axis.title.x = element_text(size = 20, family = 'serif')) +
  theme(axis.title.y = element_text(size = 20, family = 'serif')) +
  theme(axis.line.x = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(axis.ticks = element_blank())


###What if we just want New York? 
###The function subset() allows us to take only part of our data. 
ny <- subset(states, region %in% c("new york"))

ggplot() +
  geom_polygon(data = ny, aes(x = long, y = lat, group = group), fill = "black") +
  coord_fixed(1.3) +
  theme_classic() +
  xlab("Longitude (°W)") +
  ylab("Latitude (°N)") +
  theme(axis.text.x = element_text(size = 18, family = 'serif')) +
  theme(axis.text.y = element_text(size = 16, family = 'serif')) +
  theme(axis.title.x = element_text(size = 20, family = 'serif')) +
  theme(axis.title.y = element_text(size = 20, family = 'serif')) +
  theme(axis.line.x = element_blank()) +
  theme(axis.line.y = element_blank()) +
  theme(axis.ticks = element_blank()) +
  geom_point(data = geneseo, aes(x = long, y = lat), color = "blue", size = 3)



###Can you make the dot a different color?
##Can you pick a different state or county?






####PART IV
###Play with R! 
####Fun things to try with R
###Download the packages for this to work. 


library(cowsay)
say("Hello World!")
say("Hi!")
say("Hello!", by = "cow")

###randomly select animal
someone_say_hello <- function() {
  animal <- sample(names(animals), 1)
  say(paste("Hello, I'm a ", animal,".", collapse = ""), by = animal)
}
someone_say_hello()


###play minesweeper
library(fun)
if(.Platform$OS.type == "windows") x11() else x11(type = "Xlib")
mine_sweeper()

##How to cite R packages
cite(ggplot2)


###PART V: MORE! ADVANCED FIGURE MAKING CHALLENGES
###If you're ready and looking to continue to grow in R skills, here are some figure making challenges for you to try.

##Plot a scatterplot using a dataset of your choosing using ggplot. 
##Put the independent variable on the x axis and the dependent variable on the y axis.
##Fit a line to your data and plot the line. 
##Show at 95% confidence interval for your regression line.
##Change the shape of the points. 
##Create a violin plot between two groups of data.
##Add an photograph to your plot.
##Explort a high resolution of your plot.
