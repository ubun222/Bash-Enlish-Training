read -r -d '\' txt1 < $1  && read -r -d '\' txt2 < $2 && read -r -d '\' txt3 < $3
txt=$( echo $txt1 && echo $txt2 && echo $txt3)
n=$(echo $txt | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
echo 检测到$[$n/2]组单词
m=$(($n+0))
#r=$(($RANDOM%$m+1))
list=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| grep -n '')
#echo $list
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
m=$(($RANDOM%$n+1))
question=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| grep -n '' | grep -w $m | head -n 1 | awk -F: '{printf $2}')
echo  -------------------------------------------------- 
printf $question
No=$[$[m/2]+$[m%2]]
pureanswer=$(echo $txt|tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf
answer1=$(echo $pureanswer | awk '{printf $1}')
answer2=$(echo $pureanswer | awk '{printf $2}')
#echo $answer1
#echo $answer2 
if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
echo  "$pureanswer" 
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$pureanswer" 
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$[$ii-$i]题
fi
done
fi



if [[ $mode = 2 ]] ;then
m=$[n/2]
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
m2=$(($RANDOM%$m+1))
question=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk '{printf $2}')
echo  -------------------------------------------------- 
printf   "$question"
pureanswer=$(echo $txt|tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk '{printf $1}')
answer2=$(echo $pureanswer | awk '{printf $2}')
#echo $answer1
#echo $answer2 
if [[ $scanf = $answer1 ]] ;then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
echo "$pureanswer" 
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
echo -n "$pureanswer" 
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq >/dev/tty)>&/dev/null
echo @还有$[$ii-$i]题
fi
done
fi



if [[ $mode = 1 ]] ;then
m=$[m/2]
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
m2=$(($RANDOM%$m+1))
question=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk  '{RS=" "}{printf $1}' | tr -d '0-9' | tr -d ':')
echo  -------------------------------------------------- 
printf   "$question"
pureanswer=$(echo $txt|tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' |grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk '{printf $1}')
answer2=$(echo $pureanswer | awk '{printf $2}')
#echo $answer1
#echo $answer2 
if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
echo "$pureanswer" 
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
echo -n "$pureanswer" 
(cat $1 $2 $3| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty)>&/dev/null
echo @还有$[$ii-$i]题
fi
done
fi