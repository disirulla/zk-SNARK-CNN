pragma circom 2.0.8;


template argmax(l){
    signal input arr[l];
    signal output y;
    signal buf2;

    var buf = 0;
    var buf1 = 0;


// Looping over all the elements in array to find the max value
    for(var i=0; i<l; i++){ 
        arr[i]*0 === 0;
        if (buf < arr[i])
        {
            buf = arr[i]; // max value
            buf1 = i;      // position of max value
        }
    }

    buf2 <-- buf1;
    buf2*0 === 0;

    y <== buf2;
}