Return-Path: <cygwin-patches-return-9082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56559 invoked by alias); 5 Jun 2018 13:05:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56539 invoked by uid 89); 5 Jun 2018 13:05:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS,TIME_LIMIT_EXCEEDED autolearn=unavailable version=3.3.2 spammy=H*r:4.77, releasing, HTo:U*cygwin-patches
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 13:05:11 +0000
X-IPAS-Result: =?us-ascii?q?A2GjBQA3ihZb/+shHKwmLgUDHAEBAQQBAQoBAYQlgSeDeJZ?= =?us-ascii?q?BlmwLEwiBFYM8TgEIgW03FQECAQEBAQEBAgICgQQMgieBZ189ASkEfgMBAisCU?= =?us-ascii?q?RsGAgEBgx4CqR6BaTOEWINogVkPilWBDySHJBJFASaCOYJUAphuBwKBZ4FggiW?= =?us-ascii?q?IcYIChXiFJQGOJAGCeoFXSYEscIMTCYIXF4MTiwZtjHuCRwEB?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2018 15:05:06 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1fQBe4-0000Gg-Sc; Tue, 05 Jun 2018 15:05:04 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
Message-ID: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com>
Date: Tue, 05 Jun 2018 13:05:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9B5113787B706A3E525AB25A"
X-SW-Source: 2018-q2/txt/msg00039.txt.bz2

This is a multi-part message in MIME format.
--------------9B5113787B706A3E525AB25A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 2110

Hi,

I'm using attached patch for a while now, and orphan cygpid.N shared memory
instances are gone for otherwise completely unknown windows process ids.

However, I do see defunct processes now which's PPID does not exist (any more),
causing the same trouble because their windows process handle is closed but
their cygpid.N shmem handle is not.

For example, there is no PID 1768 anywhere, although it is the parent of both
the <defunct> processes:
$ ps -e
      PID    PPID    PGID     WINPID   TTY         UID    STIME COMMAND
     2416       1    1496       2416  ?         197610   May 25 /usr/bin/python2.7
      560       1     560        560  ?         197613   May 25 /usr/bin/cygrunsrv
     2348       1    2348       2348  ?         197612   May 25 /usr/bin/cygrunsrv
     1132       1    1132       1132  ?         197612   May 16 /usr/bin/cygrunsrv
      440    2028     440        740  pty0      197609   May 29 /tools/haubi/gentoo/test/usr/bin/bash
     3664    1768    3612       3664  ?         197610 12:25:01 /usr/bin/python2.7 <defunct>
     2852    2704    2852       2364  ?         197612   May 25 /usr/sbin/sshd
     2268     560    2268       2128  ?         197613   May 25 /usr/libexec/sendmail
     2968    1768    3612       1500  ?         197610 12:25:01 /usr/bin/tail <defunct>
S    2832     512    2832       2312  pty0      197609 10:57:51 /usr/bin/vim
     2028    2852    2028       2000  pty0      197609   May 25 /usr/bin/bash
     1164    1132    1164       1256  ?         197612   May 16 /usr/sbin/cron
      512     440     512       1544  pty0      197609   May 29 /tools/haubi/gentoo/test/usr/bin/bash
     3264     512    3264       1488  pty0      197609 12:43:35 /usr/bin/ps
     2704    2348    2704       2856  ?         197612   May 25 /usr/sbin/sshd

That missing 1768 process for sure was started as (grand) children of 2416.

Problem is again that another fork'ed child processes with PID 1768, 2968, 3612
and probably others fail to initialize.

But I have no idea whether attached patch is causing or uncovering this issue...

Any idea?

Thanks!
/haubi/

--------------9B5113787B706A3E525AB25A
Content-Type: text/x-patch;
 name="0001-fork-remove-cygpid.N-sharedmem-on-fork-failure.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-fork-remove-cygpid.N-sharedmem-on-fork-failure.patch"
Content-length: 1474

From 45e0fb72fea4fe32f572265c55135ff4dbd853ad Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Tue, 5 Jun 2018 12:40:21 +0200
Subject: [PATCH] fork: remove cygpid.N sharedmem on fork failure

When fork finally fails although both CreateProcess and creating the
"cygpid.N" shared memory section succeeded, we have to release that
shared memory section as well - before releasing the process handle.
Otherways we leave an orphan "cygpid.N" shared memory section, and any
subsequent cygwin process receiving the same PID fails to initialize.

* fork.cc (frok::parent): Call child.allow_remove in cleanup code.
---
 winsup/cygwin/fork.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index c6fef6755..9451bb256 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -533,13 +533,16 @@ frok::parent (volatile char * volatile stack_here)
 
 /* Common cleanup code for failure cases */
 cleanup:
+  /* release procinfo before hProcess in destructor */
+  child.allow_remove ();
+
   if (fix_impersonation)
     cygheap->user.reimpersonate ();
   if (locked)
     __malloc_unlock ();
 
   /* Remember to de-allocate the fd table. */
-  if (hchild && !child.hProcess)
+  if (hchild && !child.hProcess) /* no child.procinfo */
     ForceCloseHandle1 (hchild, childhProc);
   if (forker_finished)
     ForceCloseHandle (forker_finished);
-- 
2.16.1


--------------9B5113787B706A3E525AB25A--
