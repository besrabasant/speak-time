# Time Speaker Project
This project is a simple script that announces the current time in a colloquial manner using text-to-speech synthesis. It's designed to run on a Unix-like operating system with the shell.

## Requirements
- Unix-like operating system
- zsh or bash shell
- Piper text-to-speech tool
- SoX sound processing tool

## Installation
- Install the required tools: **Piper** and **SoX**.
- Download the suitable piper voices from [here](https://github.com/rhasspy/piper/blob/master/VOICES.md) (both voice model and the json) to the directory.
- Update the **piper_path** variable in the script with the path to your Piper installation.

## Usage
Run the script with the desired root path as an argument. If no argument is provided, the current directory is used as the root path.

```sh
./speak_time.sh [/path/to/root]
```

Note: The root path argument is only needed if you are running this script via a cronjob.

### How it works
The script performs the following steps:

1. Retrieves the current time and converts it to 12-hour and 24-hour formats.
2. Determines the part of the day (morning, afternoon, evening, or night).
3. Formats the time in a colloquial expression.
4. Synthesizes the text-to-speech audio using Piper and the pretrained model.
5. Plays the audio using SoX.

### License
This project is open-source and licensed under the MIT License.