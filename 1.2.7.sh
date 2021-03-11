#read -r -d '\' txt1 < $1  && read -r -d '\' txt2 < $2 && read -r -d '\' txt3 < $3
#txt=$( echo $txt1 && echo $txt2 && echo $txt3)

targets="${1:-} ${2:-} ${3:-} ${4:-} ${5:-} ${6:-} ${7:-} ${8:-} ${9:-}"

p=1;n1=0;l=0
for t in $(seq ${#*});do
eval rp=\${$p:-/dev/null}    
 txt=$(cat ${rp} | tr '\n' '@' | tr ' ' '/' |awk  '{ printf $0 }' |  awk -F\\\\ '{ print $1 }' )"$txt"
        txt=${txt%% }
       # txt=${txt%%@}
	p=$((p+1))
   # elif [[ pb != 0 ]];then 

done
      # txt=${txt%%@}  #加错地方了，导致验算失败
     #  echo $txt
n=$(echo ${txt%%@} | tr '@' ' ' | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
# echo $n
echo  ----------------------------------------------------
echo 检测到$(($n/2))组单词
#echo $n
nv=$n

nn=$((n/2))
for list in $(seq 1 ${nn});do
eval l$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $list | head -n 1 | awk '{printf $1}' | tr -d $list:  )
eval r$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $list | head -n 1 | awk '{printf $2}')



    

eval ln=\${l$list}  # alias
eval rn=\${r$list}  # alias
#eval lrn=\${lr$list}

eval lr$list="$ln'	'$rn"  #eval的空格需要''才能赋值，否则被视为命令行中的空格

#    for line in $(seq 2);do
    list=$((list*2-1))

 #  (eval ll$list=$rn > /dev/tty) >&/dev/null
 eval ll${list#-}=$rn   # 从变量开头删除匹配'-'的字符，否则因为变量那有'-'字符识别为command
    list=$((list+1))

    eval ll$list=$ln
    
    
        alldata="$alldata$ln $rn@"
      #  echo $alldata
 #   echo $ll1
#n1=$nn
done

# echo $n
if [[  $n = 1 ]] ;then
unset alldata
for i in $(seq 100)
do
read   -p  请手动拖入txt文件，按回车键结束： target
(dirname $target ) >&/dev/null
key=$?
targets=$targets' '$target
#echo $targets
if [[ $key != 0 ]];then
break
elif [[ $key = 0 ]];then
txt="$txt"$(cat ${target} | tr '\n' '@' | tr ' ' '/' |awk  '{ printf $0 }' |  awk -F\\\\ '{ print $1 }' )
#echo $txt

n=$(echo ${txt%@} | tr '@' ' ' | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
#最长的list的行数
# echo $n

echo 重新检测到共$(($(($n-$((n%2))))/2))组单词
fi
echo 载入词表中...
nn=$((n/2))
for list in $(seq $((n1+1)) $nn);do
eval l$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $list | head -n 1 | awk '{printf $1}' | tr -d $list:  )
eval r$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $list | head -n 1 | awk '{printf $2}')



eval ln=\${l$list}  # alias
eval rn=\${r$list}  # alias
#eval lrn=\${lr$list}

eval lr$list="$ln'	'$rn"  #eval的空格需要''才能赋值，否则被视为命令行中的空格

#    for line in $(seq 2);do
    list=$((list*2-1))

    eval ll$list=$rn
    list=$((list+1))

    eval ll$list=$ln
    
    alldata="$alldata$ln $rn@"
 #   echo $ll1

done
[[ $((nn-n1)) != 0  ]] &&  l=$((l+1))
echo 已加载"$l"张词表 #需要""，否则输出为??
n1=$nn
echo ----------------------------------------------------
done
fi
#m=$[$[$n-$[n%2]]/2]*2]

# for
read -p 输入Y/y验证词表 verify
if [[ $verify = y || $verify = Y  ]];then


(echo | shasum ) >&/dev/null
[[ $? = 0 ]] && sha1=$(echo $txt | shasum) && sha2=$(echo $alldata | shasum) &&
unset sha3  sha4

(echo | sha1sum) >&/dev/null
[[ $? = 0 ]] && sha3=$(echo $txt | sha1sum) && sha4=$(echo $alldata | sha1sum) &&
unset sha1  sha2
[[ "$sha1" ]] && echo 源变量shasum:${sha1}  #$txt
[[ "$sha2" ]] && echo 合成变量shasum:${sha2}  #$alldata
[[ "$sha3" ]] && echo 源变量sha1sum:${sha3}  #$txt
[[ "$sha4" ]] && echo 合成变量sha1sum:${sha4}
if  [[ "$sha1" = "$sha2" && "$sha3" = "$sha4"  ]];then

echo 验证通过！
#elif [[ $sha1 != $sha2 ]];then
else
read -p 验证不通过!

exit
fi

fi


voice=1

if [[ $(uname) = "Darwin" ]];then
read -p 检测到macOS，是否开启播报（y/n） vbool
if [[  $vbool = y ]] || [[  $vbool = Y ]];then 
voice=0
fi
fi

#r=$(($RANDOM%$m+1))
#list=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| grep -n '')
#echo $list
clear
echo "----------------------------------------------------"
echo "------------welcome to English Training-------------"
echo "----------------------------------------------------"
read -p "请选择练习模式:1，英译中    2，中译英    3，混合模式 " mode
read -p "请选择练习模式:1，顺序     2，倒序    3，乱序 " random
read -p "请输入练习次数:" ii

number0=0;
#raw=$[raw-1];
#rdm1=raw;rdm2=raw;
rdm1=${raw:-number0};rdm2=${raw:-n}
if [[ $mode = 3 ]] ;then

#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
#m=$[n-1]
#m=$(($RANDOM%$m+1))

if [[  $random = 1 ]];then
rdm1=$((rdm1+1))
m=$rdm1
if [[ $rdm1 = $n ]];then
rdm1=0
fi

elif [[  $random = 2 ]];then
  #因为最长的行数n始终比算出来的+1，减一后刚好
m=$rdm2
if [[ $rdm2 = 1 ]];then
rdm2=$n
fi

elif [[  $random = 3 ]];then
m=$(($RANDOM%$n+1))
fi

eval question=\${ll$m}
# question=$(echo ${l})
echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ') #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
printf  "$question"      #printf 命令需要套一个双引号才能输出空格



No=$(($((m/2))+$((m%2))))
eval lr=\${lr$No}  # alias
# pureanswer=$(echo $txt | tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
pureanswer="$lr"
eval ln=\${l$No}  # alias
eval rn=\${r$No}  # alias
#echo $ln
#echo $rn
read -p '————请输入答案:'  scanf
#answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
#answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
answer1="${ln}"
answer2="${rn}"
answer1=$(echo $answer1 | tr '/' ' ' )
answer2=$(echo $answer2 | tr '/' ' ' )
#echo $answer1
#echo $answer2

if [[ "$question" = "$answer1" ]] ;then
answer="$answer2"

elif [[ "$question" = "$answer2" ]] ;then
answer="$answer1"
fi
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
if [[ "${scanf:-0}" = "$answer" ]] ;then
echo 正确
fi


read -p  "是否查看答案y/n/v：" bool
bool=${bool:-0}
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"  #加换行，否则界面不对称
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $voice = 0 ]] ;then
say  "$answer1,$answer2"
fi 
if [[ $nv != 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
fi
fi
done
fi



if [[ $mode = 2 ]] ;then
m=$(($(($n-$((n%2))))/2))
rdm2=$((m+1))  #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do

if [[  $random = 1 ]];then
rdm1=$((rdm1+1))
m2=$rdm1
if [[ $rdm1 = $m ]];then
rdm1=0
fi

elif [[  $random = 2 ]];then
rdm2=$((rdm2-1))
m2=$rdm2
if [[ $rdm2 = 1 ]];then
rdm2=$((m+1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$m+1))
fi

#m2=$(($RANDOM%$m+1))
#question=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk '{printf $2}')
eval question=\${r$m2}
echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ') #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
printf   "$question"
#pureanswer=$(echo $txt |  tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
eval lr=\${lr$m2}
pureanswer=$lr
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk 'BEGIN{RS="	"}{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk 'BEGIN{RS="	"}{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if [[ "${scanf:-0}" = "$answer1" ]] ;then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
bool=${bool:-0}
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $voice = 0 ]] ;then
say  "$answer1,$answer2"
fi 
if [[ $nv != 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' )| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
fi
fi
done
fi



if [[ $mode = 1 ]] ;then
m=$(($(($n-$((n%2))))/2))
rdm2=$((m+1))   #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do


if [[  $random = 1 ]];then
rdm1=$((rdm1+1))
m2=$rdm1
if [[ $rdm1 = $m ]];then
rdm1=0
fi

elif [[  $random = 2 ]];then
rdm2=$((rdm2-1))
m2=$rdm2
if [[ $rdm2 = 1 ]];then
rdm2=$((m+1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$m+1))
fi


eval question=\${l$m2}
#question=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk  '{RS=" "}{printf $1}' | tr -d '0-9' | tr -d ':' | tr '/' ' ')
echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ') #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
printf   "$question"

eval lr=\${lr$m2}
pureanswer=$lr
#pureanswer=$(echo  $txt| tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' |grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -p '————请输入答案:'  scanf

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if [[ "${scanf:-0}" = "$answer2" ]];then
echo 正确
fi 
read -p  "是否查看答案y/n/v：" bool
bool=${bool:-0}
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if [[ $voice = 0 ]] ;then
say  "$answer1,$answer2"
fi 
if [[ $nv != 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' )| grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
elif [[ $nv = 1 ]];then
(cat $(echo  $targets | tr ' ' '\n' ) | grep -A 5 "${answer1} |" | sort -k2n | uniq > /dev/tty) >&/dev/null
echo @还有$(($ii-$i))题
fi
fi
done
fi
