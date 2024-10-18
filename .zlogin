if [ "$TERM_PROGRAM" = "vscode" ]; then
  cd "${OLDPWD}"
else
  SHOPIFY_REPO=$(cat /etc/spin/machine/constellation | perl -n -e'/shopify--(.*)\:/ && print $1')
  if [ ! -z "${SHOPIFY_REPO}" ]; then
    cd "${HOME}/src/github.com/Shopify/shopify/areas/core/shopify"
  fi
fi
