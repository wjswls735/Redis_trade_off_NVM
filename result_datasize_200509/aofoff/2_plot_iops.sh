
operation="GET SET"
for op in $operation;
do
	datafile="$op".dat
	outfile="$op".eps
	graphtitle="$op"
	
	ylabel="IOPS"
	xlabel="DATA"
	
    echo "$ymax"    
	opt_list="`echo '-'``echo 'e'` `echo datafile=\'$datafile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo outfile=\'$outfile\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gtitle=\'$graphtitle\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gylabel=\'$ylabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gxlabel=\'$xlabel\'`"
	opt_list="$opt_list `echo '-'``echo 'e'` `echo gymax=\'$ymax\'`"
	
	gnuplot $opt_list perf_iops.cfg && open $outfile
done



