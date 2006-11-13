Return-Path: <cygwin-patches-return-5993-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31164 invoked by alias); 13 Nov 2006 22:42:13 -0000
Received: (qmail 31154 invoked by uid 22791); 13 Nov 2006 22:42:11 -0000
X-Spam-Check-By: sourceware.org
Received: from 66-162-92-75.static.twtelecom.net (HELO saturn.p3corpnet.pivot3.com) (66.162.92.75)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 13 Nov 2006 22:42:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Patch to mapping up to 128 SCSI Disk Devices
Date: Mon, 13 Nov 2006 22:42:00 -0000
Message-ID: <E05F1FD208D5AA45B78B3983479ECF08E436C5@saturn.p3corpnet.pivot3.com>
From: "Loh, Joe" <joel@pivot3.com>
To: <cygwin-patches@cygwin.com>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00011.txt.bz2


This is a modified patch for up to 128 SCSI Disk Devices as discussed in
http://cygwin.com/ml/cygwin/2006-11/msg00060.html.

As suggested by Eric Blake, we have snail mailed the copyright
assignment to Rose Naftaly.

ChangeLog for winsup/cygwin:

2006-11-13  Joe Loh  <joel at pivot3 dot com>

        * devices.h: Add additional SCSI disk block device numbers per
        http://www.kernel.org/pub/linux/docs/device-list/devices.txt=20
        up to 128 devices.
        (DEV_SD{2..7}_MAJOR): Define.
        (FH_SD{2..7}): Define.
        (FH_SDA{A..Z}): Define.
        (FH_SDB{A..Z}): Define.
        (FH_SDC{A..Z}): Define.
        (FH_SDD{A..X}): Define.
        * devices.in: Add additional SCSI disk block device numbers per
        http://www.kernel.org/pub/linux/docs/device-list/devices.txt=20
        up to 128 devices.
        (/dev/sda{a..z}): Define.
        (/dev/sdb{a..z}): Define.
        (/dev/sdc{a..z}): Define.
        (/dev/sdd{a..x}): Define.
        (device::parsedisk): Add additonal else-if cases for decoding
base=20
        and drive indices.
        * dtable.cc (build_fh_pc): Add additional DEV_SD{2..7}_MAJOR
cases.



Index: devices.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.22
diff -u -r1.22 devices.h
--- devices.h   2 Dec 2005 00:37:21 -0000       1.22
+++ devices.h   13 Nov 2006 22:30:44 -0000
@@ -65,8 +65,20 @@
=20
   DEV_SD_MAJOR =3D 8,
   DEV_SD1_MAJOR =3D 65,
+  DEV_SD2_MAJOR =3D 66,
+  DEV_SD3_MAJOR =3D 67,
+  DEV_SD4_MAJOR =3D 68,
+  DEV_SD5_MAJOR =3D 69,
+  DEV_SD6_MAJOR =3D 70,
+  DEV_SD7_MAJOR =3D 71,
   FH_SD      =3D FHDEV (DEV_SD_MAJOR, 0),
   FH_SD1     =3D FHDEV (DEV_SD1_MAJOR, 0),
+  FH_SD2     =3D FHDEV (DEV_SD2_MAJOR, 0),
+  FH_SD3     =3D FHDEV (DEV_SD3_MAJOR, 0),
+  FH_SD4     =3D FHDEV (DEV_SD4_MAJOR, 0),
+  FH_SD5     =3D FHDEV (DEV_SD5_MAJOR, 0),
+  FH_SD6     =3D FHDEV (DEV_SD6_MAJOR, 0),
+  FH_SD7     =3D FHDEV (DEV_SD7_MAJOR, 0),
   FH_SDA     =3D FHDEV (DEV_SD_MAJOR, 0),
   FH_SDB     =3D FHDEV (DEV_SD_MAJOR, 16),
   FH_SDC     =3D FHDEV (DEV_SD_MAJOR, 32),
