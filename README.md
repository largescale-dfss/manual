# Distributed File Storage System

### Description

**Project**: Distributed File System with optional support for compression and version control.

**Project Design**: The development of the DFS system will be split into multiple parts so we can abstract each layer. We will possibly be using a combination of Python and C/C++, and the possible frameworks/libraries we would be utilizing will be Django and gRPC.

The distributed file system will be a two tier file system consisting of one master node and multiple data nodes developed in Python or C++. It will be designed as a shadow file system, so a majority of the function calls for I/O operations will just be overloaded functions designed to communicate with our RPC system. The master node will be responsible for creating the directory structure that stores the metadata. The file location in the master node will have a text file storing the data node and block number for each block. The data node will store the physical file which will be split into blocks distributed over many data nodes. The maximum block size is 1MB. The data blocks will be replicated 3 times, so that if a data node server is down, we can still retrieve the data blocks from the next available server. An additional feature is a multiple version file system that will only allow read and store operations. A new version of a file will be created each time the file has been [update/change -> replaced] resulting in a store operation.

The development of the gRPC will be done in Python. Since we are developing a multi-tier distributed file system there will be multiple RPC servers. The first such server, will be a RPC communicating between the client and the Master node. This allows the client to send operations to the Master node, in this case, the client will send a read operation with the metadata of the specific file the client desires to read. At this point, the Master node receives the first RPC and reply back with an array of the data node and block number for the file. The second RPC is designed to communicate between the client and data nodes. The client will request the blocks from the blocks from the data nodes and the data nodes will send the blocks to the client. The client will reconstruct the file in order of the array of the data number.

Finally we will develop a proof of concept web application in Django. This web application will be a applicant tracker that allows applicants to apply for a job for a specific company. When a user uploads their resume it pass the file name, file and timestamp to the storage system save function. Django will generate a hyperlink that will the user to view the resume and select the version(date) to view. When a user selects a date, the name of file and date will be sent to Django and read the upload path from the models. Then the Django will invoke a remote procedure call to the file system sending Read(name, timestamp).
In order to allow Django to talk to the DFS via gRPC, we will build a python module on top of Django to be in charge of making read, write, and update calls to the DFS. This will allow streamlined linking with Django and will allow easier debugging, since we can create a separate main.py file just to make sure that our RPC calls are getting through.

A naive way of implementing the multiple version file system would be to create a new copy of the file every time it is updated. A file named foo.txt would be marked with a timestamp as foo.txt@012231313 with seconds after the unix epoch stamped after the text file. In our masternode, all files will be timestamped and stored in the directory where foo.txt is located. Example: all resume@timestamp will be stored under /user/resume@timestamp. foo.txt If no timestamp is requested for, the most recent file should be returned.

Furthermore, we will be using Django’s custom file storage layer to interact with our DFS. [Communication to separate python file library]

Given our description above, there are four parts to our system:

- `Django file custom storage`
- `RPCs Server & Client`
- `Manager`
- `Distributed File System`

### How to run this application

1. Run `init.sh` to process and clone the repositories.
2. The sample user is `demo`, and password is `123abc`.
