Return-Path: <cygwin-patches-return-3084-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7107 invoked by alias); 24 Oct 2002 01:36:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6978 invoked from network); 24 Oct 2002 01:36:26 -0000
X-WM-Posted-At: avacado.atomice.net; Thu, 24 Oct 02 02:36:24 +0100
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: New ioctls for hard disks
Date: Wed, 23 Oct 2002 18:36:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHIEJICPAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C27B06.25603F00"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2002-q4/txt/msg00035.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C27B06.25603F00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 552

This patch implements some new ioctls for hard disks. This means you can run
fdisk under Cygwin.

Chris

--- cygwin

2002-10-24  Christopher January  <chris@atomice.net>

    * include/cygwin/fs.h: New file.
    * include/cygwin/hdreg.h: New file.
    * fhandler_floppy.cc (fhandler_floppy::ioctl): Add implementation for
    for HDIO_GETGEO, BLKGETSIZE, BLKGETSIZE64, BLKRRPART and BLKSSZGET
ioctls.

--- w32api

2002-10-24  Christopher January  <chris@atomice.net>

    * include/winioctl.h: Add definition for
    IOCTL_DISK_UPDATE_DRIVE_SIZE.

---

------=_NextPart_000_0000_01C27B06.25603F00
Content-Type: application/octet-stream;
	name="hd_ioctl.ChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hd_ioctl.ChangeLog"
Content-length: 534

--- cygwin=0A=
=0A=
2002-10-24  Christopher January  <chris@atomice.net>=0A=
=0A=
    * include/cygwin/fs.h: New file.=0A=
    * include/cygwin/hdreg.h: New file.=0A=
    * fhandler_floppy.cc (fhandler_floppy::ioctl): Add implementation for=
=0A=
    for HDIO_GETGEO, BLKGETSIZE, BLKGETSIZE64, BLKRRPART and BLKSSZGET ioct=
ls.=0A=
=0A=
--- w32api=0A=
=20=20=20=0A=
2002-10-24  Christopher January  <chris@atomice.net>=0A=
=0A=
    * include/winioctl.h: Add definition for=0A=
    IOCTL_DISK_UPDATE_DRIVE_SIZE.=0A=
=0A=
---=20=20=20=

------=_NextPart_000_0000_01C27B06.25603F00
Content-Type: application/octet-stream;
	name="hd_ioctl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hd_ioctl.patch"
Content-length: 7077

Index: cygwin/fhandler_floppy.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_floppy.cc,v=0A=
retrieving revision 1.22=0A=
diff -u -p -r1.22 fhandler_floppy.cc=0A=
--- cygwin/fhandler_floppy.cc	22 Sep 2002 03:38:57 -0000	1.22=0A=
+++ cygwin/fhandler_floppy.cc	24 Oct 2002 01:32:52 -0000=0A=
@@ -14,6 +14,9 @@ details. */=0A=
 #include <errno.h>=0A=
 #include <unistd.h>=0A=
 #include <winioctl.h>=0A=
+#include <asm/socket.h>=0A=
+#include <cygwin/hdreg.h>=0A=
+#include <cygwin/fs.h>=0A=
 #include "security.h"=0A=
 #include "fhandler.h"=0A=
 #include "cygerrno.h"=0A=
