Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta21-sa.btinternet.com
 [213.120.69.27])
 by sourceware.org (Postfix) with ESMTPS id 84944395BC09
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 16:32:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 84944395BC09
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20210719163245.TCRE18744.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 19 Jul 2021 17:32:45 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 60D644B90441269B
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduieejrdegfeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdegfedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.43) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60D644B90441269B; Mon, 19 Jul 2021 17:32:45 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Add winsymlinks:wslstrict
Date: Mon, 19 Jul 2021 17:31:34 +0100
Message-Id: <20210719163134.9230-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 19 Jul 2021 16:32:48 -0000

Add winsymlinks:wslstrict, so we have a spanning set of values for
winsymlinks.
---
 winsup/cygwin/environ.cc |  3 +++
 winsup/cygwin/globals.cc |  1 +
 winsup/cygwin/path.cc    |  7 +++++++
 winsup/doc/cygwinenv.xml | 15 ++++++++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index a7a52feeb..b53b018fd 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -88,6 +88,9 @@ set_winsymlinks (const char *buf)
   else if (ascii_strncasematch (buf, "native", 6))
     allow_winsymlinks = ascii_strcasematch (buf + 6, "strict")
 			? WSYM_nativestrict : WSYM_native;
+  else if (ascii_strncasematch (buf, "wsl", 3))
+    allow_winsymlinks = ascii_strcasematch (buf + 3, "strict")
+			? WSYM_wslstrict : WSYM_default;
 }
 
 /* The structure below is used to set up an array which is used to
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index b15980bb3..9459d8bcb 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -59,6 +59,7 @@ enum winsym_t
   WSYM_nativestrict,
   WSYM_nfs,
   WSYM_magic,
+  WSYM_wslstrict,
 };
 
 exit_states NO_COPY exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index edb3b27ee..57ec8be72 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2062,12 +2062,19 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 	  wsym_type = WSYM_default;
 	  fallthrough;
 	case WSYM_default:
+	case WSYM_wslstrict:
 	  if (win32_newpath.fs_flags () & FILE_SUPPORTS_REPARSE_POINTS)
 	    {
 	      res = symlink_wsl (oldpath, win32_newpath);
 	      if (!res)
 		__leave;
 	    }
+	  /* Strictly wsl? */
+	  if (wsym_type == WSYM_wslstrict)
+	    {
+	      __seterrno ();
+	      __leave;
+	    }
 	  /* On FSes not supporting reparse points, or in case of an error
 	     creating the WSL symlink, fall back to creating the plain old
 	     SYSTEM file symlink. */
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index 496088292..b98e27243 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -76,7 +76,7 @@ in addition to the normal UNIX argv list.  Defaults to not set.</para>
 </listitem>
 
 <listitem>
-<para><envar>winsymlinks:{lnk,magic,native,nativestrict}</envar></para>
+<para><envar>winsymlinks:{lnk,magic,native,nativestrict,wsl,wslstrict}</envar></para>
 
 <itemizedlist mark="square">
 <listitem>
@@ -105,6 +105,19 @@ with <literal>winsymlinks:native</literal>, while with
 <literal>winsymlinks:nativestrict</literal> the <literal>symlink(2)</literal>
 system call will immediately fail.</para>
 </listitem>
+
+<listitem>
+<para>If set to <literal>winsymlinks:wsl</literal> or
+<literal>winsymlinks:wslstrict</literal>, Cygwin creates symlinks as special
+reparse points, defined by WSL.</para>
+
+<para>With <literal>winsymlinks:wsl</literal>, if Cygwin fails to create a WSL
+symlink for some reason, it will fall back to creating a Cygwin magic cookie
+symlink, while with <literal>winsymlinks:wslstrict</literal> the
+<literal>symlink(2)</literal> system call will immediately fail.</para>
+
+<para><literal>winsymlinks:wsl</literal> is the default behaviour.</para>
+</listitem>
 </itemizedlist>
 
 <para>For more information on symbolic links, see
-- 
2.32.0

