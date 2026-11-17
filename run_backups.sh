#!/bin/bash

# Pass arguments
while (( "$#" )); do
    case $1 in
        --script_dir) script_dir="$2"; shift ;;
        --data_dir) data_dir="$2"; shift ;;
        --log_dir) log_dir="$2"; shift ;;
        --output_dir) output_dir="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


# Default directories
if [ ! -v "script_dir" ]; then
    script_dir="/script_dir"
fi
if [ ! -v "data_dir" ]; then
    data_dir="/data_dir"
fi
if [ ! -v "log_dir" ]; then
    log_dir="/log_dir"
fi
if [ ! -v "output_dir" ]; then
    output_dir="/output_dir"
fi


# Ensure that required directories exist
if [ ! -d "$script_dir" ]; then
  mkdir $script_dir
fi
if [ ! -d "$data_dir" ]; then
  mkdir $data_dir
fi
if [ ! -d "$log_dir" ]; then
  mkdir $log_dir
fi
if [ ! -d "$output_dir" ]; then
  mkdir $output_dir
fi

# Run all scripts
if compgen -G "$script_dir/*.sh" > /dev/null; then
  for f in $script_dir/*.sh; do
    now=`date "+%Y.%m.%d_%H.%M.%S"`
    log_fname="$log_dir/$now.${f##*/}.log"
#     echo $log_fname
    bash "$f" $data_dir $output_dir &> $log_fname
  done
fi


