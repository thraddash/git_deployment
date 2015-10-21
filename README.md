# git_deployment
Git Deployment bash script

3 Directories:  GOLDEN  DEVELOPMENT PRODUCTION

Timestamp PRODUCTION backup for each deployment)
15-10-15-16-44-36_bkup_production.tar.gz  15-10-20-19-33-18_bkup_production.tar.gz
timestamp=`date +%y-%m-%d-%H-%M-%S`

Execute deploy.sh
(Case sensitive, user must enter "Y" to execute deploy.sh)

function doit
{
1.) backing up current production area (/PRODUCTION)
  tar cvfz /home/syreen/scripts/backup/${timestamp}_bkup_production.tar.gz /home/syreen/scripts/PRODUCTION

2.) now we delete production dir /home/syreen/scripts/PRODUCTION/versionOne/v1_IterationSchedule
  rm -rf /home/syreen/scripts/production/versionOne/v1_IterationSchedule

3.) going to GOLDEN dir and pulling changes from DEVELOPMENT:master
  cd /home/syreen/scripts/GOLDEN/v1_IterationSchedule
  git pull /home/syreen/scripts/DEVELOPMENT/v1_IterationSchedule master
  
4.) copying files from GOLDEN into /home/syreen/scripts/PRODUCTION/versionOne  AREA
  cd /home/syreen/scripts/production/versionOne
  git clone /home/syreen/scripts/GOLDEN/v1_IterationSchedule
  
5.)  remove .git from PRODUCTION directory
  rm -rf /home/syreen/scripts/PRODUCTION/versionOne/v1_IterationSchedule/.git

6.) replace v1config.yml with PRODUCTION settings
  cp /home/syreen/scripts/production/versionOne/v1_IterationSchedule/config/v1config.yml_prod /home/syreen/scripts/PRODUCTION/versionOne/v1_Itera
tionSchedule/config/v1config.yml
}

read -n1 -r -p "MAKE SURE YOU HAVE COMMITED TO DEVELOPMENT:master!!!! Press 'Y' to continue: " key

if [ "$key" = 'Y' ]; then
  doit
else
  echo "Aborting..."
fi
