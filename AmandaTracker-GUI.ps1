Add-type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$DataFile = Join-Path $PSScriptRoot "TimeBlocks.json"



$ScheduledHours = 8
$AccountedHours = 0
$RemainingHours = $ScheduledHours - $AccountedHours

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Amanda Operations Tracker"
$Form.Width = 800
$Form.Height = 600

$ScheduledLabel = New-Object System.Windows.Forms.Label
$ScheduledLabel.Text = "Scheduled Hours: $ScheduledHours"
$ScheduledLabel.Location = New-Object System.Drawing.Point(30, 30)
$ScheduledLabel.AutoSize = $true
$ScheduledLabel.Font = New-object System.Drawing.Font("Segoe UI", 14)

$AccountedLabel = New-Object System.Windows.Forms.Label
$AccountedLabel.Text = "Accounted Hours: $AccountedHours"
$AccountedLabel.Location = New-Object System.Drawing.Point(30, 80)
$AccountedLabel.AutoSize = $true
$AccountedLabel.Font = New-Object System.Drawing.Font("Segoe UI", 14)

$RemainingLabel = New-Object System.Windows.Forms.Label
$RemainingLabel.text = "Remaining Hours: $RemainingHours"
$RemainingLabel.Location = New-Object System.Drawing.Point(30, 130)
$RemainingLabel.Autosize = $true
$RemainingLabel.Font = New-Object System.Drawing.Font("Segoe UI", 14)

$Form.Controls.Add($ScheduledLabel)
$Form.Controls.Add($AccountedLabel)
$Form.Controls.Add($RemainingLabel)

$ReminderTimer = New-Object System.Windows.Forms.Timer
$ReminderTimer.Interval = 1000


$LogButton = New-Object System.Windows.Forms.Button
$LogButton.Text = "+ Log Work Block"
$LogButton.Location = New-Object System.Drawing.Point(30, 200)
$LogButton.Size = New-Object System.Drawing.Size(180, 45)

$Form.Controls.Add($LogButton)

$LogButton.Add_Click({

    $EntryForm = New-Object System.Windows.Forms.Form
    $EntryForm.Text = "New Work Block"
    $EntryForm.Width = 600
    $EntryForm.Height = 650
    $EntryForm.StartPosition = "CenterParent"

    $CategoryLabel = New-Object System.Windows.Forms.Label
    $CategoryLabel.Text = "Category"
    $CategoryLabel.Location = New-Object System.Drawing.Point(20, 20)
    $CategoryLabel.AutoSize = $true

    $CategoryBox = New-Object System.Windows.Forms.ComboBox
    $CategoryBox.Location = New-Object System.Drawing.Point(20, 45)
    $CategoryBox.Size = New-Object System.Drawing.Size(530, 30)
    $CategoryBox.DropDownStyle = "DropDownList"

    [void]$CategoryBox.Items.AddRange([object[]]@(
        "Direct EU Support",
        "Software Troubleshooting",
        "Hardware Support",
        "Project Work",
        "Administrative",
        "Lunch",
        "Other"
    ))

    $CategoryBox.SelectedIndex = 0
    
    $EntryForm.Controls.Add($CategoryLabel)
    $EntryForm.Controls.Add($CategoryBox)

    $TypeLabel = New-object System.Windows.Forms.Label
    $TypeLabel.Text = "Activity Type"
    $TypeLabel.Location = New-Object System.Drawing.Point(20, 90)
    $TypeLabel.AutoSize = $true

    $TypeBox = New-Object System.Windows.Forms.ComboBox
    $TypeBox.location = New-Object System.Drawing.Point(20, 115)
    $Typebox.Size = New-Object System.Drawing.Size(530, 30)
    $TypeBox.DropDownStyle = "DropDown"

    [void]$TypeBox.Items.AddRange([object[]]@(
        "Ticket Queue Management"
        "Software Troubleshooting"
        "User Assistance"
        "Access Management"
        "Deployment"
        "Documentation"
        "Follow-up"
        "Other"
    ))

    $EntryForm.Controls.Add($TypeLabel)
    $EntryForm.Controls.Add($TypeBox)

    $SpecificsLabel = New-Object System.Windows.Forms.Label
    $SpecificsLabel.text = "Specifics - What did you accomplish"
    $SpecificsLabel.Location = New-Object System.Drawing.Point(20, 165)
    $SpecificsLabel.AutoSize = $true

    $SpecificsBox = New-Object System.Windows.Forms.TextBox
    $SpecificsBox.location = New-object system.drawing.point(20, 190)
    $SpecificsBox.Size = New-Object System.Drawing.Size(530, 170)
    $SpecificsBox.Multiline = $true
    $SpecificsBox.ScrollBars = 'Vertical'

    $EntryForm.Controls.Add($SpecificsLabel)
    $EntryForm.Controls.Add($SpecificsBox)

    $SaveButton = New-Object System.Windows.Forms.Button
    $SaveButton.Text = "Save Work Block"
    $SaveButton.Location = New-Object System.Drawing.Point(20, 390)
    $SaveButton.Size = New-Object System.Drawing.Size(180, 45)

    $EntryForm.Controls.Add($SaveButton)

    $Savebutton.Add_Click({

        $Category = $Categorybox.Text.trim()
        $ActivityType = $TypeBox.Text.Trim()
        $Specifics = $SpecificsBox.Text.Trim()

            if ([string]::IsNullOrWhiteSpace($Category) -or
                [string]::IsNullOrWhiteSpace($ActivityType) -or
                [string]::IsNullOrWhiteSpace($Specifics)) {

                    [System.Windows.Forms.MessageBox]::Show(
                        "Please complete Category, Activity Type, and Specifics"
                    )
                    return
                }

                $WorkBlock = [PSCustomObject]@{
                    Date = (Get-Date).ToString("yyyy-MM-dd")
                    Time = (Get-date).ToString("HH:mm")
                    Category = $Category
                    Type = $ActivityType
                    Specifics = $Specifics
                    DurationMinutes = 30
                }

                $AllBlocks = @()

                if(Test-Path $DataFile) {
                    $ExistingData = Get-Content $DataFile -Raw | ConvertFrom-Json
                    $AllBlocks = @($ExistingData)
                }
                
                $AllBlocks += $WorkBlock

                ConvertTo-Json -InputObject $AllBlocks -Depth 5 |
                    Set-Content -Path $DataFile -Encoding UTF8
                
                [void][System.Windows.Forms.MessageBox]::Show(
                    "Work Block Saved Successfully"
                )

                $EntryForm.Close()

            })

       
    [void]$EntryForm.ShowDialog($Form)
})

[void]$form.ShowDialog()

