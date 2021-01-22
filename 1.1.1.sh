read -r -d '\' txt1 < $1  && read -r -d '\' txt2 < $2 && read -r -d '\' txt3 < $3
txt=$( echo $txt1 && echo $txt2 && echo $txt3)
n=$(echo $txt | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
echo  --------------------------------------------------
echo 检测到$[$n/2]组单词
nv=$n
#echo $n
if [[  $n = 1 ]] ;then
for i in $(seq 100)
do
read   -p  请手动拖入txt文件，按回车键结束： target
dirname $target >/dev/null
key=$?
targets=$targets' '$target
#echo $targets
if [[ $key != 0 ]];then
break
elif [[ $key = 0 ]];then
txt=$(cat ${target} | tr '\n' '@' | tr ' ' '/'| awk  '{ printf $0 }' |  awk -F\\ '{ print $1 }' )"$txt"
#echo $txt

n=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p') #最长的list的行数
echo 重新检测到共$[$[$n-$[n%2]]/2]组单词
fi
done
fi
m=$[$[$n-$[n%2]]/2]*2]
#r=$(($RANDOM%$m+1))
#list=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| grep -n '')
#echo $list

voice=1
if [[ $(uname) = "Darwin" ]];then
voice=0
fi

clear
echo "--------------------------------------------------"
echo "-----------welcome to English Training------------"
echo "--------------------------------------------------"
read -p "请选择练习模式:1，英译中    2，中译英    3，混合模式 " mode
read -p "请输入练习次数:" ii


if [[ $mode = 3 ]] ;then
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
m=$n
m=$(($RANDOM%$m+1))

question=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| grep -n '' | grep -w $m | head -n 1 | awk -F: '{printf $2}' | tr '/' ' ')
echo  -------------------------------------------------- 
printf  "$question" 
if [[ $voice = 1 ]] ;then
say  $question
fi     #printf 命令需要套一个双引号才能输出空格
No=$[$[m/2]+$[m%2]]
pureanswer=$(echo $txt | tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf
answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')

if [[ $question = $answer1 ]] ;then
answer=$answer2

elif [[ $question = $answer2 ]] ;then
answer=$answer1
fi
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
if [[ $scanf = $answer ]] ;then
echo 正确
fi


read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"  #加换行，否则界面不对称
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $nv != 1 ]];then
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
fi
fi
done
fi



if [[ $mode = 2 ]] ;then
m=$[$[$n-$[n%2]]/2]
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
m2=$(($RANDOM%$m+1))
question=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk '{printf $2}')
echo  -------------------------------------------------- 
printf   "$question" 
if [[ $voice = 1 ]] ;then
say  $question
fi 
pureanswer=$(echo $txt |  tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if [[ $scanf = $answer1 ]] ;then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $nv != 1 ]];then
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
fi
fi
done
fi



if [[ $mode = 1 ]] ;then
m=$[$[$n-$[n%2]]/2]
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
m2=$(($RANDOM%$m+1))
question=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk  '{RS=" "}{printf $1}' | tr -d '0-9' | tr -d ':' | tr '!' ' ')
echo  -------------------------------------------------- 
printf   "$question" 
if [[ $voice = 1 ]] ;then
say  $question
fi 
pureanswer=$(echo  $txt| tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' |grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if [[ $scanf = $answer2 ]];then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $nv != 1 ]];then
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
fi
fi
done
fi