@@ -93,6 +105,108 @@
   FH_SDX     =3D FHDEV (DEV_SD1_MAJOR, 112),
   FH_SDY     =3D FHDEV (DEV_SD1_MAJOR, 128),
   FH_SDZ     =3D FHDEV (DEV_SD1_MAJOR, 144),
+  FH_SDAA    =3D FHDEV (DEV_SD1_MAJOR, 160),
+  FH_SDAB    =3D FHDEV (DEV_SD1_MAJOR, 176),
+  FH_SDAC    =3D FHDEV (DEV_SD1_MAJOR, 192),
+  FH_SDAD    =3D FHDEV (DEV_SD1_MAJOR, 208),
+  FH_SDAE    =3D FHDEV (DEV_SD1_MAJOR, 224),
+  FH_SDAF    =3D FHDEV (DEV_SD1_MAJOR, 240),
+  FH_SDAG    =3D FHDEV (DEV_SD2_MAJOR, 0),
+  FH_SDAH    =3D FHDEV (DEV_SD2_MAJOR, 16),
+  FH_SDAI    =3D FHDEV (DEV_SD2_MAJOR, 32),
+  FH_SDAJ    =3D FHDEV (DEV_SD2_MAJOR, 48),
+  FH_SDAK    =3D FHDEV (DEV_SD2_MAJOR, 64),
+  FH_SDAL    =3D FHDEV (DEV_SD2_MAJOR, 80),
+  FH_SDAM    =3D FHDEV (DEV_SD2_MAJOR, 96),
+  FH_SDAN    =3D FHDEV (DEV_SD2_MAJOR, 112),
+  FH_SDAO    =3D FHDEV (DEV_SD2_MAJOR, 128),
+  FH_SDAP    =3D FHDEV (DEV_SD2_MAJOR, 144),
+  FH_SDAQ    =3D FHDEV (DEV_SD2_MAJOR, 160),
+  FH_SDAR    =3D FHDEV (DEV_SD2_MAJOR, 176),
+  FH_SDAS    =3D FHDEV (DEV_SD2_MAJOR, 192),
+  FH_SDAT    =3D FHDEV (DEV_SD2_MAJOR, 208),
+  FH_SDAU    =3D FHDEV (DEV_SD2_MAJOR, 224),
+  FH_SDAV    =3D FHDEV (DEV_SD2_MAJOR, 240),
+  FH_SDAW    =3D FHDEV (DEV_SD3_MAJOR, 0),
+  FH_SDAX    =3D FHDEV (DEV_SD3_MAJOR, 16),
+  FH_SDAY    =3D FHDEV (DEV_SD3_MAJOR, 32),
+  FH_SDAZ    =3D FHDEV (DEV_SD3_MAJOR, 48),
+  FH_SDBA    =3D FHDEV (DEV_SD3_MAJOR, 64),
+  FH_SDBB    =3D FHDEV (DEV_SD3_MAJOR, 80),
+  FH_SDBC    =3D FHDEV (DEV_SD3_MAJOR, 96),
+  FH_SDBD    =3D FHDEV (DEV_SD3_MAJOR, 112),
+  FH_SDBE    =3D FHDEV (DEV_SD3_MAJOR, 128),
+  FH_SDBF    =3D FHDEV (DEV_SD3_MAJOR, 144),
+  FH_SDBG    =3D FHDEV (DEV_SD3_MAJOR, 160),
+  FH_SDBH    =3D FHDEV (DEV_SD3_MAJOR, 176),
+  FH_SDBI    =3D FHDEV (DEV_SD3_MAJOR, 192),
+  FH_SDBJ    =3D FHDEV (DEV_SD3_MAJOR, 208),
+  FH_SDBK    =3D FHDEV (DEV_SD3_MAJOR, 224),
+  FH_SDBL    =3D FHDEV (DEV_SD3_MAJOR, 240),
+  FH_SDBM    =3D FHDEV (DEV_SD4_MAJOR, 0),
+  FH_SDBN    =3D FHDEV (DEV_SD4_MAJOR, 16),
+  FH_SDBO    =3D FHDEV (DEV_SD4_MAJOR, 32),
+  FH_SDBP    =3D FHDEV (DEV_SD4_MAJOR, 48),
+  FH_SDBQ    =3D FHDEV (DEV_SD4_MAJOR, 64),
+  FH_SDBR    =3D FHDEV (DEV_SD4_MAJOR, 80),
+  FH_SDBS    =3D FHDEV (DEV_SD4_MAJOR, 96),
+  FH_SDBT    =3D FHDEV (DEV_SD4_MAJOR, 112),
+  FH_SDBU    =3D FHDEV (DEV_SD4_MAJOR, 128),
+  FH_SDBV    =3D FHDEV (DEV_SD4_MAJOR, 144),
+  FH_SDBW    =3D FHDEV (DEV_SD4_MAJOR, 160),
+  FH_SDBX    =3D FHDEV (DEV_SD4_MAJOR, 176),
+  FH_SDBY    =3D FHDEV (DEV_SD4_MAJOR, 192),
+  FH_SDBZ    =3D FHDEV (DEV_SD4_MAJOR, 208),
+  FH_SDCA    =3D FHDEV (DEV_SD4_MAJOR, 224),
+  FH_SDCB    =3D FHDEV (DEV_SD4_MAJOR, 240),
+  FH_SDCC    =3D FHDEV (DEV_SD5_MAJOR, 0),
+  FH_SDCD    =3D FHDEV (DEV_SD5_MAJOR, 16),
+  FH_SDCE    =3D FHDEV (DEV_SD5_MAJOR, 32),
+  FH_SDCF    =3D FHDEV (DEV_SD5_MAJOR, 48),
+  FH_SDCG    =3D FHDEV (DEV_SD5_MAJOR, 64),
+  FH_SDCH    =3D FHDEV (DEV_SD5_MAJOR, 80),
+  FH_SDCI    =3D FHDEV (DEV_SD5_MAJOR, 96),
+  FH_SDCJ    =3D FHDEV (DEV_SD5_MAJOR, 112),
+  FH_SDCK    =3D FHDEV (DEV_SD5_MAJOR, 128),
+  FH_SDCL    =3D FHDEV (DEV_SD5_MAJOR, 144),
+  FH_SDCM    =3D FHDEV (DEV_SD5_MAJOR, 160),
+  FH_SDCN    =3D FHDEV (DEV_SD5_MAJOR, 176),
+  FH_SDCO    =3D FHDEV (DEV_SD5_MAJOR, 192),
+  FH_SDCP    =3D FHDEV (DEV_SD5_MAJOR, 208),
+  FH_SDCQ    =3D FHDEV (DEV_SD5_MAJOR, 224),
+  FH_SDCR    =3D FHDEV (DEV_SD5_MAJOR, 240),
+  FH_SDCS    =3D FHDEV (DEV_SD6_MAJOR, 0),
+  FH_SDCT    =3D FHDEV (DEV_SD6_MAJOR, 16),
+  FH_SDCU    =3D FHDEV (DEV_SD6_MAJOR, 32),
+  FH_SDCV    =3D FHDEV (DEV_SD6_MAJOR, 48),
+  FH_SDCW    =3D FHDEV (DEV_SD6_MAJOR, 64),
+  FH_SDCX    =3D FHDEV (DEV_SD6_MAJOR, 80),
+  FH_SDCY    =3D FHDEV (DEV_SD6_MAJOR, 96),
+  FH_SDCZ    =3D FHDEV (DEV_SD6_MAJOR, 112),
+  FH_SDDA    =3D FHDEV (DEV_SD6_MAJOR, 128),
+  FH_SDDB    =3D FHDEV (DEV_SD6_MAJOR, 144),
+  FH_SDDC    =3D FHDEV (DEV_SD6_MAJOR, 160),
+  FH_SDDD    =3D FHDEV (DEV_SD6_MAJOR, 176),
+  FH_SDDE    =3D FHDEV (DEV_SD6_MAJOR, 192),
+  FH_SDDF    =3D FHDEV (DEV_SD6_MAJOR, 208),
+  FH_SDDG    =3D FHDEV (DEV_SD6_MAJOR, 224),
+  FH_SDDH    =3D FHDEV (DEV_SD6_MAJOR, 240),
+  FH_SDDI    =3D FHDEV (DEV_SD7_MAJOR, 0),
+  FH_SDDJ    =3D FHDEV (DEV_SD7_MAJOR, 16),
+  FH_SDDK    =3D FHDEV (DEV_SD7_MAJOR, 32),
+  FH_SDDL    =3D FHDEV (DEV_SD7_MAJOR, 48),
+  FH_SDDM    =3D FHDEV (DEV_SD7_MAJOR, 64),
+  FH_SDDN    =3D FHDEV (DEV_SD7_MAJOR, 80),
+  FH_SDDO    =3D FHDEV (DEV_SD7_MAJOR, 96),
+  FH_SDDP    =3D FHDEV (DEV_SD7_MAJOR, 112),
+  FH_SDDQ    =3D FHDEV (DEV_SD7_MAJOR, 128),
+  FH_SDDR    =3D FHDEV (DEV_SD7_MAJOR, 144),
+  FH_SDDS    =3D FHDEV (DEV_SD7_MAJOR, 160),
+  FH_SDDT    =3D FHDEV (DEV_SD7_MAJOR, 176),
+  FH_SDDU    =3D FHDEV (DEV_SD7_MAJOR, 192),
+  FH_SDDV    =3D FHDEV (DEV_SD7_MAJOR, 208),
+  FH_SDDW    =3D FHDEV (DEV_SD7_MAJOR, 224),
+  FH_SDDX    =3D FHDEV (DEV_SD7_MAJOR, 240),
=20
   FH_MEM     =3D FHDEV (1, 1),
   FH_KMEM    =3D FHDEV (1, 2),   /* not implemented yet */


