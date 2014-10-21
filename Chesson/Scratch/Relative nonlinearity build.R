#It should be noted that Chesson (2000) seems to think that too much 
#has been made of carrying capacities

#When two species have different responses to the envrionment
?rlnorm
time<-seq(1,100,by=1)
resource<-rlnorm(meanlog=1, sdlog=.5, n=100)
plot(resource~time, type="l")
hist(resource)

Resource<-seq(0,6,by=.1)
Sp1a<-2
Sp1b<-.5

Sp1Gr<-(Sp1a*Resource)/(1+Sp1a*Sp1b*Resource)
Sp2Gr<-(Sp1b+Sp1b*Resource/Sp1a)

plot(Sp1Gr~Resource, type="l", ylab="per capita growth")
points(Sp2Gr~Resource, col="blue", type="l")

Sp1N<-.01
Sp2N<-.01
#Sp1R<-input$Sp1R
#Sp2R<-input$Sp2R

Sp1R<-.1
Sp2R<-.09


K <- switch(input$setK,
            no = 10*exp(100),
            yes = 40) 

a11 <- switch(input$incAlpha1,
              no = 0,
              yes = input$a11) 

a22 <- switch(input$incAlpha1,
              no = 0,
              yes = input$a22)

a21 <- switch(input$incAlpha2,
              no = 0,
              yes = input$a21)

a12 <- switch(input$incAlpha2,
              no = 0,
              yes = input$a12) 


for (i in 1:99){Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*(((Sp1a*resource[i])/(1+Sp1a*Sp1b*resource[i]))+((K-Sp1N[i]-Sp1N[i]*a11-Sp2N[i]*a21)/K))
                 Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*((Sp1b+Sp1b*resource[i]/Sp1a)+((K-Sp1N[i]-Sp2N[i]*a22-Sp1N[i]*a12)/K))}


plot(Sp1N~time)
points(Sp2N~time, pch=3)

warnings()

Resource<-seq(0,6,by=.1)
Sp1a<-2
Sp1b<-.5

Sp1Gr<-(Sp1a*Resource)/(1+Sp1a*Sp1b*Resource)
Sp2Gr<-(Sp1b+Sp1b*Resource/Sp1a)

plot(Sp1Gr~Resource, type="l", ylab="per capita growth")
points(Sp2Gr~Resource, col="blue", type="l")

