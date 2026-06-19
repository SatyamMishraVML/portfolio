# install-sdk.ps1
# This script downloads and installs Adoptium JDK 21 and Apache Maven 3.9.x locally under C:\portfolio\.sdk.
# It does not require admin privileges.

$ProgressPreference = 'SilentlyContinue'
$sdkDir = "C:\portfolio\.sdk"

if (!(Test-Path $sdkDir)) {
    New-Item -ItemType Directory -Path $sdkDir -Force | Out-Null
    Write-Host "Created directory $sdkDir"
}

# 1. Download and Extract JDK 21
$jdkDestFolder = Join-Path $sdkDir "jdk-21"
if (Test-Path $jdkDestFolder) {
    Write-Host "JDK 21 is already installed at $jdkDestFolder. Skipping download."
} else {
    Write-Host "Downloading Eclipse Temurin JDK 21..."
    $jdkZip = Join-Path $sdkDir "jdk.zip"
    $jdkUrl = "https://api.adoptium.net/v3/binary/latest/21/ga/windows/x64/jdk/hotspot/normal/eclipse?project=jdk"
    Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkZip -MaximumRedirection 5
    
    Write-Host "Extracting JDK 21..."
    Expand-Archive -Path $jdkZip -DestinationPath $sdkDir -Force
    
    # Locate the extracted folder (usually eclipse-temurin-... or jdk-21...) and rename it to jdk-21
    $extractedFolder = Get-ChildItem $sdkDir -Directory | Where-Object { $_.Name -like "*jdk*" -or $_.Name -like "*temurin*" } | Select-Object -First 1
    if ($extractedFolder) {
        Rename-Item -Path $extractedFolder.FullName -NewName "jdk-21"
        Write-Host "Successfully installed JDK 21 to $jdkDestFolder"
    } else {
        Write-Warning "Could not find extracted JDK folder to rename."
    }
    
    Remove-Item $jdkZip -Force
}

# 2. Download and Extract Maven
$mvnDestFolder = Join-Path $sdkDir "maven"
if (Test-Path $mvnDestFolder) {
    Write-Host "Maven is already installed at $mvnDestFolder. Skipping download."
} else {
    Write-Host "Downloading Apache Maven 3.9.8..."
    $mvnZip = Join-Path $sdkDir "maven.zip"
    $mvnUrl = "https://archive.apache.org/dist/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.zip"
    Invoke-WebRequest -Uri $mvnUrl -OutFile $mvnZip
    
    Write-Host "Extracting Apache Maven..."
    Expand-Archive -Path $mvnZip -DestinationPath $sdkDir -Force
    
    $extractedFolder = Get-ChildItem $sdkDir -Directory | Where-Object { $_.Name -like "*maven-3.9*" } | Select-Object -First 1
    if ($extractedFolder) {
        Rename-Item -Path $extractedFolder.FullName -NewName "maven"
        Write-Host "Successfully installed Maven to $mvnDestFolder"
    } else {
        Write-Warning "Could not find extracted Maven folder to rename."
    }
    
    Remove-Item $mvnZip -Force
}

Write-Host "SDK Installation complete! You can run commands by pointing to local bin paths or running the setup-env script."