Index: devices.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/devices.in,v
retrieving revision 1.14
diff -u -r1.14 devices.in
--- devices.in  9 Oct 2006 08:27:23 -0000       1.14
+++ devices.in  13 Nov 2006 22:30:44 -0000
@@ -85,7 +85,15 @@
 "/dev/scd%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})),
"\\Device\\CdRom{$1}"
 "/dev/sr%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})),
"\\Device\\CdRom{$1}"
 "/dev/sd%{a-z}s", BRACK(FH_SD{uc $1}), "\\Device\\Harddisk{ord($1) -
ord('a')}\\Partition0"
+"/dev/sda%{a-z}s", BRACK(FH_SDA{uc $1}), "\\Device\\Harddisk{26 +
ord($1) - ord('a')}\\Partition0"
+"/dev/sdb%{a-z}s", BRACK(FH_SDB{uc $1}), "\\Device\\Harddisk{52 +
ord($1) - ord('a')}\\Partition0"
+"/dev/sdc%{a-z}s", BRACK(FH_SDC{uc $1}), "\\Device\\Harddisk{78 +
ord($1) - ord('a')}\\Partition0"
+"/dev/sdd%{a-x}s", BRACK(FH_SDD{uc $1}), "\\Device\\Harddisk{104 +
ord($1) - ord('a')}\\Partition0"
 "/dev/sd%{a-z}s%(1-15)d", BRACK(FH_SD{uc $1} | {$2}),
