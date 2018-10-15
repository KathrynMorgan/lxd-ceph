
#su - cadmin -c "ssh-keygen"
#cat /home/cadmin/.ssh/id_rsa.pub >> /home/cadmin/.ssh/authorized_keys 

sudo curl http://canonical:ubuntu@ppa.braincraft.io/configure/xenial/install.sh | bash
echo "cadmin ALL = (root) NOPASSWD: ALL" | tee /etc/sudoers.d/cadmin
chmod 0440 /etc/sudoers.d/*
chown cadmin:cadmin /home/cadmin/.ssh/*
chmod 644 /home/cadmin/.ssh/*
apt install ntp ntpdate -y
export lxd_fqdn=$(cat /etc/hostname)
echo "$lxd_fqdn.braincraft.io" >/etc/hostname
echo "127.0.1.1 $lxd_fqdn.braincraft.io" >> /etc/hosts
systemctl start sshd
systemctl status sshd
