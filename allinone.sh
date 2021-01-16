#read -r -d '\' -p "请拖入文件"  txt1 < $1
alltxt=
yes=
for i in $(seq 100)
do


read -p "请拖入!一个!文件回车,完成后请输入+号"  txt1

if [[ "$txt1" = "+" ]];then

break

fi

alltxt="$alltxt $(echo $(cat "$txt1" | grep -B 100 '\\' | sed 's/\\//g' ))"
#有bug。alltxt="$alltxt$(echo $(cat $txt1 | awk -F'\\' '{printf $1}'))"

done

echo $alltxt

echo  "creating $(pwd)/allinone.txt..."

read -p "type yes to continue..." yes


if  [[ "$yes" = "yes" ]];then

echo $alltxt | tr ' ' '\n' | sed 'N;s/\n/ /' >./allinone.txt


if [[ "$?" = "0" ]] ;then

echo 50%finished... 

fi



echo "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\" | cat >> ./allinone.txt

if [[ "$?" = "0" ]] ;then

echo Success! 

fi
fi

