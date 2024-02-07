import fs from 'fs'; 
import * as snarkjs from 'snarkjs'; 
import sha256 from 'crypto-js/sha256'; 

const input = {
    "secretKeyword": "0x" + "123456".padEnd(64, "0"),
    "expiryTimestamp": "0x" + (Date.now() / 1000 + 86400).toString(16), // 1 day in future
    "currentTimestamp": "0x" + (Date.now() / 1000).toString(16),
    "publicHash": "0x" + sha256("123456").toString(),
  };
  
  
  const { proof, publicSignals } = snarkjs.groth16.fullProve(
    input,
    "circuit.wasm",
    "circuit_final.zkey",
  );
  
  console.log(proof);