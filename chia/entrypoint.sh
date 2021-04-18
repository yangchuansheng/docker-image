#! /bin/bash

# clean up chia placeholder.
# Loop NFS path
for ((i = $NFS_INDEX_FIRST; i <= $NFS_INDEX_LAST; i++)); do
    # Loop drive path
    for ((j = $DRIVE_INDEX_FIRST; j <= $DRIVE_INDEX_LAST; j++)); do

        TARGET_PATH=$NFS_BASE_PATH$i$DRIVE_BASE_PATH$j
        if [ ! -d $TARGET_PATH ]; then
            echo "Target path $TARGET_PATH 404, pass."
            continue
        fi

        echo "Delete path $TARGET_PATH/planned"
        rm -r $TARGET_PATH/planned
        mkdir -p $TARGET_PATH/planned

        find $TARGET_PATH -name "plot-*" -type f -size -99G | xargs -n 1 rm

        # PLOT_SIZE_LIST=$(du -s $TARGET_PATH/plot-* | awk '{print $1}')
        # for i in $PLOT_SIZE_LIST; do
        #     PLOT_SIZE_TRUE=$(($i / 1024 / 1024))
        #     if [ $PLOT_SIZE_TRUE -le $PLOT_SIZE ]; then
        #         sleep 1s
        #         INVALID_PLOT_LIST=$(du -s $TARGET_PATH/plot-* | grep $i | awk '{print $2}')
        #         for j in $INVALID_PLOT_LIST; do
        #             echo "Delete $j, size ${i}GB."
        #             echo "rm $TARGET_PATH/$j"
        #         done
        #     fi
        # done

        # UNIQ_PLOT=$(ls $TARGET_PATH | grep -v planned | awk -F. '{ print $1 }' | awk -F- '{ print $NF }' | sort | uniq)

        # mkdir $TARGET_PATH/planned
        # for k in $UNIQ_PLOT; do
        #     if [[ ! -z "$k" && -d $TARGET_PATH/planned ]]; then
        #         PLOT_NAME_LIST=$(ls $TARGET_PATH/planned | grep $k)
        #         for m in $PLOT_NAME_LIST; do
        #             echo $m
        #             rm $TARGET_PATH/planned/$m
        #         done
        #     fi
        #     sleep 0.5
        # done
        sleep 1
    done
done

cd /chia-blockchain
./chia-plotter -action plotting -plotting-fpk $FARMER_PK -plotting-ppk $POOL_PK -plotting-n 1 -d /nfs9901/test1 -t /tank1/test1 -2 /tank1/test1
