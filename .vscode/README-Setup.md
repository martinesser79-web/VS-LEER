# VS Code Setup für Nicht-Programmierer

## ✅ Installierte Tools

### 1. Profil-Management (Eingebaut)
- Verschiedene Arbeitsumgebungen per Klick wechseln
- **Nutzen:** `Strg+Shift+P` → `Profil: Neues Profil erstellen`
- Umschalten über Zahnrad-Symbol unten links

### 2. Extension Profiles
- Erstelle Erweiterungs-Gruppen (z.B. "Nur GitHub", "Alles aus")
- **Nutzen:** Rechtsklick auf Erweiterung → `Add to Profile`
- Profile wechseln über Command Palette

### 3. Project Manager
- Verwalte mehrere Projekte
- **Nutzen:** Sidebar-Symbol oder `Strg+Shift+P` → `Project Manager`
- Speichere aktuelle Projekte mit `Save Project`

### 4. Extension Host Pulse Monitor
- Zeigt Performance-Probleme von Erweiterungen
- **Nutzen:** `Strg+Shift+P` → `Extension Host: Show Performance`
- Siehst du, welche Extension CPU/RAM frisst

### 5. Monitor Pro
- System-Überwachung in Statusleiste
- **Nutzen:** Automatisch aktiv, zeigt CPU/RAM unten rechts
- Klick auf Monitor-Symbol für Details

## 🔧 Dein Task: Nur GitHub-Erweiterungen

### Per Button (Statusleiste)
- Unten rechts: Button `Extensions off` klicken
- Führt PowerShell-Skript aus

### Per Tastatur
- `Strg+Shift+P` → `Tasks: Ausführen`
- Wähle `VS Code: Nur GitHub-Erweiterungen aktiv`

### Was passiert?
- Alle Erweiterungen außer GitHub werden nach `~/.vscode/extensions.disabled` verschoben
- VS Code neu starten, um Änderungen zu sehen

## 🚨 Probleme mit Erweiterungen finden

1. **Performance-Check:**
   - `Strg+Shift+P` → `Extension Host: Show Performance`
   - Sortiere nach CPU-Zeit – die obersten sind die Übeltäter

2. **Startup-Zeit:**
   - `Strg+Shift+P` → `Developer: Startup Performance`
   - Zeigt, welche Extension VS Code langsam macht

3. **Logs prüfen:**
   - `Strg+Shift+P` → `Developer: Show Logs`
   - Wähle Extension-Log für Details

## 📋 Empfohlene Profile

### Profil "Minimal"
- Nur: German Language Pack, Theme
- Nutzen: Für schnelles Bearbeiten ohne Ablenkung

### Profil "GitHub"
- Nur: GitHub Copilot, GitHub Pull Requests
- Nutzen: Für GitHub-Arbeit (schon als Task verfügbar)

### Profil "Produktiv"
- Alle hilfreichen Extensions
- Nutzen: Für normale Arbeit

## 🎯 Nächste Schritte

1. Erstelle 2-3 Profile für deine Aufgaben
2. Nutze Project Manager für deine Ordner
3. Beobachte Monitor Pro – wenn CPU >80%, Extensions prüfen
4. Bei Bugs: Extension Host Performance öffnen und lahme Extensions deaktivieren
