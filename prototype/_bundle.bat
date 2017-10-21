echo "**************IF THIS ERRORS********************"
echo "Patch Natural to not require 'WNdb' "
echo "Patch Sylvester to not require 'lapack'"
echo "************************************************"

browserify --extension='.coffee' -r ./runner.coffee:./runner -r ./server_logging/logging_client.coffee:./server_logging/logging_client -o bundle.js
uglifyjs bundle.js -o bundle.min.js -m -c
cp bundle.min.js ./WebA/bundle.min.js
cp bundle.min.js ./WebB/bundle.min.js
rm bundle.js
rm bundle.min.js
