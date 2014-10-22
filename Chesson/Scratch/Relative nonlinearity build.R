#It should be noted that Chesson (2000) seems to think that too much 
#has been made of carrying capacities

#When two species have different responses to the envrionment

time<-seq(1,100,by=1)
#resource<-rlnorm(meanlog=1, sdlog=.5, n=100)
resource<-rlnorm(meanlog=.005, sdlog=.3, n=100)
plot(resource~time, type="l")
hist(resource)

Resource<-seq(0,6,by=.1)
Sp1a<-2 #(.5 to 2)
Sp1b<-.5
Sp1Gr<-(Sp1a*Resource)/(1+Sp1a*Sp1b*Resource)

Sp2a<-.2
Sp2b<-.4
Sp2Gr<-Sp2a+Sp2b*Resource

plot(Sp1Gr~Resource, type="l", ylab="per capita growth")
points(Sp2Gr~Resource, col="blue", type="l")

Sp1N<-1
Sp2N<-1
#Sp1R<-input$Sp1R
#Sp2R<-input$Sp2R

Sp1R<-.05
Sp2R<-.05

x<-seq(1,7, by=.1)

a<-2
a2<-1
b<-3
b2<-4
c<-0
c2<-0

y<-c+log(x)/(a+b*log(x))
y1<-c2+log(x)/(a2+b2*log(x))
plot(y~x, type="l", col="blue")
points(y1~x, type="l")


res1<-(Sp1a*resource[i])/(1+Sp1a*Sp1b*resource[i]) #resource response 1
res2<-Sp1b+Sp1b*resource[i]/Sp1a

for (i in 1:99){
  
  Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*((Sp1a*resource[i])/(1+Sp1a*Sp1b*resource[i]))
                 Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*(Sp1b+Sp1b*resource[i]/Sp1a)}

plot(Sp1N~time, ylim=c(0,100))
points(Sp2N~time, pch=3)

#insert K's and an indicator of coexistence in bth LV and this module.