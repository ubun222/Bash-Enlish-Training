
p=1;n1=0;l=0;n=1;output25=0;outputed=0

if ([ ${#*} != 0 ]) || ([ "${txt:-}" !=  '' ]);then
targets="${1:-} ${2:-} ${3:-} ${4:-} ${5:-} ${6:-} ${7:-} ${8:-} ${9:-}"


for t in $(seq ${#*});do
eval rp=\${$p:-/dev/null}    
 txt=$(cat ${rp} | tr '\n' '@' | tr ' ' '/' |awk  '{ printf $0 }' |  awk -F\\\\ '{ print $1 }' )"$txt"
        txt=${txt%% }

	p=$((p+1))


done
txt=$(echo $txt | tr '	' '\n' | grep '[^ ]'| tr '\n' '	' )

n=$(echo "${txt%%@}"  | awk 'BEGIN{RS="	"}{print $1}' |  tr '@' '\n'  |  grep -c '[^ ]')

echo  ----------------------------------------------------
echo "$(($n/2)) group words detected"

nn=$((n/2))
for list in $(seq 1 ${nn});do
#([ $nn = 0 ]) && nn=1
eval l$list=$(echo "$txt" | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| grep -n '[^_^]' | grep -w $list | head -n 1 | awk '{printf $1}' | tr -d $list:  )
eval r$list=$(echo "$txt" | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| grep -n '[^_^]' | grep -w $list | head -n 1 | awk '{printf $2}')


cha=$((nn))
if ([ $cha -gt 25 ]);then
list100=$(($((list*100))-$((n1*100))))

output=$((list100/$((nn-n1))))                         

output25=$((output/4))
trial=$((output25-outputed))
([ $trial -ne 0 ]) && str=$str#
outputed=${output25:-0}
echo -e "\033[k\r                          ]$output%\r $str\r[\c"
elif ([ $cha -le 25 ]);then
list100=$(($((list*100))-$((n1*100))))
output=$((list100/$((cha))))
output5=$((output/20))
trial=$((output5-outputed))                           
([ $trial -ne 0 ]) && str=$str#####
outputed=${output5:-0}
echo -e "\033[k\r                          ]$output%\r $str\r[\c"

fi


eval ln=\${l$list}
eval rn=\${r$list}

eval lr$list="$ln'	'$rn"

    list=$((list*2-1))

 eval ll${list#-}="$rn"
    list=$((list+1))

    eval ll$list="$ln"
    
    
        alldata="$alldata$ln	$rn@"

done
echo $alldata
echo
fi

if ([  $n = 1 ]) ;then
unset alldata
for i in $(seq 100)
do
echo 'Please drag in a single txt file and press enter to continue：'
read   target
(dirname $target ) >&/dev/null
key=$?
targets=$target' '$targets

if ([ $key -ne 0 ]);then
break
elif ([ $key = 0 ]);then
txt="$txt"$(cat ${target} | tr '\n' '@' | tr ' ' '/' |awk  '{ printf $0 }' |  awk -F\\\\ '{ print $1 }' )


n=$(echo ${txt%@} | tr '@' ' ' | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')


echo "A total of $(($(($n-$((n%2))))/2)) words are detected again"
fi
echo "Loading the vocabulary..."
nn=$((n/2))
n11=$((n1+1))

for list in $(seq $n11 $nn);do
eval l$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '[^_^]' | grep -w $list | head -n 1 | awk '{printf $1}' | tr -d $list:  )
eval r$list=$(echo $txt | tr '@' ' ' | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '[^_^]' | grep -w $list | head -n 1 | awk '{printf $2}')



cha=$((nn-n1))

if ([ $cha -gt 25 ]);then
list100=$(($((list*100))-$((n1*100))))
output=$((list100/$((cha))))

 output25=$((output/4))
trial=$((output25-outputed))
([ $trial = 1  ]) && str=$str#
outputed=${output25:-0}
echo -e "\033[k\r                          ]$output%\r $str\r[\c"

elif ([ $cha -le 25 ]);then
list100=$(($((list*100))-$((n1*100))))
output=$((list100/$((cha))))
output5=$((output/20))                                 
trial=$((output5-outputed))                            
([ $trial = 1 ]) && str=$str#####
outputed=${output5:-0}                                 
echo -e "\033[k\r                          ]$output%\r $str\r[\c"

fi
([ ${#str} = 25 ]) && str=
eval ln=\${l$list}  # alias
eval rn=\${r$list}  # alias

eval lr$list="$ln'	'$rn"


    list=$((list*2-1))

    eval ll$list=$rn
    list=$((list+1))

    eval ll$list=$ln
    
    alldata="$alldata$ln $rn@"


done
([ $((nn-n1)) -ne 0  ]) &&  l=$((l+1))
echo
echo "$l" vocabulary has been loaded
n1=$nn
echo ----------------------------------------------------
done
fi





voice=1

if ([ "$(uname)" = "Darwin" ]);then
read  -p "Detect macOS, whether to turn on voice（y/n）:" vbool
if ([  "$vbool" = y ]) || ([  "$vbool" = Y ]);then
voice=0
fi
fi


clear
echo "----------------------------------------------------"
echo "------------welcome to English Training-------------"
echo "----------------------------------------------------"
echo "Please select practice mode: 1, En to Ch 2, Ch to En 3, mixed mode "
read   mode
echo "Please select practice mode: 1, order 2, reverse order 3, disorder "
read  random
echo 'Please enter the number of exercises:'
read  ii

number0=0;

rdm1=${raw:-number0};rdm2=${raw:-n}
if ([ "$mode" = 3 ]) ;then


for i in $(seq 1 $ii)
do

if ([  "$random" = 1 ]);then
rdm1=$((rdm1+1))
m=$rdm1
if ([ "$rdm1" = $n ]);then
rdm1=0
fi

elif ([  "$random" = 2 ]);then

m=$rdm2
if ([ "$rdm2" = 1 ]);then
rdm2=$n
fi

elif ([  "$random" = 3 ]);then
m=$(($RANDOM%$n+1))
fi

eval question=\${ll$m}

echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ')
printf  "$question"



No=$(($((m/2))+$((m%2))))
eval lr=\${lr$No}  # alias

pureanswer="$lr"
eval ln=\${l$No}  # alias
eval rn=\${r$No}  # alias
#echo $ln
#echo $rn

echo  -n '————Please enter the answer:'
read   scanf

answer1="${ln}"
answer2="${rn}"
answer1=$(echo $answer1 | tr '/' ' ' )
answer2=$(echo $answer2 | tr '/' ' ' )

if ([ "$question" = "$answer1" ]) ;then
answer="$answer2"

elif ([ "$question" = "$answer2" ]) ;then
answer="$answer1"
fi

if ([ "${scanf:-0}" = "$answer" ]) ;then
echo  bingo
fi

echo -n "See the answer?y/n/v："
read  bool
bool=${bool:-0}
if ([ "$bool" = 'y' ]) || ([ "$bool" = 'Y' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif ([ "$bool" = 'v' ]) || ([ "$bool" = 'V' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if ([ "$voice" = 0 ]) ;then
say  "$answer1,$answer2"
fi 


echo @$(($ii-$i)) questions left

fi
done
fi



if ([ "$mode" = 2 ]) ;then
m=$(($(($n-$((n%2))))/2))
rdm2=$((m+1))  #为了抵消下面的-1

for i in $(seq 1 $ii)
do

if ([  "$random" = 1 ]);then
rdm1=$((rdm1+1))
m2=$rdm1
if ([ "$rdm1" = "$m" ]);then
rdm1=0
fi

elif ([  "$random" = 2 ]);then
rdm2=$((rdm2-1))
m2=$rdm2
if ([ "$rdm2" = 1 ]);then
rdm2=$((m+1))
fi

elif ([  "$random" = 3 ]);then

m2=$(($RANDOM%$m+1))
fi


eval question=\${r$m2}
echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ')
printf   "$question"

eval lr=\${lr$m2}
pureanswer=$lr

echo -n '————Please enter the answer:'
read  scanf

answer1=$(echo $pureanswer | awk 'BEGIN{RS="	"}{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk 'BEGIN{RS="	"}{printf $2}' | tr '/' ' ')

if ([ "${scanf:-0}" = "$answer1" ]) ;then
echo  bingo
fi
echo -n "See the answer?y/n/v："
read  bool
bool=${bool:-0}
if ([ "$bool" = 'y' ]) || ([ "$bool" = 'Y' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif ([ "$bool" = 'v' ]) || ([ "$bool" = 'V' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if ([ "$voice" = 0 ]) ;then
say  "$answer1,$answer2"
fi 


echo @$(($ii-$i)) questions left

fi
done
fi



if ([ "$mode" = 1 ]) ;then
m=$(($(($n-$((n%2))))/2))
rdm2=$((m+1))   #为了抵消下面的-1

for i in $(seq 1 $ii)
do


if ([  "$random" = 1 ]);then
rdm1=$((rdm1+1))
m2=$rdm1
if ([ "$rdm1" = "$m" ]);then
rdm1=0
fi

elif ([  "$random" = 2 ]);then
rdm2=$((rdm2-1))
m2=$rdm2
if ([ "$rdm2" = 1 ]);then
rdm2=$((m+1))
fi

elif ([  "$random" = 3 ]);then

m2=$(($RANDOM%$m+1))
fi


eval question=\${l$m2}

echo  ----------------------------------------------------
question=$(echo $question | tr '/' ' ')
printf   "$question"

eval lr=\${lr$m2}
pureanswer=$lr
echo -n '————Please enter the answer:'
read  scanf

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if ([ "${scanf:-0}" = "$answer2" ]);then
echo  bingo
fi
echo -n "See the answer?y/n/v："
read  bool
bool=${bool:-0}
if ([ "$bool" = 'y' ]) || ([ "$bool" = 'Y' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')\n"
elif ([ "$bool" = 'v' ]) || ([ "$bool" = 'V' ])  ; then
printf "$(echo $pureanswer | tr '/' ' ')"
if ([ "$voice" = 0 ]) ;then
say  "$answer1,$answer2"
fi 


echo @$(($ii-$i)) questions left

fi
done
fi

