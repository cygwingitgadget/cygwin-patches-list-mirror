Return-Path: <cygwin-patches-return-6042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23038 invoked by alias); 19 Mar 2007 06:30:23 -0000
Received: (qmail 23026 invoked by uid 22791); 19 Mar 2007 06:30:22 -0000
X-Spam-Check-By: sourceware.org
Received: from icculus.org (HELO icculus.org) (67.106.77.212)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 19 Mar 2007 06:30:19 +0000
Received: (qmail 27441 invoked by uid 305); 19 Mar 2007 02:30:09 -0400
Received: from icculus@icculus.org by gamehenge by uid 305 with qmail-scanner-1.22   (clamdscan: 0.75.1.  Clear:RC:1(75.181.37.52):.   Processed in 0.117292 secs); 19 Mar 2007 06:30:09 -0000
Received: from unknown (HELO ?192.168.1.133?) (icculus@75.181.37.52)   by icculus.org with ESMTPA; 19 Mar 2007 02:30:09 -0400
Message-ID: <45FE2DF8.40709@icculus.org>
Date: Mon, 19 Mar 2007 06:30:00 -0000
From: "Ryan C. Gordon" <icculus@icculus.org>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [PATCH] getmntent()->mnt_type values that match Linux...
Content-Type: multipart/mixed;  boundary="------------000401080005020207050800"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00023.txt.bz2

This is a multi-part message in MIME format.
--------------000401080005020207050800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2001


There was a discussion quite some time ago about getmntent()'s mnt_type 
field:

    http://www.cygwin.com/ml/cygwin-developers/2002-09/msg00078.html

