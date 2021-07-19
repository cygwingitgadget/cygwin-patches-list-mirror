Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta7-sa.btinternet.com
 [213.120.69.13])
 by sourceware.org (Postfix) with ESMTPS id 2C0233953D03
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 16:32:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2C0233953D03
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20210719163243.YSKV26114.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 19 Jul 2021 17:32:43 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 60D644B904412657
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduieejrdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdegfedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.43) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60D644B904412657; Mon, 19 Jul 2021 17:32:43 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Add winsymlinks:magic
Date: Mon, 19 Jul 2021 17:31:33 +0100
Message-Id: <20210719163134.9230-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 19 Jul 2021 16:32:45 -0000

Add winsymlinks:magic, to explicitly select always using plain files
containing a magic cookie to represent a symlink.
---
 winsup/cygwin/environ.cc |  2 ++
 winsup/cygwin/globals.cc |  3 ++-
 winsup/cygwin/path.cc    |  3 ++-
 winsup/doc/cygwinenv.xml | 16 +++++++++++++++-
 winsup/doc/pathnames.xml |  7 +++----
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 3a03657db..a7a52feeb 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -82,6 +82,8 @@ set_winsymlinks (const char *buf)
     allow_winsymlinks = WSYM_lnk;
   else if (ascii_strncasematch (buf, "lnk", 3))
     allow_winsymlinks = WSYM_lnk;
+  else if (ascii_strncasematch (buf, "magic", 5))
+    allow_winsymlinks = WSYM_magic;
   /* Make sure to try native symlinks only on systems supporting them. */
   else if (ascii_strncasematch (buf, "native", 6))
     allow_winsymlinks = ascii_strcasematch (buf + 6, "strict")
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 066026421..b15980bb3 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -57,7 +57,8 @@ enum winsym_t
   WSYM_lnk,
   WSYM_native,
   WSYM_nativestrict,
-  WSYM_nfs
+  WSYM_nfs,
+  WSYM_magic,
 };
 
 exit_states NO_COPY exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index cd029c5b4..edb3b27ee 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2071,6 +2071,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 	  /* On FSes not supporting reparse points, or in case of an error
 	     creating the WSL symlink, fall back to creating the plain old
 	     SYSTEM file symlink. */
+	  wsym_type = WSYM_magic;
 	  break;
 	default:
 	  break;
@@ -2211,7 +2212,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 		  * sizeof (WCHAR);
 	  cp += *plen;
 	}
-      else
+      else /* wsym_type == WSYM_magic */
 	{
 	  /* Default technique creating a symlink. */
 	  buf = tp.t_get ();
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index a52b6ac19..496088292 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -76,11 +76,23 @@ in addition to the normal UNIX argv list.  Defaults to not set.</para>
 </listitem>
 
 <listitem>
-<para><envar>winsymlinks:{lnk,native,nativestrict}</envar> - if set to just
+<para><envar>winsymlinks:{lnk,magic,native,nativestrict}</envar></para>
+
+<itemizedlist mark="square">
+<listitem>
+<para>If set to just
 <literal>winsymlinks</literal> or <literal>winsymlinks:lnk</literal>,
 Cygwin creates symlinks as Windows shortcuts with a special header and
 the R/O attribute set.</para>
+</listitem>
 
+<listitem>
+<para>If set to <literal>winsymlinks:magic</literal> Cygwin creates symlinks
+as plain files containing a magic cookie followed by the path to which the
+link points.</para>
+</listitem>
+
+<listitem>
 <para>If set to <literal>winsymlinks:native</literal> or
 <literal>winsymlinks:nativestrict</literal>, Cygwin creates symlinks as
 native Windows symlinks on filesystems and OS versions supporting them.</para>
@@ -92,6 +104,8 @@ some reason, it will fall back to creating Cygwin default symlinks
 with <literal>winsymlinks:native</literal>, while with
 <literal>winsymlinks:nativestrict</literal> the <literal>symlink(2)</literal>
 system call will immediately fail.</para>
+</listitem>
+</itemizedlist>
 
 <para>For more information on symbolic links, see
 <xref linkend="pathnames-symlinks"></xref>.</para>
diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index 2966bdabf..132d8a3e1 100644
--- a/winsup/doc/pathnames.xml
+++ b/winsup/doc/pathnames.xml
@@ -389,10 +389,9 @@ ways.</para>
 <itemizedlist mark="bullet">
 
 <listitem>
-<para>The default symlinks created by Cygwin are either special reparse
-points shared with WSL on Windows 10, or plain files containing a magic
-cookie followed by the path to which the link points.  The reparse point
-is used on NTFS, the plain file on almost any other filesystem.</para>
+<para>The default symlinks created by Cygwin are either special reparse points
+shared with WSL on NTFS on Windows 10 1607 or later, otherwise plain files
+containing a magic cookie followed by the path to which the link points.</para>
 
 <note><para>Symlinks created by really old Cygwin releases (prior to
 Cygwin 1.7.0) are usually readable.  However, you could run into problems
-- 
2.32.0

