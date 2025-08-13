#!/bin/zsh

# Define the disk name or UUID
DISK_NAME="SeagateBackup"

# Set the total wait time in seconds
TOTAL_WAIT_TIME=1800  # 30 minutes

while true; do
  # Check if the disk is mounted
  if mount | grep -q "/Volumes/$DISK_NAME"; then
    # Start backup
    tmutil startbackup
    echo "Time Machine backup started."
  fi

  # Start countdown for next backup check
  echo "Waiting for 10 minutes before the next backup attempt..."
  
  for ((i = 1; i <= TOTAL_WAIT_TIME; i++)); do
    # Calculate percentage and time remaining
    percent=$((i * 100 / TOTAL_WAIT_TIME))
    remaining=$((TOTAL_WAIT_TIME - i))
    
    # Display progress bar and time remaining
    printf "\rProgress: [%-50s] %3d%% - %02d:%02d remaining" \
           $(printf "#%.0s" $(seq 1 $((i * 50 / TOTAL_WAIT_TIME)))) \
           $percent \
           $((remaining / 60)) \
           $((remaining % 60))
           
    sleep 1
  done
  
  echo "\n"
done
