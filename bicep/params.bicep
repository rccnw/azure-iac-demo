param storageAccounts_upworkprodstgacctsa_name string = 'upworkprodstgacctsa'
param serverfarms_upwork_prod_service_plan_sp_name string = 'upwork-prod-service-plan--sp'
param sites_upwork_prod_function_app_hzhg7864_fa_name string = 'upwork-prod-function-app-hzhg7864-fa'
param staticSites_upwork_prod_static_web_app_swa_name string = 'upwork-prod-static-web-app--swa'



resource storageAccounts_upworkprodstgacctsa_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_upworkprodstgacctsa_name
  location: 'westeurope'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  identity: {
    type: 'None'
  }
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    isNfsV3Enabled: false
    isLocalUserEnabled: true
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    isHnsEnabled: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_upwork_prod_service_plan_sp_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_upwork_prod_service_plan_sp_name
  location: 'West Europe'
  tags: {
    environment: 'prod'
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource staticSites_upwork_prod_static_web_app_swa_name_resource 'Microsoft.Web/staticSites@2023-12-01' = {
  name: staticSites_upwork_prod_static_web_app_swa_name
  location: 'West Europe'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'None'
    enterpriseGradeCdnStatus: 'Disabled'
  }
}

resource storageAccounts_upworkprodstgacctsa_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_upworkprodstgacctsa_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_upworkprodstgacctsa_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_upworkprodstgacctsa_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_upwork_prod_function_app_hzhg7864_fa_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_upwork_prod_function_app_hzhg7864_fa_name
  location: 'West Europe'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_upwork_prod_function_app_hzhg7864_fa_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_upwork_prod_function_app_hzhg7864_fa_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_upwork_prod_service_plan_sp_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Optional'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'B90967E10B2CD51A753CAA8AA964F66EC9FBED4401D049A24C05825D179FBD9E'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_upwork_prod_function_app_hzhg7864_fa_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_upwork_prod_function_app_hzhg7864_fa_name_resource
  name: 'ftp'
  location: 'West Europe'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  properties: {
    allow: true
  }
}

resource sites_upwork_prod_function_app_hzhg7864_fa_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_upwork_prod_function_app_hzhg7864_fa_name_resource
  name: 'scm'
  location: 'West Europe'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  properties: {
    allow: true
  }
}

resource sites_upwork_prod_function_app_hzhg7864_fa_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_upwork_prod_function_app_hzhg7864_fa_name_resource
  name: 'web'
  location: 'West Europe'
  tags: {
    environment: 'prod'
    project: 'upwork'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$upwork-prod-function-app-hzhg7864-fa'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'Disabled'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_upwork_prod_function_app_hzhg7864_fa_name_sites_upwork_prod_function_app_hzhg7864_fa_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_upwork_prod_function_app_hzhg7864_fa_name_resource
  name: '${sites_upwork_prod_function_app_hzhg7864_fa_name}.azurewebsites.net'
  location: 'West Europe'
  properties: {
    siteName: 'upwork-prod-function-app-hzhg7864-fa'
    hostNameType: 'Verified'
  }
}

resource staticSites_upwork_prod_static_web_app_swa_name_default 'Microsoft.Web/staticSites/basicAuth@2023-12-01' = {
  parent: staticSites_upwork_prod_static_web_app_swa_name_resource
  name: 'default'
  location: 'West Europe'
  properties: {
    applicableEnvironmentsMode: 'SpecifiedEnvironments'
  }
}

resource storageAccounts_upworkprodstgacctsa_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_upworkprodstgacctsa_name_resource
  ]
}

resource storageAccounts_upworkprodstgacctsa_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_upworkprodstgacctsa_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_upworkprodstgacctsa_name_resource
  ]
}

resource storageAccounts_upworkprodstgacctsa_name_default_upwork_prod_function_app_hzhg7864_fa_de8a 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_upworkprodstgacctsa_name_default
  name: 'upwork-prod-function-app-hzhg7864-fa-de8a'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_upworkprodstgacctsa_name_resource
  ]
}
