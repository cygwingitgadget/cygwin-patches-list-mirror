Return-Path: <cygwin-patches-return-8260-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44924 invoked by alias); 22 Oct 2015 17:35:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44862 invoked by uid 89); 22 Oct 2015 17:35:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,UPPERCASE_50_75 autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 22 Oct 2015 17:35:01 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (Postfix) with ESMTPS id 7FAAA341AC9	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2015 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-52.rdu2.redhat.com [10.10.116.52])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9MHYxTq010596	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2015 13:35:00 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/utils: add CPU cache variables to getconf(1)
Date: Thu, 22 Oct 2015 17:35:00 -0000
Message-Id: <1445535301-15564-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q4/txt/msg00013.txt.bz2

* getconf.c (conf_table): Add LEVEL*_CACHE_* variables.
---
 winsup/utils/ChangeLog |  4 ++++
 winsup/utils/getconf.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/winsup/utils/ChangeLog b/winsup/utils/ChangeLog
index 66bfcb0..ac6eb98 100644
--- a/winsup/utils/ChangeLog
+++ b/winsup/utils/ChangeLog
@@ -1,3 +1,7 @@
+2015-10-22  Yaakov Selkowitz  <yselkowi@redhat.com>
+
+	* getconf.c (conf_table): Add LEVEL*_CACHE_* variables.
+
 2015-08-30  Corinna Vinschen  <corinna@vinschen.de>
 
 	* cygcheck.cc (dump_sysinfo): Fix missing commas in products array.
diff --git a/winsup/utils/getconf.c b/winsup/utils/getconf.c
index 7e0b5f5..8732be1 100644
--- a/winsup/utils/getconf.c
+++ b/winsup/utils/getconf.c
@@ -357,6 +357,21 @@ static const struct conf_variable conf_table[] =
   { "POSIX2_UPE",			SYSCONF,	_SC_2_UPE		},
   { "POSIX2_VERSION",			SYSCONF,	_SC_2_VERSION		},
   /* implementation-specific values */
+  { "LEVEL1_ICACHE_SIZE",		SYSCONF,	_SC_LEVEL1_ICACHE_SIZE	},
+  { "LEVEL1_ICACHE_ASSOC",		SYSCONF,	_SC_LEVEL1_ICACHE_ASSOC	},
+  { "LEVEL1_ICACHE_LINESIZE",		SYSCONF,	_SC_LEVEL1_ICACHE_LINESIZE	},
+  { "LEVEL1_DCACHE_SIZE",		SYSCONF,	_SC_LEVEL1_DCACHE_SIZE	},
+  { "LEVEL1_DCACHE_ASSOC",		SYSCONF,	_SC_LEVEL1_DCACHE_ASSOC	},
+  { "LEVEL1_DCACHE_LINESIZE",		SYSCONF,	_SC_LEVEL1_DCACHE_LINESIZE	},
+  { "LEVEL2_CACHE_SIZE",		SYSCONF,	_SC_LEVEL2_CACHE_SIZE	},
+  { "LEVEL2_CACHE_ASSOC",		SYSCONF,	_SC_LEVEL2_CACHE_ASSOC	},
+  { "LEVEL2_CACHE_LINESIZE",		SYSCONF,	_SC_LEVEL2_CACHE_LINESIZE	},
+  { "LEVEL3_CACHE_SIZE",		SYSCONF,	_SC_LEVEL3_CACHE_SIZE	},
+  { "LEVEL3_CACHE_ASSOC",		SYSCONF,	_SC_LEVEL3_CACHE_ASSOC	},
+  { "LEVEL3_CACHE_LINESIZE",		SYSCONF,	_SC_LEVEL3_CACHE_LINESIZE	},
+  { "LEVEL4_CACHE_SIZE",		SYSCONF,	_SC_LEVEL4_CACHE_SIZE	},
+  { "LEVEL4_CACHE_ASSOC",		SYSCONF,	_SC_LEVEL4_CACHE_ASSOC	},
+  { "LEVEL4_CACHE_LINESIZE",		SYSCONF,	_SC_LEVEL4_CACHE_LINESIZE	},
   { "_NPROCESSORS_CONF",		SYSCONF,	_SC_NPROCESSORS_CONF	},
   { "_NPROCESSORS_ONLN",		SYSCONF,	_SC_NPROCESSORS_ONLN	},
   { "_AVPHYS_PAGES",			SYSCONF,	_SC_AVPHYS_PAGES	},
-- 
2.5.3
