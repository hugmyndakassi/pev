#!/bin/bash

prog="valgrind -q ../src/build/pepack"
samples=../support_files/samples/*

n=0
err=0
for sample in $samples; do

	echo -e "\n$sample"
	$prog $sample > /dev/null 2>&1 || let err++
	let n++
done

echo "$n samples analyzed. $err errors." > /dev/fd/2
exit $err
