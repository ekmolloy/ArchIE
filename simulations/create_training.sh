set -e
gcc -o ../msmodified/ms ../msmodified/ms.c ../msmodified/streec.c ../msmodified/rand1.c -lm # recompile ms to make sure it works
mkdir -p sims/

NREPS=10000 # number of simulations to run.
f=0.02 # admixture fraction
window_size=50000
for i in `seq 1 ${NREPS}`;
do
  echo "Simulation " ${i}
  bash ms.sh ${window_size} ${f}
  python calc_stats_ms.py -s out.snp -a out.ADMIXED.geno -r out.1.geno --anc out.ADMIXED.anc -n ${window_size} > sims/${i}.txt
done

cat sims/* > training_data.txt
rm sims/*
