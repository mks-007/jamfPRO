#!/bin/bash


JAMF='/usr/local/bin/jamf'
password=$5
LocalAdmin=$4
CName=`scutil --get ComputerName`


# Add Local admin Account
		User=`${JAMF} listUsers -showAll | grep  "<name>$LocalAdmin</name>" | wc -l`
				
		if [ ${User} -eq 1 ]; then 

		echo "Finalizing-Script: User $LocalAdmin exists Deleting Account"
		${JAMF} deleteAccount -username $LocalAdmin -deleteHomeDirectory
		
		deleteAccount -username $LocalAdmin -deleteHomeDirectory
		
		
		fi
		
		echo "Creating Admin Account $LocalAdmin"
		defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool YES
		${JAMF}  createAccount -username $LocalAdmin -realname "Local-MacAdmin" -password $password -admin -hiddenUser
		
		User=""
		User=`${JAMF} listUsers -showAll | grep  "<name>$ManagedAccount</name>" | wc -l`
		if [ ${User} -eq 1 ]; then 
			echo "Admin Account $LocalAdmin Created"
			exit 0
		else
			echo "Admin Account $LocalAdmin Failed"
			exit 1
		fi
		
