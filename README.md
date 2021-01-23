#### I am not good at English,so I made this...


## Have a easy try:
export txt1=$(echo $(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-Enlish-Training/master/example.txt ) | tr -d '\\' ) && bash -c "$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-Enlish-Training/master/1.1.2.sh)"  3 2 1

## Small Guide
```
clone
chmod +x Bash-Enlish-Training/1.*.sh
cd Bash-Enlish-Training
./1.1.2.sh ./example.txt    #or ...
./1.1.2.sh                  #然后一个一个将.txt文件拖入终端，或者输入文件路径
```
the structure of .txt file is...
1. 英文与中文必须要用TAB制表符隔开。
2. 英文部分允许有空格（1.1.0才支持），但这样就不能使用传参（即.sh后跟txt文件）形式加载词表（计数错误）。
3. 词表部分每行(包括\行)不能以空格结尾。
3. 单词表部分，即\\\\\\\\\\\\\\前不允许有空行。
4. 若想使用v模式查询功能，需要固定格式，即\\\\\\\\\\\\\\后部分，每个单词的详细释义上下隔至少5行，并且行首的单词需要以happy |即单词后跟一个空格和"|"这个字符。

* 该Shell（1.*.sh）仅使用了终端命令和变量储存，不会生成任何文件。
* allinone.sh等文件作用于./txt/*.txt，会拼接所有词表部分然后写进allinone.txt。
* allinone.sh的用法除了终端执行外，也可点击allinone.command一键生成allinone.txt。
* 另一个分支do在被push后，会执行GitHub Action，在云服务器中运行Allinone.sh，并上传。



