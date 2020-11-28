
#https://ubuntuforums.org/showthread.php?t=2404746

sudo apt update
sudo apt install -y munge slurm-wlm

slurmd -C

#NodeName=ip-172-31-31-98 CPUs=2 Boards=1 SocketsPerBoard=1 CoresPerSocket=1 ThreadsPerCore=2 RealMemory=456
#UpTime=0-00:03:41



# Install slurm.conf
sudo vi etc/slurm-llnl/slurm.conf






sudo systemctl enable slurmctld
sudo systemctl start slurmctld
# Enable and start the agent slurmd:
sudo systemctl enable slurmd
sudo systemctl start slurmd


sudo chmod a+r /var/log/slurm-llnl/slurm_jobacct.log


# Start job
sbatch --mem=100M --mincpus=1 job.sh
