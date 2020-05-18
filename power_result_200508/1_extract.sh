clock1="1500 3400"
clock2="DRAM_1500 PMDK_1500 DRAM_3400MHz PMDK_3400MHz"
threads="1 5 10 15 20"
operation="sr sw"
memory="dram nvm"

for op in $operation; do
	case $op in
		sr) of=GET.dat ;;
		sw) of=SET.dat ;;
	esac
    
    echo "threads $clock2" > $of
	for th in $threads; do
        echo $th | tr "\n" " " >> $of
        for cl1 in $clock1; do
            for me in $memory; do
                if [[ $op == sr ]]; then
                    cat thread_"$th"_"$me"_"$op"_"$cl1".txt | grep "Gets" | awk '{print $2}' | tr "\n" " " >> $of
	            else
                    cat thread_"$th"_"$me"_"$op"_"$cl1".txt | grep "Sets" | awk '{print $2}' | tr "\n" " " >> $of
                fi
            done
         done	
        echo " " >> $of
   done
done
