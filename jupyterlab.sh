source /home/saul/.condainit
conda activate py3
nohup jupyter-lab $@ > /dev/null 2>&1 &
