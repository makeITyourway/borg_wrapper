# OPTIONAL SCRIPTS TO USE FOR BORG_WRAPPER

## cronrunner.borg_wrapper.sample.sh
A Wrapper that ensures, all your backups are startet right after another. This ensures, Backups are running in the shortest period of time.
Since I can not recommend to parallelize backup jobs, this is our solution. The file `` contains a sample of how we do it !
Copy cronrunner.borg_wrapper.sample.sh to cronrunner.borg_wrapper.sh.


Modify the following line in cronrunner.borg_wrapper.sh and add it to your crontab:   
`0 1 * * *	/path/to/borg_wrapper/scripts/cronrunner.borg_wrapper.sh`  
The Example above would trigger at 1am and start all related jobs inside in sequence.  
  
You can clone the file for different backup timings (e.g. weekly or monthly projects)  



