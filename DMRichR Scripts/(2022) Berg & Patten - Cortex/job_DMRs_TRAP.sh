#!/usr/bin/env bash
#SBATCH --time=10-00:00:00
#SBATCH --partition=production
#SBATCH -n 10
#SBATCH --mem=80G



module load R/4.1.0
module load homer


call="nohup \
Rscript \
--vanilla \
/share/lasallelab/programs/DMRichR/DM.R \
--genome rn6 \
--coverage 1 \
--perGroup '0.75' \
--minCpGs 5 \
--maxPerms 10 \
--maxBlockPerms 10 \
--cutoff '0.10' \
--testCovariate 'Exposure' \
--adjustCovariate 'Sex' \
--sexCheck TRUE \
--GOfuncR TRUE \
--cores 10 \
--EnsDb FALSE \
> DMRichR.$$.log 2>&1"

echo $call
eval $call 
echo $! > save_pid.txt

