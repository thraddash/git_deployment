#!/bin/bash

set -e

timestamp=`date +%y-%m-%d-%H-%M-%S`

function doit
{
  echo "backing up current production area"
  tar cvfz /home/syreen/scripts/backup/${timestamp}_bkup_production.tar.gz /home/syreen/scripts/production

  echo "now we delete /home/syreen/scripts/production/versionOne/v1_IterationSchedule"
  rm -rf /home/syreen/scripts/production/versionOne/v1_IterationSchedule

  echo "going to GOLDEN and pulling changes from DEVELOPMENT:master"
  cd /home/syreen/scripts/GOLDEN/v1_IterationSchedule
  git pull /home/syreen/scripts/DEVELOPMENT/v1_IterationSchedule master

  echo "copying files from GOLDEN into /home/syreen/scripts/production/versionOne"
  cd /home/syreen/scripts/production/versionOne
  git clone /home/syreen/scripts/GOLDEN/v1_IterationSchedule

  echo "remove .git from production directory"
  rm -rf /home/syreen/scripts/production/versionOne/v1_IterationSchedule/.git

  echo "replace v1config.yml with production settings"
  cp /home/syreen/scripts/production/versionOne/v1_IterationSchedule/config/v1config.yml_prod /home/syreen/scripts/production/versionOne/v1_Itera
tionSchedule/config/v1config.yml

  echo "deploy complete"
}


read -n1 -r -p "MAKE SURE YOU HAVE COMMITED TO DEVELOPMENT:master!!!! Press 'Y' to continue: " key

if [ "$key" = 'Y' ]; then
  doit
else
  echo "Aborting..."
fi
