$tsBinary = Get-Command -Name tailscale

Write-Output "Do you want to sign all Mullvad nodes?"
$choice0 = Read-Host "Y/y to confirm: "

if ($choice0 -eq "Y" -or $choice0 -eq "y") {
    Write-Output ""
    Write-Output 'Input the two letter country code for the Mullvad exit nodes you would like to sign.'
    Write-Output 'Use ".." to sign all nodes.'
    $country = Read-Host

    if ($country.Length -gt 2) {
        Write-Output "Country code longer than 2 characters, please only enter 2 characters."
        exit 1
    }

    $lockedNodes = & $tsBinary lock status --json | ConvertFrom-Json

    foreach ($node in $lockedNodes.FilteredPeers) {
        $nodeName = $node.Name
        if ($nodeName -match "^$country.*mullvad\.ts\.net\.$") {
            Write-Output "Signing node $nodeName"
            & $tsBinary lock sign $node.NodeKey
        } else {
            if ($args[0] -eq "-v") {
                Write-Output "Node $nodeName skipped"
            }
        }
    }
} else {
    Write-Output "'$choice0' not 'Y' or 'y'. Exiting..."
    exit 1
}