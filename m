Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C4071385C6DE
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:31:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4071385C6DE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4071385C6DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750969904; cv=none;
	b=mGq6aIWqVqqwCVR+Tv0HntLSIuGPAqwExHGS90aBI+x+qo/S6Yq5UeQ4LJtxqNzUYbvpObiUOxr8NB5hQ8++t7svFNl2LnLZPdcM46QLeqknqddPiGotcGmAlTD23C4rx9BejAUnakGi6D3QFuXesRUg+mrZiLsgBr9vTvdbdbw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750969904; c=relaxed/simple;
	bh=ChIQOUAsgJVzY/zDmM6Cne+1Wuwjh1Ia/VhKdxR7n0g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mdab8tRZOkf7njkZS9wPCxwp7jkYL2RkfO3m3XOka9b52igxxY/euDPYi3eT5rgWyablxM0GbzoYwBRbvYIZuXqI2NEaBd6nD7WCLism/MLEb9EKGF72ho8S5pv3EJ+lELY/dJ12FyRTfVNGIdArILMZDl+zqYG4cy4edSAXlrs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C4071385C6DE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=HpJ5aa93
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A07F245D3B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=1kohR
	QAzaXeD+1iTRoaVAw2ySks=; b=HpJ5aa93ge3983YL810wB1DyQPDJoUCbc3PRv
	O9EAs2RNAtfLVwTNc8iP97JDxYEETj548n4eenfXgUnw+MCT1xByf3lXQnKeLiJ8
	8r1r8QGLFz3QR7pDC+PijR/E8qWST7OwCa29AhefY0F677xVXl/fLY+uyxDvCKK9
	ll22Wc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9ACF445D37
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:31:44 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:31:44 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This program is currently meant to test standard file handles and
current working directory (since these are settable via posix_spawn),
but could be extended to add additional checks if other cygwin-to-win32
process properties need to be tested.

Change cygrun environment variable to mingwtestdir, and use that instead
in cygrun.sh, so that other tests can find mingw test executables using
the environment variable.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
-Wl,--disable-high-entropy-va in LDFLAGS?

 winsup/testsuite/Makefile.am                  |   2 +-
 winsup/testsuite/cygrun.sh                    |   4 +-
 winsup/testsuite/mingw/Makefile.am            |   7 +-
 .../winsup.api/posix_spawn/winchild.c         | 130 ++++++++++++++++++
 4 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/winchild.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 957554a828..03f65d8184 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -349,7 +349,7 @@ XFAIL_TESTS = \
 LOG_COMPILER = $(srcdir)/cygrun.sh

 export runtime_root=$(abs_builddir)/testinst/bin
-export cygrun=$(builddir)/mingw/cygrun
+export mingwtestdir=$(builddir)/mingw

 # Set up things in the Cygwin 'installation' at testsuite/testinst/ to provide
 # things which tests need to work
diff --git a/winsup/testsuite/cygrun.sh b/winsup/testsuite/cygrun.sh
index bf1d5cc6b5..f1673e4dbd 100755
--- a/winsup/testsuite/cygrun.sh
+++ b/winsup/testsuite/cygrun.sh
@@ -11,7 +11,7 @@ export PATH="$runtime_root:${PATH}"
 if [ "$1" = "./mingw/cygload" ]
 then
     windows_runtime_root=$(cygpath -m $runtime_root)
-    $cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
+    $mingwtestdir/cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
 else
-    cygdrop $cygrun $exe
+    cygdrop $mingwtestdir/cygrun $exe
 fi
diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Makefile.am
index 772e73405f..25300a15d9 100644
--- a/winsup/testsuite/mingw/Makefile.am
+++ b/winsup/testsuite/mingw/Makefile.am
@@ -16,7 +16,7 @@ override CC = @MINGW_CC@
 override CXX = @MINGW_CXX@
 AM_CPPFLAGS =

-noinst_PROGRAMS = cygrun cygload
+noinst_PROGRAMS = cygrun cygload winchild

 cygrun_SOURCES = \
 	../cygrun.c
@@ -24,3 +24,8 @@ cygrun_SOURCES = \
 cygload_SOURCES = \
 	../winsup.api/cygload.cc
 cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
