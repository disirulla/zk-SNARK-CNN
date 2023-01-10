pragma circom 2.0.8;

// Linear Layer 

include "arrsum.circom";
include "relu.circom";

template linear(l)
{
  signal input image[l*l];
  signal input filter[l*l][l];
  signal input bias[l];
  signal output lin[l];
// We can't re-assign value to a signal like variables, hence it is important to declare a component array instead of signle component to accomidate all iterations.
  component linarrsum[l];


 
for (var i=0; i<l; i++ ){
    linarrsum[i]=arrsum(l*l); 
    for (var j=0; j<l*l; j++){
      linarrsum[i].in[j] <==  image[j]*filter[j][i]; 
    }
    lin[i] <== linarrsum[i].op + bias[i] ;
  }
 
}