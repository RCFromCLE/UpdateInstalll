InstallUpdatesFromSCCM.ps1
=======================

This PowerShell script installs software updates on Windows machines using WMI. The script allows targeted patching based on specific criteria like the evaluation state and the name of the update.

#### Note: This script has not been tested. Testing is needed to validate its function.

Usage

-----

To use the script, provide the path to a CSV containing computer names. 

Optionally, you can specify filters for the software updates you want to apply.

Install updates using default settings:
`Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv"`

Install updates with filters:
`Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv" -SupName "Security"`

`Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv" -AppEvalState "Available" -SupName "Security"`

### CSV Format

The CSV should have a column named `ComputerName` with a list of the computer names:

`ComputerName
Computer1
Computer2
...`

Filtering Software Updates
--------------------------

### `$AppEvalState` (appeval)

-   **Purpose**: Filters software updates based on their `EvaluationState` property.

-   **Description**: The `EvaluationState` often indicates the current status of a software update, such as whether it's available, installed, required, etc.

-   **Example**: If you only want to install updates that are in an "Available" state, you'd set:

-   `$AppEvalState = "Available"`

    Note: The actual values for `EvaluationState` might differ based on your environment and software. Always consult your system's documentation or output to determine the exact states.

### `$SupName` (upname)

-   **Purpose**: Filters software updates based on their `Name` property.

-   **Description**: This allows you to target specific updates by looking for keywords or patterns in the update's name.

-   **Example**: If you want to install only updates that have the term "Security" in their name, you'd set:

`$SupName = "Security"`

This will target updates like "Security Update for Windows", "Security Patch for XYZ", etc.