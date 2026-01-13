# VS-LEER Test Suite

This test suite validates the VS-LEER repository configuration and scripts.

## What is Tested

### 1. Directory Structure
- Verifies that the `.vscode` directory exists
- Verifies that the `scripts` directory exists

### 2. Documentation Files
- Checks for `README-Setup.md` (German VS Code setup guide)
- Checks for `VSCODIUM-SETUP.md` (VSCodium AI extensions setup)

### 3. Configuration Files (JSON Validation)
- `settings.json` - VS Code settings for large file handling
- `vscodium-settings.json` - VSCodium-specific settings
- `tasks.json` - Build tasks for enabling/disabling extensions
- `extensions.json` - Recommended extensions for VS Code
- `vscodium-extensions.json` - Recommended extensions for VSCodium

### 4. PowerShell Scripts (Syntax Validation)
- `Disable-Extensions.ps1` - Disables all extensions except core GitHub tools
- `Enable-Extensions.ps1` - Re-enables specific extensions from backup

### 5. Script Content Validation
- Verifies that `Disable-Extensions.ps1` contains the keep list
- Verifies that GitHub Copilot is in the keep list
- Verifies that `Enable-Extensions.ps1` contains the restore list

## Running the Tests

### Prerequisites
- PowerShell Core (pwsh) or Windows PowerShell

### Run All Tests
```powershell
pwsh -File test-repository.ps1
```

### Expected Output
```
=== VS-LEER Repository Tests ===

Testing directory structure...
✓ Directory .vscode exists
✓ Directory scripts exists

Testing documentation files...
✓ README-Setup.md exists
✓ VSCODIUM-SETUP.md exists

Testing VS Code configuration files...
✓ .vscode/settings.json is valid JSON
✓ .vscode/vscodium-settings.json is valid JSON
✓ .vscode/tasks.json is valid JSON
✓ .vscode/extensions.json is valid JSON
✓ .vscode/vscodium-extensions.json is valid JSON

Testing PowerShell scripts...
✓ scripts/Disable-Extensions.ps1 exists
✓ scripts/Disable-Extensions.ps1 has valid syntax
✓ scripts/Enable-Extensions.ps1 exists
✓ scripts/Enable-Extensions.ps1 has valid syntax

Testing script content...
✓ Disable-Extensions.ps1 contains keep list
✓ Disable-Extensions.ps1 contains github.copilot
✓ Enable-Extensions.ps1 contains restore list

=== Test Results ===
Passed: 16
Failed: 0

All tests passed! ✓
```

## Test Results

All 16 tests passed successfully:
- ✅ Directory structure is correct
- ✅ Documentation files exist
- ✅ All JSON configuration files are valid
- ✅ PowerShell scripts have correct syntax
- ✅ Scripts contain required functionality

## Purpose

This test suite ensures that:
1. The repository structure is intact
2. All configuration files are properly formatted
3. PowerShell scripts are syntactically correct
4. Key functionality (extension management) is present in the scripts

## Maintenance

When adding new configuration files or scripts:
1. Add validation tests to `test-repository.ps1`
2. Update this README with new test descriptions
3. Run the test suite to ensure everything works
