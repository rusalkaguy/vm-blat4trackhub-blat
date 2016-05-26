#!/bin/bash

# these don't work
#ucsc_kent/2016-05-10/blat/gfServer stop localhost 17777
#ucsc_kent/2016-05-10/blat/gfServer stop localhost 17779

# brute force
ps -eaf | grep gf | awk '{print $2}' | xargs kill -9

