if [ "$TERM_PROGRAM" = "vscode" ]; then
  cd "${OLDPWD}"
elif [ -d "${HOME}/src/github.com/Shopify/shopify" ]; then
  cd "${HOME}/src/github.com/Shopify/shopify"
fi
