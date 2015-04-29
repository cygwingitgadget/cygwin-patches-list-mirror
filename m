Return-Path: <cygwin-patches-return-8137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116038 invoked by alias); 29 Apr 2015 16:22:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116025 invoked by uid 89); 29 Apr 2015 16:22:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 29 Apr 2015 16:22:41 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3TGMdxc029372	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Wed, 29 Apr 2015 12:22:40 -0400
Received: from localhost.localdomain ([10.10.116.23])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3TGMYIH028083	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Wed, 29 Apr 2015 12:22:38 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix more typos in ntsec.xml
Date: Wed, 29 Apr 2015 16:22:00 -0000
Message-Id: <1430324556-12152-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q2/txt/msg00038.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/doc/ntsec.xml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index b731cd0..d982867 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -863,7 +863,7 @@ the old information.
 <para>
 So, what settings can we perform with <filename>/etc/nsswitch.conf</filename>?
 Let's start with an example <filename>/etc/nsswitch.conf</filename> file
-file set up to all default values:
+set up to all default values:
 </para>
 
 <screen>
@@ -1749,7 +1749,7 @@ The <literal>unix</literal> schema utilizes the
 <literal>posixAccount</literal> attribute extension.  This is one of two
 schema extensions which are connected to AD accounts, available by default
 starting with Windows Server 2003 R2.  They are usually
-<literal>not set</literal>, unless used by the Active Directory
+<emphasis role='bold'>not set</emphasis>, unless used by the Active Directory
 <literal>Server for NIS</literal> feature (deprecated since Server 2012 R2).
 
 Two schemata are interesting for Cygwin, <literal>posixAccount</literal>,
@@ -2031,7 +2031,7 @@ by child processes.
 
 <para>
 A fully set up Samba file server with domain integration is running winbindd to
-map Window SIDs to artificially created UNIX uids and gids, and this mapping is
+map Windows SIDs to artificially created UNIX uids and gids, and this mapping is
 transparent within the domain, so Cygwin doesn't have to do anything special.
 </para>
 
@@ -2134,7 +2134,7 @@ met.  Later ACEs are not taken into account.</para></listitem>
 
 <listitem><para>All access denied ACEs <emphasis
 role='bold'>should</emphasis> precede any access allowed ACE.  ACLs
-following this rule are called "canonical"</para></listitem>
+following this rule are called "canonical".</para></listitem>
 </itemizedlist>
 
 <para>Note that the last rule is a preference or a definition of
-- 
2.1.4
