
## Changelog
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
- [ ] implement ICINGA Check (yeahyeahyeah)
- [ ] mailing on errors ?
- [ ] -p all option


## KNOWN ISSUES
- not working with curlftpfs anymore (stopped working since version 0.9.2
Try using version 0.9.1 if you have no alternatives  - works perfectly
- Issue when specifying "-c" - running into backup ! (fixed !)