@@ -186,6 +189,124 @@ fhandler_dev_floppy::lseek (__off64_t of=0A=
 int=0A=
 fhandler_dev_floppy::ioctl (unsigned int cmd, void *buf)=0A=
 {=0A=
-  return fhandler_dev_raw::ioctl (cmd, buf);=0A=
+  DISK_GEOMETRY di;=0A=
+  PARTITION_INFORMATION pi;=0A=
+  DWORD bytes_read;=0A=
+  __off64_t drive_size =3D 0;=0A=
+  __off64_t start =3D 0;=0A=
+  switch (cmd)=0A=
+    {=0A=
+    case HDIO_GETGEO:=0A=
+      {=0A=
+        debug_printf ("HDIO_GETGEO");=0A=
+        if (!DeviceIoControl (get_handle (),=0A=
+                              IOCTL_DISK_GET_DRIVE_GEOMETRY,=0A=
+                              NULL, 0,=0A=
+                              &di, sizeof (di),=0A=
+                              &bytes_read, NULL))=0A=
+          {=0A=
+            __seterrno ();=0A=
+            return -1;=0A=
+          }=0A=
+        debug_printf ("disk geometry: (%ld cyl)*(%ld trk)*(%ld sec)*(%ld b=
ps)",=0A=
+                      di.Cylinders.LowPart,=0A=
+                      di.TracksPerCylinder,=0A=
+                      di.SectorsPerTrack,=0A=
+                      di.BytesPerSector);=0A=
+        if (DeviceIoControl (get_handle (),=0A=
+                              IOCTL_DISK_GET_PARTITION_INFO,=0A=
+                              NULL, 0,=0A=
+                              &pi, sizeof (pi),=0A=
+                              &bytes_read, NULL))=0A=
+          {=0A=
+            debug_printf ("partition info: %ld (%ld)",=0A=
+                          pi.StartingOffset.LowPart,=0A=
+                          pi.PartitionLength.LowPart);=0A=
+            start =3D pi.StartingOffset.QuadPart >> 9ULL;=0A=
+          }=0A=
+        struct hd_geometry *geo =3D (struct hd_geometry *) buf;=0A=
+        geo->heads =3D di.TracksPerCylinder;=0A=
+        geo->sectors =3D di.SectorsPerTrack;=0A=
+        geo->cylinders =3D di.Cylinders.LowPart;=0A=
+        geo->start =3D start;=0A=
+        return 0;=0A=
+      }=0A=
+    case BLKGETSIZE:=0A=
+    case BLKGETSIZE64:=0A=
+      {=0A=
+        debug_printf ("BLKGETSIZE");=0A=
+        if (!DeviceIoControl (get_handle (),=0A=
+                              IOCTL_DISK_GET_DRIVE_GEOMETRY,=0A=
+                              NULL, 0,=0A=
+                              &di, sizeof (di),=0A=
+                              &bytes_read, NULL))=0A=
+          {=0A=
+            __seterrno ();=0A=
+            return -1;=0A=
+          }=0A=
+        debug_printf ("disk geometry: (%ld cyl)*(%ld trk)*(%ld sec)*(%ld b=
ps)",=0A=
+                      di.Cylinders.LowPart,=0A=
+                      di.TracksPerCylinder,=0A=
+                      di.SectorsPerTrack,=0A=
+                      di.BytesPerSector);=0A=
+        if (DeviceIoControl (get_handle (),=0A=
+                             IOCTL_DISK_GET_PARTITION_INFO,=0A=
+                             NULL, 0,=0A=
+                             &pi, sizeof (pi),=0A=
+                             &bytes_read, NULL))=0A=
+          {=0A=
+            debug_printf ("partition info: %ld (%ld)",=0A=
+                          pi.StartingOffset.LowPart,=0A=
+                          pi.PartitionLength.LowPart);=0A=
+            drive_size =3D pi.PartitionLength.QuadPart;=0A=
+          }=0A=
+        else=0A=
+          {=0A=
+            drive_size =3D di.Cylinders.QuadPart * di.TracksPerCylinder *=
=0A=
+                         di.SectorsPerTrack * di.BytesPerSector;=0A=
+          }=0A=
+        if (cmd =3D=3D BLKGETSIZE)=0A=
+          *(long *)buf =3D drive_size >> 9UL;=0A=
+        else=0A=
+          *(__off64_t *)buf =3D drive_size;=0A=
+        return 0;=0A=
+      }=0A=
+    case BLKRRPART:=0A=
+      {=0A=
+        debug_printf ("BLKRRPART");=0A=
+        if (!DeviceIoControl (get_handle (),=0A=
+                              IOCTL_DISK_UPDATE_DRIVE_SIZE,=0A=
+                              NULL, 0,=0A=
+                              &di, sizeof (di),=0A=
+                              &bytes_read, NULL))=0A=
+          {=0A=
+            __seterrno ();=0A=
+            return -1;=0A=
+          }=0A=
+        return 0;=0A=
+      }=0A=
+    case BLKSSZGET:=0A=
+      {=0A=
+        debug_printf ("BLKSSZGET");=0A=
+        if (!DeviceIoControl (get_handle (),=0A=
+                              IOCTL_DISK_GET_DRIVE_GEOMETRY,=0A=
+                              NULL, 0,=0A=
+                              &di, sizeof (di),=0A=
+                              &bytes_read, NULL))=0A=
+          {=0A=
+            __seterrno ();=0A=
+            return -1;=0A=
+          }=0A=
+        debug_printf ("disk geometry: (%ld cyl)*(%ld trk)*(%ld sec)*(%ld b=
ps)",=0A=
+                      di.Cylinders.LowPart,=0A=
+                      di.TracksPerCylinder,=0A=
+                      di.SectorsPerTrack,=0A=
+                      di.BytesPerSector);=0A=
+        *(int *)buf =3D di.BytesPerSector;=0A=
+        return 0;=0A=
+      }=0A=
+    default:=0A=
+      return fhandler_dev_raw::ioctl (cmd, buf);=0A=
+    }=0A=
 }=0A=
