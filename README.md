InstallUpdatesFromSCCM.ps1
=======================

This PowerShell script installs software updates on Windows machines using WMI. The script allows targeted patching based on specific criteria like the evaluation state and the name of the update.

#### Note: This script has not been tested. Testing is needed to validate its function.

Usage
-----

Before executing any commands, ensure that you navigate to the working directory where the patching script is located. This will ensure the script functions as expected.

To effectively use the script, you will need to supply a path to a CSV file containing the names of the computers you intend to update. Additionally, the script provides the option to fine-tune which software updates are applied based on specific criteria.

### Navigating to the Script's Directory

You can navigate to the script's directory using the `cd` (change directory) command in your PowerShell terminal:

`cd path\to\script\directory`

Replace `path\to\script\directory` with the actual path to the directory containing your script.

### Default Usage

To apply updates using the script's default settings (i.e., without any specific filters), use the following command:

- `Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv"`

### Filtering Updates

You can hone in on specific software updates by specifying filters. Below are some examples demonstrating this:

**Applying updates with a specific keyword in their name** (e.g., "Security"):

 - `Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv" -SupName "Security"`

**Combining multiple filters** (e.g., targeting updates that are "Available" and have "Security" in their name):

   - `Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv" -AppEvalState "Available" -SupName "Security"`

### CSV Format

Ensure that your CSV file follows the format illustrated below. It should possess a single column named `ComputerName` enumerating the computer names:

`ComputerName
Computer1
Computer2
...`

* * * * *