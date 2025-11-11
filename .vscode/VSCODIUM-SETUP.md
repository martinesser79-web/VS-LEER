# VSCodium AI-Extensions Setup

## Problem
Continue, Cody und andere AI-Extensions laufen nicht, weil VSCodium standardmäßig Open VSX statt Microsoft Marketplace nutzt.

## ✅ Lösung: Microsoft Marketplace aktivieren

### Schritt 1: Product.json bearbeiten
1. VSCodium schließen
2. Datei öffnen: `C:\Users\Wladislaw\AppData\Local\Programs\VSCodium\resources\app\product.json`
3. Finde den Abschnitt `"extensionsGallery"` und ersetze ihn mit:

```json
"extensionsGallery": {
  "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
  "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
  "itemUrl": "https://marketplace.visualstudio.com/items"
}
```

4. Speichern & VSCodium neu starten

### Schritt 2: Extensions installieren

Nach Neustart kannst du normal installieren:
- **Continue**: `Strg+Shift+X` → "Continue" suchen → Install
- **Cody**: `Strg+Shift+X` → "Cody AI" suchen → Install
- **Windsurf**: Windsurf ist eine eigene IDE, keine Extension

### Schritt 3: Settings kopieren

Kopiere `vscodium-settings.json` nach:
- Windows: `C:\Users\Wladislaw\AppData\Roaming\VSCodium\User\settings.json`
- Oder: `Strg+Shift+P` → "Open User Settings (JSON)"

## 🔧 Alternative: Manuelle Installation

Falls Marketplace nicht funktioniert:

1. **Continue Extension (.vsix) herunterladen:**
   - https://marketplace.visualstudio.com/items?itemName=Continue.continue
   - Klick "Download Extension" (rechts)

2. **In VSCodium installieren:**
   - `Strg+Shift+P` → "Extensions: Install from VSIX"
   - Wähle die .vsix-Datei aus

3. **Dasselbe für Cody:**
   - https://marketplace.visualstudio.com/items?itemName=sourcegraph.cody-ai

## 🚨 Wenn Extensions trotzdem nicht laufen

### Continue Debug:
1. `Strg+Shift+P` → "Developer: Toggle Developer Tools"
2. Tab "Console" - zeigt Fehler an
3. Häufig: API-Key fehlt oder falsch konfiguriert

### Cody Debug:
1. Prüfe ob Sourcegraph Account verbunden ist
2. `Strg+Shift+P` → "Cody: Sign In"

## 📋 Empfohlene AI-Extensions für VSCodium

✅ **Funktionieren gut:**
- Continue (mit product.json-Fix)
- Cody AI (mit product.json-Fix)
- TabNine
- GitHub Copilot (wenn product.json gefixt)

❌ **Funktionieren nicht:**
- Windsurf (ist eigene IDE, keine Extension)

## 🎯 Performance-Tipps

Bei großen Dateien (5k+ Zeilen):
- Extensions deaktivieren die du nicht brauchst
- `files.maxMemoryForLargeFilesMB: 4096` in settings.json
- HTML-Autovervollständigung aus (siehe vscodium-settings.json)

## 💡 Wichtig

Nach product.json-Änderung:
- VSCodium komplett schließen (auch Tray)
- Neu starten
- Extensions-Tab sollte jetzt VS Marketplace zeigen
