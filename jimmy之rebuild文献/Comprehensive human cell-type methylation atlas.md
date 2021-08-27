# 文献解读
<!-- by xiaojiao -->
    《Comprehensive human cell-type methylation atlas reveals origins of circulating cell-free DNA in health
    and disease》

研究对象：***Methylation*** patterns of ***circulating cell-free DNA*** (cfDNA)

研究方法：
1.  the ***`Illumina Infinium methylation array`***, which allows thesimultaneous analysis of the methylation status of >450,000 CpG sites throughout the human genome.


数据来源:
1. The Cancer Genome Atlas (TCGA)
2.  Gene Expression Omnibus (GEO)

选材,跟买菜差不多，买的好，又得妙（精）：
-   we only used primaryt issue sources, avoid culture pollution;
-   used the methylomes of healthy human tissues, universally conserved;
-   excluded tissue methylomes that contained a high proportion of blood-derived DNA;
-   merged the methylomes of highly similar tissues;
-   preferred the methylomes of specific cell types, rather than whole tissues.


一个衍生算法：computational deconvolution algorithm
<!-- 就叫反卷积算法？ emm，剥洋葱算法比较有意思。 -->
>We approximate the plasma cfDNA
methylation profile as a linear combination of the methylation
profiles of cell types in the reference atlas. According to this
model, the relative contributions of different cell types to plasma
cfDNA can be determined using non-negative least squares linear
regression (NNLS)23,29,30. In addition, the relative contributions
of cfDNA can be multiplied by the total concentration of cfDNA
in plasma to obtain the absolute concentrations of cfDNA originating from each cell type (genome equivalents/ml)

-  简单的独立变量，线性相加
-   回归曲线，最小二乘法来确立各个变量的权重

Tissue origins of healthy cfDNA：
>As previously reported, we found that
the main contributors to cfDNA were of hematopoietic origin.

>这里有个算法的有效性是咋弄的？似乎统计学 + 芯片数据+ 预测数据来查看的。。。

最主要的是验证了这个算法，感觉，以后有时间再瞅瞅。




#### 相关链接
> [生信技能树的甲基化系列教程，目录](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247495304&idx=2&sn=e06e23fd11495904365094a3774ac6cb&scene=21#wechat_redirect)

>[跟着Nature Medicine学MeDIP-seq数据分析](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247497344&idx=1&sn=1f001547389e3688643f1c0f19bd1387&chksm=9b4bb63bac3c3f2da41ad2f6fc20fe2cf57af19adfe0d7fab80f8f9d0fa66227605374a66c7b&mpshare=1&scene=1&srcid=0501T47DM4qZnHA0APddtW2s&sharer_sharetime=1619858761848&sharer_shareid=37cf2248a89b28e3f058624640def046&exportkey=A4F4D5nSH81Yc7%2BN%2BZ%2Bb9R0%3D&pass_ticket=V7GcjjmwgctrNyVxOc2gwBjgic6eLfEIbHVNOHaUvTZHxvtV%2FPR0T5USEEhGYPib&wx_header=0#rd)

>[全套MeRIP-seq文章图表复现代码](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247501254&idx=1&sn=bfd80a73dc1e4c90e4a57a4a62575a72&chksm=9b4b857dac3c0c6b163e572e84f30afcce1e859d50c5147a91749138f750d391001ed524bccd&mpshare=1&scene=1&srcid=0501BhXyU7rOyLbT5wSEgNJm&sharer_sharetime=1619858748717&sharer_shareid=37cf2248a89b28e3f058624640def046&exportkey=Ayxm92J25K1pjrZKsOkxlN8%3D&pass_ticket=V7GcjjmwgctrNyVxOc2gwBjgic6eLfEIbHVNOHaUvTZHxvtV%2FPR0T5USEEhGYPib&wx_header=0#rd)

>[some code availability](https://github.com/nloyfer/meth_atlas)