...but nothing seems to have come of it. I noticed that Cygwin builds of 
PhysicsFS (http://icculus.org/physfs/) don't detect CD-ROM drives since 
mnt_type is always "system" or "user" ... this patch changes this to 
make an earnest effort to match what a GNU/Linux system would report, 
and moves the system/user string to mnt_opts.

Without some solution like this, code external to Cygwin would have to 
take heroic measures (#ifdefs and calls into the Win32 API) to figure 
out what type of filesystem /cygdrive/f really is.

After patching, here's the output from "mount" for a hard drive with two 
NTFS partitions (C: and D:), a CD-ROM drive (E:), a FAT memory stick 
(F:), and a Samba share (Z:) ...

$ mount
C:\cygwin\bin on /usr/bin type ntfs (binmode,system)
C:\cygwin\lib on /usr/lib type ntfs (binmode,system)
C:\cygwin on / type ntfs (binmode,system)
c: on /cygdrive/c type ntfs (binmode,noumount,system)
d: on /cygdrive/d type ntfs (binmode,noumount,system)
e: on /cygdrive/e type iso9660 (binmode,noumount,system)
f: on /cygdrive/f type vfat (binmode,noumount,system)
z: on /cygdrive/z type smbfs (binmode,noumount,system)


I haven't noticed any side effects of this patch, but my testing of the 
Cygwin system as a whole is fairly limited. Comments welcome.

Patch is against latest CVS.

Thanks,
--ryan.


2007-03-19  Ryan C. Gordon  <icculus@icculus.org>

	* path.cc (fs_info::update): set and use is_cdrom.
	* path.cc (fillout_mntent): set ret.mnt_type to something more
	Linux-like, based on data from fs_info. Move "system" and "user"
	strings from mnt_type to mnt_opts.
	* path.h (struct fs_info): Add is_cdrom field.
	* path.h (fs_info::clear): Initialize is_cdrom.
	* path.h (struct fs_info): Add IMPLEMENT_STATUS_FLAG(bool,is_cdrom).
	* path.h (class path_conv): Add fs_is_cdrom method. Add missing
	fs_is_netapp method.



--------------000401080005020207050800
Content-Type: text/plain;
 name="cygwin-getmntent-mnt_type-RYAN1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-getmntent-mnt_type-RYAN1.diff"
Content-length: 4203

Index: cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.434
diff -u -p -r1.434 path.cc
--- cygwin/path.cc	1 Mar 2007 15:13:47 -0000	1.434
+++ cygwin/path.cc	19 Mar 2007 05:01:10 -0000
@@ -461,6 +461,7 @@ fs_info::update (const char *win32_path)
 	     && FS_IS_NETAPP_DATAONTAP);
   is_ntfs (strcmp (fsname, "NTFS") == 0 && !is_samba () && !is_netapp ());
   is_nfs (strcmp (fsname, "NFS") == 0);
+  is_cdrom (drive_type () == DRIVE_CDROM);
 
   has_ea (is_ntfs ());
   has_acls ((flags () & FS_PERSISTENT_ACLS)
@@ -474,8 +475,7 @@ fs_info::update (const char *win32_path)
   has_buggy_open (!strcmp (fsname, "SUNWNFS"));
 
   /* Only append non-removable drives to the global fsinfo storage */
-  if (drive_type () != DRIVE_REMOVABLE && drive_type () != DRIVE_CDROM
-      && idx < MAX_FS_INFO_CNT)
+  if (drive_type () != DRIVE_REMOVABLE && !is_cdrom() && idx < MAX_FS_INFO_CNT)
     {
       LONG exc_cnt;
       while ((exc_cnt = InterlockedExchange (&fsinfo_cnt, -1)) == -1)
@@ -2552,10 +2552,27 @@ fillout_mntent (const char *native_path,
   strcpy (_my_tls.locals.mnt_dir, posix_path);
   ret.mnt_dir = _my_tls.locals.mnt_dir;
 
-  if (!(flags & MOUNT_SYSTEM))		/* user mount */
-    strcpy (_my_tls.locals.mnt_type, (char *) "user");
-  else					/* system mount */
-    strcpy (_my_tls.locals.mnt_type, (char *) "system");
+  /* Try to give a filesystem type that matches what a Linux application might
+     expect. Naturally, this is a moving target, but we can make some
+     reasonable guesses for popular types. */
+
+  fs_info mntinfo;
+  mntinfo.update(native_path);  /* this pulls from a cache, usually. */
+
+  if (mntinfo.is_samba())
+    strcpy (_my_tls.locals.mnt_type, (char *) "smbfs");
+  else if (mntinfo.is_nfs())
+    strcpy (_my_tls.locals.mnt_type, (char *) "nfs");
+  else if (mntinfo.is_fat())
+    strcpy (_my_tls.locals.mnt_type, (char *) "vfat");
+  else if (mntinfo.is_ntfs())
+    strcpy (_my_tls.locals.mnt_type, (char *) "ntfs");
+  else if (mntinfo.is_netapp())
+    strcpy (_my_tls.locals.mnt_type, (char *) "netapp");
+  else if (mntinfo.is_cdrom())
+    strcpy (_my_tls.locals.mnt_type, (char *) "iso9660");
+  else
+    strcpy (_my_tls.locals.mnt_type, (char *) "unknown");
 
   ret.mnt_type = _my_tls.locals.mnt_type;
 
@@ -2579,6 +2596,12 @@ fillout_mntent (const char *native_path,
 
   if ((flags & MOUNT_CYGDRIVE))		/* cygdrive */
     strcat (_my_tls.locals.mnt_opts, (char *) ",noumount");
+
+  if (!(flags & MOUNT_SYSTEM))		/* user mount */
+    strcat (_my_tls.locals.mnt_opts, (char *) ",user");
+  else					/* system mount */
+    strcat (_my_tls.locals.mnt_opts, (char *) ",system");
+
   ret.mnt_opts = _my_tls.locals.mnt_opts;
 
   ret.mnt_freq = 1;
Index: cygwin/path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.97
diff -u -p -r1.97 path.h
--- cygwin/path.h	17 Jan 2007 19:26:58 -0000	1.97
+++ cygwin/path.h	19 Mar 2007 05:01:10 -0000
@@ -111,6 +111,7 @@ struct fs_info
     unsigned is_samba        : 1;
     unsigned is_nfs          : 1;
     unsigned is_netapp       : 1;
+    unsigned is_cdrom        : 1;
   } status;
  public:
   void clear ()
@@ -129,6 +130,7 @@ struct fs_info
     is_samba (false);
     is_nfs (false);
     is_netapp (false);
+    is_cdrom (false);
   }
   inline DWORD& flags () {return status.flags;};
   inline DWORD& serial () {return status.serial;};
@@ -145,6 +147,7 @@ struct fs_info
   IMPLEMENT_STATUS_FLAG (bool, is_samba)
   IMPLEMENT_STATUS_FLAG (bool, is_nfs)
   IMPLEMENT_STATUS_FLAG (bool, is_netapp)
+  IMPLEMENT_STATUS_FLAG (bool, is_cdrom)
 
   bool update (const char *);
 };
@@ -274,6 +277,8 @@ class path_conv
   bool fs_is_ntfs () const {return fs.is_ntfs ();}
   bool fs_is_samba () const {return fs.is_samba ();}
   bool fs_is_nfs () const {return fs.is_nfs ();}
+  bool fs_is_netapp () const {return fs.is_netapp ();}
+  bool fs_is_cdrom () const {return fs.is_cdrom ();}
   void set_path (const char *p) {strcpy (path, p);}
   DWORD volser () { return fs.serial (); }
   void fillin (HANDLE h);

--------------000401080005020207050800--
