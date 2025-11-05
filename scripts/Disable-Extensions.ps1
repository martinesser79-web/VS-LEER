# Disables all VS Code extensions except the ones listed in $keep by moving them
# into a backup folder. Run this script while VS Code is closed.
$extensionsDir = Join-Path $env:USERPROFILE '.vscode\extensions'
$backupDir = "$extensionsDir.disabled"

if (-not (Test-Path $extensionsDir)) {
    Write-Error "Erweiterungsverzeichnis nicht gefunden: $extensionsDir"
    exit 1
}

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

$keep = @(
    'github.copilot',
    'github.vscode-pull-request-github',
    'github.copilot-chat'
)

Get-ChildItem -Path $extensionsDir -Directory | ForEach-Object {
    $extensionId = $_.Name.Split('-')[0]
    if ($keep -notcontains $extensionId.ToLower()) {
        $target = Join-Path $backupDir $_.Name
        Write-Host "Verschiebe $extensionId nach $target"
        Move-Item -Path $_.FullName -Destination $target
    } else {
        Write-Host "Behalte $extensionId"
    }
}

Write-Host "Fertig. VS Code neu starten."
