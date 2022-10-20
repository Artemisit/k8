for (( i=1; i<=255; i++ ))
do
    lookup=$(nslookup "host$i.k8.local")
    if [ $? -eq 1 ]
    then
        echo "host$i.k8.local does not exist"
        ADDR=`/sbin/ifconfig ens192 | grep 'inet' | grep -v 'inet6'| awk '{print $2}'`
        HOST="host$i.k8.local"
        echo "update delete host$i.k8.local A" > /var/nsupdate.txt
        echo "update add host$i.k8.local 86400 A $ADDR" >> /var/nsupdate.txt
        echo "update delete host$i.k8.local PTR" >> /var/nsupdate.txt
        echo "update add host$i.k8.local 86400 PTR $ADDR" >> /var/nsupdate.txt
        echo "send" >> /var/nsupdate.txt
        nsupdate /var/nsupdate.txt
        break
    else
    echo "blah"
    fi
done
