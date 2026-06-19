# env-setup.ps1
# Dotted-source this script in PowerShell to add the local Java 21 and Maven to your current session PATH.
# Usage: . .\env-setup.ps1

$sdkDir = "C:\portfolio\.sdk"
$jdkBin = Join-Path $sdkDir "jdk-21\bin"
$mvnBin = Join-Path $sdkDir "maven\bin"

$configured = $true

if (Test-Path $jdkBin) {
    $env:JAVA_HOME = Join-Path $sdkDir "jdk-21"
    $env:PATH = "$jdkBin;$env:PATH"
    Write-Host "Configured JAVA_HOME: $env:JAVA_HOME"
    Write-Host "Added Java to PATH"
} else {
    Write-Warning "Java bin folder not found at $jdkBin. Please run .\install-sdk.ps1 first."
    $configured = $false
}

if (Test-Path $mvnBin) {
    $env:M2_HOME = Join-Path $sdkDir "maven"
    $env:PATH = "$mvnBin;$env:PATH"
    Write-Host "Configured M2_HOME: $env:M2_HOME"
    Write-Host "Added Maven to PATH"
} else {
    Write-Warning "Maven bin folder not found at $mvnBin. Please run .\install-sdk.ps1 first."
    $configured = $false
}

if ($configured) {
    Write-Host "`nVerifying local versions:" -ForegroundColor Green
    java -version
    Write-Host ""
    mvn -version
}
