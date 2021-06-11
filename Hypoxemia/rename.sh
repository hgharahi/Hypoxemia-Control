numfiles="$(ls -dq *GA_RES* | wc -l)"
echo $numfiles
mv GA_RES.mat "GA_RES${numfiles}.mat"

