#!/bin/bash

# Check if a Job ID was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <TARGET_JOB_ID>"
    exit 1
fi

TARGET_JOB="$1"

echo "=== Step 1: Prioritizing Job $TARGET_JOB ==="

# 1. Loop through all pending jobs and set Nice=1000, except the target job
for job in $(squeue -u $USER -t PENDING -h -o "%i"); do 
    if [ "$job" != "$TARGET_JOB" ]; then
        scontrol update jobid=$job Nice=1000
    else
        echo "Keeping target job $job at top priority."
    fi
done

echo "------------------------------------------------"
echo "=== Step 2: Waiting for job $TARGET_JOB to run ==="

# 2. Poll squeue until the target job state is 'R' (RUNNING)
while true; do
    # Get the state of the target job
    STATE=$(squeue -j "$TARGET_JOB" -h -o "%t" 2>/dev/null)
    
    # If squeue returns nothing, the job might have finished, failed, or been canceled
    if [ -z "$STATE" ]; then
        echo "Warning: Target job $TARGET_JOB is no longer in the active queue (it may have finished or failed)."
        break
    elif [ "$STATE" = "R" ]; then
        echo "Success! Job $TARGET_JOB has entered RUNNING state."
        break
    else
        echo "Job status: $STATE. Checking again in 10 seconds..."
        sleep 10
    fi
done

echo "------------------------------------------------"
echo "=== Step 3: Resetting all nice values to 0 ==="

# 3. Restore all remaining pending jobs back to default priority
for job in $(squeue -u $USER -t PENDING -h -o "%i"); do 
    scontrol update jobid=$job Nice=0
done

echo "All pending jobs have been reset to Nice=0."
