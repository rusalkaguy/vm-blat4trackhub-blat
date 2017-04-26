#!/bin/awk -f
#
# parse UCSC track hub genomes.txt file to output a list of gfServers to run
#

# trim functions portect us against DOS-files
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }
# basename
function dirname(path) {
    sub("/[^/]+$", "", path)
    if( path=="") { return "." }
    return path
}
BEGIN {
	PORT=3
	NOHUP="nohup $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost"
}
# parse value/key pairs
($1!=""){keys[$1]=rtrim($2)}

# NT server
(/^blat/     ){print NOHUP,rtrim($3),"-stepSize=5 -seqLog -ipLog -log=$ROOTDIR/logs/" keys["genome"] ".dna."rtrim($PORT)".log " dirname(FILENAME)"/"keys["twoBitPath"]" &"}

# NT server
(/^transBlat/){print NOHUP,rtrim($3),"-trans      -seqLog -ipLog -log=$ROOTDIR/logs/" keys["genome"] ".dna."rtrim($PORT)".log " dirname(FILENAME)"/"keys["twoBitPath"]" &"}

