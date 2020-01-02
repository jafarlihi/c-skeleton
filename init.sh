#!/usr/bin/env bash

makefile_project_name_marker="#ProjectNameMarker"
module_name_marker="NAMEOFUNIT"
read -r -d '' header_content_template <<'EOF'
#ifndef NAMEOFUNIT_H
#define NAMEOFUNIT_H

#endif NAMEOFUNIT_H
EOF
read -r -d '' test_content_template <<'EOF'
#include <unity.h>
#include <NAMEOFUNIT>

void test_NAMEOFUNIT_firstTest(void) {

}
EOF

function create_module {
    touch ./sources/$1.c
    touch ./tests/$1-test.c
    touch ./includes/$1.h
    create_header_file $1
    create_test_file $1
    register_test_file $1
    echo "Module named '$1' was created"
}

function create_header_file {
    header_content=$(sed "s/NAMEOFUNIT/$1/g" <<< $header_content_template)
    echo "${header_content^^}" >> ./includes/$1.h
}

function create_test_file {
    test_content=$(sed "s/NAMEOFUNIT/$1/g" <<< $test_content_template)
    echo "${test_content}" >> ./tests/$1-test.c
}

function register_test_file {
    # TODO: Make this less hacky
    echo "#include <$1-test.h>" >> ./tests/main-test.c
    echo "extern void test_$1_firstTest(void);" >> ./tests/main-test.c
}

function additional_module_prompt {
    read -p "One more module? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        read -p "Module name?: " module_name
        create_module $module_name
        additional_module_prompt
    else
        echo "All done!"
        exit 0
    fi
}

# TODO: Switch on a flag for creation of more modules and initialization
read -p "Name of project: " project_name
sed -i "s/$makefile_project_name_marker/$project_name/g" Makefile
read -p "Name of first module?: " module_name
create_module $module_name
additional_module_prompt

