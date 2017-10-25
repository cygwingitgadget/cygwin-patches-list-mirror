Return-Path: <cygwin-patches-return-8882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94999 invoked by alias); 25 Oct 2017 11:23:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93721 invoked by uid 89); 25 Oct 2017 11:23:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 11:23:37 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v9PBNYU9021527;	Wed, 25 Oct 2017 07:23:34 -0400
Received: from localhost.localdomain (50-192-26-108-static.hfc.comcastbusiness.net [50.192.26.108])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v9PBNObB012386	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Wed, 25 Oct 2017 07:23:33 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck: Fix parsing of file names containing colons
Date: Wed, 25 Oct 2017 11:23:00 -0000
Message-Id: <20171025112316.13004-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=X
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00012.txt.bz2

Up to now the function winsup/utils/dump_setup.cc:base skips past
colons when parsing file names.  As a result, a line like

  foo foo-1:2.3-4.tar.bz2 1

in /etc/setup/installed.db would cause 'cygcheck -cd foo' to report 4
as the installed version of foo insted of 1:2.3-4.  This is not an
issue now, but it will become an issue when version numbers are
allowed to contain epochs.
---
 winsup/utils/dump_setup.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
index 320d69fab..3922b18f8 100644
--- a/winsup/utils/dump_setup.cc
+++ b/winsup/utils/dump_setup.cc
@@ -56,7 +56,7 @@ base (const char *s)
   const char *rv = s;
   while (*s)
     {
-      if ((*s == '/' || *s == ':' || *s == '\\') && s[1])
+      if ((*s == '/' || *s == '\\') && s[1])
 	rv = s + 1;
       s++;
     }
-- 
2.14.2
