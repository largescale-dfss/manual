if [ -d app ] ; then
    rm -rf app
fi

mkdir app
git clone git@github.com:largescale-dfss/RPC-server-client.git app/RPC-server-client
git clone git@github.com:largescale-dfss/distributed-file-system.git app/distributed-file-system
git clone git@github.com:largescale-dfss/django-file-custom-storage.git app/django-file-custom-storage
git clone git@github.com:largescale-dfss/manager.git app/manager
git clone git@github.com:largescale-dfss/concept-demo.git app/concept-demo