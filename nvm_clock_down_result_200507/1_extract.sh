clock1="1500 3400"
clock2="nvm_1500MHz nvm_3400MHz"
threads="1 5 10 15 20"
operation="sr sw"


for op in $operation; do
	case $op in
		sr) of=GET.dat ;;
		sw) of=SET.dat ;;
	esac

    echo "threads $clock2" > $of
	for th in $threads; do
        echo $th | tr "\n" " " >> $of
        for cl1 in $clock1; do
            if [[ $op == sr ]]; then
                cat thread_"$th"_"nvm"_"$op"_$cl1.txt | grep "Gets" | awk '{print $2}' | tr "\n" " " >> $of
	        else
                cat thread_"$th"_"nvm"_"$op"_$cl1.txt | grep "Sets" | awk '{print $2}' | tr "\n" " " >> $of
            fi
        done	
        echo " " >> $of
    done
done
