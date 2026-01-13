# Test script to validate VS-LEER repository contents
# Tests configuration files, scripts, and documentation

Write-Host "=== VS-LEER Repository Tests ===" -ForegroundColor Cyan
Write-Host ""

$testsPassed = 0
$testsFailed = 0

function Test-Result {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string]$ErrorMessage = ""
    )
    
    if ($Passed) {
        Write-Host "✓ $TestName" -ForegroundColor Green
        $script:testsPassed++
    } else {
        Write-Host "✗ $TestName" -ForegroundColor Red
        if ($ErrorMessage) {
            Write-Host "  Error: $ErrorMessage" -ForegroundColor Yellow
        }
        $script:testsFailed++
    }
}

# Test 1: Verify directory structure
Write-Host "Testing directory structure..." -ForegroundColor Yellow
Test-Result "Directory .vscode exists" (Test-Path ".vscode")
Test-Result "Directory scripts exists" (Test-Path "scripts")

# Test 2: Verify documentation files
Write-Host "`nTesting documentation files..." -ForegroundColor Yellow
Test-Result "README-Setup.md exists" (Test-Path ".vscode/README-Setup.md")
Test-Result "VSCODIUM-SETUP.md exists" (Test-Path ".vscode/VSCODIUM-SETUP.md")

# Test 3: Verify VS Code configuration files
Write-Host "`nTesting VS Code configuration files..." -ForegroundColor Yellow

$jsonFiles = @(
    ".vscode/settings.json",
    ".vscode/vscodium-settings.json",
    ".vscode/tasks.json",
    ".vscode/extensions.json",
    ".vscode/vscodium-extensions.json"
)

foreach ($file in $jsonFiles) {
    if (Test-Path $file) {
        try {
            $content = Get-Content $file -Raw
            $json = ConvertFrom-Json $content -ErrorAction Stop
            Test-Result "$file is valid JSON" $true
        } catch {
            Test-Result "$file is valid JSON" $false $_.Exception.Message
        }
    } else {
        Test-Result "$file exists" $false "File not found"
    }
}

# Test 4: Verify PowerShell scripts
Write-Host "`nTesting PowerShell scripts..." -ForegroundColor Yellow

$scripts = @(
    "scripts/Disable-Extensions.ps1",
    "scripts/Enable-Extensions.ps1"
)

foreach ($script in $scripts) {
    if (Test-Path $script) {
        Test-Result "$script exists" $true
        
        # Test syntax by parsing the script
        try {
            $errors = $null
            $tokens = $null
            $null = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content $script -Raw), [ref]$tokens, [ref]$errors)
            if ($errors.Count -eq 0) {
                Test-Result "$script has valid syntax" $true
            } else {
                Test-Result "$script has valid syntax" $false "Parse errors found"
            }
        } catch {
            Test-Result "$script has valid syntax" $false $_.Exception.Message
        }
    } else {
        Test-Result "$script exists" $false "File not found"
    }
}

# Test 5: Verify script functionality (basic checks)
Write-Host "`nTesting script content..." -ForegroundColor Yellow

if (Test-Path "scripts/Disable-Extensions.ps1") {
    $disableScript = Get-Content "scripts/Disable-Extensions.ps1" -Raw
    Test-Result "Disable-Extensions.ps1 contains keep list" ($disableScript -match '\$keep\s*=\s*@\(')
    Test-Result "Disable-Extensions.ps1 contains github.copilot" ($disableScript -match 'github\.copilot')
} else {
    Test-Result "Disable-Extensions.ps1 content check" $false "File not found"
}

if (Test-Path "scripts/Enable-Extensions.ps1") {
    $enableScript = Get-Content "scripts/Enable-Extensions.ps1" -Raw
    Test-Result "Enable-Extensions.ps1 contains restore list" ($enableScript -match '\$restore\s*=\s*@\(')
} else {
    Test-Result "Enable-Extensions.ps1 content check" $false "File not found"
}

# Summary
Write-Host ""
Write-Host "=== Test Results ===" -ForegroundColor Cyan
Write-Host "Passed: $testsPassed" -ForegroundColor Green
Write-Host "Failed: $testsFailed" -ForegroundColor $(if ($testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($testsFailed -eq 0) {
    Write-Host "All tests passed! ✓" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed. Please review the errors above." -ForegroundColor Red
    exit 1
}
