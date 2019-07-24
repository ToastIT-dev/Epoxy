function Initialize-EpoxyTypeData {
    $TypeData = @{
        TypeName = 'Epoxy.Organization'
        DefaultDisplayPropertySet = 'ID', 'Name', 'Status', 'Type'
    }
    Update-TypeData @TypeData
}
