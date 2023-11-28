#!/bin/bash

readpe="valgrind -q ../src/build/readpe"
samples=../support_files/samples/*
opts_noarg='-A -H -d -i'
opts_arg[0]='-h dos'
opts_arg[1]='-h coff'
opts_arg[2]='-h optional'

n=0
err=0
for sample in $samples; do

	echo $sample

	for opt in $opts_noarg; do
		$readpe $opt $sample > /dev/null 2>&1 || let err++
	done

	for format in text csv xml html; do
		for opt in $opts_noarg; do
			$readpe -f $format $opt $sample > /dev/null 2>&1 || let err++
		done
	done

	for i in 0 1 2; do
		$readpe ${opts_arg[i]} $sample > /dev/null 2>&1 || let err++
		for format in text csv xml html; do
			for opt in $opts_noarg; do
				$readpe -f $format $opt ${opts_arg[i]} $sample > /dev/null 2>&1 || let err++
			done
		done
	done
	let n++

done

echo "$n samples analyzed. $err errors." > /dev/fd/2
exit $err
