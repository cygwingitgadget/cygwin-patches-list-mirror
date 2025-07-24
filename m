Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2F3663858C56; Thu, 24 Jul 2025 13:06:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F3663858C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753362390;
	bh=Xql8bpDx8cfKM1VJThJ2K81hBqdrNjzrkj6KRB8A2xU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cGMc/ehO0qeN1IDq2Vs36SE8T7DSDl8AU/RwYXLnHr7hIwWNRXJlf3P+rU5ldEPlz
	 ob5IxkQgO41h5qU2qNxOdK14RH/nl9GqHojvfiC9hSoJP5SGruneHTkosLV1BoqCGS
	 6lera4qj2m92pUm0nbLGtpu0IiHAazc6hyj3aZ8o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 09F74A80DCD; Thu, 24 Jul 2025 15:06:28 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:06:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix handling of archetype fhandler in
 process_fd
Message-ID: <aIIv1EH-BccejUqa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 24 20:57, Takashi Yano wrote:
> Previously, process_fd failed to correctly handle fhandlers using an
> archetype. This was due to the missing PATH_OPEN flag in path_conv,
> which caused build_fh_pc() to skip archetype initialization. The
> root cause was a bug where open() did not set the PATH_OPEN flag
> for fhandlers using an archetype.
> 
> This patch introduces a new method, path_conv::set_isopen(), to
> explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
> open_with_arch().

Wouldn't this patch fix the problem as well?

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 887e2ef722bf..2801c806edd5 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4311,7 +4311,7 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
 {
   // this->fhandler_termios::init (h, mode, bin);
   /* Ensure both input and output console handles are open */
-  int flags = 0;
+  int flags = PC_OPEN;
 
   a &= GENERIC_READ | GENERIC_WRITE;
   if (a == GENERIC_READ)
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 77a363eb0e3b..10785e240091 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1015,7 +1015,7 @@ fhandler_pty_slave::close (int flag)
 int
 fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
 {
-  int flags = 0;
+  int flags = PC_OPEN;
 
   a &= GENERIC_READ | GENERIC_WRITE;
   if (a == GENERIC_READ)


Corinna
