# IT Operations Tracker --- Development Notes

## Project Details

- **Project:** IT Operations Tracker
-  **Main Script:** 'AmandaTracker-GUI.ps1'
-  **Runtime data file:** `TimeBlocks.json`
-  **Language / GUI:** PowerShell / Windows Forms
-  **Editor:** Visual Studio Code
-  **Platform:** Windows
-  **Status:** In development

## 1. Startup and data path

The script loads `System.Windows.Forms` and `System.Drawing`, then
defines the data path:

``` powershell
$DataFile = Join-Path $PSScriptRoot "TimeBlocks.json"
```

The JSON file is expected beside the PowerShell script.

## 2. Workday values

The source initializes:

``` powershell
$ScheduledHours = 8
$AccountedHours = 0
$RemainingHours = $ScheduledHours - $AccountedHours
```

These values are used to populate the dashboard. Accounted hours are not
yet calculated from saved work blocks, and the labels are not
recalculated after a save.

## 3. Main dashboard

The script creates a Windows Forms window titled
`Amanda Operations Tracker`, sized 800 × 600. It adds three labels:
Scheduled Hours, Accounted Hours, and Remaining Hours. It also adds a
**Log Work Block** button.

The labels display values set when the form is created. They are not yet
connected to live calculations.

## 4. Work-entry form

The Log Work Block button has an `Add_Click` event handler that creates
a separate modal form titled `New Work Block`, sized 600 × 650 and
centered relative to the parent.

### Category

A ComboBox with `DropDownList` style, containing seven options:

1.  Direct EU Support
2.  Software Troubleshooting
3.  Hardware Support
4.  Project Work
5.  Administrative
6.  Lunch
7.  Other

The first category is selected by default.

### Activity Type

An editable ComboBox with these suggested values:

1.  Ticket Queue Management
2.  Software Troubleshooting
3.  User Assistance
4.  Access Management
5.  Deployment
6.  Documentation
7.  Follow-up
8.  Other

Because its style is `DropDown`, users can type a custom activity type.

### Specifics

A multiline TextBox with a vertical scrollbar and the prompt
`Specifics - What did you accomplish`.

### Save button and validation

The Save Work Block button reads the Category, Activity Type, and
Specifics values and trims whitespace. It checks all three with
`[string]::IsNullOrWhiteSpace()`. If any is blank, it displays a
validation message and returns without saving.

## 5. Work-block data object

After validation, the script creates a `[PSCustomObject]` with these
properties:

  Property            Purpose
  ------------------- ---------------------------------
  `Date`              Date formatted as `yyyy-MM-dd`
  `Time`              Time formatted as `HH:mm`
  `Category`          Selected category
  `Type`              Selected or typed activity type
  `Specifics`         User's description
  `DurationMinutes`   Fixed at 30 minutes

The current source calls `Get-Date` separately for Date and Time. A
future refinement could capture one timestamp and derive both values
from it.

## 6. JSON persistence

The save handler initializes an empty array. If the data file exists, it
reads the file with `Get-Content -Raw`, converts JSON to PowerShell
objects with `ConvertFrom-Json`, and wraps the result in an array.

It appends the new record and writes the collection back using
`ConvertTo-Json -Depth 5` piped to `Set-Content -Encoding UTF8`.

The script then displays a success message and closes the entry form.

This describes the persistence implementation in the supplied source.
Test it on Windows with fictional data before claiming runtime
verification. Error handling for malformed or unreadable JSON has not
yet been added.

## 7. Reminder timer --- partially prepared

The source creates a Windows Forms timer and sets:

``` powershell
$ReminderTimer.Interval = 1000
```

That configures a one-second interval. The source does not yet attach a
`Tick` event handler, check for minute `00` or `30`, suppress duplicate
reminders, display a reminder, or call `$ReminderTimer.Start()`. The
reminder feature is therefore not operational yet.

## 8. Feature inventory

### Present in the supplied source

-   [x] Load Windows Forms and Drawing assemblies.
-   [x] Define a JSON data-file path beside the script.
-   [x] Define an eight-hour scheduled day.
-   [x] Create the main dashboard and three time labels.
-   [x] Create the Log Work Block button.
-   [x] Create the New Work Block dialog.
-   [x] Create Category and Activity Type dropdowns.
-   [x] Create the multiline Specifics field.
-   [x] Validate required fields.
-   [x] Create a custom work-block object.
-   [x] Assign a fixed 30-minute duration.
-   [x] Read existing JSON records.
-   [x] Append a new record and write JSON.
-   [x] Create a timer and set a one-second interval.

### Not yet implemented in the supplied source

-   [ ] Calculate accounted hours from saved records.
-   [ ] Calculate remaining hours from actual accounted time.
-   [ ] Decide and implement whether Lunch is excluded from totals.
-   [ ] Refresh dashboard labels after saving.
-   [ ] Attach the timer Tick event.
-   [ ] Detect `:00` and `:30`.
-   [ ] Prevent duplicate reminders within a minute.
-   [ ] Start the timer and restrict it to intended work hours.
-   [ ] Generate daily activity reports.
-   [ ] Add robust error handling for JSON read/write failures.

## 9. Recommended next development sequence

### Mission 005 --- Complete reminders

1.  Add a timer `Tick` event handler.
2.  Read the current time on each tick.
3.  Detect minute `00` or `30`.
4.  Track the last reminder timestamp to prevent duplicates.
5.  Display the reminder prompt.
6.  Start the timer before the main form's `ShowDialog()` call.
7.  Test on Windows.

### Next --- Calculate dashboard totals

1.  Read today's entries from JSON at startup.
2.  Filter records to today's date.
3.  Sum the applicable `DurationMinutes`.
4.  Convert minutes into hours for display.
5.  Calculate remaining time.
6.  Refresh labels after a successful save.
7.  Test normal work entries and Lunch entries.

### Later --- Daily reporting

Summarize time by Category and Activity Type, with totals and a readable
export format.

## 10. GitHub publishing checklist

-   [ ] Review the source for internal company details, credentials,
    usernames, and sensitive paths.
-   [ ] Keep real `TimeBlocks.json` records out of the public
    repository.
-   [ ] Add `.gitignore` rules for local data and logs.
-   [ ] Test the application on Windows.
-   [ ] Add a dashboard screenshot.
-   [ ] Update this document as features are implemented and tested.

## Learning outcomes

The current source demonstrates loading .NET assemblies, creating
Windows Forms controls, handling click events, opening modal forms,
validating input, creating PowerShell custom objects, formatting
date/time values, reading and writing JSON, and preparing a timer-driven
feature.
