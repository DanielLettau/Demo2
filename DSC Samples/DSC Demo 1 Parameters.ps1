configuration Test1 {
    param(
        [Parameter(Mandatory)]
        [string[]]$ComputerName
    )
    
    Node $ComputerName {

        File TestFile1 {
             DestinationPath = 'C:\TestFile1.txt'
             Type = 'File'
             Ensure = 'Present'
             Contents = 'abc123'
        }

        WindowsFeature RemoveXpsViewer {
            Name = 'XPS-Viewer'
            Ensure = 'Absent'
            DependsOn = '[Group]LocalAdministrators'
        }

        Group LocalAdministrators {
            GroupName = 'Administrators'
            MembersToInclude = 'contoso\devadmin', 'Administrator', 'contoso\Domain Admins'
        }

    }
}

$computers = Get-ADComputer -Filter 'Name -like "DSCFile*"'
Remove-Item -Path C:\DSC\*
Test1 -OutputPath C:\DSC -ComputerName $computers.DnsHostName
#Start-DscConfiguration -Path C:\DSC -Wait -Verbose -Force