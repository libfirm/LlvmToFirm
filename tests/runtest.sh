#!/bin/bash

# Can be used, to run a single test only.
SINGLE_TEST=$1

if [ "${SHOW_GRAPHS}" = "" ] ; then
	SHOW_GRAPHS=0
fi

if [ "${LTF_HOME}" = "" ] ; then
	LTF_HOME="$(pwd)/../../build/llvmtofirm/FirmLlvmCompiler"
fi

TEST_COUNT=0
TEST_SUCCESS=0

begin_test()
{
	# Clear old output files.
	TESTHTML=${HTMLDIR}/${TESTNAME}.xhtml
	rm -f "${TESTHTML}"
	rm -f "${HTMLDIR}/${TESTNAME}_types.svg"
	rm -f "${HTMLDIR}/${TESTNAME}_main.svg"
	
	# Add the test to the index, create the html file.
	echo -n "		<tr><td><a href=\"${TESTNAME}.xhtml\">${TESTNAME}</a></td>" >> "${HTMLINDEX}"

	cat > "${TESTHTML}" << EOF
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>${TESTNAME}</title>
		<meta http-equiv="content-type" content="application/xhtml+xml;" />
	</head>
	<body>
EOF

	# Create the temp directory.
	TESTTEMPDIR=${TEMPDIR}/${TESTNAME}
	mkdir -p "${TESTTEMPDIR}"
	rm -f "${TESTTEMPDIR}"/*
	
	cd "${TESTTEMPDIR}"
	CONVTIME="-"
}

end_test()
{
	cd "${ROOTDIR}"
	
	# Finish the html file.
	cat >> "${TESTHTML}" << EOF
	</body>
</html>
EOF

	# Output the result.
	echo $1
	
	if [ "$1" = "OK" ] ; then
		TEST_SUCCESS=$((TEST_SUCCESS+1))
		RESULTCOLOR=green
	elif [ "$1" = "SKIPPED" ] ; then
		RESULTCOLOR=grey
	else
		RESULTCOLOR=red
	fi
	
	echo "<td><span style=\"color: ${RESULTCOLOR};\">$1</span></td><td>${CONVTIME}</td></tr>" >> $HTMLINDEX
}

GCC=gcc
GPP=g++
YCOMP=ycomp
LTF_LLC=ltf-llc

ROOTDIR=$(pwd)
HTMLDIR=$(pwd)/html
TEMPDIR=$(pwd)/temp

mkdir -p "${HTMLDIR}"
mkdir -p "${TEMPDIR}"
rm -rf "${TEMPDIR}/*"

# Output the html header.
HTMLINDEX=${HTMLDIR}/index.xhtml
cat > "${HTMLINDEX}" << EOF
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Test-Index</title>
		<meta http-equiv="content-type" content="application/xhtml+xml;" />
	</head>
	<body>
		<h1>Tests</h1>
		<table border="1">
		<tr><th>Test name</th><th>Result</th><th>Conversion time</th></tr>
EOF

TEST_SUCCESS=0

for TESTSOURCE in $(pwd)/*.ll
do
	# Determine file and test names and temp directory.
	TESTNAME=$(basename "$TESTSOURCE")
	TESTNAME=${TESTNAME%.ll}
	printf "%-30s" "${TESTNAME}"

	begin_test

	if [ ! "${SINGLE_TEST}" = "" ] ; then
		if [ ! "${SINGLE_TEST}" = "${TESTNAME}" ] ; then
			end_test "SKIPPED"
			continue
		fi
	fi
	
	TEST_COUNT=$((TEST_COUNT+1))

	# Output the source code.
	cat >> "${TESTHTML}" << EOF
		<h1>Source-Code</h1>
		<pre><![CDATA[$(cat ${TESTSOURCE})]]></pre>
EOF

	##############
	# CONVERSION #
	##############

	TESTASM=${TESTTEMPDIR}/${TESTNAME}.s
	TESTASMLOG=${TESTTEMPDIR}/${TESTNAME}.s.log
	COMMAND="time -p \"${LTF_LLC}\" -S --log-level 3 --dump-all \"${TESTSOURCE}\" \"${TESTASM}\""
	eval ${COMMAND} 1> "${TESTASMLOG}" 2>&1
	RESULT=$?
	
	# Execution log.
	cat >> "${TESTHTML}" << EOF
		<h1>Conversion</h1>
		
		<h3>Execution</h3>
		<pre><![CDATA[CMD> ${COMMAND}

$(cat ${TESTASMLOG})]]></pre>
EOF
	
	if [ $RESULT -ne 0 ] ; then
		end_test "CONVERSION ERROR"
		continue
	fi
	
	# Determine the conversion time.
	CONVTIME="$(cat "${TESTASMLOG}" | tail -3 | grep real | cut -d " " -f 2) s"
	
	# Output file.
	cat >> "${TESTHTML}" << EOF
		<h3>Output</h3>
		<pre><![CDATA[$(cat ${TESTASM})]]></pre>
EOF

	if [ $SHOW_GRAPHS -eq 1 ] ; then
		for GRAPHFILE in *.vcg
		do
			if [ "${GRAPHFILE: -7}" != "low.vcg" ] ; then
				"${YCOMP}" "${GRAPHFILE}" --export "${HTMLDIR}/${TESTNAME}_${GRAPHFILE%.vcg}.svg" 1> /dev/null 2>&1
				if [ -e "${HTMLDIR}/${TESTNAME}_${GRAPHFILE%.vcg}.svg" ] ; then
					cat >> "${TESTHTML}" << EOF
		<h3>${GRAPHFILE}</h3>
		<div><object type="image/svg+xml" data="${TESTNAME}_${GRAPHFILE%.vcg}.svg"></object></div>
EOF
				fi
			fi
		done
	fi
	
	###########
	# BACKEND #
	###########
	
	CFLAGS_FILE=${ROOTDIR}/${TESTNAME}.cfl
	TEST_CFLAGS=
	LINK_WITH_GPP=

	if [ -e "${CFLAGS_FILE}" ] ; then
		source ${CFLAGS_FILE}
	fi
	
	TESTPROG=${TESTTEMPDIR}/${TESTNAME}.prg
	TESTPROGLOG=${TESTTEMPDIR}/${TESTNAME}.prg.log

	if [ "${LINK_WITH_GPP}" = "1" ] ; then
		LINKER=$GPP
	else
		LINKER=$GCC
	fi

	COMMAND="time -p \"${LINKER}\" -m32 ${TEST_CFLAGS} \"${TESTASM}\" -o \"${TESTPROG}\""

	eval ${COMMAND} 1> "${TESTPROGLOG}" 2>&1
	RESULT=$?
	
	# Execution log.
	cat >> "${TESTHTML}" << EOF
		<h1>Backend</h1>
		
		<h3>Execution</h3>
		<pre><![CDATA[CMD> ${COMMAND}

$(cat ${TESTPROGLOG})]]></pre>
EOF
	
	if [ $RESULT -ne 0 ] ; then
		end_test "BACKEND ERROR"
		continue
	fi
	
	############
	# TEST RUN #
	############
	
	TESTIN=${ROOTDIR}/${TESTNAME}.in
	TESTOUT=${ROOTDIR}/${TESTNAME}.out
	
	cat >> "${TESTHTML}" << EOF
		<h1>Test run</h1>
		
		<h3>Input</h3>
		<pre><![CDATA[$(cat ${TESTIN})]]></pre>
		
		<h3>Expected output</h3>
		<pre><![CDATA[$(cat ${TESTOUT})]]></pre>
EOF

	####################
	# VERIFICATION RUN #
	####################
	
	TESTPROGRUNLOG=${TESTTEMPDIR}/${TESTNAME}.prg.run.log
	COMMAND="cat \"${TESTIN}\" | \"${TESTPROG}\""
	eval ${COMMAND} 1> "${TESTPROGRUNLOG}" 2>&1
	RESULT=$?
	
	# Show results.
	cat >> "${TESTHTML}" << EOF
		<h3>Verification run</h3>
		<pre><![CDATA[CMD> ${COMMAND}

$(cat ${TESTPROGRUNLOG})]]></pre>
EOF
	
	if [ $RESULT -ne 0 ] ; then
		end_test "VERIFICATION RUN ERROR"
		continue
	fi
	
	if [ "$(cat ${TESTOUT})" != "$(cat ${TESTPROGRUNLOG})" ] ; then
		end_test "OUTPUT MISMATCH"
		continue
	fi

	end_test "OK"
done

cat >> "${HTMLINDEX}" << EOF
		</table>
		<p><b>Summary:</b> ${TEST_SUCCESS} of ${TEST_COUNT} tests successful ($(((TEST_SUCCESS*100)/TEST_COUNT))%)</p>
	</body>
</html>
EOF

exit 0
