#!/usr/bin/env bash
cat <<EOF
#
# Run a query against the server, check results. 
#
EOF
BLAT_DIR=./ucsc_kent/2025-06-20/blat/
IN_FA=test.fa
OUT_PSL=test_out.psl
EXPECT_PSL=test_expect.psl

cat <<EOF

BLAT_DIR=$BLAT_DIR
IN_FA=$IN_FA
OUT_PSL=$OUT_PSL
EXPECT_PSL=$EXPECT_PSL
EOF

cat <<EOF

#
# check servers are running
#
EOF
echo ps -eaf | grep gfServer
ps -eaf | grep gfServer

cat <<EOF

#
# run query
#
EOF
echo $BLAT_DIR/gfClient \
	-t=dna -q=dna \
	localhost 17779 \
	hcmv_pub/hh5Merlin2 \
	$IN_FA \
	stdout \
	\> $OUT_PSL 2\>\&1 

$BLAT_DIR/gfClient \
	-t=dna -q=dna \
	localhost 17779 \
	hcmv_pub/hh5Merlin2 \
	$IN_FA \
	stdout \
	> $OUT_PSL 2>&1 

cat <<EOF

#
# check results
#
EOF
echo wc -l $EXPECT_PSL $OUT_PSL
wc -l $EXPECT_PSL $OUT_PSL
echo diff $EXPECT_PSL $OUT_PSL
diff $EXPECT_PSL $OUT_PSL
if [[ $? -eq 0 ]]; then echo "SUCCESS"; else echo "ERROR"; fi
echo diff -y $EXPECT_PSL $OUT_PSL
diff -y $EXPECT_PSL $OUT_PSL
if [[ $? -eq 0 ]]; then echo "SUCCESS"; else echo "ERROR"; fi
