# Restores specific VS Code extensions from the backup folder (~/.vscode/extensions.disabled)
# back into the active extensions folder (~/.vscode/extensions).
# Run this while VS Code is closed for best results.

$extensionsDir = Join-Path $env:USERPROFILE '.vscode\extensions'
$backupDir     = "$extensionsDir.disabled"

if (-not (Test-Path $backupDir)) {
    Write-Error "Backup-Verzeichnis nicht gefunden: $backupDir"
    exit 1
}

# IDs to restore (folders are typically like anweber.statusbar-commands-<version>)
$restore = @(
    'anweber.statusbar-commands',
    'seunlanlege.action-buttons'
)

foreach ($id in $restore) {
    $candidates = Get-ChildItem -Path $backupDir -Directory -Filter "$id-*"
    if (-not $candidates) {
        Write-Warning "Keine Sicherung für $id im Backup gefunden. Evtl. neu installieren."
        continue
    }
    foreach ($dir in $candidates) {
        $target = Join-Path $extensionsDir $dir.Name
        Write-Host "Stelle wieder her: $($dir.FullName) -> $target"
        Move-Item -Path $dir.FullName -Destination $target -Force
    }
}

Write-Host "Fertig. VS Code neu starten."
