#!/usr/bin/env zsh

current_dir=$(pwd)

root_path="${1:-$current_dir}"

export XDG_RUNTIME_DIR=/run/user/$(id -u)

# Get the current time in 12-hour format
current_time=$(date +'%I:%M %p')

# Convert to 24-hour format to simplify comparisons
hour24=$(date -d "$current_time" +"%H" | sed 's/^0*//')
minute=$(date -d "$current_time" +"%M")
formatted_time=""
part_of_day=""

# Determine part of the day
if ((hour24 < 12)); then
    part_of_day="morning"
elif ((hour24 < 17)); then
    part_of_day="afternoon"
elif ((hour24 < 21)); then
    part_of_day="evening"
else
    part_of_day="night"
fi
# Convert to 12-hour format for output
hour=$(date -d "$current_time" +"%I" | sed 's/^0*//')

# Determine the colloquial expression
if [ $minute -eq "00" ]; then
    formatted_time="$hour o'clock in the $part_of_day"
elif [ $minute -eq "30" ]; then
    formatted_time="half past $hour in the $part_of_day"
elif [ "$minute" -eq "15" ]; then
    formatted_time="quarter past $hour in the $part_of_day"
elif [ "$minute" -eq "45" ]; then
    # For "quarter to", increase hour by 1 for colloquial correctness
    next_hour=$((hour % 12 + 1))
    formatted_time="quarter to $next_hour in the $part_of_day"
else
    # For times not on the hour or half past, just return the original time string
    formatted_time="$current_time in the $part_of_day"
fi

# Text to be spoken (replace with your desired message)
message="It is $formatted_time."

# Path to your WAV file (replace with the actual path)
wav_file_path="$root_path/time.wav"

piper_path="$root_path/piper"
model_path="$root_path/en_US-ryan-high.onnx"

echo "$message" | $piper_path --model $model_path --output_file $wav_file_path &>/dev/null

cat "$wav_file_path" | sox -v 0.15 -t wav - -t alsa &>/dev/null

# Wait for both processes (speaking & playing) to finish before exiting
wait
