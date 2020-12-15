#!/bin/bash
# seperating individual links from html "3082",searching for specified ones 
wget https://www.ynetnews.com/category/3082
grep -o 'https://www.ynetnews.com/article/[[:alnum:]]*' 3082 | sort | uniq > result.txt
num=$(less result.txt | wc -l)
echo $num >> results.csv
arr=($(less result.txt))
# run on links. get num of times Netanyahu/Gantz mentioned.
for (( i=0; i<$num;i++ ));
do
	wget -O temp.txt ${arr[i]} &> /dev/null
	count_netanyahu=$(less temp.txt | grep  -o Netanyahu | wc -l)
	count_gantz=$(less temp.txt | grep  -o Gantz | wc -l )
	if [[ $count_netanyahu == 0  &&  $count_gantz == 0 ]]; 
	then
		echo "${arr[i]},-" >> results.csv

	else echo "${arr[i]},Netanyahu,$count_netanyahu,Gantz,$count_gantz" >> results.csv
	fi
done