+
+winchild_SOURCES = \
+	../winsup.api/posix_spawn/winchild.c
+winchild_LDFLAGS=-municode
+winchild_LDADD=-lntdll
diff --git a/winsup/testsuite/winsup.api/posix_spawn/winchild.c b/winsup/testsuite/winsup.api/posix_spawn/winchild.c
new file mode 100644
index 0000000000..6fdfa002c0
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/winchild.c
@@ -0,0 +1,130 @@
+#define WIN32_LEAN_AND_MEAN
+#include <windows.h>
+#include <winternl.h>
+#include <ctype.h>
+#include <stdio.h>
+
+
+int wmain (int argc, wchar_t **argv)
+{
+  if (argc != 3)
+    {
+      fwprintf (stderr, L"Usage: %ls handle expected\n", argv[0]);
+      return 1;
+    }
+
+  if (!wcscmp (argv[1], L"CWD"))
+    {
+      LPWSTR buffer;
+      DWORD len = GetCurrentDirectoryW (0, NULL);
+      if (len == 0)
+        {
+	  fwprintf (stderr, L"%ls: GetCurrentDirectory failed with error %lu\n",
+		    argv[0], GetLastError ());
+	  return 2;
+	}
+      buffer = malloc (len * sizeof (WCHAR));
+      if (GetCurrentDirectoryW (len, buffer) != len - 1)
+        {
+	  fwprintf (stderr, L"%ls: GetCurrentDirectory failed with error %lu\n",
+		    argv[0], GetLastError ());
+	  return 2;
+	}
+      if (wcscmp (argv[2], buffer))
+        {
+	  fwprintf (stderr, L"%ls: CWD '%ls' != expected '%ls'\n",
+		    argv[0], buffer, argv[2]);
+	  free (buffer);
+	  return 4;
+	}
+      free (buffer);
+    }
+  else if (iswdigit (argv[1][0]) && !argv[1][1])
+    {
+      HANDLE stdhandle;
+      DWORD nStdHandle;
+      switch (argv[1][0])
+      {
+	case L'0':
+	  nStdHandle = STD_INPUT_HANDLE;
+	  break;
+	case L'1':
+	  nStdHandle = STD_OUTPUT_HANDLE;
+	  break;
+	case L'2':
+	  nStdHandle = STD_ERROR_HANDLE;
+	  break;
+	default:
+	  fwprintf (stderr, L"%ls: Unknown handle '%ls'\n", argv[0], argv[1]);
+	  return 1;
+      }
+
+      stdhandle = GetStdHandle (nStdHandle);
+      if (stdhandle == INVALID_HANDLE_VALUE)
+        {
+	  fwprintf (stderr, L"%ls: Failed getting standard handle %ls: %lu\n",
+	      argv[0], argv[1], GetLastError ());
+	  return 2;
+	}
+      else if (stdhandle == NULL)
+	{
+	  if (wcscmp (argv[2], L"<CLOSED>"))
+	    {
+	      fwprintf (stderr,
+			L"%ls: Handle %ls name '%ls' != expected '%ls'\n",
+			argv[0], argv[1], L"<CLOSED>", argv[2]);
+	      return 4;
+	    }
+	}
+      else
+        {
+	  LPWSTR buf, win32path;
+	  buf = malloc (65536);
+	  if (!GetFinalPathNameByHandleW (stdhandle, buf,
+					  65536 / sizeof (WCHAR),
+					  FILE_NAME_OPENED|VOLUME_NAME_DOS))
+	    {
+	      POBJECT_NAME_INFORMATION pinfo = (POBJECT_NAME_INFORMATION) buf;
+	      DWORD err = GetLastError ();
+	      ULONG len;
+	      NTSTATUS status = NtQueryObject (stdhandle, ObjectNameInformation,
+					       pinfo, 65536, &len);
+	      if (!NT_SUCCESS (status))
+		{
+		  fwprintf (stderr,
+		      L"%ls: NtQueryObject for handle %ls failed: 0x%08x\n",
+		      argv[0], argv[1], status);
+		  free (buf);
+		  return 3;
+		}
+
+	      pinfo->Name.Buffer[pinfo->Name.Length / sizeof (WCHAR)] = L'\0';
+	      win32path = pinfo->Name.Buffer;
+	    }
+	  else
+	    {
+	      static const WCHAR prefix[] = L"\\\\?\\";
+	      win32path = buf;
+	      if (!wcsncmp (win32path, prefix,
+			    sizeof (prefix) / sizeof (WCHAR) - 1))
+		win32path += sizeof (prefix) / sizeof (WCHAR) - 1;
+	    }
+
+	  if (wcscmp (win32path, argv[2]))
+	    {
+	      fwprintf (stderr,
+			L"%ls: Handle %ls name '%ls' != expected '%ls'\n",
+			argv[0], argv[1], win32path, argv[2]);
+	      free (buf);
+	      return 4;
+	    }
+	  free (buf);
+	}
+    }
+  else
+    {
+      fwprintf (stderr, L"%ls: Unknown handle '%ls'\n", argv[0], argv[1]);
+      return 1;
+    }
+  return 0;
+}
-- 
2.49.0.windows.1

