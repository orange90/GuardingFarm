GuardingFarm
============
#如何使用代码
在【GuardingFarm】文件夹里面的是工程文件，里面的swc文件是资源库，由【游戏flash素材源码】文件夹里面的各个源码生成。  
本工程用Flash Develop构建。安装Flash Develop后双击后缀名为 .as3proj的文件即可打开工程。
游戏数据配置文件在此处下载

	http://www.liketocode.com/demo/gameSetting.xml  

##如何修改源码
Main文件有一个载入xml文件的过程，并把xml数据存到静态类XMLParser里面。若你需要把游戏配置文件放到别的地方，则修改Main.as里面的xml路径。  
还有一个xml文件，用于存储排名数据，放在：

	http://www.liketocode.com/demo/Scores.xml  
游戏的排名数据读取从这里得到。若你需要把游戏的得分数据路径改到您的主机上，则打开【游戏flash素材源码】里面的【排名页面】，找到World_ranking.as，打开，十九行的位置修改成您所希望的位置。

##演示地址：
<a href="http://www.liketocode.com/demo/guardingfarm.swf" target="_blank"> 点击此处</a>
##更新历史
###2013-05-03
0.1版本。仅实现了游戏主逻辑和规则，排名数据仍未可以提交（但可以读取）.无背景音乐。

0.2版本。水果飞行效果优化。并对总体代码优化了，看起来更清晰。