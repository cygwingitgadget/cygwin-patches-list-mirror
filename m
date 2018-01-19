Return-Path: <cygwin-patches-return-9000-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98883 invoked by alias); 19 Jan 2018 05:42:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98854 invoked by uid 89); 19 Jan 2018 05:42:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 05:42:48 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 54955356F4	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id D88D860A9D	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 05:42:46 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] catgets APIs, gencat tool
Date: Fri, 19 Jan 2018 05:42:00 -0000
Message-Id: <20180119054236.22748-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00008.txt.bz2

This adds FreeBSD-derived implementations to replace the glibc-derived
standalone implementation shipped in the catgets package. An integrated
implementation avoids the need to remember to install libcatgets-devel and
modify the build to link with -lcatgets.

The easiest way to test this is:

1) Uninstall catgets and libcatgets-devel.
2) Install Cygwin rebuilt with this patch, particularly the DLL, nl_types.h,
libcygwin.a, and gencat.exe
3) Rebuild tcsh.  The following should be seen during configure:

checking for gencat... /usr/bin/gencat
[snip]
checking for library containing catgets... none required

And the resulting binary should show catclose/catgets/catopen imports from
cygwin1.dll, not cyggetcats1.dll.
4) Install this tcsh, then run an invalid command, e.g.:

$ LANG=fr_FR tcsh  -c '()'
Commande nulle incorrecte.

Yaakov Selkowitz (2):
  cygwin: add catopen, catgets, catclose
  cygwin: add gencat tool

 winsup/cygwin/Makefile.in              |   1 +
 winsup/cygwin/common.din               |   3 +
 winsup/cygwin/include/cygwin/version.h |   3 +-
 winsup/cygwin/include/nl_types.h       |  94 +++++
 winsup/cygwin/libc/msgcat.c            | 478 ++++++++++++++++++++++
 winsup/utils/Makefile.in               |   2 +-
 winsup/utils/gencat.c                  | 696 +++++++++++++++++++++++++++++++++
 7 files changed, 1275 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/include/nl_types.h
 create mode 100644 winsup/cygwin/libc/msgcat.c
 create mode 100644 winsup/utils/gencat.c

-- 
2.15.1
