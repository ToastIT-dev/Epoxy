function Get-EpoxyOrganization {
    [CmdletBinding()]
    param (
        [switch] $All,
        [switch] $Refresh
    )

    begin {
        if ($Refresh -or -not $Script:Organizations) {
            $PageNumber = 1
            $More = $true

            $Script:Organizations = [System.Collections.Generic.List[PSCustomObject]]::new()

            while ($More) {
                $OrgsRequest = Get-ITGlueOrganizations -page_size 1000 -page_number $PageNumber

                if ($OrgsRequest.data.Count -lt 1000) {
                    $More = $false
                }

                foreach ($Org in $OrgsRequest.data) {
                    $Script:Organizations.Add([PSCustomObject] [Ordered] @{
                        PSTypeName          = Epoxy.Organization
                        ID                  = $Org.Id
                        Name                = $Org.attributes.'name'
                        Status              = $Org.attributes.'organization-status-name'
                        Type                = $Org.attributes.'organization-type-name'
                        PsaIntegration      = $Org.attributes.'psa-integration'
                        Alert               = $Org.attributes.'alert'
                        Description         = $Org.attributes.'description'
                        TypeID              = $Org.attributes.'organization-type-id'
                        StatusID            = $Org.attributes.'organization-status-id'
                        Primary             = [bool] $Org.attributes.'primary'
                        QuickNotes          = $Org.attributes.'quick-notes'
                        ShortName           = $Org.attributes.'short-name'
                        Created             = [datetime] $Org.attributes.'created-at'
                        Updated             = [datetime] $Org.attributes.'updated-at'
                        Logo                = $Org.attributes.'logo'
                        MyGlueAccountID     = $Org.attributes.'my-glue-account-id'
                        MyGlueAccountStatus = $Org.attributes.'my-glue-account-status'
                    })
                }

                $PageNumber += 1
            }
        }
    }

    process {
    }

    end {
    }
}
