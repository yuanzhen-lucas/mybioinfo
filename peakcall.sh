 #!/bin/bash

do

bedtools bamtobed -i ~/mnase0329/rs512.bam > rs512.bed

./fseq -v -of npf rs512.bed

mkdir rs512.npf

mv *.npf rs512.npf

cd rs512.npf

touch rs512allpeak

cp Chr1.npf rs512allpeak

cat Chr2.npf >> rs512allpeak
cat Chr3.npf >> rs512allpeak
cat Chr4.npf >> rs512allpeak
cat Chr5.npf >> rs512allpeak
cat chloroplast.npf >> rs512allpeak
cat mitochondria.npf >> rs512allpeak

sed -i 's/mitochondria/ChrM/g' rs512allpeak
sed -i 's/chloroplast/ChrC/g' rs512allpeak

done