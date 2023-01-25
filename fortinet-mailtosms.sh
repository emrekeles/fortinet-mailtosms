#!/bin/bash
while true; do
        for email_file in $(ls /home/vmail/sms.emrekeles.com/catch-all/Maildir/new/ ); do
                if [[ ! -f $email_file ]]
                then
                        to=$(grep "To:" /home/vmail/sms.emrekeles.com/catch-all/Maildir/new/"$email_file" | sed 's/To: //' |tail -1 | awk -F"@" '{print $1}')
                        body=$(sed -n '/^$/ {n; :loop p; n; /^$/ b loop}' /home/vmail/sms.emrekeles.com/catch-all/Maildir/new/"$email_file" )
                        contents=$(echo "$body" | base64 --decode | sed 's/\. //' | grep -oP '([0-9]+)')
                        #curl smsgateway                    
                        rm -rf /home/vmail/sms.emrekeles.com/catch-all/Maildir/new/"$email_file"
                fi
    done
done
