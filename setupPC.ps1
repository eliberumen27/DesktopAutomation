# Title: Automated Dell Laptop Setup
#  
# Date: January 2021
#
# Author: Elijah Berumen


try {
# Check for model

$model = wmic computersystem get manufacturer

    if ($model -eq "Dell") {
        # Apply Pulse Fix
        
        $adapter = Get-NetAdapterRsc | select Name
        
        $adapter= $adapter-replace ".*=" -replace "}",""
        
        Disable-NetAdapterRsc -Name $adapter
        
        # Check Bitlocker volume and output the status of C:\
        
        echo "Pulse Fix Applied"
        
        $bitlocker = Get-BitLockerVolume | select ProtectionStatus
        
        echo "C:\ Bitlocker Protection Status:"
        
        echo $bitlocker[1] "`n"
        
        # Launch DisplayLink update
        
        echo "Launching DisplayLink Update"
        
        Start-Process -FilePath 'DisplayLink USB Graphics Software for Windows 9.2 M0.exe'
        
        Start-Sleep -Seconds 15
        
        # Launch Dell Command Update Utility
        
        echo "Dell Command Update Utility only installs driver updates for the current user only(no need to install as OptivAdmin...)"
        
        Start-Process -FilePath 'Dell-Command-Update_Y2KWD_WIN_3.0.1_A00.EXE'
        
        # Set Script Execution Policy back to restricted
        
        Set-ExecutionPolicy Restricted
        
        # TODO 
        # Make the driver installer file paths variables for modularity/reusability...also find the newest driver installers, and look into the flags to do 
        # silent installations
        # Look into checking for Windows updates and setting default apps???
        # anything else?
        }
    elseif ($model -eq "Lenovo") {
        # Insert what we have for Lenovos here
}
}

catch {
    echo "Sorry..something went wrong, or there's no support for that machine yet!"
}