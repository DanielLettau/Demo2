[DscLocalConfigurationManager()]
Configuration PullConfig1
{
    param (
    [Parameter(Mandatory)]
    [string]$ComputerName,

    [Parameter(Mandatory)]
    [string]$ConfigurationName
    )

    Node $ComputerName
    {
        Settings
        {
            RefreshMode          = 'Pull'
            ActionAfterReboot    = 'ContinueConfiguration'
            AllowModuleOverWrite = $True
            RebootNodeIfNeeded   = $True
        }
        ConfigurationRepositoryWeb PullServerConfig
        {
            ServerURL                = 'http://DSCHost01.contoso.com:8080/PSDSCPullServer.svc'
            AllowUnsecureConnection  = $true
            ConfigurationNames       = $ComputerName
            RegistrationKey          = 'Hello'
        }
        ReportServerWeb PullServerReport
        {
            ServerURL               = 'http://DSCHost01.contoso.com:8080/PSDSCPullServer.svc'
            AllowUnsecureConnection = $true
            RegistrationKey = 'Hello'
        }
    }
}

Remove-Item -Path C:\DSC\*
PullConfig1 -ComputerName DSCFile01.contoso.com -ConfigurationName DSCFile01.contoso.com -OutputPath C:\DSC
Set-DscLocalConfigurationManager -Path C:\DSC -Verbose

Update-DscConfiguration -Wait -Verbose