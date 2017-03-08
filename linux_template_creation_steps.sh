#### Linux template creation steps#####
##Author : Santhosh Kumar Poturaju
#Version : 1.0.0

#Stop logging services.
/sbin/service rsyslog stop
/sbin/service auditd stop

#Remove old kernels
/bin/package-cleanup --oldkernels --count=1

#Clean out yum.
/usr/bin/yum clean all

#Force the logs to rotate & remove old logs we don’t need.
/usr/sbin/logrotate –f /etc/logrotate.conf
/bin/rm –f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda

#Truncate the audit logs (and other logs we want to keep placeholders for).
/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby

#Remove the udev persistent device rules
/bin/rm -f /etc/udev/rules.d/70*

#Remove the traces of the template MAC address and UUIDs.
/bin/sed -i ‘/^(HWADDR|UUID)=/d’ /etc/sysconfig/network-scripts/ifcfg-eth0

#Clean /tmp out.
/bin/rm –rf /tmp/*
/bin/rm –rf /var/tmp/*

#Remove the SSH host keys.
/bin/rm –f /etc/ssh/*key*

# Remove the root user’s shell history.

/bin/rm -f ~root/.bash_history
unset HISTFILE

#Remove the root user’s SSH history & other cruft.
/bin/rm -rf ~root/.ssh/
/bin/rm -f ~root/anaconda-ks.cfg

