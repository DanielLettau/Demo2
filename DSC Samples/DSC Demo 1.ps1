configuration Test1 {
    
    Node localhost {

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

Remove-Item -Path C:\DSC\*
Test1 -OutputPath C:\DSC
#Start-DscConfiguration -Path C:\DSC -Wait -Verbose -Force