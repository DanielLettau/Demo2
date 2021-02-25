configuration BasicVisibleCmdlets {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    Import-DscResource -ModuleName JeaDsc

    node localhost {

        JeaRoleCapabilities BasicVisibleCmdlets {
            Path = $Path
            Ensure = 'Present'
            VisibleCmdlets = 'Get-Service'
        }

    }
}
