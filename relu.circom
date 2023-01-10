pragma circom 2.0.8;

// Rectified Linear Unit (ReLU)
// <== means assignment and adding the constraint

template relu() {  

    signal input reluin;   
    signal output y;  
    signal  buf;
    buf <-- reluin>0 ? reluin : 0;  // Equivalent to if-else condition
    buf*0 === 0; // Taken a buffer signal because, we can't assign directly using <== 
    y <== reluin;
  
  }


