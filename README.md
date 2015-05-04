# benchmark-awk-vs [![Build Status](https://api.travis-ci.org/Tensibai/benchmark-awk-vs.svg?branch=master)](https://travis-ci.org/Tensibai/benchmark-awk-vs)

Let's make a challenge versus awk and other implementations.

[Source idea was here on StackOverflow](http://stackoverflow.com/questions/29825821/what-is-the-performance-difference-between-gawk-and)

Reported here as the original question from ![Ed Morton](http://stackoverflow.com/users/flair/1745001):

Given a 10 Million line input file created by this script:

    $ awk 'BEGIN{for (i=1;i<=10000000;i++) print (i%5?"miss":"hit"),i,"  third\t \tfourth"}' > file

    $ wc -l file
    10000000 file

    $ head -10 file
    miss 1   third          fourth
    miss 2   third          fourth
    miss 3   third          fourth
    miss 4   third          fourth
    hit 5   third           fourth
    miss 6   third          fourth
    miss 7   third          fourth
    miss 8   third          fourth
    miss 9   third          fourth
    hit 10   third          fourth

and given this awk script which prints the 4th then 1st then 3rd field of every line that starts with "hit" followed by an even number:

    $ cat tst.awk
    /hit [[:digit:]]*0 / { print $4, $1, $3 }

Here are the first 5 lines of expected output:

    $ awk -f tst.awk file | head -5
    fourth hit third
    fourth hit third
    fourth hit third
    fourth hit third
    fourth hit third

and here is the result when piped to a 2nd awk script to verify that the main script above is actually functioning exactly as intended:

    $ awk -f tst.awk file |
    awk '!seen[$0]++{unq++;r=$0} END{print ((unq==1) && (seen[r]==1000000) && (r=="fourth hit third")) ? "PASS" : "FAIL"}'
    PASS

# How it works:
On each commit a build is launched on travis CI wich produce a markdown file with the results.
The build ensure each script pass the test and then run it without output enclose by time to measure the time taken
The resulting file is inserted in a gh-pages site visible [here](http://tensibai.github.io/benchmark-awk-vs/) which is updated at end of each build

# How to participate:
 * Fork this repository
 * Add your script to be tested in the `test/<desired language>` directory
 * If there's not already a launcher, create one (try to keep close from others to not loose time)
 * Make a pull request ;)

# ToDo:
 * Find participant to get tests in other languages
