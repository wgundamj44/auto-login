#!/usr/bin/expect -f
set user [lindex $argv 0]
set host [lindex $argv 1]
# pass is in the format: host\tuser\tpassword
set fp [open "~/private/pass" r]
set file_data [read $fp]
close $fp
set data [split $file_data "\n"]
foreach line $data {
    if {[regexp [subst -nocommands -nobackslashes {($host)	($user)	(\w+)}] $line t0 t1 t2 t3]} {
        set password $t3
        spawn ssh "${user}\@${host}"
        expect "assword:"
        send "${password}\r"
        interact
    }
}

