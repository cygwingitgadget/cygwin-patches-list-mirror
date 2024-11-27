Return-Path: <SRS0=5dpU=SW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 368F83858CDB
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 19:22:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 368F83858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 368F83858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732735370; cv=none;
	b=fUghfNBb1nO1yeHaxSAaeEaWEJzGVqpiEqwYf/5Z7b6ie6eVCm2DByfjJ2rWryu2UixzzN6Vxj31GFZrngXCct2Z9SW1KSfzZcsLsx7uKjSz6RUwDXjmwwg2k1KK4Aal2HZyE0D2PT6J14SpalF9LYjXxu5syWFGJRLpo3/jrsY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732735370; c=relaxed/simple;
	bh=AuglglgOAiwizNJ8ePET/KxmUikvXwu8qTFuiCqmmBQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jHDOgyB94+qRJO5L98X1R/W+0p9yuadONCT2gL2gmYp3uA9k8QKWMF+ci2O6irBvDgqaq7FxKYCKm/aATXi6zIDtklgvJFMMbKLzSUVUHI8mgl53X7o02o5Em6epfC0sfAL0wO4k0RXknWL5Eu3roQGOH0Lnnia/5kpwThl35x0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 368F83858CDB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=hsynvXyB
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C547B45C83
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 14:22:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Y4LrU
	UWxVJbmgEf3aKwxLAZp/YU=; b=hsynvXyBfhpe5DtwXo4CEVwhw+gKZVkZb3HS8
	HvI5d+HPcf1qjCiQx7BtWzecYWCzVP+FZUS+DK2S/Fw6brd3ealSlpnviiLB8kB+
	mxalUmcxjB/bpI0kHGyNgZoPMmoTBDPRICj2U9c759JM+tdeEP5q9rc8d/BfzlIP
	t+34UE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id BCAE945C82
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 14:22:49 -0500 (EST)
Date: Wed, 27 Nov 2024 11:22:49 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <4b3e07b2-bd40-088e-6a90-f6d7dca00a54@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This was already used in the FAST_CWD check, and could be used in a
couple other places.

I found the "emulated"/process value returned from the function largely
useless, so I did not cache it.  It is useless because, as the docs say,
it is set to IMAGE_FILE_MACHINE_UNKNOWN (0) if the process is not
running under WOW64, but Microsoft also doesn't consider x64-on-ARM64 to
be WOW64, so it is set to 0 regardless if the process is ARM64 or x64.
You can tell the difference via
GetProcessInformation(ProcessMachineTypeInfo), but for the current
process even that's overkill: what we really want to know is the
IMAGE_FILE_MACHINE_* constant for the Cygwin dll itself, which is
conveniently located in memory already, so cache that in wincap also for
easy comparisons.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
v2: rename current_module_machine to cygwin_machine, adjust comment and
remove ifdefs from fallback case when IsWow64Process2 fails.

v3: cache cygwin_mach as member in wincapc, rename extern IMAGE_DOS_HEADER
to __image_base__ to avoid __asm__

 winsup/cygwin/local_includes/wincap.h |  4 ++++
 winsup/cygwin/path.cc                 |  6 ++----
 winsup/cygwin/wincap.cc               | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local_includes/wincap.h
index c14872787c..250866f061 100644
--- a/winsup/cygwin/local_includes/wincap.h
+++ b/winsup/cygwin/local_includes/wincap.h
@@ -42,6 +42,8 @@ class wincapc
   RTL_OSVERSIONINFOEXW	version;
   char			osnam[40];
   const void		*caps;
+  USHORT		host_mach;
+  USHORT		cygwin_mach;
   bool			_is_server;

 public:
@@ -61,6 +63,8 @@ public:
 		     { return (size_t) system_info.dwAllocationGranularity; }
   const char *osname () const { return osnam; }
   const DWORD build_number () const { return version.dwBuildNumber; }
+  const USHORT host_machine () const { return host_mach; }
+  const USHORT cygwin_machine () const { return cygwin_mach; }

 #define IMPLEMENT(cap) cap() const { return ((wincaps *) this->caps)->cap; }

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 5cfcbc0f2f..869383c836 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4617,14 +4617,12 @@ find_fast_cwd_pointer ()
 static fcwd_access_t **
 find_fast_cwd ()
 {
-  USHORT emulated, hosted;
   fcwd_access_t **f_cwd_ptr;

-  /* First check if we're running in WOW64 on ARM64 emulating AMD64.  Skip
+  /* First check if we're running on an ARM64 system.  Skip
      fetching FAST_CWD pointer as long as there's no solution for finding
      it on that system. */
-  if (IsWow64Process2 (GetCurrentProcess (), &emulated, &hosted)
-      && hosted == IMAGE_FILE_MACHINE_ARM64)
+  if (wincap.host_machine () == IMAGE_FILE_MACHINE_ARM64)
     return NULL;

   /* Fetch the pointer but don't set the global fast_cwd_ptr yet.  First
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 30d9c14e8d..deecf8ba51 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -235,9 +235,15 @@ static const wincaps wincap_11 = {

 wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));

+extern IMAGE_DOS_HEADER
+__image_base__;
+
 void
 wincapc::init ()
 {
+  PIMAGE_NT_HEADERS ntheader;
+  USHORT emul_mach;
+
   if (caps)
     return;		// already initialized

@@ -282,4 +288,17 @@ wincapc::init ()

   __small_sprintf (osnam, "NT-%d.%d", version.dwMajorVersion,
 		   version.dwMinorVersion);
+
+  if (!IsWow64Process2 (GetCurrentProcess (), &emul_mach, &host_mach))
+    {
+      /* If IsWow64Process2 succeeded, it filled in host_mach.  Assume the only
+	 way it fails for the current process is that we're running on an OS
+	 version where it's not implemented yet.  As such, the only realistic
+	 option for host_mach is AMD64 */
+      host_mach = IMAGE_FILE_MACHINE_AMD64;
+    }
+
+  ntheader = (PIMAGE_NT_HEADERS)((LPBYTE) &__image_base__
+				 + __image_base__.e_lfanew);
+  cygwin_mach = ntheader->FileHeader.Machine;
 }
-- 
2.47.0.windows.2

