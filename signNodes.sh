#! /bin/zsh

#prompt the user to confirm that they want to sign all nodes
echo 'Do you want to sign all Mullvad nodes?'
if read -q "choice0?Y/y to confirm"; then
  #ask which country nodes to sign
  echo '\nInput the two letter country code for the Mullvad exit nodes you would like to sign.\nUse ".." to sign all nodes.'
  read country
  if [[ ${#country} -gt 2 ]]; then
    echo "Country code longer than 2 characters, please only enter 2 characters."
    return
  fi
  #store all unsigned nodes
  lockedNodes=($(/Applications/Tailscale.app/Contents/MacOS/Tailscale lock status --json | jq -rc '.FilteredPeers[]'))
  #loop thorugh all locked nodes
  for node in $lockedNodes; do
    if [[ "$(echo $node | jq -r .Name)" =~ "^$country.*mullvad\.ts\.net\.$" ]]; then
      echo "Signing node $(echo $node | jq .Name)"
      /Applications/Tailscale.app/Contents/MacOS/Tailscale lock sign $(echo $node | jq -r '.NodeKey')
    else
      #if verbose logging is enabled, show skipped nodes
      if [[ $1 == "-v" ]]; then
        echo "Node $(echo $node | jq .Name) skipped"
      fi
    fi
  done
  
else
	echo ""
	echo "'$choice0' not 'Y' or 'y'. Exiting..."
	return 1
fi