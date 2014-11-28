#The number of individuals (N) of species 1 at a particular time is the result 
#of the number of individuals of that species at the revious time multiplied by
#its growth rate, r

#When competition within the species or from other species (a), interferes 
#with the species' ability to grow, r is reduced in proportion to those effects

#Notation:
#a11 indicates the effect of species 1 on species 1
#a21 indicates the effect of species 2 on species 1
#For species 1, (all parameters for species one start with "Sp1"):

time<-seq(1,100,by=1)

Sp1N<-3
Sp2N<-3

Sp1R<-input$Sp1R
Sp2R<-input$Sp2R

grow1<-for (i in 1:99){Sp1N[i+1]<-N[i]*Sp1R[i]}
grow2<-for (i in 1:99){Sp2N[i+1]<-N[i]*Sp2R[i]}

#In the absence of competition
Sp1N2<-Sp1N1*Sp1r1 
 
#or

#With competition; when a->0, the original equation is retrieved
Sp1N2<-Sp1N1*Sp1r1*(1-a11*Sp1N1-a21*Sp2N1) 


#These equations also apply to the other species, Sp2:

#In the absence of competition:
Sp2N2<-Sp2N2*r2 

#or

#With competition; when a->0, the original equation is retrieved
Sp2N2<-Sp2N1*r2*(1-a22*Sp2N1-a12*Sp1N1) 


