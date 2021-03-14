#### I am not good at English,so I made this...


## Have a easy try:
```
export txt=$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-English-Training/master/allinone.txt  |  tr '\n' '@' | tr ' ' '/' |awk  '{ printf $0 }' |  awk -F\\\\ '{ print $1 }' )  && bash -c "$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-English-Training/master/1.3.5.sh)"  
```
## Small Guide
```
clone
chmod +x Bash-English-Training/1.*.sh
cd Bash-English-Training
./1.3.5.sh ./allinone.txt       #or ...
./1.3.5.sh                      #然后一个一个将.txt文件拖入终端，或者输入文件路径
```


the structure of .txt file is...
1. 英文与中文必须要用TAB制表符隔开。
2. 英文部分允许有空格（1.1.0以及更新版本才支持）。
3. 单词表部分，即\\\\\\\\\\\\\\前暂不允许有空行。
4. 若想使用v模式查询功能，需要固定格式，即\\\\\\\\\\\\\\后的详细释义部分。每个单词的详细释义上下隔至少5行，并且需要以happy |即单词后跟一个空格和"|"这个字符的形式作为行首。

----

* 1.1.6以及更新版本支持IOS的模拟终端[ISH](https://github.com/ish-app/ish)
* 1.3.5以及更新版本支持安卓的模拟终端[JuiceSSH](https://juicessh.com)
* 支持传参形式加载单词部分含有空格的词表
* 主体Shell（1.*.sh）仅使用了终端命令和变量储存，不会生成任何文件。
* allinone.sh等文件作用于./txt/*.txt，会拼接所有词表部分然后写进allinone.txt，可直接点击allinone.command一键生成allinone.txt。
* 另一个分支do在被push后，会执行GitHub Action，在云服务器中运行allinone.sh，并上传。
* 如遇到curl报错的问题，请参考[这里](https://cb9919.github.io/2021/01/19/修改hosts连接githubraw/)

