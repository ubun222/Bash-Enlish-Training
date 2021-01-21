#### I am not good at English,so I made this...


## Have a easy try:
export txt1=$(echo $(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-Enlish-Training/master/allinone.txt ) | tr -d '\\' ) && bash -c "$(curl -fsSL https://raw.githubusercontent.com/ubun222/Bash-Enlish-Training/master/1.1.0.sh)"  3 2 1

## Small Guide
```
clone
chmod +x Bash-Enlish-Training/1.*.sh
cd Bash-Enlish-Training
./1.1.0.sh ./txt/1.txt ./txt/2.txt ./txt/3.txt       #or just...
./1.1.0.sh
```
the structure of .txt file is...
1. 英文与中文必须要用TAB制表符隔开
2. 英文部分允许有空格（1.1.0才支持）
3. 单词表部分，即\\\\\\\\\\\\\\前不允许有空行
4. 若想使用v模式查询功能，需要固定格式，即\\\\\\\\\\\\\\后部分，每个单词的详细释义上下隔至少5行，并且行首的单词需要以happy |即单词后跟一个空格和"|"这个字符。






