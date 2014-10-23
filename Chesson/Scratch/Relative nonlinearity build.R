#It should be noted that Chesson (2000) seems to think that too much 
#has been made of carrying capacities

#When two species have different responses to the envrionment

Sp1N<-1
Sp2N<-1
#Sp1R<-input$Sp1R
#Sp2R<-input$Sp2R

Sp1R<-1
Sp2R<-1

x<-seq(1,7, by=.1)
a<-.5
a2<-.35
b<-.7
b2<-.9
c<-0
c2<-0

y<-c+log(x)/(a+b*log(x))
y1<-c2+log(x)/(a2+b2*log(x))
plot(y~x, type="l", col="blue")
points(y1~x, type="l")

set.seed(15)
x<-rlnorm(n=100, meanlog=log(3), sdlog=log(1.3))
max(x)

for (i in 1:99){
  Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*(c+log(x[i])/(a+b*log(x[i])))
  Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*(c2+log(x[i])/(a2+b2*log(x[i])))}

plot(x~seq(1:100), type="l")
plot(Sp1N~seq(1:100), ylim=c(0,100))
points(Sp2N~seq(1:100), pch=3)

a11<-1
a22<-1
a12<-8
a21<-5
K=100

for (i in 1:99){
  resp1[i]<-(c+log(x[i]))/(a+b*log(x[i]))
  resp2[i]<-(c2+log(x[i]))/(a2+b2*log(x[i]))
  comp1[i]<-((K-Sp1N[i]-Sp1N[i]*a11-Sp2N[i]*a21)/K)
  comp2[i]<-((K-Sp2N[i]-Sp2N[i]*a22-Sp1N[i]*a12)/K)
  Sp1N[i+1]<-Sp1N[i]+Sp1N[i]*Sp1R*(comp1[i]-resp1[i])
  Sp2N[i+1]<-Sp2N[i]+Sp2N[i]*Sp2R*(comp2[i]-resp2[i])}

plot(x~seq(1:100), type="l")
plot(Sp1N~seq(1:100), ylim=c(0,20))
points(Sp2N~seq(1:100), pch=3)

plot(comp1~seq(1:99), type="l")
points(comp2~seq(1:99), type="l")

plot(resp1~seq(1:99), type="l")
points(resp2~seq(1:99), type="l")

#insert K's and an indicator of coexistence in bth LV and this module.