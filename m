Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 31872385828E; Tue, 10 Dec 2024 13:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31872385828E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733835656;
	bh=jsPXhsgRONI9e3ipXn8UpfXlNa7QOe16JISwVhyXKZg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lENcjXMmWoCKB2Q0I3SAtPWjNsr87mSwMxIh7VZId7RmDLUm1db+cScBF+0tCNoqS
	 +qK7hbOulmxZxvySzpQ6/hjDaBKh/xiE++lDbWvXaK6bpyDnBCBjtkyO7U17rcmsNX
	 t20yI05Ym4cSXb+t3SAgsqXiiTzUrfkYP7ROW580=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 04EB9A8093F; Tue, 10 Dec 2024 14:00:53 +0100 (CET)
Date: Tue, 10 Dec 2024 14:00:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-ID: <Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
 <ZztqpBESgcTXcd3d@calimero.vinschen.de>
 <20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
 <Zzz7FJim9kIiqjyy@calimero.vinschen.de>
 <20241208081338.e097563889a03619fc467930@nifty.ne.jp>
 <Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
 <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
 <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
 <Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
 <20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Dec 10 21:21, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 9 Dec 2024 16:26:53 +0100
> Corinna Vinschen wrote:
> > On Dec  9 22:57, Takashi Yano wrote:
> > > On Mon, 9 Dec 2024 22:44:00 +0900
> > > Takashi Yano wrote:
> > > > On Mon, 9 Dec 2024 12:11:56 +0100
> > > > Corinna Vinschen wrote:
> > > > > init_reopen_attr() uses the "open by handle" functionality as in the
> > > > > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > > > > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > > > > fails for you.
> > > > 
> > > > I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> > > > for what handle to be passed.
> > > > 
> > > > > > What handle should I pass to pc.init_reopen_attr()?
> > > > > 
> > > > > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > > > > perhaps?
> > > > 
> > > > I have tried pc.handle() and suceeded. Thanks for advice!
> > > 
> > > No! pc.handle() sometimes seems to be NULL....
> > 
> > Can you please figure out in which scenario it's NULL?  Theoretically
> > the function shouldn't even be called in this case.
> 
> This seems to happen when check_file_access() is called from av::setup()
> (spawn.cc:1237) called from child_info_spawn::worker() (spawn.cc:358).

Huh, yeah, thanks for tracking this down.  And this code snippet is
actually only called if we *failed* opening the file, so there's no
usable handle.

Try this:


From 23387c343381ba01d02210257e33cf2691611c2d Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Tue, 10 Dec 2024 13:55:54 +0100
Subject: [PATCH] Cygwin: path_conv: allow NULL handle in init_reopen_attr()

init_reopen_attr() doesn't guard against a NULL handle.  However,
there are scenarios calling functions deliberately with a NULL handle,
for instance, av::setup() calling check_file_access() only if opening
the file did NOT succeed.

So check for a NULL handle in init_reopen_attr() and if so, use the
name based approach filling the OBJECT_ATTRIBUTES struct, just as in
the has_buggy_reopen() case.

Fixes: 4c9d01fdad2a ("* mount.h (class fs_info): Add has_buggy_reopen flag and accessor methods.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/local_includes/path.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 3dd21d975abf..2a05cf44d40a 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -323,7 +323,7 @@ class path_conv
   }
   inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
   {
-    if (has_buggy_reopen ())
+    if (!h || has_buggy_reopen ())
       InitializeObjectAttributes (&attr, get_nt_native_path (),
 				  objcaseinsensitive (), NULL, NULL)
     else
-- 
2.47.0



