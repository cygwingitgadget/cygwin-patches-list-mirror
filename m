Return-Path: <cygwin-patches-return-8872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112653 invoked by alias); 9 Oct 2017 16:15:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112626 invoked by uid 89); 9 Oct 2017 16:15:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*RU:sk:michael, H*r:sk:michael, Hx-spam-relays-external:sk:michael, endless
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 16:15:31 +0000
X-IPAS-Result: =?us-ascii?q?A2HXBADLn9tZ/+shHKxdHgYMhEGBFYN6rTAfhnkKEwiBE4Q?= =?us-ascii?q?NhH4UAQIBAQEBAQEBA4EQhAJbOwEpgQIDAQIrAlEbBgIBAbI1gieLIgwBFg+CN?= =?us-ascii?q?3aFaIdLVyyCR4JhBaE1gi6CDoMij3iIbocsApFzAYNmgTk2ZEx4h310hyeCQwE?= =?us-ascii?q?BAQ?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2017 18:15:28 +0200
Received: from [172.28.41.101]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1e1aiF-0004h9-98	for cygwin-patches@cygwin.com; Mon, 09 Oct 2017 18:15:27 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] initialize variable for RtlLookupFunctionEntry
Message-ID: <e7a6c229-229d-47a5-e645-fe8ea312deca@ssi-schaefer.com>
Date: Mon, 09 Oct 2017 16:15:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------424AF5763E47DA6E36A14E05"
X-SW-Source: 2017-q4/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------424AF5763E47DA6E36A14E05
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 799

Hi,

for the records: The (random) situation leading to attached patch:

Reproducibly encountered the binutils-nm process falling into an
endless loop during some build process - but the reproducibility
depended on the length and/or the number of elements in the PATH
environment variable. Attaching with gdb shows endless wait for
tls::stacklock in _sigbe. More debugging outlines that nm first
received the expected SIGPIPE, but subsequently received SIGSEGV
while in the RtlLookupFunctionEntry windows function, causing no
signal handler to be finally executed, but returning to _sigbe.

The command in question (with longer PATH environment variable) was:
$ x86_64-pc-cygwin-nm -f posix -A /lib/libcygwin.a | sed 1q
It was important to locate nm via PATH, not with /path/to/nm.

Thanks!
/haubi/

--------------424AF5763E47DA6E36A14E05
Content-Type: text/x-patch;
 name="0001-cygwin-initialize-variable-for-stack-unwinding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-cygwin-initialize-variable-for-stack-unwinding.patch"
Content-length: 940

From b029e683e2a03879c3c1cee06bf6cd2af86b67d9 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Mon, 9 Oct 2017 17:37:40 +0200
Subject: [PATCH] cygwin: initialize variable for stack unwinding

The third argument of RtlLookupFunctionEntry actually is documented as
_Inout_opt_ for both x64 and ARM, although generic doc says _Out_ only.

* exceptions.cc (__unwind_single_frame): Initialize hist variable.
---
 winsup/cygwin/exceptions.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 743c73200..a3ee5cf71 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -280,7 +280,7 @@ __unwind_single_frame (PCONTEXT ctx)
 {
   PRUNTIME_FUNCTION f;
   ULONG64 imagebase;
-  UNWIND_HISTORY_TABLE hist;
+  UNWIND_HISTORY_TABLE hist = {0};
   DWORD64 establisher;
   PVOID hdl;
 
-- 
2.14.2


--------------424AF5763E47DA6E36A14E05--
