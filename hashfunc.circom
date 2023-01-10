pragma circom 2.0.8;

include "mimcsponge.circom";

// MiMC Hash Fucntion
// Source: https://github.com/iden3/circomlib/blob/master/circuits/mimcsponge.circom

template Hash(l,w){
  component p = MiMCSponge(l*w,220,1); // component of actual hash MiMC function // => nRounds should be 220 according to actual function;
  signal input in[l][w];
  signal output hash;
  p.k <== 0;
  var c = 0;

  
  for (var i = 0; i < l; i++) {
    for (var j = 0; j < w; j++){
      p.ins[c] <== in[i][j];
      c++;
    }
  }
hash <== p.outs[0]; // [0] because we initiated component with nOutputs = 1
}

