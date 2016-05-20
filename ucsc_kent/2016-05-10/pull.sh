#!/bin/bash
URL=http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat
mkdir -p blat
cd blat
for F in FOOTER.txt blat gfClient gfServer; do
	wget --timestamping  $URL/$F;
done


