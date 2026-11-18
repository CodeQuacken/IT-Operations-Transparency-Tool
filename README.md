# IT Operations Transparency Tool

A PowerShell-based operations tracker designed to document technician workloads, highlight Level 3 IT complexity, and make the value of IT operations more visible.

## Project Overview

The IT Operations Transparency Tool is a Windows desktop application developed to capture and organize how IT technicians spend their time.

Traditional ticket counts don't always communicate the full scope of IT operations. Troubleshooting, infrastructure support, project work, access management, and administrative responsibilities all contribute to the daily workload.

This project aims to make those activities more visible by recording work in structured 30-minute blocks.

## Project Objectives

- Improve visibility into technician workloads.
- Document work beyond traditional Tier 1 and Tier 2 support.
- Capture the types of activities performed throughout the workday.
- Create a structured record of operational contributions.
- Explore how workload data can demonstrate the value of IT operations.

## Current Features

The application currently includes:

- **Windows Forms GUI:** A graphical PowerShell desktop application.
- **Work Block Entry:** A separate form for recording work activities.
- **Category Selection:** Predefined work categories.
- **Activity Classification:** Suggested activity types with support for custom entries.
- **Work Descriptions:** Multiline field for documenting accomplishments and specifics.
- **Input Validation:** Required-field checks before saving.
- **JSON Persistence:** Work records are saved locally to `TimeBlocks.json`.
- **Existing Record Support:** Existing JSON records are loaded before new entries are appended.

### Work Categories

- Direct EU Support
- Software Troubleshooting
- Hardware Support
- Project Work
- Administrative
- Lunch
- Other

## Technology Stack

| Technology | Purpose |
|---|---|
| PowerShell | Application logic and automation |
| Windows Forms | Desktop graphical interface |
| .NET System.Drawing | GUI layout and styling |
| JSON | Local data storage |
| Visual Studio Code | Development environment |
| Git / GitHub | Source control and project documentation |

## Data Storage

Work records are stored locally in `TimeBlocks.json` alongside the application script.

Each record contains:

- Date
- Time
- Category
- Activity Type
- Specifics
- Duration in minutes

The application currently assigns a duration of 30 minutes to each saved work block.

**Privacy:** `TimeBlocks.json` is excluded through `.gitignore`. Real workplace, customer, or company-sensitive information should never be committed to this public repository.

## Development Roadmap

The project is actively being developed. Planned improvements include:

- [ ] Automatic work-entry prompts every 30 minutes.
- [ ] Duplicate reminder prevention.
- [ ] Dynamic dashboard calculations using saved JSON records.
- [ ] Live scheduled, accounted, and remaining hour totals.
- [ ] Daily progress indicators.
- [ ] Recent work activity display.
- [ ] Professional GUI redesign.
- [ ] Daily and categorized activity reports.
- [ ] Improved error handling and data validation.

## Project Status

**In Development**

The initial Windows Forms interface, work-entry workflow, input validation, and JSON storage implementation are in place.

Dashboard calculations, automatic reminders, reporting, and further interface improvements remain under development.

## Project Documentation

See [Development Notes](Development_Notes.md) for additional technical details, implementation history, and development milestones.

---

*Built as a hands-on PowerShell development project focused on IT operations, automation, workload visibility, and practical application development.*
