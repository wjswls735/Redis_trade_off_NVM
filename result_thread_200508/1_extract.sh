cl1=3400
clock2="DRAM_aofon PMDK_aofon DRAM_aofoff PMDK_aofaff "
threads="1 5 10 15 20"
operation="sr sw"
memory="dram nvm"
append="on off"


for op in $operation; do
	case $op in
		sr) of=GET.dat ;;
		sw) of=SET.dat ;;
	esac

    echo "threads $clock2" > $of
	
    for th in $threads; do
        echo $th | tr "\n" " " >> $of
        for aof in $append; do
            for me in $memory; do
                if [[ $op == sr ]]; then
                    cat thread_"$th"_"$me"_"$op"_"$cl1"_0_aof"$aof".txt | grep "Gets" | awk '{print $2}' | tr "\n" " " >> $of
	            else
                    cat thread_"$th"_"$me"_"$op"_"$cl1"_0_aof"$aof".txt | grep "Sets" | awk '{print $2}' | tr "\n" " " >> $of
                fi
            done
         done	
        echo " " >> $of
   done
done
