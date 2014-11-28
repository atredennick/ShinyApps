#This shiny app was developed for an in-class actity on bet hedging

time<-seq(1,100, by=1)
N<-10 #the number of seeds each student starts with
g<-input$germ #the percent of seeds germinating every year (indifferent to conditions)
L<-rpois(lambda=1, n=100)
s<-1

for (i in 1:99) {N[i+1]<-s*(1-g)*N[i]+L[i]*g*N[i]}

plot(L~time)
plot(N~time)

