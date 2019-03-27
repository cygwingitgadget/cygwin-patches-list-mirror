Return-Path: <cygwin-patches-return-9244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50475 invoked by alias); 27 Mar 2019 16:01:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50461 invoked by uid 89); 27 Mar 2019 16:01:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:D*nl, HX-Languages-Length:2041, H*F:D*nl, held
X-HELO: lb3-smtp-cloud8.xs4all.net
Received: from lb3-smtp-cloud8.xs4all.net (HELO lb3-smtp-cloud8.xs4all.net) (194.109.24.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 16:01:51 +0000
Received: from frodo.localdomain ([83.162.234.136])	by smtp-cloud8.xs4all.net with ESMTPA	id 9AzphCTU8UjKf9AzqhplSw; Wed, 27 Mar 2019 17:01:47 +0100
From: "J.H. van de Water" <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. van de Water" <houder@xs4all.nl>
Subject: [PATCH 1/1] Cygwin: fix: seteuid32() must return EPERM if privileges are not held.
Date: Wed, 27 Mar 2019 16:01:00 -0000
Message-Id: <1553702463-1680-1-git-send-email-houder@xs4all.nl>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00054.txt.bz2

Starting w/ the intro of S4U, seteuid32() calls lsaprivkeyauth(), then
s4uauth(). s4uauth calls LsaRegisterLogonProcess().
LsaRegisterLogonProcess fails w/ STATUS_PORT_CONNECTION_REFUSED, if the
proper privileges are not held.
Because of RtlNtStatusToDosError(), this status would be mapped to
ERROR_ACCESS_DENIED, which in turn would map to EACCES. Therefore it is
useless to add this status to errmap[] (errno.cc), as s4auauth() should
return EPERM as errno here (i.e. if process is not privileged).

Hence the kludge.

Before the intro of S4U, seteuid32() called lsaprivkeyauth(), then
lsaauth(), then create_token(). Before the intro of Vista, the latter
would have called NtCreateToken().
NtCreateToken() would have failed w/ STATUS_PRIVILEGE_NOT_HELD for a
process w/o the proper privileges. In that case, calling seteuid32()
would have returned EPERM (as required).

Since the intro of Vista, and if the process had been started from an
UNelevated shell, create_token() does NOT reach NtCreateToken()!
As create_token() failed to properly set errno in that case, calling
seteuid32() would return errno as set by lsaauth(), i.e. EACCES, not
in agreement w/ Posix (a bug which was present for years).
(lsaauth() called LsaRegisterLogonProcess() which would fail)
---
 winsup/cygwin/sec_auth.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/sec_auth.cc b/winsup/cygwin/sec_auth.cc
index a76f453..7a1aa8e 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -1539,6 +1539,11 @@ s4uauth (bool logon, PCWSTR domain, PCWSTR user, NTSTATUS &ret_status)
     {
       debug_printf ("%s: %y", logon ? "LsaRegisterLogonProcess"
 				    : "LsaConnectUntrusted", status);
+      // kludge! (if the privilege is not held, return the proper errno)
+      if (status == STATUS_PORT_CONNECTION_REFUSED) // 0xC0000041 => EACCES
+        {
+          status = STATUS_PRIVILEGE_NOT_HELD; // 0xC0000061 => EPERM
+        }
       __seterrno_from_nt_status (status);
       goto out;
     }
-- 
2.7.5
