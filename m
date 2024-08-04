Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 7E85C385841D
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:48:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7E85C385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7E85C385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808141; cv=none;
	b=hQ85iCIboqQ2WxMI4r9k9sUXDYNC4Otay31/sqzeNiIcO5zVuj78B+znK9ZNuIfAsv1w2FLmkJvUynV6ciKoB5UYOgA/dW6mIh5AptNfdX2sAIs6JddpWn6A0ozAHnPL1qfoa6QPh/cKGYcykNqGqAipjAE/34vRO6v6s7+RmXE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808141; c=relaxed/simple;
	bh=uAcp3bE8CqQMi5hMJ7KEOiUxrI4J3bV3IrwlXLmk6fU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VPFh4hy8WvA1IQKzmylZPV66VyW/9da3+ONqkG09IOSWx/k4q5VN2qceCQcnMm4nVEo5R2h5Kps5kVHLs3mHJzIn1j8jhX/ztmZaikWy9IRScjCKPoAFyd4tuRExtZ98w7PHHoBSVlDdsOsu1G8QXqbKHAuAH4gdbgt4XkDHV0Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1D2E
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdffueduteekhffhgfekgfdvteetgffhheevuefhkeegudevveeuleegudfftedunecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1D2E; Sun, 4 Aug 2024 22:48:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/6] Cygwin: Fix warnings about narrowing conversions of NTSTATUS constants
Date: Sun,  4 Aug 2024 22:48:23 +0100
Message-ID: <20240804214829.43085-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix warnings with gcc 12 about narrowing conversions of NTSTATUS
constants when used as case labels, e.g:

> ../../../../src/winsup/cygwin/exceptions.cc: In static member function ‘static int exception::handle(EXCEPTION_RECORD*, void*, CONTEXT*, PDISPATCHER_CONTEXT)’:
> ../../../../src/winsup/cygwin/exceptions.cc:670:10: error: narrowing conversion of ‘-1073741682’ from ‘NTSTATUS’ {aka ‘int’} to ‘unsigned int’ [-Wnarrowing]

See also: c5bdf60ac46401a51a7e974333d9622966e22d67
---
 winsup/cygwin/exceptions.cc          | 2 +-
 winsup/cygwin/local_includes/ntdll.h | 2 +-
 winsup/cygwin/pinfo.cc               | 2 +-
 winsup/cygwin/sigproc.cc             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 28d0431d5..74e5905d5 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -665,7 +665,7 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   siginfo_t si = {};
   si.si_code = SI_KERNEL;
   /* Coerce win32 value to posix value.  */
-  switch (e->ExceptionCode)
+  switch ((NTSTATUS)e->ExceptionCode)
     {
     case STATUS_FLOAT_DIVIDE_BY_ZERO:
       si.si_signo = SIGFPE;
diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_includes/ntdll.h
index 7737ae503..4497fe53f 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -23,7 +23,7 @@ extern GUID __cygwin_socket_guid;
 /* Custom Cygwin-only status codes. */
 #define STATUS_THREAD_SIGNALED	((NTSTATUS)0xe0000001)
 #define STATUS_THREAD_CANCELED	((NTSTATUS)0xe0000002)
-#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((DWORD) 0xe0000269)
+#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)
 
 /* Simplify checking for a transactional error code. */
 #define NT_TRANSACTIONAL_ERROR(s)	\
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 7f1f41d79..d3c55d8d5 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -118,7 +118,7 @@ pinfo_init (char **envp, int envc)
 DWORD
 pinfo::status_exit (DWORD x)
 {
-  switch (x)
+  switch ((NTSTATUS)x)
     {
     case STATUS_DLL_NOT_FOUND:
       {
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 86e4e607a..82836fc3b 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1082,7 +1082,7 @@ child_info::proc_retry (HANDLE h)
   if (!exit_code)
     return EXITCODE_OK;
   sigproc_printf ("exit_code %y", exit_code);
-  switch (exit_code)
+  switch ((NTSTATUS)exit_code)
     {
     case STILL_ACTIVE:	/* shouldn't happen */
       sigproc_printf ("STILL_ACTIVE?  How'd we get here?");
-- 
2.45.1

