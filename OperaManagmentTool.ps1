# Load Windows Forms and Drawing Assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# Create the Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Opera Management Tool"
$form.Size = New-Object System.Drawing.Size(800, 700)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 36)  # Dark pixel-art background
$form.Font = New-Object System.Drawing.Font("Consolas", 10)

# Pixelated Header Banner
$header = New-Object System.Windows.Forms.Label
$header.Text = "Opera Management Tool"
$header.Font = New-Object System.Drawing.Font("Consolas", 20, [System.Drawing.FontStyle]::Bold)
$header.Size = New-Object System.Drawing.Size(750, 50)
$header.Location = New-Object System.Drawing.Point(25, 20)
$header.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$header.ForeColor = [System.Drawing.Color]::FromArgb(255, 165, 0)  # Vibrant orange
$form.Controls.Add($header)

# Add a separator line under the banner
$separator = New-Object System.Windows.Forms.Label
$separator.Text = ""
$separator.Size = New-Object System.Drawing.Size(750, 4)
$separator.Location = New-Object System.Drawing.Point(25, 80)
$separator.BackColor = [System.Drawing.Color]::FromArgb(200, 160, 60)  # Golden line
$form.Controls.Add($separator)

# Function to Create Checkboxes
function CreateCheckbox {
    param (
        [string]$text,
        [int]$xOffset,
        [int]$yOffset
    )
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = $text
    $checkbox.Size = New-Object System.Drawing.Size(300, 30)
    $checkbox.Location = New-Object System.Drawing.Point($xOffset, $yOffset)
    $checkbox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $checkbox.ForeColor = [System.Drawing.Color]::LightGray
    $checkbox.BackColor = [System.Drawing.Color]::Transparent
    return $checkbox
}

# Opera Section Label
$operaLabel = New-Object System.Windows.Forms.Label
$operaLabel.Text = "Opera"
$operaLabel.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Bold)
$operaLabel.Size = New-Object System.Drawing.Size(300, 30)
$operaLabel.Location = New-Object System.Drawing.Point(50, 100)
$operaLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($operaLabel)

# Opera GX Section Label
$operaGXLabel = New-Object System.Windows.Forms.Label
$operaGXLabel.Text = "Opera GX"
$operaGXLabel.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Bold)
$operaGXLabel.Size = New-Object System.Drawing.Size(300, 30)
$operaGXLabel.Location = New-Object System.Drawing.Point(400, 100)
$operaGXLabel.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($operaGXLabel)

# Opera Checkboxes
$chkUninstallOpera = CreateCheckbox "Uninstall Opera" 50 140
$chkReinstallOpera = CreateCheckbox "Reinstall Opera" 50 180
$chkLaunchOpera = CreateCheckbox "Launch Opera" 50 220
$chkKillProcessesOpera = CreateCheckbox "Kill Opera Processes" 50 260
$chkDeleteInstallerOpera = CreateCheckbox "Delete Opera Installers" 50 300
$form.Controls.Add($chkUninstallOpera)
$form.Controls.Add($chkReinstallOpera)
$form.Controls.Add($chkLaunchOpera)
$form.Controls.Add($chkKillProcessesOpera)
$form.Controls.Add($chkDeleteInstallerOpera)

# Opera GX Checkboxes
$chkUninstallOperaGX = CreateCheckbox "Uninstall Opera GX" 400 140
$chkReinstallOperaGX = CreateCheckbox "Reinstall Opera GX" 400 180
$chkLaunchOperaGX = CreateCheckbox "Launch Opera GX" 400 220
$chkKillProcessesGX = CreateCheckbox "Kill Opera GX Processes" 400 260
$chkDeleteInstallerGX = CreateCheckbox "Delete Opera GX Installers" 400 300
$form.Controls.Add($chkUninstallOperaGX)
$form.Controls.Add($chkReinstallOperaGX)
$form.Controls.Add($chkLaunchOperaGX)
$form.Controls.Add($chkKillProcessesGX)
$form.Controls.Add($chkDeleteInstallerGX)

# Log Display TextBox
$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Multiline = $true
$logTextBox.AcceptsReturn = $true
$logTextBox.Size = New-Object System.Drawing.Size(700, 200)
$logTextBox.Location = New-Object System.Drawing.Point(50, 360)
$logTextBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$logTextBox.ReadOnly = $true
$logTextBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$logTextBox.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 30)  # Darker background
$logTextBox.ForeColor = [System.Drawing.Color]::Lime
$form.Controls.Add($logTextBox)

# Function to Install Opera Setup
function InstallSetup {
    param (
        [string]$DownloadUrl = "https://net.geo.opera.com/opera_gx/stable/edition/std-2?utm_source=utod&utm_medium=pb&utm_campaign=organic",
        [string]$InstallerPath = ""
    )

    $logTextBox.AppendText("Downloading Opera installer...`n")

    try {
        $InstallerPath = Join-Path ([Environment]::GetFolderPath("UserProfile")) "Downloads\OperaSetup.exe"
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $InstallerPath -ErrorAction Stop
        $logTextBox.AppendText("Download completed.`n")

        $logTextBox.AppendText("Installing Opera...`n")
        Start-Process $InstallerPath -ArgumentList "/silent" -Wait
        $logTextBox.AppendText("Opera installation complete")
    } catch {
        $logTextBox.AppendText("Failed to download or install Opera: $($_.Exception.Message)`n")
    }
}

