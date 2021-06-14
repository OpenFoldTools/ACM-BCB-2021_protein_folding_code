#!/bin/bash
#SBATCH -A PROJECT_CODE
#SBATCH -p batch
#SBATCH -t 2:00:00
#SBATCH -N 1
#SBATCH -J fold_prot
#SBATCH -o ./bbb.out
#SBATCH -e ./bbb.err

export OUTPUT_DIR="output/directory/path/"
export SUBMIT_DIR="submit/directory/path/"

export MEMBERWORK="memberwork/directory/path/"
export FoldProtein="path/to/fold_protein/code/"

conda activate FoldProtein

echo $MEMBERWORK/$OUTPUT_DIR/bbb/
mkdir -p $MEMBERWORK/$OUTPUT_DIR/bbb/
cp $SUBMIT_DIR/fold_protein.json $MEMBERWORK/$OUTPUT_DIR/bbb/ 
cd $MEMBERWORK/$OUTPUT_DIR/bbb/
cat fold_protein.json

pidArr=()
let nCores=$SLURM_JOB_NUM_NODES*$SLURM_CPUS_ON_NODE
echo $nCores are available to be used
for i in $(seq 1 $nCores)
do
	printf -v I "%03d" $i
	sed -e "s/AAA/$I/g" -e "s?BBB?bbb/?g" fold_protein.json > "$I".json
	echo $I
	time python3 $OpenFoldAmberHOME/fold_protein.py "$I".json > "$I".out 2> "$I".err &
	pidArr+=($!)
done

wait ${pidArr[@]}

for i in $(seq 1 $nCores)
do
	printf -v I "%03d" $i
	mv "$I"* "$I"_run_output
done

