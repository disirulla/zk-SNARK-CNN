pragma circom 2.0.8;

// 2-D Convolution Layer 

include "arrsum.circom"; 
include "relu.circom";

template convolution(l,z) {  

    signal input image[l][l]; // Image
    signal input filter[z][z]; //Kernel
    signal input bias; // Bias
    signal output conv2dop[l-z+1][l-z+1]; // l-z+1 size of output after convolution operation.
// We can't re-assign value to a signal like variables, hence it is important to declare a component array instead of signle component to accomidate all iterations.
    component intersum[l-z+1][l-z+1]; 
    component relulayer[l-z+1][l-z+1];

   
for (var i = 0; i < l-z+1; i++) {
    for (var j = 0; j < l-z+1; j++){  
        intersum[i][j] = arrsum(z*z);
        relulayer[i][j] = relu();
        var k = 0;  // To convert a 2D array into a linear array and send it to arrsum.     
        for (var ii = 0; ii < z; ii++) {
                for (var jj = 0; jj < z; jj++){
                    intersum[i][j].in[k] <== image[i+ii][j+jj]*filter[ii][jj];
                    k++;
                }    
        }

        relulayer[i][j].reluin <== intersum[i][j].op + bias; 
        conv2dop[i][j] <== relulayer[i][j].y;

    }
} 

}