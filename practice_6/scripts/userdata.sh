#!/bin/bash
echo 'This is a message using User Data / root user' > ~/README.txt
echo 'This is a message using User Data / ec2-user user' > /home/ec2-user/README.txt
echo "IP details: $(ip a s)" >> /home/ec2-user/network.txt

#Change permissions
chown ec2-user:ec2-user /home/ec2-user/README.txt
chown ec2-user:ec2-user /home/ec2-user/network.txt