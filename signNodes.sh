#! /bin/sh

# Store the command in a variable
tsBinary=$(which tailscale)

# Check if root and whether to use sudo or doas
	CAN_ROOT=
	SUDO=
	if [ "$(id -u)" = 0 ]; then
		CAN_ROOT=1
		SUDO=""
	elif type sudo >/dev/null; then
		CAN_ROOT=1
		SUDO="sudo"
	elif type doas >/dev/null; then
		CAN_ROOT=1
		SUDO="doas"
	fi
	if [ "$CAN_ROOT" != "1" ]; then
		echo "This installer needs to run commands as root."
		echo "We tried looking for 'sudo' and 'doas', but couldn't find them."
		echo "Either re-run this script as root, or set up sudo/doas."
		exit 1
	fi

# Prompt the user to confirm that they want to sign all nodes
printf "Do you want to sign all Mullvad nodes?\n"
printf "Y/y to confirm: "
read -r choice0
printf "\n" # To move to a new line after input

if [ "$choice0" = "Y" ] || [ "$choice0" = "y" ]; then
  # Ask which country nodes to sign
  printf '\nInput the two letter country code for the Mullvad exit nodes you would like to sign.\nUse ".." to sign all nodes.\n'
  read -r country
  if [ ${#country} -gt 2 ]; then
    printf "Country code longer than 2 characters, please only enter 2 characters.\n"
    exit 1
  fi
  # Store all unsigned nodes
  lockedNodes=$($tsBinary lock status --json | jq -rc '.FilteredPeers[]')
  # Loop through all locked nodes
  echo "$lockedNodes" | while read -r node; do
    nodeName=$(echo "$node" | jq -r .Name)
    if echo "$nodeName" | grep -q "^$country.*mullvad\.ts\.net\.$"; then
      printf "Signing node %s\n" "$nodeName"
      $SUDO "$tsBinary" lock sign "$(echo "$node" | jq -r '.NodeKey')"
    else
      # If verbose logging is enabled, show skipped nodes
      if [ "$1" = "-v" ]; then
        printf "Node %s skipped\n" "$nodeName"
      fi
    fi
  done
else
  printf "\n'%s' not 'Y' or 'y'. Exiting...\n" "$choice0"
  exit 1
fi