# Create Buttons
function CreateButton {
    param (
        [string]$text,
        [int]$xOffset,
        [int]$yOffset,
        [scriptblock]$clickEvent
    )
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Location = New-Object System.Drawing.Point($xOffset, $yOffset)
    $button.Size = New-Object System.Drawing.Size(140, 40)
    $button.BackColor = [System.Drawing.Color]::FromArgb(60, 90, 120)  # Cool-toned button
    $button.ForeColor = [System.Drawing.Color]::White
    $button.Font = New-Object System.Drawing.Font("Consolas", 12, [System.Drawing.FontStyle]::Bold)
    $button.Add_Click($clickEvent)
    return $button
}


# Add Install Opera Button
$btnInstallOpera = CreateButton "Install Opera" 50 580 {
    $logTextBox.AppendText("Starting Opera installation...`n")
    InstallSetup
}
$form.Controls.Add($btnInstallOpera)

# Execute Button
$btnExecute = CreateButton "Execute" 210 580 {
    $logTextBox.AppendText("Executing operations.`n")
    $UserPath = [Environment]::GetFolderPath("UserProfile")

    # Kill Opera Processes
    if ($chkKillProcessesOpera.Checked) {
        $logTextBox.AppendText("Killing Opera Processes...`n")
        Stop-Process -Name "opera" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }

    # Kill Opera GX Processes
    if ($chkKillProcessesGX.Checked) {
        $logTextBox.AppendText("Killing Opera GX Processes...`n")
        Stop-Process -Name "opera" -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }

    # Uninstall Opera
    if ($chkUninstallOpera.Checked) {
        $logTextBox.AppendText("Uninstalling Opera...`n")
        Remove-Item "$UserPath\AppData\Local\Programs\Opera" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$UserPath\AppData\Roaming\Opera Software" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }


    # Uninstall OperaGX
    if ($chkUninstallOperaGX.Checked) {
        $logTextBox.AppendText("Uninstalling Opera...`n")
        Remove-Item "$UserPath\AppData\Local\Programs\Opera GX" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "$UserPath\AppData\Roaming\Opera Software" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }

     
    # Reinstall Opera
    if ($chkReinstallOpera.Checked) {
        $logTextBox.AppendText("Reinstalling Opera...`n")
        InstallSetup -DownloadUrl "https://net.geo.opera.com/opera/stable/edition/std?utm_source=utod&utm_medium=pb&utm_campaign=organic"
        Start-Sleep -Seconds 2
    }

    # Reinstall Opera GX
    if ($chkReinstallOperaGX.Checked) {
        $logTextBox.AppendText("Reinstalling Opera GX...`n")
        InstallSetup -DownloadUrl "https://net.geo.opera.com/opera_gx/stable/edition/std-2?utm_source=utod&utm_medium=pb&utm_campaign=organic"
        Start-Sleep -Seconds 2
    }

    # Launch Opera
    if ($chkLaunchOpera.Checked) {
        $logTextBox.AppendText("Launching Opera...`n")
        Start-Process "$UserPath\AppData\Local\Programs\Opera\opera.exe" -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2

    }

    # Launch Opera GX
    if ($chkLaunchOperaGX.Checked) {
        $logTextBox.AppendText("Launching Opera GX...`n")
        Start-Process "$UserPath\AppData\Local\Programs\Opera GX\opera.exe" -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }

    # Delete Installers
    if ($chkDeleteInstallerOpera.Checked -or $chkDeleteInstallerGX.Checked) {
        $operaInstallerPath = "$UserPath\Downloads\OperaSetup*.exe"
        $operaGXInstallerPath = "$UserPath\Downloads\OperaSetup*.exe"

        if ($chkDeleteInstallerOpera.Checked -and (Test-Path $operaInstallerPath)) {
            Remove-Item $operaInstallerPath -Force
            $logTextBox.AppendText("Deleted Opera installer.`n")
        } elseif ($chkDeleteInstallerOpera.Checked) {
            $logTextBox.AppendText("No Opera installer found.`n")
        }

        if ($chkDeleteInstallerGX.Checked -and (Test-Path $operaGXInstallerPath)) {
            Remove-Item $operaGXInstallerPath -Force
            $logTextBox.AppendText("Deleted Opera GX installer.`n")
        } elseif ($chkDeleteInstallerGX.Checked) {
            $logTextBox.AppendText("No Opera GX installer found.`n")
        }
        Start-Sleep -Seconds 2
    }

    $logTextBox.AppendText("Process Completed.`n")
}

# Close Button
$btnClose = CreateButton "Close" 370 580 {
    $form.Close()
}

# Add Buttons to the Form
$form.Controls.Add($btnExecute)
$form.Controls.Add($btnClose)

# Show the Form
$form.ShowDialog()

[System.Windows.Forms.Application]::Exit()
