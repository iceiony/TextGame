echo 'compiling coffeescript'
coffee --output ../prototype-out/ --map  --compile ./

echo 'copying package.json and node_modules'
cp ./package.json ../prototype-out/
cp -R ./node_modules ../prototype-out/
cp -R ./prompt-input ../prototype-out/