#!/bin/bash
#set -a myfles
#index=0
IFS_old=$IFS
IFS=$'\n'
rm -rf /tmp/cvu.log
rm -rf cvu_tasks.log
rm -rf cvu_err.log
rm -rf /tmp/cvu_new.log
grep -n TASK_START /scratch/crsusr/cvutrace/cvutrace.log.0 > cvu_tasks.log
grep -n PRV /scratch/crsusr/cvutrace/cvutrace.log.0 > cvu_err.log
task_num_array=(`awk -F ":" '{print $1}' cvu_tasks.log`)
err_num_array=(`awk -F ":" '{print $1}' cvu_err.log`)
task_name_array=(`awk -F ":" '{print  $2}' cvu_tasks.log`)
err_name_array=(`awk -F ":" '{print  $2 $3}' cvu_err.log`)

for task_num_a in ${task_num_array[*]};
do

echo $task_num_a;


done


len_task=${#task_num_array[@]}
echo $len_task

len_err=${#err_num_array[@]}
echo $len_err

#for task in cvu_tasks.log;
#do
#echo $task;
#done
#len=${#task[@]}
#echo $len
j=0
i=0
 
while [ $i -le $len_task ]
do
i=`expr $i + 1`;

while [ $j -le $len_err ]
  do
echo "task index is $i"
echo "err index is $j"


task_num=`expr ${task_num_array[$i]} + 0`;
task_num_next=`expr ${task_num_array[$i+1]} + 0`;
err_num=`expr ${err_num_array[$j]} + 0`;
echo $task_num
echo $task_num_next
echo $err_num


 if [ $i -eq `expr $len_task - 1` ]
       then

              echo " ${err_name_array[$j]} belongs to ${task_name_array[$i]}" >>  /tmp/cvu.log
break 1

   elif [ $err_num -gt $task_num -a  $err_num -le $task_num_next ]

           then

               echo " ${err_name_array[$j]} belongs to ${task_name_array[$i]}" >>  /tmp/cvu.log
             echo "find it!!!"
elif [ $err_num -gt $task_num -a  $err_num -gt $task_num_next ]
then
echo "this err belong to the follow tasks, go next task"
break 1 
elif [ $err_num -lt $task_num ]
then
echo "this err belong to no task, go next err"
#     j=`expr $j + 1`;


   else 

echo "??"
fi
j=`expr $j + 1`;
   done

#i=`expr $i + 1`;

done

#sort -k2n /tmp/cvu.log |uniq > /tmp/cvu_new.log


sort -k2n /tmp/cvu.log | awk '{if ($0!=line) print;line=$0}' >> /tmp/cvu_new.log

# sort -k2n /tmp/cvu.log | sed '$!N; /^\(.*\)\n\1$/!P; D' >> /tmp/cvu.log


