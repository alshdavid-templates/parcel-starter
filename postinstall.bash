#!/bin/bash

while true; do
    read -p "Use Local Parcel? [Y/n] " use_parcel_local
    if 
      [ "$use_parcel_local" = "y" ] || 
      [ "$use_parcel_local" = "Y" ] || 
      [ "$use_parcel_local" = "yes" ]
    then
      use_parcel_local="true"
      break
    fi

    if 
      [ "$use_parcel_local" = "n" ] || 
      [ "$use_parcel_local" = "N" ] ||
      [ "$use_parcel_local" = "no" ]
    then
      use_parcel_local="false"
      break
    fi
done

if [ "$use_parcel_local" = "false" ]; then
  echo "selecting 'package.latest.json'"
  rm -rf package.json
  rm -rf package.local.json
  mv package.latest.json package.json
  exit 0
fi

parcel_src_path="$PARCEL_SRC_PATH"

if [ "$parcel_src_path" = "" ]; then
  read -p "Enter Parcel Source Path [default: '\$HOME/Development/parcel-bundler/parcel'] " parcel_src_path
fi

if [ "$parcel_src_path" = "" ]; then
  parcel_src_path="$HOME/Development/parcel-bundler/parcel"
fi

echo "Parcel Source Path: $parcel_src_path"
echo "selecting 'package.local.json'"
rm -rf package.json
rm -rf package.latest.json
mv package.local.json package.json
sed -i 's@${PARCEL_SRC_PATH}@'"$parcel_src_path"'@g' package.json