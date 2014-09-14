cd /opt/IBM/WebSphere/AppServer/bin
./startServer.sh server1

while ( true )
    do
    echo "Detach with Ctrl-p Ctrl-q. Dropping to shell"
    sleep 1
    /bin/bash
done
