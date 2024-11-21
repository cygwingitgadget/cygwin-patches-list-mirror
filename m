Return-Path: <SRS0=PnHA=SQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 8218D3857BBA
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 19:42:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8218D3857BBA
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8218D3857BBA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732218178; cv=none;
	b=er6yFTQ4bEwC96vFfb3eJu6E5SeKFy+R2XVSvG5z1AsP0upeYFdnnsR5kBC9WxiBKqAoP0bXVuZKRuJnpFAvrFcJdarP8XYo//75c4HM2R4G9gaChWp3Tic/UVheOTbxM20txhT6feeYwwV6sNDPYR8l9Q1nTEjpOTSYEyORL2o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732218178; c=relaxed/simple;
	bh=zZAj1SVNMiTbDhj8n7qukx/MUuuOelQcWu1VU7jdmMQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=B/S1rRpB0RZNdn151jyvI1xuXILv/wMG2BDMCvZsSjppIfhb/lmgoIB5ypnhVQdWVmDcEd94mlOjMSBWKYATl7x0WAe/bYiqrzJM1NtDIz7cO6X3Ej4pR4EmeHJooYS3lvrYdQPcu1wFOtFT9bogQiI444hp43pzaFNReiWjqjg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8218D3857BBA
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=WLYf40+T
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 454D145C0A
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 14:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=1otcL
	LtVcGUkFLlBlZDhWLn2i80=; b=WLYf40+T8W+gh0dudokcUoD1v5rB3UKP00ZHo
	wswUsUM/0QDe7oshuVs0yaeAeEbt+eLTGjwgOPMiKHFNARlaXjOjpg5FtG1sGyuT
	63DWIVDLpakcm3TBtgjDx9mfOKSOpWkj2AjKevkQdbNpxnPqyhdQuX5G6cuzZLNN
	pYW7Cw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id DE32845C00
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 14:42:57 -0500 (EST)
Date: Thu, 21 Nov 2024 11:42:57 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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
conveniently located in memory already, so make an accessor function to
access that.  (It could also be cached in a member variable for a
simpler accessor, and looked up in init).
---
Note the elif defined (__i386__) case won't compile because it references
the no-longer-present `wow64` value.  This was written and tested against
3.3.6, and the __i386__ case could just go away here...

 winsup/cygwin/local_includes/wincap.h |  3 +++
 winsup/cygwin/path.cc                 |  6 ++----
 winsup/cygwin/wincap.cc               | 28 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local_includes/wincap.h
index c14872787c..41d0e2c041 100644
--- a/winsup/cygwin/local_includes/wincap.h
+++ b/winsup/cygwin/local_includes/wincap.h
@@ -42,6 +42,7 @@ class wincapc
   RTL_OSVERSIONINFOEXW	version;
   char			osnam[40];
   const void		*caps;
+  USHORT		host_mach;
   bool			_is_server;

 public:
@@ -61,6 +62,8 @@ public:
 		     { return (size_t) system_info.dwAllocationGranularity; }
   const char *osname () const { return osnam; }
   const DWORD build_number () const { return version.dwBuildNumber; }
+  const USHORT host_machine () const { return host_mach; }
+  const USHORT current_module_machine () const;

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
index 30d9c14e8d..76c10168d6 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -238,6 +238,8 @@ wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));
 void
 wincapc::init ()
 {
+  USHORT emul_mach;
+
   if (caps)
     return;		// already initialized

@@ -282,4 +284,30 @@ wincapc::init ()

   __small_sprintf (osnam, "NT-%d.%d", version.dwMajorVersion,
 		   version.dwMinorVersion);
+
+  if (!IsWow64Process2 (GetCurrentProcess (), &emul_mach, &host_mach))
+    {
+      /* assume the only way IsWow64Process2 fails for the current process is
+	 that we're running on an OS version where it's not implemented yet.
+	 As such, the only two realistic options are AMD64 or I386 */
+#if defined (__x86_64__)
+      host_mach = IMAGE_FILE_MACHINE_AMD64;
+#elif defined (__i386__)
+      host_mach = wow64 ? IMAGE_FILE_MACHINE_AMD64 : IMAGE_FILE_MACHINE_I386;
+#else
+      /* this should not happen */
+      host_mach = IMAGE_FILE_MACHINE_UNKNOWN;
+#endif
+    }
+}
+
+extern const IMAGE_DOS_HEADER
+dosheader __asm__ ("__image_base__");
+
+const USHORT
+wincapc::current_module_machine () const
+{
+  PIMAGE_NT_HEADERS ntheader = (PIMAGE_NT_HEADERS)((LPBYTE) &dosheader
+                                                   + dosheader.e_lfanew);
+  return ntheader->FileHeader.Machine;
 }
-- 
2.47.0.windows.2

