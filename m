Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 408EF3858288; Tue,  7 Jan 2025 16:49:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 408EF3858288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736268541;
	bh=gR1ggt+1mf2JCM2mJaWxxXlXn/AoDCsDJqAXbs3qgpQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UA5FeN2vWSAL74dWBdYI9JVK/xMymNkA7qHmZpRUpyCCmhAXXLQEFQ3fPcQDhHFzO
	 HpbDz2tGrpeWgEvY7UQyKE0O2SOA8Ze3/iGYGV5JdmD8jrVBRYkyOe5HYc3XsbDIqN
	 DdyHbV+BSBjdEF63ui2o5fGoS+gO+NkUtn6HMGnE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6ECFCA80B76; Tue,  7 Jan 2025 17:48:59 +0100 (CET)
Date: Tue, 7 Jan 2025 17:48:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: access: Fix X_OK behaviour for administrator
Message-ID: <Z31a-_lO1hs4yc5I@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pgz/B0/QSi4gFxlU"
Content-Disposition: inline
In-Reply-To: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>


--pgz/B0/QSi4gFxlU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Takashi,

Happy New Year!

On Dec 26 21:34, Takashi Yano wrote:
> @@ -613,6 +613,22 @@ check_file_access (path_conv &pc, int flags, bool effective)
>    if (flags & X_OK)
>      desired |= FILE_EXECUTE;
>  
> +  /* The Administrator has full access permission regardless of ACL,
> +     however, access() should return -1 if 'x' permission is set
> +     for neither user, group nor others, even though NtOpenFile()
> +     succeeds. */

The explanation isn't quite right, see below.

> +  if ((flags & X_OK) && !pc.isdir ())
> +    {
> +      struct stat st;
> +      if (stat (pc.get_posix (), &st))
> +	goto out;
> +      else if ((st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)) == 0)
> +	{
> +	  set_errno (EACCES);
> +	  goto out;
> +	}
> +    }
> +

Calling stat here is not the right thing to do.  It slows down access()
as well as exec'ing applications a lot because it adds the overhead of a
full system call on each invocation.

When I saw your patch this morning for the first time, I was inclined to
request that you simply revert a0933cd17d19 ("Correction for samba/SMB
share").  The behaviour on Samba was not a regression, but this here
is, so it would be prudent to rethink the entire approach.

However, it occured to me that there may be a simpler way to fix this:

The reason for this behaviour is the way SE_BACKUP_PRIVILEGE works.  To
allow a user with backup privileges full access to files, you have to
enable the SE_BACKUP_PRIVILEGE in the user's token *and* you have to
open files with FILE_OPEN_FOR_BACKUP_INTENT.  The problem now is this:
SE_BACKUP_PRIVILEGE + FILE_OPEN_FOR_BACKUP_INTENT allow to open the
file, no matter what.  In particular, they allow to open the file for
FILE_EXECUTE, even if the execute perms in the ACL deny the user
execution of the file.

So... given how this is supposed to work, we must not use the
FILE_OPEN_FOR_BACKUP_INTENT flag when checking for execute permissions
and the result should be the desired one.  I tested this locally, and I
don't see a regression compared to 3.5.4.

Patch attached.  Please review.


Thanks,
Corinna

--pgz/B0/QSi4gFxlU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Cygwin-access-Fix-X_OK-behaviour-for-backup-operator.patch"

From 351d514c8058a67085b3496d5f5648577fff8f32 Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Tue, 7 Jan 2025 17:44:44 +0100
Subject: [PATCH] Cygwin: access: Fix X_OK behaviour for backup operators and
 admins

After commit a0933cd17d19, access(_, X_OK) returns 0 if the user
holds SE_BACKUP_PRIVILEGE, even if the file's ACL denies execution
to the user.  This is triggered by trying to open the file with
FILE_OPEN_FOR_BACKUP_INTENT.

Fix check_file_access() so it checks for X_OK without specifying
the FILE_OPEN_FOR_BACKUP_INTENT flag.

Rearrange function slightly and add comments for easier comprehension.

Fixes: a0933cd17d19 ("Cygwin: access: Correction for samba/SMB share")
Reported-by: Bruno Haible <bruno@clisp.org>
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/sec/base.cc | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/sec/base.cc b/winsup/cygwin/sec/base.cc
index 647c27ec617e..e5c8d69edc52 100644
--- a/winsup/cygwin/sec/base.cc
+++ b/winsup/cygwin/sec/base.cc
@@ -604,25 +604,38 @@ check_access (security_descriptor &sd, GENERIC_MAPPING &mapping,
 int
 check_file_access (path_conv &pc, int flags, bool effective)
 {
-  int ret = -1;
+  NTSTATUS status = STATUS_SUCCESS;
   ACCESS_MASK desired = 0;
+  OBJECT_ATTRIBUTES attr;
+  IO_STATUS_BLOCK io;
+  HANDLE h = NULL;
+  int ret = -1;
+
   if (flags & R_OK)
     desired |= FILE_READ_DATA;
   if (flags & W_OK)
     desired |= FILE_WRITE_DATA;
-  if (flags & X_OK)
-    desired |= FILE_EXECUTE;
 
   if (!effective)
     cygheap->user.deimpersonate ();
 
-  OBJECT_ATTRIBUTES attr;
   pc.init_reopen_attr (attr, pc.handle ());
-  NTSTATUS status;
-  IO_STATUS_BLOCK io;
-  HANDLE h;
-  status = NtOpenFile (&h, desired, &attr, &io, FILE_SHARE_VALID_FLAGS,
-		       FILE_OPEN_FOR_BACKUP_INTENT);
+
+  /* For R_OK and W_OK we check with FILE_OPEN_FOR_BACKUP_INTENT since
+     we want to enable the full power of backup/restore privileges. */
+  if (desired)
+    status = NtOpenFile (&h, desired, &attr, &io, FILE_SHARE_VALID_FLAGS,
+			 FILE_OPEN_FOR_BACKUP_INTENT);
+  /* For X_OK, drop the FILE_OPEN_FOR_BACKUP_INTENT flag.  If the caller
+     holds SE_BACKUP_PRIVILEGE, FILE_OPEN_FOR_BACKUP_INTENT opens the file,
+     no matter what access is requested. */
+  if (NT_SUCCESS (status) && (flags & X_OK))
+    {
+      if (h)
+	NtClose (h);
+      status = NtOpenFile (&h, FILE_EXECUTE, &attr, &io,
+			   FILE_SHARE_VALID_FLAGS, 0);
+    }
   if (NT_SUCCESS (status))
     {
       NtClose (h);
-- 
2.47.1


--pgz/B0/QSi4gFxlU--
