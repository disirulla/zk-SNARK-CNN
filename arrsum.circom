pragma circom 2.0.8;

// arrsum: Sum of All elements in a given 1-D array

template arrsum (arrlen){
    signal input in[arrlen];
    signal output op;

    var s = 0;
    for (var m = 0; m<arrlen; m+=1){ // Loop for summation of all elements in array
            s = s + in[m];  
    }
    op <== s;
}

