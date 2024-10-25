# mullvad-script
sh script to automate the signing of Mullvad exit nodes on a tailnet with Tailnet Lock enabled. This script is compatible with any system capable of running sh scripts.

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
2. **Setup `tailscale` CLI**: The `tailscale` CLI command must be setup properly. The CLI is configured properly by default on Linux. On macOS, follow the instructions here in the [Tailscale documentation](https://tailscale.com/kb/1080/cli?tab=macos) to setup the CLI: [https://tailscale.com/kb/1080/cli](https://tailscale.com/kb/1080/cli).

## Usage - Linux
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

## Usage - Windows
1. **Download the Script**: Either clone the repo or copy the contents of the script to a local file.

2. **Enable Execution Policy**: Open PowerShell as an administrator and run the following command to enable the execution of the script.

    ```powershell
    Set-ExecutionPolicy Unrestricted -Scope CurrentUser
    ```
    You'll receive a the following prompt:  

    ```
    Execution Policy Change
    The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose
    you to the security risks described in the about_Execution_Policies help topic at
    https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):
    ```

    Select `Y` to continue.

3. **Run the Script**: Execute the script with the proper info in the arguments.

    ```powershell
    .\signNodes.ps1
    ```
4. **Follow the Prompts**: The script will prompt you to confirm that you want to sign Mullvad exit nodes, and for the country prefix for the country's exit nodes you want to sign. Use ".." to sign all Mullvad exit nodes.

5. **Return Execution Policy to Default**: Once you're done using the script, you should reset the execution policy to its default value.

    ```powershell
    Set-ExecutionPolicy Default -Scope CurrentUser
    ```
