echo 'compiling coffee script'
coffee --output ../world-modeling-out/ --map  --compile ./

echo 'copying package.json and node_modules'
cp ./package.json ../world-modeling-out/
cp -R ./node_modules ../world-modeling-out