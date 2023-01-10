pragma circom 2.0.8;

include "convolution.circom";
include "linear.circom";
include "argmax.circom";

// A simple cnn model for MNIST data


template model (){

    component conv1 = convolution(28,9); // For Layer1
    component conv2 = convolution(20, 11); // For Layer2
    component linear1 = linear(10); // For Linear Layer
    component argmax1 = argmax(10); // Returns Output

    
    // Inputs
    signal input image[28][28]; 
    signal input filter1[9][9];
    signal input bias1;
    signal input filter2[11][11];
    signal input bias2;
    signal input filterlin[100][10];
    signal input biaslin[10];
   
    // Output
    signal output label;

    for (var i = 0; i < 28; i++) {
        for (var j = 0; j < 28; j++){
            conv1.image[i][j] <== image[i][j]; // Feeding Input Image
        }
    }
    

    for (var k = 0; k < 9; k++) {
        for (var l = 0; l < 9; l++){ 
            conv1.filter[k][l] <== filter1[k][l];  // Feeding Layer-1 Filter
        }
    }
    conv1.bias <== bias1; // Feeding L-1 Bias

    for (var m = 0; m < 20; m++) {
        for (var n = 0; n < 20; n++){
            conv2.image[m][n] <== conv1.conv2dop[m][n]; // Sending the o/p of Layer-1 to Layer-2
        }
    }
    

    for (var o = 0; o < 11; o++) {
        for (var p = 0; p < 11; p++){ 
            conv2.filter[o][p] <== filter2[o][p]; // Feeding Layer-2 Filter
        }
    }
    conv2.bias <== bias2; // Feeding Layer-2 Bias
    var ss = 0;
    for (var r = 0; r < 10; r++) {
        for (var s = 0; s < 10; s++){
            linear1.image[ss] <== conv2.conv2dop[r][s]; // Sending the o/p of Layer-2 to Lin-Layer
            ss++;
        }
    }

    for (var t = 0; t < 10; t++) {
        for (var tt = 0; tt < 100; tt++) {
        
        linear1.filter[tt][t] <== filterlin[tt][t]; // Feeding Layer-3 Filter
    }
        linear1.bias[t] <== biaslin[t]; // Feeding Layer-3 Bias
       
    }

    for (var u = 0; u < 10; u++) {
        argmax1.arr[u] <== linear1.lin[u];  // Argmax Function
    }
    label <== argmax1.y; // Final Output
    
    }

component main  = model ();
