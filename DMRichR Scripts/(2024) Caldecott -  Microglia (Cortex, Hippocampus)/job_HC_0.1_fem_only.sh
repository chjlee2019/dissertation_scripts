#!/usr/bin/env bash
#SBATCH --time=3-00:00:00
#SBATCH --partition=production
#SBATCH -n 10
#SBATCH --mem=400G
#SBATCH --mail-user=chjlee@ucdavis.edu
#SBATCH --mail-type=BEGIN,END,FAIL

###################
# Run Information #
###################


start=`date +%s`

hostname

THREADS=${SLURM_NTASKS}
MEM=$(expr ${SLURM_MEM_PER_CPU} / 1024)

echo "Allocated threads: " $THREADS
echo "Allocated memory: " $MEM

################
# Load Modules #
################

module load R/4.1.0
module load homer

########
# DM.R #
########



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
--testCovariate 'AirTreatment' \
--GOfuncR TRUE \
--cores 10 \
--EnsDb FALSE \
> DMRichR.$$.log 2>&1"

echo HC_DMRichR_0.1_fem
cd /share/segallab/chjlee/2024_TRAP_WGBS/tunnelRats/HC_DMRichR/cytosine_reports/
echo $call
eval $call 
echo $! > save_pid.txt

