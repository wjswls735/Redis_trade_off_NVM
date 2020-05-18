cl1=3400
clock2="DRAM_aofon PMDK_aofon"
th="10"
data="32 64 128 256 512 1024"
operation="sr sw"
memory="dram nvm"
append="on"


for op in $operation; do
	case $op in
		sr) of=GET.dat ;;
		sw) of=SET.dat ;;
	esac

    echo "data $clock2" > $of
	
    for da in $data; do
        echo $da | tr "\n" " " >> $of
        for aof in $append; do
            for me in $memory; do
                if [[ $op == sr ]]; then
                    cat thread_"$th"_data_"$da"_"$me"_"$op"_"$cl1"_0_aof"$aof".txt | grep "Gets" | awk '{print $2}' | tr "\n" " " >> $of
	            else
                    cat thread_"$th"_data_"$da"_"$me"_"$op"_"$cl1"_0_aof"$aof".txt | grep "Sets" | awk '{print $2}' | tr "\n" " " >> $of
                fi
            done
         done	
        echo " " >> $of
   done
done
