#### I am not good at English,so I made this...


## Have a easy try:
```
export txt=$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-English-Training/master/allinone.txt  |  tr '\n' '@' | tr ' ' '/' |  awk -F\\\\ '{ print $1 }' )  && ${0#-} -c "$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-English-Training/master/allrun.sh)"  
```
## Small Guide
```
clone
chmod +x Bash-English-Training/1.*.sh
cd Bash-English-Training
./1.4.1.sh ./allinone.txt       #or ...
./1.4.1.sh                      #然后一个一个将.txt文件拖入终端，或者输入文件路径
```


the structure of .txt file is...
1. 英文与中文必须要用TAB制表符隔开。
2. 英文部分允许有空格（1.1.0以及更新版本才支持）。
3. 单词表部分，即\\\\\\\\\\\\\\前暂不允许有空行。
4. 若想使用v模式查询功能，需要固定格式，即\\\\\\\\\\\\\\后的详细释义部分。每个单词的详细释义上下隔至少5行，并且需要以happy |即单词后跟一个空格和"|"这个字符的形式作为行首。

----

* 1.1.6以及更新版本支持IOS的模拟终端[ISH](https://github.com/ish-app/ish)
* 不怎么支持安卓的模拟终端[JuiceSSH](https://juicessh.com)

* 如遇到curl报错的问题，请参考[这里](https://cb9919.github.io/2021/01/19/修改hosts连接githubraw/)

