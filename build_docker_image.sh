docker build --force-rm \
  --no-cache \
  -t dkp-webpack-test .


# docker build --force-rm \
#   --cache-from $DKP_IMAGE_REGISTRY/dkp-webpack-test \
#   -t $DKP_IMAGE_REGISTRY/dkp-webpack-test .