#!/bin/bash

# script to run redis benchmark with different payload, pipeline, and iothreads ( the iothreads are configured on the redis-server VM
# and that argument is only for creating a different file for different redis-server configs

args=("$@")
n=${args[0]}
iothreads=${args[1]}
dir=${args[2]}

echo "Saving results in " $dir;

for connections in  512; do
	for payload_size in  3 100 1000; do
	for pipeline_size in  1 5 10; do
	for num_threads in 12 24 36 48; do
	echo "running for pipeline size" $pipeline_size ", payload size of" $payload_size ", connections" $connections ", with $num_threads threads";
		date;
		redis-benchmark -t mset,set,get,hset,lrange_100,xadd -c $connections -P $pipeline_size -n $n --threads $num_threads -d $payload_size >> $dir/"iothreads_"$iothreads"_pipeline_"$pipeline_size"_connections_"$connections"_payload_"$payload_size"_threads_"$num_threads".txt";
	done;
	done;
	done;
done;
