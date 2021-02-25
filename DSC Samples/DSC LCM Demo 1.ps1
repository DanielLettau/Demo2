[DscLocalConfigurationManager()]
Configuration LcmConfig1
{
    Node localhost
    {
        Settings
        {
            ActionAfterReboot              = 'ContinueConfiguration'
            AllowModuleOverWrite           = $True
            ConfigurationMode              = 'ApplyAndAutoCorrect'
            ConfigurationModeFrequencyMins = 15
            RefreshFrequencyMins           = 60
            StatusRetentionTimeInDays      = 7
            RebootNodeIfNeeded             = $True
            RefreshMode                    = 'Push'
            CertificateID                  = '70488CBE6440184505F92F5294408255F1EF6A92'
        }
    }
}

LcmConfig1 -OutputPath C:\DSC
