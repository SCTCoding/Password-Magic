#! /bin/bash

#Copyright (c) 2016, Simon Carlson-Thies
#All rights reserved.

#Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

#1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

#2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the 
#documentation and/or other materials provided with the distribution.

#3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software 
#without specific prior written permission.

#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
#THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS 
#BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
#GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
#LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
#DAMAGE.

echo "THIS SCRIPT WORKS WITH COMPUTERS RUNNING OS 10.8-10.12 ONLY."
echo ""
echo "THIS SCRIPT MUST BE RUN FROM AN ADMINISTRATOR ACCOUNT ON THE BOOT"
echo "VOLUME OF THE PASSWORD TO BE MOVED OUT OF THE WAY."
echo ""
echo ""

username=$(whoami)

#Data Collection
read -p "What is the password for $username? " password
read -p "What is the name of the user who's password needs to be moved? " target

echo ""
echo "Backing Up User File"
echo ""

#Backup User File
echo $password | sudo -S cp /var/db/dslocal/nodes/Default/users/$target.plist /Users/$username/Desktop/

echo "Backup Complete"
echo ""
echo "Converting PLIST to XML"
echo ""

#Convert To XML
echo $password | sudo -S plutil -convert xml1 /var/db/dslocal/nodes/Default/users/$target.plist

echo "Conversion Complete"
echo ""
echo "Fixing Password To mm"
echo ""

echo $password | sudo -S plutil -replace ShadowHashData.0 -data "YnBsaXN0MDDRAQJfEBRTQUxURUQtU0hBNTEyLVBCS0RGMtMDBAUGBwhXZW50cm9weVRzYWx0Wml0ZXJhdGlvbnNPEICWHJt3rUCfD8S7OmHkLvSyI+pe3Lu5EUgcZ10yYDMSEIGUKN5ksKr31c70RpYPUKY+4rD13C//Fxtn9SIZIz5I3ISlZ7AhoMfbJwbhor6lpRBcQU2JUSifdXTzOARNje0rm1Cm4B13fuD6DN27q1lmqreOuqqlPKAdjOzE10lkg08QIN3cN9urqmj5HByZr2tIUwzw3J06aOxQMadQQGivpWeBEaAXCAsiKTE2QcTnAAAAAAAAAQEAAAAAAAAACQAAAAAAAAAAAAAAAAAAAOo=" /var/db/dslocal/nodes/Default/users/$target.plist

echo "Converting PLIST to Binary"
echo ""

#Convert Back To Binary
echo $password | sudo -S plutil -convert binary1 /var/db/dslocal/nodes/Default/users/$target.plist

echo "Conversion Complete"

#history -c

exit
