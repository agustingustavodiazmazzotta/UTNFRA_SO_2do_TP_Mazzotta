sudo fdisk /dev/sdb
[sudo] password for amazzotta: 

Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xe8b03b85.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-4194303, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-4194303, default 4194303): 

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo fdisk /dev/sdd

Welcome to fdisk (util-linux 2.37.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xe59d2f76.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-2097151, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-2097151, default 2097151): 

Created a new partition 1 of type 'Linux' and of size 1023 MiB.

Command (m for help): t
Selected partition 1
Hex code or alias (type L to list all): 8e
Changed type of partition 'Linux' to 'Linux LVM'.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0 63.8M  1 loop /snap/core20/2866
loop1    7:1    0 91.7M  1 loop /snap/lxd/38800
loop2    7:2    0 49.3M  1 loop /snap/snapd/26865
sda      8:0    0   40G  0 disk 
└─sda1   8:1    0   40G  0 part /
sdb      8:16   0    2G  0 disk 
└─sdb1   8:17   0    2G  0 part 
sdc      8:32   0   10M  0 disk 
sdd      8:48   0    1G  0 disk 
└─sdd1   8:49   0 1023M  0 part 
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo pvcreate /dev/sdd1
  Physical volume "/dev/sdd1" successfully created.
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo pvs
  PV         VG Fmt  Attr PSize    PFree   
  /dev/sdb1     lvm2 ---    <2.00g   <2.00g
  /dev/sdd1     lvm2 ---  1023.00m 1023.00m
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo vgcreate vg_datos /dev/sdb1
  Volume group "vg_datos" successfully created
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo vgcreate vg_temp /dev/sdd1
  Volume group "vg_temp" successfully created
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo vgs
  VG       #PV #LV #SN Attr   VSize    VFree   
  vg_datos   1   0   0 wz--n-   <2.00g   <2.00g
  vg_temp    1   0   0 wz--n- 1020.00m 1020.00m
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo lvcreate -L 5M    -n lv_docker    vg_datos
  Rounding up size to full physical extent 8.00 MiB
  Logical volume "lv_docker" created.
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo lvcreate -L 1.5G  -n lv_workareas vg_datos
  Logical volume "lv_workareas" created.
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo lvcreate -L 512M  -n lv_swap      vg_temp
  Logical volume "lv_swap" created.
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo lvs
  LV           VG       Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv_docker    vg_datos -wi-a-----   8.00m                                                    
  lv_workareas vg_datos -wi-a-----   1.50g                                                    
  lv_swap      vg_temp  -wi-a----- 512.00m                                                    
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 2048 4k blocks and 2048 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 393216 4k blocks and 98304 inodes
Filesystem UUID: 9d081f26-d7e9-44c7-b28f-1a22852ee05d
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done 

amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mkswap    /dev/mapper/vg_temp-lv_swap
Setting up swapspace version 1, size = 512 MiB (536866816 bytes)
no label, UUID=d399cb71-6197-4623-b945-d408beba0ab2
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mkdir -p /var/lib/docker
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mkdir -p /work
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mount /dev/mapper/vg_datos-lv_docker    /var/lib/docker
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mount /dev/mapper/vg_datos-lv_workareas /work
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo swapon /dev/mapper/vg_temp-lv_swap
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ echo "/dev/mapper/vg_datos-lv_docker    /var/lib/docker  ext4  defaults  0 2" | sudo tee -a /etc/fstab
/dev/mapper/vg_datos-lv_docker    /var/lib/docker  ext4  defaults  0 2
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ echo "/dev/mapper/vg_datos-lv_workareas /work            ext4  defaults  0 2" | sudo tee -a /etc/fstab
/dev/mapper/vg_datos-lv_workareas /work            ext4  defaults  0 2
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ echo "/dev/mapper/vg_temp-lv_swap       none             swap  sw        0 0" | sudo tee -a /etc/fstab
/dev/mapper/vg_temp-lv_swap       none             swap  sw        0 0
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo mount -a
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo pvs && sudo vgs && sudo lvs
  PV         VG       Fmt  Attr PSize    PFree  
  /dev/sdb1  vg_datos lvm2 a--    <2.00g 500.00m
  /dev/sdd1  vg_temp  lvm2 a--  1020.00m 508.00m
  VG       #PV #LV #SN Attr   VSize    VFree  
  vg_datos   1   2   0 wz--n-   <2.00g 500.00m
  vg_temp    1   1   0 wz--n- 1020.00m 508.00m
  LV           VG       Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv_docker    vg_datos -wi-ao----   8.00m                                                    
  lv_workareas vg_datos -wi-ao----   1.50g                                                    
  lv_swap      vg_temp  -wi-ao---- 512.00m                                                    
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ df -h /var/lib/docker /work
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/vg_datos-lv_docker     3.5M   24K  3.0M   1% /var/lib/docker
/dev/mapper/vg_datos-lv_workareas  1.5G   24K  1.4G   1% /work
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ swapon --show
NAME      TYPE      SIZE USED PRIO
/dev/dm-2 partition 512M   0B   -2
amazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo systemctl restart docker
^[[Aamazzotta@parcial:~/UTNFRA_SO_2do_TP_Mazzotta$ sudo systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2026-06-25 07:28:05 UTC; 16s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 6498 (dockerd)
      Tasks: 9
     Memory: 23.9M
        CPU: 874ms
     CGroup: /system.slice/docker.service
             └─6498 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Jun 25 07:28:02 parcial dockerd[6498]: time="2026-06-25T07:28:02.496310997Z" level=info msg="Restoring containers: start."
Jun 25 07:28:02 parcial dockerd[6498]: time="2026-06-25T07:28:02.679483318Z" level=info msg="Deleting nftables IPv4 rules" error="running nft: /dev/stdin:1:1>
Jun 25 07:28:02 parcial dockerd[6498]: time="2026-06-25T07:28:02.702731093Z" level=info msg="Deleting nftables IPv6 rules" error="running nft: /dev/stdin:1:1>
Jun 25 07:28:04 parcial dockerd[6498]: time="2026-06-25T07:28:04.439661896Z" level=info msg="Loading containers: done."
Jun 25 07:28:04 parcial dockerd[6498]: time="2026-06-25T07:28:04.453713903Z" level=info msg="Docker daemon" commit=70eaf5e containerd-snapshotter=true storag>
Jun 25 07:28:04 parcial dockerd[6498]: time="2026-06-25T07:28:04.453997864Z" level=info msg="Initializing buildkit"
Jun 25 07:28:05 parcial dockerd[6498]: time="2026-06-25T07:28:05.399068894Z" level=info msg="Completed buildkit initialization"
Jun 25 07:28:05 parcial dockerd[6498]: time="2026-06-25T07:28:05.412770529Z" level=info msg="Daemon has completed initialization"
Jun 25 07:28:05 parcial dockerd[6498]: time="2026-06-25T07:28:05.413524073Z" level=info msg="API listen on /run/docker.sock"
Jun 25 07:28:05 parcial systemd[1]: Started Docker Application Container Engine.
