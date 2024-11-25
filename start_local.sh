#!/bin/bash
# prefix environment variables with REACT_APP_ENV_
while read p; do
  IFS== read var1 var2 <<< $p
  export REACT_APP_ENV_$var1=$var2
done < <(printenv)

# update package.json
sed -i 's#\"proxy\": \"[^\"]*\"#\"proxy\": \"'"http://dkp-metadata-services-ui-backend:8000"'\"#' package.json

# start React app
npm start