$Password_assignment = ConvertTo-SecureString 'JakieTamHasloJest1!8&%' -AsPlainText -Force
New-LocalUser "Test_01" -Password $Password_assignment -FullName "Test Provisioning" -Description "Test user"
Add-LocalGroupMember -Group "Administrators" -Member "Test_01"
