echo '#!/usr/bin/bash --login' > base.sh
echo '#SBATCH --job-name='`echo $1 | cut -f1 -d.` >> base.sh
echo '#SBATCH --constraint='$2 >> base.sh
echo '#SBATCH --time='$3 >> base.sh
echo '#SBATCH --mem='$4'Gb' >> base.sh
echo '#SBATCH --nodes=1' >> base.sh
echo '#SBATCH --ntasks=1' >> base.sh
echo '#SBATCH --cpus-per-task=1' >> base.sh
echo '#SBATCH --mail-type=FAIL' >> base.sh
#echo '#SBATCH --output='`echo $1 | cut -f1 -d.`'_literate/%x.out' >> base.sh

echo 'cd '`pwd` >> base.sh

echo 'knitr_spin.R' $1 >> base.sh

echo 'if [ -d '`echo $1 | cut -f1 -d.`'_literate/ ]' >> base.sh
echo '  then' >> base.sh
echo '	  rm -rf' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh
echo 'fi' >> base.sh

echo 'mkdir' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh

echo 'if [ -d figure/ ]' >> base.sh
echo '  then' >> base.sh
echo '	  mv figure/ '`echo $1 | cut -f1 -d.`'_literate/' >> base.sh
echo 'fi' >> base.sh

echo 'mv '`echo $1 | cut -f1 -d.`'.md' `echo $1 | cut -f1 -d.`'_literate/' >> base.sh

echo 'rm '`echo $1 | cut -f1 -d.`'.html' >> base.sh

echo 'scontrol show job $SLURM_JOB_ID' >> base.sh

sbatch base.sh

rm base.sh
