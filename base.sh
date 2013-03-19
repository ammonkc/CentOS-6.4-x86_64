# Base install

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# activate wheel sudoers
sed -i '/NOPASSWD/!s/# %wheel/%wheel/g' /etc/sudoers

# fix secure_path in sudoers
sed -i 's#\(secure_path.*\)#\1:/usr/local/bin#' /etc/sudoers

# set root passwd
echo "Pandr00+"|sudo passwd --stdin root

# Add admin group
/usr/sbin/groupadd admin
echo "%admin        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/admin
chmod 0440 /etc/sudoers.d/admin

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=Extra Packages for Enterprise Linux 6 - \$basearch
#baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=0
EOM

yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget nfs-utils ntp

