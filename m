Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4DD3E3858C42; Wed, 19 Feb 2025 10:06:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4DD3E3858C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739959588;
	bh=soSgKwCpP5CaalLbZ46ciRt7NK78pRmo5jHKVtSFfVw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=krAhWqO2risqvMsMRPY5sy1PPoCMdDs3NI+4kyr6FzxflcjducJ7/BCLMW1K1eso/
	 F6h1ixlFtVE8jzsw1Ixpx6Vmegf3Ev//6IUMZWhXygMkAhVpIW4T+QD9RZuGTBvbWb
	 sVvhU9Xa+WrQA1BOUB6qQRwWDfdzo4ocVKr0uDC8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1775BA80B96; Wed, 19 Feb 2025 11:06:26 +0100 (CET)
Date: Wed, 19 Feb 2025 11:06:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <Z7WtIsNZb7Fqnmxg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9b20134b-c892-edbd-eac3-d2781bcec039@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b20134b-c892-edbd-eac3-d2781bcec039@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

just a minor thingy:

On Feb 18 17:51, Jeremy Drake via Cygwin-patches wrote:
> +  dos_drive_mappings (bool with_floppies = true);

I would rather not make this a default parameter, but call it elsewhere
with an argument "true".  Or even better with an explicit value, like

enum {
  NO_FLOPPIES = false,
  WITH_FLOPPIES = true
};

I have a local tweak along these lines.  Would you mind if I
amend your patch with this tiny change?

diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 6dfd11c44470..50a5af24f911 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -576,7 +576,7 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 
       case CW_ALLOC_DRIVE_MAP:
 	{
-	  dos_drive_mappings *ddm = new dos_drive_mappings ();
+	  dos_drive_mappings *ddm = new dos_drive_mappings (WITH_FLOPPIES);
 	  res = (uintptr_t) ddm;
 	}
 	break;
diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 550da2a82068..8fae9be5f678 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -887,7 +887,7 @@ format_process_maps (void *data, char *&destbuf)
   } cur = {{{'\0'}}, (char *)1, 0, 0};
 
   MEMORY_BASIC_INFORMATION mb;
-  dos_drive_mappings drive_maps;
+  dos_drive_mappings drive_maps (WITH_FLOPPIES);
   heap_info heaps (p->dwProcessId);
   thread_info threads (p->dwProcessId, proc);
   struct stat st;
diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index b719d983594d..163b47551fcb 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -220,6 +220,11 @@ class mount_info
   struct mntent *cygdrive_getmntent ();
 };
 
+enum {
+  NO_FLOPPIES = false,
+  WITH_FLOPPIES = true
+};
+
 class dos_drive_mappings
 {
   struct mapping
@@ -237,7 +242,7 @@ class dos_drive_mappings
   mapping::dosmount *cur_dos;
 
 public:
-  dos_drive_mappings (bool with_floppies = true);
+  dos_drive_mappings (bool with_floppies);
   ~dos_drive_mappings ();
   wchar_t *fixup_if_match (wchar_t *path);
   const wchar_t *next_dos_mount ();
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index c921c7691c56..1cfee5c41571 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1746,7 +1746,7 @@ mount_info::cygdrive_getmntent ()
   char *win32_path, *posix_path;
 
   if (!_my_tls.locals.drivemappings)
-    _my_tls.locals.drivemappings = new dos_drive_mappings (false);
+    _my_tls.locals.drivemappings = new dos_drive_mappings (NO_FLOPPIES);
 
   wide_path = _my_tls.locals.drivemappings->next_dos_mount ();
   if (wide_path)


Thanks,
Corinna
