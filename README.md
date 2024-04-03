# mullvad-script
zsh script to automate the signing of Mullvad exit nodes on a tailnet with Tailnet Lock enabled.

## Overview
This script has no mandatory arguments, but you can specify `-v` to view more verbose output.

## Prerequisites

1. **Install `jq`**: You must have `jq` installed for the script to work. Follow the installation instructions on the [jq GitHub repository](https://jqlang.github.io/jq/download/).

    ```bash
    # macOS or Linux
    brew install jq

    # Arch Linux (btw)
    sudo pacman -S jq

    # Debian/Ubuntu
    sudo apt-get install jq

    # Fedora/RHEL
    sudo dnf install jq

    # Windows (via WinGet, Scoop, or Chocolatey)
    winget install jqlang.jq
    scoop install jq
    chocolatey install jq
    ```

## Usage
1. **Download the Script**: Either clone the repo or copy the contents of the script to a local file.

2. **Make the Script Executable**: Navigate to the directory where the script is located and make it executable.

    ```bash
    chmod +x signNodes.sh
    ```

3. **Run the Script**: Execute the script with the proper info in the arguments.

    ```bash
    ./signNodes.sh
    ```

4. **Follow the Prompts**: The script will prompt you to confirm that you want to sign Mullvad exit nodes, and for the country prefix for the country's exit nodes you want to sign. Use ".." to sign all Mullvad exit nodes.
