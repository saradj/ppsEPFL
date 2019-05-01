#!/bin/bash

## Basic tests for weeks 9 and 10

source $(dirname ${BASH_SOURCE[0]})/test_env.sh

test=0

# ======================================================================
# tool function
check_output_with_file() {

    checkX "Test TLB hierarchy" "$1"

    ref='tests/files'
    cmdfile="${ref}/$2"
    [ -f "$cmdfile" ] || error "Expected command file \"$cmdfile\" not found."

    memfile="${ref}/$3"
    [ -f "$memfile" ] || error "Expected mem dump file \"$memfile\" not found."

    refoutput="${ref}/$4"
    [ -f "$refoutput" ] || error "Expected output file \"$refoutput\" not found."
    
    mytmp1="$(new_tmp_file)"
    mytmp2="$(new_tmp_file)"
    "$1" "$cmdfile" "$memfile" "$mytmp1" 2>"$mytmp2"
    # we don't do anything with stderr yet, but may be useful sometime

    diff -w "$mytmp1" "$refoutput" \
        && echo "PASS" \
        || (echo "FAIL"; \
            exit 1)
}

# ======================================================================
# test test-tlb_simple on a few provided files
check_output_with_file test-tlb_hrchy commands02.txt memory-dump-01.mem output/tlb-hrchy-01-out.txt
printf "Test %1d (test-tlb_hrchy 1): " $((++test))

# ======================================================================
echo "SUCCESS"
