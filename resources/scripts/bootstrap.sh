#!/bin/bash

set -e

SCRIPTPATH=$(dirname $(realpath $BASH_SOURCE[0]))

overrides=("-Djava.security.egd=file:/dev/./urandom")
optspec=":h-:"

while getopts "$optspec" optchar; do
  case "${optchar}" in
    -)
      case "${OPTARG}" in
        overrides=*)
          echo ${OPTARG/overrides=/}
          overrides+=("${OPTARG/overrides=/}")
          ;;
        javaopt=*)
            JAVA_OPT="${OPTARG/javaopt=/}"
          ;;
        *)
            echo "aaa"
            exit;
          ;;
      esac;;
    *)
            echo "unkown"
    ;;
    esac
done

echo ${overrides[@]}


set -x
java -jar \
    -server \
    $JAVA_OPT \
    ${overrides[@]}\
    eurekaserver-0.0.1-SNAPSHOT.jar
