#!/bin/bash 
# #x=`xrandr --query |grep 2720 |wc -l`; #home
# x=`xrandr --query |grep 3360 |wc -l`;  #riso
# if [[ $x > 0 ]] 
# then
#     terminator --geometry +2000 -m  -l 4terms
# else
#     terminator -m -l 4terms    
# fi
# Screen 0: minimum 2720 x 1024, current 2720 x 1024, maximum 2720 x 1024
# default connected 2720x1024+0+0 0mm x 0mm
#    2720x1024      50.0* 
# if [[ $HOSTNAME == 'work' ]]
# then
#     -T TERM-PhDThesis --working-directory=/work/publications/phdthesis/ --command='run-cmd git status' --tab \
xfce4-terminal \
    -T TERM-SYST         --working-directory=/etc/ --tab\
    -T TERM-HOME         --working-directory=/home/manu/ --tab\
    -T TERM-CURR         --working-directory=/home/manu/Exchange --tab\
    -T TERM-CURR         --working-directory=/home/manu/Exchange \
    --maximize
#     -T TERM-OMNIVOR         --working-directory=/work/libs/OmniVor/ --command='mr status' \
# fi

