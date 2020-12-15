#!/bin/bash
# seperating individual links from html "3082",searching for specified ones 
wget https://www.ynetnews.com/category/3082
less 3082 | grep -o "https://www.ynetnews.com/article/[[:alnum:]]*" | sort -u > result.txt
num=$(less result.txt | wc -l)
echo $num
arr=($(less result.txt))
# run on links. get num of times Netanyahu/Gantz mentioned.
for (( i=0; i<$num;i++ ));
do
	wget -O temp.txt ${arr[i]} &> /dev/null
	count_netanyahu=$(less temp.txt | grep  -o Netanyahu | wc -l)
	count_gantz=$(less temp.txt | grep  -o Gantz | wc -l )
	if [[ $count_netanyahu == 0  &&  $count_gantz == 0 ]]; 
	then
		echo "${arr[i]},-"

	else echo "${arr[i]},Netanyahu,$count_netanyahu,Gantz,$count_gantz"
	fi
done
