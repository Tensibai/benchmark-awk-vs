!seen[$0]++{ 
  unq++;r=$0
} 
END{
  print ((unq==1) && (seen[r]==1000000) && (r=="fourth hit third")) ? "PASS" : "FAIL"
}
