docker build --force-rm \
  --no-cache \
  -f build.Dockerfile \
  -t dkp-webpack-test:production .


# docker build --force-rm \
#   --cache-from $DKP_IMAGE_REGISTRY/dkp-webpack-test \
#   -t $DKP_IMAGE_REGISTRY/dkp-webpack-test .