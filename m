Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta19-sa.btinternet.com
 [213.120.69.25])
 by sourceware.org (Postfix) with ESMTPS id 36DD23860C37
 for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021 17:21:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 36DD23860C37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20210729172125.UROD7927.sa-prd-fep-042.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 29 Jul 2021 18:21:25 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 60FF56FA0062DAC3
X-Originating-IP: [86.139.158.70]
X-OWM-Source-IP: 86.139.158.70 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrheefgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrjedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrjedtpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.70) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60FF56FA0062DAC3; Thu, 29 Jul 2021 18:21:25 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Add winsymlinks:sys
Date: Thu, 29 Jul 2021 18:20:12 +0100
Message-Id: <20210729172012.10624-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
References: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Thu, 29 Jul 2021 17:21:27 -0000

Add winsymlinks:sys, to explicitly select always using plain files
containing a magic cookie to represent a symlink.
---
 winsup/cygwin/environ.cc |  2 ++
 winsup/cygwin/globals.cc |  3 ++-
 winsup/cygwin/path.cc    |  3 ++-
 winsup/doc/cygwinenv.xml | 20 +++++++++++++++++++-
 winsup/doc/pathnames.xml | 29 +++++++++++++++++++----------
 5 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 3a03657db..a14b47953 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -82,6 +82,8 @@ set_winsymlinks (const char *buf)
     allow_winsymlinks = WSYM_lnk;
   else if (ascii_strncasematch (buf, "lnk", 3))
     allow_winsymlinks = WSYM_lnk;
+  else if (ascii_strncasematch (buf, "sys", 3))
+    allow_winsymlinks = WSYM_sysfile;
   /* Make sure to try native symlinks only on systems supporting them. */
   else if (ascii_strncasematch (buf, "native", 6))
     allow_winsymlinks = ascii_strcasematch (buf + 6, "strict")
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 066026421..48fb312de 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -57,7 +57,8 @@ enum winsym_t
   WSYM_lnk,
   WSYM_native,
   WSYM_nativestrict,
-  WSYM_nfs
+  WSYM_nfs,
+  WSYM_sysfile,
 };
 
 exit_states NO_COPY exit_state;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index cd029c5b4..baf04ce89 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2071,6 +2071,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 	  /* On FSes not supporting reparse points, or in case of an error
 	     creating the WSL symlink, fall back to creating the plain old
 	     SYSTEM file symlink. */
+	  wsym_type = WSYM_sysfile;
 	  break;
 	default:
 	  break;
@@ -2211,7 +2212,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 		  * sizeof (WCHAR);
 	  cp += *plen;
 	}
-      else
+      else /* wsym_type == WSYM_sysfile */
 	{
 	  /* Default technique creating a symlink. */
 	  buf = tp.t_get ();
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index a52b6ac19..649084dfa 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -76,11 +76,17 @@ in addition to the normal UNIX argv list.  Defaults to not set.</para>
 </listitem>
 
 <listitem>
-<para><envar>winsymlinks:{lnk,native,nativestrict}</envar> - if set to just
+<para><envar>winsymlinks:{lnk,native,nativestrict,sys}</envar></para>
+
+<itemizedlist mark="square">
+<listitem>
+<para>If set to just
 <literal>winsymlinks</literal> or <literal>winsymlinks:lnk</literal>,
 Cygwin creates symlinks as Windows shortcuts with a special header and
 the R/O attribute set.</para>
+</listitem>
 
+<listitem>
 <para>If set to <literal>winsymlinks:native</literal> or
 <literal>winsymlinks:nativestrict</literal>, Cygwin creates symlinks as
 native Windows symlinks on filesystems and OS versions supporting them.</para>
@@ -92,9 +98,21 @@ some reason, it will fall back to creating Cygwin default symlinks
 with <literal>winsymlinks:native</literal>, while with
 <literal>winsymlinks:nativestrict</literal> the <literal>symlink(2)</literal>
 system call will immediately fail.</para>
+</listitem>
+
+<listitem>
+<para>If set to <literal>winsymlinks:sys</literal>, Cygwin creates symlinks as
+plain files with the <literal>system</literal> attribute, containing a magic
+cookie followed by the path to which the link points.</para>
+</listitem>
+</itemizedlist>
+
+<para>Note that this setting has no effect where Cygwin knows that the
+filesystem only supports a creating symlinks in a specific way.</para>
 
 <para>For more information on symbolic links, see
 <xref linkend="pathnames-symlinks"></xref>.</para>
+
 </listitem>
 
 <listitem>
diff --git a/winsup/doc/pathnames.xml b/winsup/doc/pathnames.xml
index 2966bdabf..1ab45c130 100644
--- a/winsup/doc/pathnames.xml
+++ b/winsup/doc/pathnames.xml
@@ -389,16 +389,25 @@ ways.</para>
 <itemizedlist mark="bullet">
 
 <listitem>
-<para>The default symlinks created by Cygwin are either special reparse
-points shared with WSL on Windows 10, or plain files containing a magic
-cookie followed by the path to which the link points.  The reparse point
-is used on NTFS, the plain file on almost any other filesystem.</para>
-
-<note><para>Symlinks created by really old Cygwin releases (prior to
-Cygwin 1.7.0) are usually readable.  However, you could run into problems
-if you're now using another character set than the one you used when
-creating these symlinks (see <xref linkend="setup-locale-problems"></xref>).
-</para></note>
+  <para>The default symlinks created by Cygwin are:</para>
+
+  <itemizedlist mark="square">
+    <listitem>
+      <para>special reparse points shared with WSL (on NTFS on Windows 10 1607
+      or later)</para>
+    </listitem>
+    <listitem>
+      <para>plain files with the <literal>system</literal> attribute, containing
+      a magic cookie followed by the path to which the link points.
+      </para>
+      <note><para>Symlinks of this type created by really old Cygwin releases
+      (prior to Cygwin 1.7.0) are usually readable.  However, you could run into
+      problems if you're now using another character set than the one you used
+      when creating these symlinks (see <xref
+      linkend="setup-locale-problems"></xref>).
+      </para></note>
+    </listitem>
+  </itemizedlist>
 </listitem>
 
 <listitem>
-- 
2.32.0

