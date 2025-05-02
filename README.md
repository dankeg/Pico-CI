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