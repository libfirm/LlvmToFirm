#!/bin/sh

tempDir=../temp

compile()
{	
	# Extract in- and output.
	input=`cat $1 | sed 's/$//' | sed -n 's@^.*//[[:space:]]*\[in\][[:space:]]*\(.*\)[[:space:]]*@\1@p'`
	output=`cat $1 | sed 's/$//' | sed -n 's@^.*//[[:space:]]*\[out\][[:space:]]*\(.*\)[[:space:]]*@\1@p'`
	optlevels=`cat $1 | sed 's/$//' | sed -n 's@^.*//[[:space:]]*\[opt\][[:space:]]*\(.*\)[[:space:]]*@\1@p'`
	
	# Determine optimization levels to use.
	if [ "$optlevels" = "" ] ; then
		optlevels=1
	fi
	
	for opt in $optlevels ; do
		if [ ! -e ../$2_$opt.ll ] ; then
			echo $2_$opt

			# Compile the source code.
			llvm-gcc -m32 --emit-llvm -O$opt -S $1 -o ../$2_$opt.ll || exit 1
			
			# Create automatic output.
			if [ "$output" = "<auto>" ] ; then
				llvm-gcc -m32 -O$opt $1 -o ${tempDir}/$2_$opt.prg || exit 1
				output=`echo -n $input | ${tempDir}/$2_$opt.prg 2>&1`
				rm ${tempDir}/$2_$opt.prg
			fi
			
			# Write the in- and output file.
			cat > ../$2_$opt.in << EOF
$input
EOF

			cat > ../$2_$opt.out << EOF
$output
EOF
		fi
	done
}

for file in *.c
do
	compile $file ${file%.c}
done

exit 0
