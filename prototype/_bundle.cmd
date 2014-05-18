echo "**************IF THIS ERRORS********************"
echo "Patch Natural to not require 'WNdb' "
echo "Patch Sylvester to not require 'lapack'"
echo "************************************************"

browserify --extension='.coffee' -t coffeeify runner.coffee -o bundle.js -r ./runner -r ./server_logging/logging_client
uglifyjs bundle.js -o bundle.min.js -m -c
rm bundle.js
cp bundle.min.js ./WebA/bundle.min.js
cp bundle.min.js ./WebB/bundle.min.js