"\\Device\\Harddisk{ord($1) - ord('a')}\\Partition{$2 % 16}"
+"/dev/sda%{a-z}s%(1-15)d", BRACK(FH_SDA{uc $1} | {$2}),
"\\Device\\Harddisk{26 + ord($1) - ord('a')}\\Partition{$2 % 16}"
+"/dev/sdb%{a-z}s%(1-15)d", BRACK(FH_SDB{uc $1} | {$2}),
"\\Device\\Harddisk{52 + ord($1) - ord('a')}\\Partition{$2 % 16}"
+"/dev/sdc%{a-z}s%(1-15)d", BRACK(FH_SDC{uc $1} | {$2}),
"\\Device\\Harddisk{78 + ord($1) - ord('a')}\\Partition{$2 % 16}"
+"/dev/sdd%{a-x}s%(1-15)d", BRACK(FH_SDD{uc $1} | {$2}),
"\\Device\\Harddisk{104 + ord($1) - ord('a')}\\Partition{$2 % 16}"
 "/dev/kmsg", BRACK(FH_KMSG), "\\\\.\\mailslot\\cygwin\\dev\\kmsg"
 "/dev", BRACK(FH_DEV), "/dev"
 %other {return NULL;}
@@ -146,12 +154,44 @@
 device::parsedisk (int drive, int part)
 {
   int base;
-  if (drive < ('q' - 'a'))
+  if (drive < ('q' - 'a'))      // /dev/sda -to- /dev/sdp
     base =3D DEV_SD_MAJOR;
-  else
+  else if (drive < 32)          // /dev/sdq -to- /dev/sdaf
     {
       base =3D DEV_SD1_MAJOR;
       drive -=3D 'q' - 'a';
     }
+  else if (drive < 48)          // /dev/sdag -to- /dev/sdav
+    {
+      base =3D DEV_SD2_MAJOR;
+      drive -=3D 32;
+    }
     {
       base =3D DEV_SD1_MAJOR;
       drive -=3D 'q' - 'a';
     }
+  else if (drive < 48)          // /dev/sdag -to- /dev/sdav
+    {
+      base =3D DEV_SD2_MAJOR;
+      drive -=3D 32;
+    }
+  else if (drive < 64)          // /dev/sdaw -to- /dev/sdbl
+    {
+      base =3D DEV_SD3_MAJOR;
+      drive -=3D 48;
+    }
+  else if (drive < 80)          // /dev/sdbm -to- /dev/sdcb
+    {
+      base =3D DEV_SD4_MAJOR;
+      drive -=3D 64;
+    }
+  else if (drive < 96)          // /dev/sdcc -to- /dev/sdcr
+    {
+      base =3D DEV_SD5_MAJOR;
+      drive -=3D 80;
+    }
+  else if (drive < 112)          // /dev/sdcs -to- /dev/sddh
+    {
+      base =3D DEV_SD6_MAJOR;
+      drive -=3D 96;
+    }
+  // NOTE: This will cause multiple /dev/sddx entries in
+  //       /proc/partitions if there are more than 128 devices
+  else                           // /dev/sddi -to- /dev/sddx
+    {
+      base =3D DEV_SD7_MAJOR;
+      drive -=3D 112;
+    }
   parse (base, part + (drive * 16));
 }


Index: dtable.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.170
diff -u -r1.170 dtable.cc
--- dtable.cc   6 Nov 2006 13:46:24 -0000       1.170
+++ dtable.cc   13 Nov 2006 22:30:45 -0000
@@ -384,6 +384,12 @@
     case DEV_CDROM_MAJOR:
     case DEV_SD_MAJOR:
     case DEV_SD1_MAJOR:
+    case DEV_SD2_MAJOR:
+    case DEV_SD3_MAJOR:
+    case DEV_SD4_MAJOR:
+    case DEV_SD5_MAJOR:
+    case DEV_SD6_MAJOR:
+    case DEV_SD7_MAJOR:
       fh =3D cnew (fhandler_dev_floppy) ();
       break;
     case DEV_TAPE_MAJOR:
