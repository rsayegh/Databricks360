param baseName string
param env string
param location string = resourceGroup().location
param adbmngresourceid string
param locationshortname string
param lawid string
param pricingTier string = 'premium'

//var managedRGId = '${subscription().id}/resourceGroups/${resourceGroup().name}-mng'

resource adbws 'Microsoft.Databricks/workspaces@2024-05-01' = {
  name: 'adbws-${locationshortname}${baseName}${env}'
  location: location
  sku: {
    name: pricingTier
  }
  properties: {
    managedResourceGroupId: adbmngresourceid
  }
}

resource adbwsdiags 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${adbws.name}diags'
  scope: adbws
  properties: {
    workspaceId: lawid
    logs: [
      {
        category: 'dbfs'
        enabled: true
      }
      {
        category: 'clusters'
        enabled: true
      }
      {
        category: 'accounts'
        enabled: true
      }
      {
        category: 'jobs'
        enabled: true
      }
      {
        category: 'notebook'
        enabled: true
      }
      {
        category:'workspace'
        enabled: true
      }
      {
        category: 'sqlAnalytics'
        enabled: true
      }
      {
        category: 'repos'
        enabled: true
      }
      {
        category: 'unitycatalog'
        enabled: true
      }
    ]
  }
}





