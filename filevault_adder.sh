#!/bin/zsh 

expect -c "
spawn fdesetup add -usertoadd $userName
expect "Enter the primary user name:"
send ${adminName}
expect "Enter the password for the user '$adminName':"
send ${adminPass}
expect "Enter the password for the added user '$userName':"
send ${userPass}
expect



#expect -c "
#spawn fdesetup add -usertoadd teacher
#expect "Enter the primary user name:"
#send ${adminName}
#expect "Enter the password for the user '$adminName':"
#send ${adminPass}
#expect "Enter the password for the added user 'teacher':"
#send ${userPass}
#expect
