<?php

$fd=fopen($argv[1], 'r');
while($line = fgets($fd)){
    if(preg_match("/hit \d*0 /", $line)){
        $f=preg_split("/\s+/", $line);
        echo $f[3]." ".$f[0]." ".$f[2]."\n";
    }
}
fclose($fd);

