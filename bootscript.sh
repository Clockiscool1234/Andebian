### this bootscript is to chroot into a debian image
### if umounting does not work, check any tasks using the /data/local/mnt folder and umount again 

MNT=/data/local/mnt
IMG=/storage/extSdCard/debiancore.img
echo "Mounting system onto $MNT..."		
busybox mknod /dev/block/loop99 b 7 100
busybox losetup /dev/block/loop99 $IMG
mount -t ext2 /dev/block/loop99 $MNT  
mount -t proc none $MNT/proc
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
echo "Mounting sys..."
mount -t sysfs none $MNT/sys
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
echo "Mounting dev..."
mount -o bind /dev $MNT/dev
mount -t devpts none $MNT/dev/pts
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi

echo 'Entering chroot enviroment...'
chroot $MNT $@ /root/launch.sh

echo "Unmounting dev..."
umount $MNT/dev/pts
umount $MNT/dev
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
echo "Unmounting sys..."
umount $MNT/sys
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
echo "Unmounting proc..."
umount $MNT/proc
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
echo "Unmounting $MNT..."
umount $MNT
if [ $? -eq 0 ]
then
echo OK
else
echo FAIL
fi
