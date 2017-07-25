## Changelog
### v1.0 (20170725)
- fixed some minor bugs
- added POST and PRE Tasks for CRON RUN (--cron)
- fixed binary allocation bug
- added PRUNE to the CRON RUN (--cron)
- fixed a bug regarding remote repos (via SSH)
- added icinga check
- added scripts directory for additional tooling (cronrunner)
- fixed minor bug when calling script without params (show help)
- general cleanup for v1.0

### v0.3 (20170704) 
- fixed several code quality issues
- moved repo availability check to base functions
- added BORG Installation check
- added project config validation 
- added catcherror handling of BORG Wrapper Returncodes
- added `--cron` action to the script
- added compression option for backups (see project config)
- added mount option witih verifications
- removed some bugs withing the code handling
- fixed a bug: you now can run the script from whererver you want (dirfix)
- fixed a bug: you can either specify project name or projectfile (including path) with --project
- fixed a bug: accidently there was a permanent exclusion variable set from debugging - removed !
- nice: moved changelod to a seperate file

### v0.2 (20170703) 	
- fixed some orphaned files - first working tryout version 
- added shell function
- major fixes for several bugs found

### v0.1 (20170703) 
- first shot of this thingy - let's give it a try ...
- added init, backup, check / verify, list, prune 
- added debugging output (script - wise)
- added project config handling
- added minor validations 


## TODOS / FEATURE WISHES
Those features might be in possible upcoming releases 
- [x] v0.3 treat return codes of borg
- [x] v0.3 implement CRON auto (backup & check/verify)
- [x] v0.3 add compression for backups
- [x] v0.3 add mount command
- [x] fix pathes for projects / configs
- [x] add PRE and POST Execution tasks
- [x] add PRUNE to the automated cron task
- [x] implement ICINGA Check (yeahyeahyeah)
- [ ] mailing on errors ?
- [ ] -p all option (not in v1.0)

## KNOWN ISSUES
- not working with curlftpfs anymore (stopped working since version curlftpfs-0.9.2
Try using version 0.9.1 if you have no alternatives  - works perfectly
- Issue when specifying "-c" - running into backup ! (fixed !)
- there seems to be a bug when specifying the project dir and file instead of the name
- add Artefact to --list command for detailed listing
