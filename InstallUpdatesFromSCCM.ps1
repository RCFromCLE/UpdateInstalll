# Author: Rudy Corradetti
# Date: 8/15/2023

# function to install patches on computers from a provided CSV file
function Install-PatchesFromCSV {

    # Parameters for the function:
    # CSVPath: Path to the CSV file containing computer names. This parameter is mandatory.
    # AppEvalState: A filter for the evaluation state of the application. Default is wildcard '*'.
    # SupName: A filter for the name of the software update. Default is wildcard '*'.
    param (
        [Parameter(Mandatory = $true)]
        [string]$CSVPath,
        [string]$AppEvalState = '*',
        [string]$SupName = '*'
    )

    # Import the list of computer names from the specified CSV file
    # Assuming the CSV has a column named 'ComputerName' for the computer names
    $ComputerNames = Import-Csv -Path $CSVPath | ForEach-Object { $_.ComputerName }

    # Loop through each computer from the list
    foreach ($Computer in $ComputerNames) {

        # Provide feedback on which computer is currently being processed
        Write-Host "Processing $Computer..."

        # Use a try-catch block to handle any errors that might occur during the patching process
        try {
            
            # Fetch software update information using WMI from the current computer, based on the provided filters
            $Application = Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate -ComputerName $Computer |
            Where-Object { $_.EvaluationState -like "*$($AppEvalState)*" -and $_.Name -like "*$($SupName)*" }

            # Check if there are any applications that matched the criteria
            if ($Application) {
                # If matched applications are found, invoke the method to install the updates
                Invoke-WmiMethod -Class CCM_SoftwareUpdatesManager -Name InstallUpdates -ArgumentList (, $Application) -Namespace root\ccm\clientsdk -ComputerName $Computer
                # Provide feedback on successful patching
                Write-Host "$Computer patched successfully!"

            }
            else {

                # Inform the user if no updates matched the criteria
                Write-Host "No updates matched the criteria on $Computer."
            }

        }
        catch {

            # If any errors occur, display them to the user
            Write-Host "Error processing ${Computer}: $_"
        }
    }
}
# run the function with the CSV file as the parameter
Install-PatchesFromCSV -CSVPath "ServersToUpdate.csv"