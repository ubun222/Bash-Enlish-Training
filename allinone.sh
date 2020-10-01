#read -r -d '\' -p "请拖入文件"  txt1 < $1
alltxt=
for i in $(seq 100)
do


read -p "请拖入!一个!文件回车,完成后请输入+号"  txt1

if [[ "$txt1" != "+" ]];then

echo $txt1

alltxt="$alltxt$(echo $(cat $txt1 | grep -B 100 '\\' | sed 's/\\//g' ))"
#有bug。alltxt="$alltxt$(echo $(cat $txt1 | awk -F'\\' '{printf $1}'))"
echo $alltxt
 

elif [[ "$txt1" = "+" ]];then

clear

#echo $alltxt | tr ' ' '\n' | sed 'N;s/\n/ /'

read -t 3 -p "creating $(pwd)/allinone.txt..."

echo  

read -p "type yes to continue..." yes

if  [[ "$yes" = "yes" ]];then

echo $alltxt | tr ' ' '\n' | sed 'N;s/\n/ /' >./allinone.txt

if [[ "$?" = "0" ]] ;then

echo Success! 

break 

fi

fi

fi

done