=20=0A=
Index: w32api/include/winioctl.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winioctl.h,v=0A=
retrieving revision 1.7=0A=
diff -u -p -r1.7 winioctl.h=0A=
--- w32api/include/winioctl.h	25 Jun 2002 21:05:19 -0000	1.7=0A=
+++ w32api/include/winioctl.h	24 Oct 2002 01:33:01 -0000=0A=
@@ -56,6 +56,7 @@ extern "C" {=0A=
 #define IOCTL_DISK_FIND_NEW_DEVICES CTL_CODE(IOCTL_DISK_BASE,0x206,METHOD_=
BUFFERED,FILE_READ_ACCESS)=0A=
 #define IOCTL_DISK_REMOVE_DEVICE CTL_CODE(IOCTL_DISK_BASE,0x207,METHOD_BUF=
FERED,FILE_READ_ACCESS)=0A=
 #define IOCTL_DISK_GET_MEDIA_TYPES CTL_CODE(IOCTL_DISK_BASE,0x300,METHOD_B=
UFFERED,FILE_ANY_ACCESS)=0A=
+#define IOCTL_DISK_UPDATE_DRIVE_SIZE CTL_CODE(IOCTL_DISK_BASE, 0x0032, MET=
HOD_BUFFERED, FILE_READ_ACCESS | FILE_WRITE_ACCESS)=0A=
 #define IOCTL_SERIAL_LSRMST_INSERT	CTL_CODE(FILE_DEVICE_SERIAL_PORT,31,MET=
HOD_BUFFERED,FILE_ANY_ACCESS)=0A=
 #define FSCTL_LOCK_VOLUME	CTL_CODE(FILE_DEVICE_FILE_SYSTEM,6,METHOD_BUFFER=
ED,FILE_ANY_ACCESS)=0A=
 #define FSCTL_UNLOCK_VOLUME	CTL_CODE(FILE_DEVICE_FILE_SYSTEM,7,METHOD_BUFF=
ERED,FILE_ANY_ACCESS)=0A=

------=_NextPart_000_0000_01C27B06.25603F00
Content-Type: text/plain;
	name="fs.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fs.h"
Content-length: 471

/* cygwin/fs.h

   Copyright 2002 Red Hat Inc.
   Written by Chris January <chris@atomice.net>

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _CYGWIN_FS_H_
#define _CYGWIN_FS_H_

#include <cygwin/types.h>

#define BLKRRPART  0x0000125f
#define BLKGETSIZE 0x00001260
#define BLKSSZGET  0x00001268
#define BLKGETSIZE64 0x00041268

#endif

------=_NextPart_000_0000_01C27B06.25603F00
Content-Type: text/plain;
	name="hdreg.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hdreg.h"
Content-length: 502

/* cygwin/hdreg.h

   Copyright 2002 Red Hat Inc.
   Written by Chris January <chris@atomice.net>

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _CYGWIN_HDREG_H_
#define _CYGWIN_HDREG_H_

struct hd_geometry {
  unsigned char heads;
  unsigned char sectors;
  unsigned short cylinders;
  unsigned long start;
};

#define HDIO_GETGEO                     0x301

#endif


------=_NextPart_000_0000_01C27B06.25603F00--
