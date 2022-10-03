function Rename-ClusterPhoto {
    [CmdletBinding(SupportsShouldProcess)]
    param(
         [Parameter(Mandatory = $false, Position = 0, HelpMessage = "Location of the cluster photos.")]
        [string]$Location
    )

    if($Location -eq $null)
    {
        $Location = Get-Location
    }

    $items = Get-ChildItem $Location | Where-Object { $_.Name -match "\b[A-F0-9]{8}(?:-[A-F0-9]{4}){3}-[A-F0-9]{12}\b.png" }

    foreach($item in $items)
    {
        $writeTime = $item.LastWriteTime.ToString("yyyyMMdd_HHmmss")
        $newName =  ("{0}_{1}" -f $writeTime, $item.Name)
        if($PSCmdlet.ShouldProcess("$item -> $newName", "Rename File")){
            Move-Item -Path $item -Destination $newName
        }
    }
}