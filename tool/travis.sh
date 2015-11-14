#!/bin/bash

# Jump ship on failure
set -e

# Fail if not dartfmt'd
dartfmt -n lib test

# Fail if analyzer warns
dartanalyzer lib/client.dart test/all_tests.dart

# Run tests 
pub run test -r expanded -p vm 

if [ "$COVERALLS_TOKEN" ]; then
    # Run coverage tool if coveralls token is available
    pub global activate dart_coveralls
    pub global run dart_coveralls report \
        --retry 2 \
        --exclude-test-files \
        test/all_tests.dart
fi
