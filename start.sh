#!/bin/bash
# prefix environment variables with REACT_APP_ENV_
while read p; do
  IFS== read var1 var2 <<< $p
  export REACT_APP_ENV_$var1=$var2
done < <(printenv)

# update package.json
sed -i 's#\"proxy\": \"[^\"]*\"#\"proxy\": \"'"$DKP_METADATA_SERVICES_UI_BACKEND_SCHEME://$DKP_METADATA_SERVICES_UI_BACKEND_SERVICE_SERVICE_HOST:$DKP_METADATA_SERVICES_UI_BACKEND_SERVICE_SERVICE_PORT"'\"#' package.json

# start React app
npm start
