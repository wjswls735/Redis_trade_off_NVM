workload="sw sr"

memory="dram"
memtype="dram"
cpupower="1500 3400"
threads="1 5 10 15 20"
num=0
max=1

ops=100000

client=1

data=1024
add="dram_clock_down_result_200507"
master=7900

mkdir $add 
for me in $memory; do
	for cp in $cpupower; do
		cpupower frequency-set -u "$cp"MHz
		for th in $threads; do
    		num=0
    		while [[ $num -lt $max ]]; do
        		for wo in $workload; do
            		    fname=thread_"$th"_"$me"_"$wo"_"$cp".txt

                		if [[ $wo == "sw" ]] ; then
                    		/home/oslab/LJS/"$master"_"$memtype"/"$me".sh
                		fi  
               			sleep 10s 

                		echo "-------------------------------------doing $wo load------------------------------------------------"
                		case $wo in
                    		sr) ./memtier_benchmark -p $master -t $th --ratio=0:100 -d $data -c $client -n $ops > "$add"/"$fname" ;;
                    		sw) ./memtier_benchmark -p $master -t $th --ratio=100:0 -d $data -c $client -n $ops > "$add"/"$fname" ;;
               	 		esac
                		echo "-------------------------------------doing $wo load------------------------------------------------"
        		done
        		num=$((num+1))
    		done

		done
	done
done


