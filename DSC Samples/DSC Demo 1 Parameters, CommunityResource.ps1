configuration Test1 {
    param(
        [Parameter(Mandatory)]
        [string[]]$ComputerName
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration -ModuleVersion 9.1.0
    
    Node $ComputerName {

        File TestFile1 {
             DestinationPath = 'C:\TestFile1.txt'
             Type = 'File'
             Ensure = 'Present'
             Contents = 'abc123'
        }

        File TestFile2 {
             DestinationPath = 'C:\TestFile2.txt'
             Type = 'File'
             Ensure = 'Present'
             SourcePath = '\\dscdc01\c$\Unattend.xml'
             PsDscRunAsCredential = $cred
        }

        WindowsFeature RemoveXpsViewer {
            Name = 'XPS-Viewer'
            Ensure = 'Absent'
            DependsOn = '[xGroup]LocalAdministrators'
        }

        xGroup LocalAdministrators {
            GroupName = 'Administrators'
            Members = 'contoso\devadmin', 'Administrator', 'contoso\Domain Admins'
        }
    }
}

$cred = New-Object pscredential('contoso\install', ('Somepass1' | ConvertTo-SecureString -AsPlainText -Force))

$computers = Get-ADComputer -Filter 'Name -like "DSCFile*"'
Remove-Item -Path C:\DSC\*
Test1 -OutputPath C:\DSC -ComputerName $computers.DnsHostName

#dir -Path C:\DSC -Filter *.mof | ForEach-Object { New-DscChecksum -Path $_.FullName }
#Start-DscConfiguration -Path C:\DSC -Wait -Verbose -Force