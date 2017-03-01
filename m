Return-Path: <cygwin-patches-return-8704-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2451 invoked by alias); 1 Mar 2017 19:18:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2420 invoked by uid 89); 1 Mar 2017 19:18:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-27.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=tape, needless, HX-Envelope-From:sk:michael, disappearing
X-HELO: smtpout.aon.at
Received: from smtpout.aon.at (HELO smtpout.aon.at) (195.3.96.117) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Mar 2017 19:18:40 +0000
Received: (qmail 844 invoked from network); 1 Mar 2017 19:18:36 -0000
Received: from 80-121-141-44.adsl.highway.telekom.at (HELO [10.0.0.5]) ([80.121.141.44])          (envelope-sender <michael.haubenwallner@ssi-schaefer.com>)          by smarthub82.res.a1.net (qmail-ldap-1.03) with DHE-RSA-AES256-SHA encrypted SMTP; 1 Mar 2017 19:18:36 -0000
X-A1Mail-Track-Id: 1488395914:752:smarthub82:80.121.141.44:1
Subject: Re: (fixup) [PATCH] forkables: use dynloaded dll's IndexNumber as dirname
To: cygwin-patches@cygwin.com
References: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com> <20170223140347.GK23946@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <fde647fb-1b6c-4a2d-cf9f-93bd7f2c9750@ssi-schaefer.com>
Date: Wed, 01 Mar 2017 19:18:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170223140347.GK23946@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------787D8B7E91AE3325CBA7D010"
X-SW-Source: 2017-q1/txt/msg00045.txt.bz2

This is a multi-part message in MIME format.
--------------787D8B7E91AE3325CBA7D010
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 2294

Hi Corinna,

On 02/23/2017 03:03 PM, Corinna Vinschen wrote:
> Hi Michael,
> 
> I'm inclined to promote the "forkables" code to master.  I just have a
> few points before we do that:
> 
> - Revert bumping of CYGWIN_VERSION_SHARED_DATA.  We only have to do that
>   if the shared region changes in an incompatible way.  But this is just
>   adding a member to the end.

Ok.
As long as properly aligned, even int-access should be atomic:
Is it ok to add the new member as 'char' rather than 'int'?

> - I'm looking a bit cross-eyed on the usage of forkables_needs and
>   cygwin_shared->prefer_forkable_hardlinks.  It seems to me as if the
>   split between those two isn't quite right and the fact that both
>   share information seems error prone.
>   
>   IMHO prefer_forkable_hardlinks should actually be the single marker
>   for the per-installation state.  After startup of the first process it
>   should be "unknown" (0) by default.  At startup it's set to one of
> 
>     "disabled"   (-1)	no NTFS or dir is missing
>     "enabled"    (+1)	NTFS and dir exists
> 
>   That sets the state once and for all by the first Cygwin process in
>   the system.

The initial check now is moved to dll_list::forkable_ntnamesize(),
which is called by dll_list::alloc().

What about the renaming cygwin_shared->prefer_forkable_hardlinks
to cygwin_shared->forkable_hardlink_support?

The new dll_list::forkables_supported() replaces the "unknown","impossible",
"disabled" values.  I've thought about inlining into dll_init.h, but that
would require to include "shared_info.h": Is there a specific reason behind
dll_init.h not having any #include right now?

>   Consequentially, forkables_needs should only reflect the per-process
>   states
> 
>     "needless"
>     "needed"
>     "created"
> 
> - Shouldn't forkables_needs be renamed to forkables_needed?

I've further simplified and replaced "enum forkables_needs" with
"bool forkables_created", because the "needless" value now is
implemented as "first fork tries without hardlinks". So as soon as
request_forkables() is entered, hardlinks aren't "needless" any more.

> That's all.  There are a few minor formatting issues, but they are
> negligible.

Do you prefer another patch series with this patch applied as fixups?

Thanks a lot!
/haubi/

--------------787D8B7E91AE3325CBA7D010
Content-Type: text/x-patch;
 name="0001-forkables-simplify-disabling-via-shm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-forkables-simplify-disabling-via-shm.patch"
Content-length: 11556

From bf08d3ae7441f7db23d034cccb9563cee0842fa6 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Wed, 1 Mar 2017 10:19:37 +0100
Subject: [PATCH] forkables: simplify disabling via shm

