# Pico-CI
This repo outlines a basic setup for creating a Custom Local CI Runner using a Raspberry Pi, which pulls and builds our code, and runs it on a connected Pico or RP2040/RP2350 Board.
This enables us to automatically run integration tests upon pushing code, and leverage the GPIO of the Raspberry PI to perform tasks such as resets, external probing and validation (such as capturing temperature and transmitted signals), and more!

The hope is to integrate this, or a system similar to this, for Software Development on Pleiades Atlas and TeraLink.
There is lots of potential to build upon this: reach out if you're interested in contributing!

# Setup
***Run into any issues during setup? Feel free to create an issue!***

Within a Github repo, navigate to Settings, Actions, Runner, New Self Hosted Runner.

Under the configure step, note the token within the command:
`./config.sh --url https://github.com/dankeg/JupyterPicoSDK --token <actual-token>`

Clone the repo on your Raspberry Pi, and modify the constants at the top to use this token, and to reference your repo.
Run the script to perform the setup `./runner_setup.sh`.

Navigating back to Settings, Actions, Runner, you should now see that the runner is online!
This repo provides sample workflow files which demonstrate pinging the runner, and using it to build & flash code for the Pico, and subsequently monitor it. 
These are currently set to be manually activable, & run upon pushing to any branch. 

# Future Extensions
The following is a list of potential modifications and features. If you're interested in developing any of these, contact Ganesh or someone from Project Horizon, and we can discuss next steps in greater detail. 
- Dockerize build environments to ensure a cleaner setup that enables concurrent jobs 
    - Integrate [PicoSDK Devcontainer](https://github.com/NU-Horizonsat/pico-sdk-template)
    - Integrate [Zephyr Devcontainer](https://github.com/zephyrproject-rtos/docker-image) 
    - Integrate [F'Prime Devcontainer](https://github.com/fprime-community/fprime-docker/tree/devel)
- Integrate Raspberry Pi GPIO Utilization
    - Enable hard-resets using the Pico Reset Pin
    - Integrate basic external temperature monitoring 
    - Integrate basic LoRa transmission/reception 
    - Other external probing and validation, as it becomes relevant
- Other Devices
    - Integrate flashing using a hardware debugger, such as a J-Link, Raspberry Pi Debug Probe, etc.
    - Integrate flashing RT1050 based boards, such as the Payload Board & [Arch Mix](https://www.seeedstudio.com/Arch-Mix-p-2901.html?srsltid=AfmBOoobFxhTZL7-anU2D6zFEJh4VMdzgBNCDeRyTfGmM7_G4sYXSwcT)
    - Integrate flashing the BeagleBone Black
    - Integrate flashing Raspberry Pi Single Board Computer models 

