# Auto-disables all VS Code extensions except the ones needed for productive work:
# GitHub tools, status bar buttons, project/profile managers, and system monitors.
# Run this script while VS Code is closed for best results.
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
    # Core GitHub tools
    'github.copilot',
    'github.vscode-pull-request-github',
    # Status bar buttons so they remain visible
    'anweber.statusbar-commands',
    'seunlanlege.action-buttons',
    # Project & extension management tools
    'alefragnani.project-manager',
    'evald24.vscode-extension-profiles',
    # System monitoring for performance tracking
    'aeschli.vscode-pulse-monitor',
    'nexmoe.monitor-pro'
)

Get-ChildItem -Path $extensionsDir -Directory | ForEach-Object {
    # Extract extension ID (everything before the last dash-version pattern)
    # Example: anweber.statusbar-commands-2.8.0 -> anweber.statusbar-commands
    $fullName = $_.Name
    if ($fullName -match '^(.+?)-(\d+\.\d+\.\d+.*)$') {
        $extensionId = $matches[1]
    } else {
        $extensionId = $fullName
    }
    
    if ($keep -notcontains $extensionId.ToLower()) {
        $target = Join-Path $backupDir $_.Name
        Write-Host "Verschiebe $extensionId nach $target"
        Move-Item -Path $_.FullName -Destination $target
    } else {
        Write-Host "Behalte $extensionId"
    }
}

Write-Host "Fertig. VS Code neu starten."