* Rename cygwin_shared->prefer_forkable_hardlinks to
  forkable_hardlink_support, with values
  0 for Unknown, 1 for Supported, -1 for Unsupported.
  Upon first dll loaded ever, dll_list::forkable_ntnamesize checks the
  /var/run/cygfork directory to both exist and reside on NTFS, setting
  cygwin_shared->forkable_hardlink_support accordingly.
* Replace enum forkables_needs by bool forkables_created: Set
  to True by request_forkables after creating forkable hardlinks.
---
 winsup/cygwin/dll_init.h               |  21 ++--
 winsup/cygwin/forkable.cc              | 185 ++++++++++-----------------------
 winsup/cygwin/include/cygwin/version.h |   2 +-
 winsup/cygwin/shared.cc                |   2 +-
 winsup/cygwin/shared_info.h            |   4 +-
 5 files changed, 65 insertions(+), 149 deletions(-)

diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index d598618..7129cee 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -87,17 +87,9 @@ struct dll
 class dll_list
 {
   /* forkables */
-  enum
-    {
-      forkables_unknown,
-      forkables_impossible,
-      forkables_disabled,
-      forkables_needless,
-      forkables_needed,
-      forkables_created,
-    }
-    forkables_needs;
+  bool forkables_supported ();
   DWORD forkables_dirx_size;
+  bool forkables_created;
   PWCHAR forkables_dirx_ntname;
   PWCHAR forkables_mutex_name;
   HANDLE forkables_mutex;
@@ -160,10 +152,11 @@ public:
   void cleanup_forkables ();
   bool setup_forkables (bool with_forkables)
   {
-    if (forkables_needs == forkables_impossible)
-      return true; /* short cut to not retry fork */
-    /* Once used, always use forkables in current process chain. */
-    if (forkables_needs != forkables_unknown)
+    if (!forkables_supported ())
+      return true; /* no need to retry fork */
+    if (forkables_created)
+      /* Once created, use forkables in current
+	 process chain on first fork try already. */
       with_forkables = true;
     if (with_forkables)
       request_forkables ();
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index ebbed8c..b668d03 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -501,17 +501,56 @@ dll::create_forkable ()
   return false;
 }
 
+bool
+dll_list::forkables_supported ()
+{
+  return cygwin_shared->forkable_hardlink_support >= 0;
+}
+
 /* return the number of characters necessary to store one forkable name */
 size_t
 dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modname)
 {
   /* per process, this is the first forkables-method ever called */
-  if (forkables_needs == forkables_unknown &&
-      !cygwin_shared->prefer_forkable_hardlinks)
-      forkables_needs = forkables_impossible; /* short cut */
+  if (cygwin_shared->forkable_hardlink_support == 0) /* Unknown */
+    {
+      /* check existence of forkables dir */
+      PWCHAR pbuf = nt_max_path_buf ();
+      for (namepart const *part = forkable_nameparts; part->text; ++part)
+	{
+	  if (part->textfunc)
+	    pbuf += part->textfunc (pbuf, -1);
+	  else
+	    pbuf += __small_swprintf (pbuf, L"%W", part->text);
+	  if (part->mutex_from_dir)
+	    break; /* up to first mutex-naming dir */
+	}
+      pbuf = nt_max_path_buf ();
 
-  if (forkables_needs == forkables_impossible)
-    return 0;
+      UNICODE_STRING fn;
+      RtlInitUnicodeString (&fn, pbuf);
+
+      HANDLE dh = INVALID_HANDLE_VALUE;
+      fs_info fsi;
+      if (fsi.update (&fn, NULL) &&
+/* FIXME: !fsi.is_readonly () && */
+	  fsi.is_ntfs ())
+	dh = ntopenfile (pbuf, NULL, FILE_DIRECTORY_FILE);
+      if (dh != INVALID_HANDLE_VALUE)
+	{
+	  cygwin_shared->forkable_hardlink_support = 1; /* Yes */
+	  NtClose (dh);
+	  debug_printf ("enabled");
+	}
+      else
+	{
+	  cygwin_shared->forkable_hardlink_support = -1; /* No */
+	  debug_printf ("disabled, missing or not on NTFS %W", fn.Buffer);
+	}
+    }
+
+  if (!forkables_supported ())
+      return 0;
 
   if (!forkables_dirx_size)
     {
@@ -560,9 +599,6 @@ dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modnam
 void
 dll_list::prepare_forkables_nomination ()
 {
-  if (!forkables_dirx_ntname)
-    return;
-
   dll *d = &dlls.start;
   while ((d = d->next))
     stat_real_file_once (d); /* uses nt_max_path_buf () */
@@ -627,106 +663,19 @@ dll_list::prepare_forkables_nomination ()
 void
 dll_list::update_forkables_needs ()
 {
-  dll *d;
-
-  if (forkables_needs == forkables_unknown)
-    {
-      /* check if filesystem of forkables dir is NTFS */
-      PWCHAR pbuf = nt_max_path_buf ();
-      for (namepart const *part = forkable_nameparts; part->text; ++part)
-	{
-	  if (part->mutex_from_dir)
-	    break; /* leading non-mutex-naming dirs, must exist anyway */
-	  if (part->textfunc)
-	    pbuf += part->textfunc (pbuf, -1);
-	  else
-	    pbuf += __small_swprintf (pbuf, L"%W", part->text);
-	}
-
-      UNICODE_STRING fn;
-      RtlInitUnicodeString (&fn, nt_max_path_buf ());
-
-      fs_info fsi;
-      if (fsi.update (&fn, NULL) &&
-/* FIXME: !fsi.is_readonly () && */
-	  fsi.is_ntfs ())
-	forkables_needs = forkables_disabled; /* check directory itself */
-      else
-	{
-	  debug_printf ("impossible, not on NTFS %W", fn.Buffer);
-	  forkables_needs = forkables_impossible;
-	  cygwin_shared->prefer_forkable_hardlinks = 0;
-	}
-    }
-
-  if (forkables_needs == forkables_impossible)
-    return; /* we have not created any hardlink, nothing to clean up */
-
-  if (forkables_needs == forkables_disabled ||
-      forkables_needs == forkables_needless ||
-      forkables_needs == forkables_created)
-    {
-      /* (re-)check existence of forkables dir */
-      PWCHAR pbuf = nt_max_path_buf ();
-      for (namepart const *part = forkable_nameparts; part->text; ++part)
-	{
-	  if (part->textfunc)
-	    pbuf += part->textfunc (pbuf, -1);
-	  else
-	    pbuf += __small_swprintf (pbuf, L"%W", part->text);
-	  if (part->mutex_from_dir)
-	    break; /* up to first mutex-naming dir */
-	}
-      pbuf = nt_max_path_buf ();
-
-      HANDLE dh = ntopenfile (pbuf, NULL, FILE_DIRECTORY_FILE);
-      if (dh != INVALID_HANDLE_VALUE)
-	{
-	  NtClose (dh);
-	  if (forkables_needs == forkables_disabled)
-	    forkables_needs = forkables_needless;
-	}
-      else if (forkables_needs != forkables_disabled)
-	{
-	  debug_printf ("disabled, disappearing %W", pbuf);
-	  close_mutex ();
-	  denominate_forkables ();
-	  forkables_needs = forkables_disabled;
-	}
-      else
-	debug_printf ("disabled, missing %W", pbuf);
-    }
-
-  if (forkables_needs == forkables_disabled)
-    return;
-
-  if (forkables_needs == forkables_created)
+  if (forkables_created)
     {
       /* already have created hardlinks in this process, ... */
-      forkables_needs = forkables_needless;
-      d = &start;
+      dll *d = &start;
       while ((d = d->next) != NULL)
 	if (d->forkable_ntname && !*d->forkable_ntname)
 	  {
 	    /* ... but another dll was loaded since last fork */
 	    debug_printf ("needed, since last fork loaded %W", d->ntname);
-	    forkables_needs = forkables_needed;
+	    forkables_created = false;
 	    break;
 	  }
     }
-
-  if (forkables_needs > forkables_needless)
-    return; /* no need to check anything else */
-
-  if (forkables_needs != forkables_needless)
-    {
-      /* paranoia */
-      system_printf ("WARNING: invalid forkables_needs value %d",
-		     forkables_needs);
-      return;
-    }
-
-  forkables_needs = forkables_needed;
 }
 
 /* Create the nominated forkable hardlinks and directories as necessary,
@@ -958,7 +907,7 @@ dll_list::close_mutex ()
 void
 dll_list::cleanup_forkables ()
 {
-  if (!forkables_dirx_ntname)
+  if (!forkables_supported ())
     return;
 
   bool locked = close_mutex ();
@@ -1034,58 +983,32 @@ dll_list::set_forkables_inheritance (bool inherit)
 void
 dll_list::request_forkables ()
 {
-  if (!forkables_dirx_ntname)
+  if (!forkables_supported ())
     return;
 
-  /* Even on forkables_impossible, keep the number of open handles
-     stable across the fork, and close them when releasing only. */
   prepare_forkables_nomination ();
 
   update_forkables_needs ();
 
   set_forkables_inheritance (true);
 
-  if (forkables_needs == forkables_disabled)
-    {
-      /* we do not support (re-)enabling on the fly */
-      forkables_needs = forkables_impossible;
-      cygwin_shared->prefer_forkable_hardlinks = 0;
-    }
-
-  if (forkables_needs <= forkables_needless)
-    return;
+  if (forkables_created)
+    return; /* nothing new to create */
 
   dll *d = &start;
   while ((d = d->next))
     d->nominate_forkable (forkables_dirx_ntname);
 
-  bool updated = update_forkables ();
-
-  if (!updated)
-    forkables_needs = forkables_needless;
-  else
-    forkables_needs = forkables_created;
+  if (update_forkables ())
+    forkables_created = true;
 }
 
 
 void
 dll_list::release_forkables ()
 {
-  if (!forkables_dirx_ntname)
+  if (!forkables_supported ())
     return;
 
   set_forkables_inheritance (false);
-
-  if (forkables_needs == forkables_impossible)
-    {
-      cleanup_forkables ();
-
-      dll *d = &start;
-      while ((d = d->next))
-	d->forkable_ntname = NULL;
-
-      cfree (forkables_dirx_ntname);
-      forkables_dirx_ntname = NULL;
-      forkables_mutex_name = NULL;
-    }
 }
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index f449805..0da3d37 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -482,7 +482,7 @@ details. */
    regions.  It is incremented when incompatible changes are made to the shared
    memory region *or* to any named shared mutexes, semaphores, etc. */
 
-#define CYGWIN_VERSION_SHARED_DATA 6
+#define CYGWIN_VERSION_SHARED_DATA 5
 
 /* An identifier used in the names used to create shared objects.  The full
    names include the CYGWIN_VERSION_SHARED_DATA version as well as this
diff --git a/winsup/cygwin/shared.cc b/winsup/cygwin/shared.cc
index 4d754d0..06684f4 100644
--- a/winsup/cygwin/shared.cc
+++ b/winsup/cygwin/shared.cc
@@ -328,7 +328,7 @@ shared_info::initialize ()
       init_obcaseinsensitive ();	/* Initialize obcaseinsensitive */
       tty.init ();			/* Initialize tty table  */
       mt.initialize ();			/* Initialize shared tape information */
-      prefer_forkable_hardlinks = 1;    /* Yes */
+      forkable_hardlink_support = 0;    /* 0: Unknown, 1: Yes, -1: No */
       /* Defer debug output printing the installation root and installation key
 	 up to this point.  Debug output except for system_printf requires
 	 the global shared memory to exist. */
diff --git a/winsup/cygwin/shared_info.h b/winsup/cygwin/shared_info.h
index ad7c8f4..fcc53d7 100644
--- a/winsup/cygwin/shared_info.h
+++ b/winsup/cygwin/shared_info.h
@@ -32,7 +32,7 @@ public:
 /* Data accessible to all tasks */
 
 
-#define CURR_SHARED_MAGIC 0xbc5d6a9cU
+#define CURR_SHARED_MAGIC 0x72c39e6fU
 
 #define USER_VERSION   1
 
@@ -48,7 +48,7 @@ class shared_info
   LONG last_used_bindresvport;
   DWORD obcaseinsensitive;
   mtinfo mt;
-  char prefer_forkable_hardlinks; /* single byte access always is atomic */
+  char forkable_hardlink_support; /* single byte access always is atomic */
 
   void initialize ();
   void init_obcaseinsensitive ();
-- 
2.8.3


--------------787D8B7E91AE3325CBA7D010--
