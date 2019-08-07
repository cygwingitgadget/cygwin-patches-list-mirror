Return-Path: <cygwin-patches-return-9551-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73918 invoked by alias); 7 Aug 2019 11:14:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73909 invoked by uid 89); 7 Aug 2019 11:14:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=collision, cygwincom, cygwin.com, UD:cygwin.com
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 07 Aug 2019 11:14:15 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 13:14:13 +0200
Received: from fril0049.wamas.com ([172.28.42.244] helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hvJtU-00030v-6n; Wed, 07 Aug 2019 13:14:12 +0200
Received: with nullmailer 2.2;	Wed, 07 Aug 2019 11:14:12 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: environ: restore SYSTEMDRIVE if unset
Date: Wed, 07 Aug 2019 11:14:00 -0000
Message-Id: <20190807111352.16147-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00071.txt.bz2

Various registry values do rely on the %SystemDrive% env var to be set.
Right now, it is not known to be easily possible to query the value of
SYSTEMDRIVE environment variable other than preserving the original
environment value even across 'env -i', for use cases like the one in:
https://cygwin.com/ml/cygwin/2019-08/msg00072.html

Note: As we do not store the default value, setting SYSTEMDRIVE to the
empty value will allow it to be unset, but that has to be explicit now.
---
 winsup/cygwin/environ.cc    | 2 +-
 winsup/cygwin/release/3.1.0 | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 8fa01b2d5..75eb81e27 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -969,7 +969,7 @@ static NO_COPY spenv spenvs[] =
   {NL ("HOMEPATH="), false, false, &cygheap_user::env_homepath},
   {NL ("LOGONSERVER="), false, false, &cygheap_user::env_logsrv},
   {NL ("PATH="), false, true, NULL},
-  {NL ("SYSTEMDRIVE="), false, true, NULL},
+  {NL ("SYSTEMDRIVE="), true, true, NULL},
   {NL ("SYSTEMROOT="), true, true, &cygheap_user::env_systemroot},
   {NL ("USERDOMAIN="), false, false, &cygheap_user::env_domain},
   {NL ("USERNAME="), false, false, &cygheap_user::env_name},
diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
index 2c1e8d2a8..987ec1f6c 100644
--- a/winsup/cygwin/release/3.1.0
+++ b/winsup/cygwin/release/3.1.0
@@ -24,6 +24,9 @@ What changed:
 - Eliminate a header file name collision with <X11/XLocale.h> on case
   insensitive filesystems by reverting <xlocale.h> back to <sys/_locale.h>.
 
+- Unless empty, keep the SYSTEMDRIVE environment variable for new processes.
+  Adresses: https://cygwin.com/ml/cygwin/2019-08/msg00072.html
+
 
 Bug Fixes
 ---------
-- 
2.21.0
