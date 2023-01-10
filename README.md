# zk-SNARK CNN

A more detailed way to run the above code could be found [here](https://github.com/iden3/snarkjs/blob/master/README.md)

Basic Steps Involved:

1. Powers of Tau Cermony
2. Creating circuit
3. Setup of proof system
4. Generate Witness
5. Generate Proof
6. Verify the Generated Proof

### Powers of Tau Cermony

You can download Ptau files from the README.md of snarkjs. A power of 17 would be sufficient if you are not going to use Hash Fucntion.

The one available in snarkjs repo: [powersOfTau28_hez_final_17.ptau](https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_17.ptau)
The one I generated: [GeneratedPtauFinal.ptau](https://drive.google.com/file/d/1ctffe72_iwzcbGPmdH3wZZW3H0vh__II/view?usp=sharing)

Verify the downloaded `ptau` file
```sh
snarkjs powersoftau verify pot12_final.ptau
```
If it is working fine, then its great. You have saved yourself a half-day of computation.

### Creating Circuit

The `mnistmodel.circom` has the implementation of the a simple CNN model and `input.json` has the information input image and model weights.

Compile the circuit using

```sh
circom mnistmodel.circom --wasm --r1cs
```

Bring back the files generated in `mnistmodel_js` folder back to your home folder using:

```sh
cd mnistmodel_js/
mv * ../
cd ..
```

### Setup of proof system

For Groth16, a trusted setup is required (refer to snarkjs documentation). But for Plonk trusted setup is not required. Run this code for the setup of keys:

```sh
snarkjs plonk setup mnistmodel.r1cs GeneratedPtauFinal.ptau circuit_final.zkey
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
```
### Generate Witness
To generate witness run
```sh
node generate_witness.js mnistmodel.wasm input.json witness.wtns
```

### Generate Proof
To generate proof run
```sh
snarkjs plonk prove circuit_final.zkey witness.wtns proof.json public.json
```

### Verify the Generated Proof
To verify the computation run
```sh
snarkjs plonk verify verification_key.json public.json proof.json
```
The output will be OK! it is verified

## Commiting model or input or both

You can use the functionality of `hashfunc.circom` and make hashes of either model or image public according to situation.
However to keep the example simple, I have not included this in the `mnistmodel.circom`.

Why MiMC? Why not Poseidon hash? 
Poseidon hash implementation present in the circomlib is not functioning, I am unable to debug, hence took reference from [here](https://0xparc.org/blog/zk-mnist). The MultiMiMC template available in circomlib could also be used.  

Note: `ifiles` folder containts the intermediate files generated during my execution.






