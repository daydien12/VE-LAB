import socketio
import time
import sys 
import re

# standard Python
sio = socketio.Client()

@sio.event
def connect():
        print("I'm connected!")
        #sio.emit('message', 'Hello world\n')

@sio.on('handshake')
def on_message(data):
        print('HandShake', data)

@sio.event
def message(data):
        print('I received a message!')

sio.connect('http://localhost:4040')

workspaceurl = re.sub("@[0-9]","", sys.argv[4])

sendMsg = {"BuildID":sys.argv[1], "Branch":sys.argv[2], "CommitID":sys.argv[3] , "Workspace":workspaceurl}

time.sleep(1)
sio.emit('message', sendMsg)
time.sleep(1.5)
