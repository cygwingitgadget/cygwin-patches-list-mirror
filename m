Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 630E43857B84; Thu, 24 Jul 2025 13:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 630E43857B84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753362815;
	bh=dca9EhrAunGkxsjjDwPmCSSDv97UpcNs24RNwQKSsws=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qHjLg88ro+n2dLFpJuv+DC1OQ1UqIRIPyQr3qG3iT6kuogFoGrpshjXNNsnDEK+ls
	 pRBF+YIzrx3Ujr9g4Vy2pf4+KlHDFKGfA0Qnh76AinKfjzmFvOIYv/QpHgx9I+XXb/
	 O6xhziKbM9SDW2SmUmGnvRtuwh2ApeUTo2yVgYJM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AAAC3A80DCD; Thu, 24 Jul 2025 15:13:33 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:13:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix handling of archetype fhandler in
 process_fd
Message-ID: <aIIxfYssj6zseSPi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
 <aIIv1EH-BccejUqa@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIIv1EH-BccejUqa@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 24 15:06, Corinna Vinschen wrote:
> On Jul 24 20:57, Takashi Yano wrote:
> > Previously, process_fd failed to correctly handle fhandlers using an
> > archetype. This was due to the missing PATH_OPEN flag in path_conv,
> > which caused build_fh_pc() to skip archetype initialization. The
> > root cause was a bug where open() did not set the PATH_OPEN flag
> > for fhandlers using an archetype.
> > 
> > This patch introduces a new method, path_conv::set_isopen(), to
> > explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
> > open_with_arch().
> 
> Wouldn't this patch fix the problem as well?
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 887e2ef722bf..2801c806edd5 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -4311,7 +4311,7 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
>  {
>    // this->fhandler_termios::init (h, mode, bin);
>    /* Ensure both input and output console handles are open */
> -  int flags = 0;
> +  int flags = PC_OPEN;
>  
>    a &= GENERIC_READ | GENERIC_WRITE;
>    if (a == GENERIC_READ)
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 77a363eb0e3b..10785e240091 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1015,7 +1015,7 @@ fhandler_pty_slave::close (int flag)
>  int
>  fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
>  {
> -  int flags = 0;
> +  int flags = PC_OPEN;
>  
>    a &= GENERIC_READ | GENERIC_WRITE;
>    if (a == GENERIC_READ)
> 
> 
> Corinna

No, it wouldn't.  flags are not or'ed in the followup code.  Sigh.

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 887e2ef722bf..57e69f2c9791 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4311,15 +4311,15 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
 {
   // this->fhandler_termios::init (h, mode, bin);
   /* Ensure both input and output console handles are open */
-  int flags = 0;
+  int flags = PC_OPEN;
 
   a &= GENERIC_READ | GENERIC_WRITE;
   if (a == GENERIC_READ)
-    flags = O_RDONLY;
-  if (a == GENERIC_WRITE)
-    flags = O_WRONLY;
-  if (a == (GENERIC_READ | GENERIC_WRITE))
-    flags = O_RDWR;
+    flags |= O_RDONLY;
+  else if (a == GENERIC_WRITE)
+    flags |= O_WRONLY;
+  else if (a == (GENERIC_READ | GENERIC_WRITE))
+    flags |= O_RDWR;
   open_with_arch (flags | O_BINARY | (h ? 0 : O_NOCTTY));
 
   return !tcsetattr (0, &get_ttyp ()->ti);
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 77a363eb0e3b..ef0f2d766bc3 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1015,15 +1015,15 @@ fhandler_pty_slave::close (int flag)
 int
 fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
 {
-  int flags = 0;
+  int flags = PC_OPEN;
 
   a &= GENERIC_READ | GENERIC_WRITE;
   if (a == GENERIC_READ)
-    flags = O_RDONLY;
-  if (a == GENERIC_WRITE)
-    flags = O_WRONLY;
-  if (a == (GENERIC_READ | GENERIC_WRITE))
-    flags = O_RDWR;
+    flags |= O_RDONLY;
+  else if (a == GENERIC_WRITE)
+    flags |= O_WRONLY;
+  else if (a == (GENERIC_READ | GENERIC_WRITE))
+    flags |= O_RDWR;
 
   int ret = open_with_arch (flags);
 

Corinna
