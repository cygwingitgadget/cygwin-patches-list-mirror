Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta7-sa.btinternet.com
 [213.120.69.13])
 by sourceware.org (Postfix) with ESMTPS id 21E8A3844063
 for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2020 14:26:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 21E8A3844063
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20200721142632.SFSR26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 21 Jul 2020 15:26:32 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeigdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E07E8010F; Tue, 21 Jul 2020 15:26:32 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Cygwin: Add --nokill dumper option
Date: Tue, 21 Jul 2020 15:26:14 +0100
Message-Id: <20200721142616.28605-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
References: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Jul 2020 14:26:39 -0000

Add --nokill option to dumper, for compatibility with minidumper, and to
assist with testing.
---
 winsup/doc/utils.xml   |  9 ++++++---
 winsup/utils/dumper.cc | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 8b92bfdf1..176f9a0d3 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -496,6 +496,7 @@ dumper [OPTION] FILENAME WIN32PID
     <refsect1 id="dumper-options">
       <title>Options</title>
       <screen>
+-n, --nokill   don't terminate the dumped process
 -d, --verbose  be verbose while dumping
 -h, --help     output help information and exit
 -q, --quiet    be quiet while dumping (default)
@@ -519,9 +520,11 @@ error_start=x:\path\to\dumper.exe
       be started whenever some program encounters a fatal error. </para>
 
     <para> <command>dumper</command> can be also be started from the command
-      line to create a core dump of any running process. Unfortunately, because
-      of a Windows API limitation, when a core dump is created and
-      <command>dumper</command> exits, the target process is terminated too. </para>
+      line to create a core dump of any running process.</para>
+
+    <para>Unless the <literal>-n</literal> option is given, after the core dump
+    is created and when the <command>dumper</command> exits, the target process
+    is also terminated.</para>
 
     <para> To save space in the core dump, <command>dumper</command> doesn't
       write those portions of the target process's memory space that are loaded
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 3af138b9e..fa6d9641a 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -64,6 +64,7 @@ __attribute__ ((packed))
   note_header;
 
 BOOL verbose = FALSE;
+BOOL nokill = FALSE;
 
 int deb_printf (const char *format,...)
 {
@@ -716,7 +717,19 @@ dumper::collect_process_information ()
 			  current_event.dwThreadId,
 			  DBG_CONTINUE);
     }
+
 failed:
+  if (nokill)
+    {
+      if (!DebugActiveProcessStop (pid))
+	{
+	  fprintf (stderr, "Cannot detach from process #%u, error %ld",
+		   (unsigned int) pid, (long) GetLastError ());
+	}
+    }
+  /* Otherwise, the debuggee is terminated when this process exits
+     (as DebugSetProcessKillOnExit() defaults to TRUE) */
+
   /* set debugee free */
   if (sync_with_debugee)
     SetEvent (sync_with_debugee);
@@ -960,6 +973,7 @@ Usage: %s [OPTION] FILENAME WIN32PID\n\
 \n\
 Dump core from WIN32PID to FILENAME.core\n\
 \n\
+ -n, --nokill   don't terminate the dumped process\n\
  -d, --verbose  be verbose while dumping\n\
  -h, --help     output help information and exit\n\
  -q, --quiet    be quiet while dumping (default)\n\
@@ -969,13 +983,14 @@ Dump core from WIN32PID to FILENAME.core\n\
 }
 
 struct option longopts[] = {
+  {"nokill", no_argument, NULL, 'n'},
   {"verbose", no_argument, NULL, 'd'},
   {"help", no_argument, NULL, 'h'},
   {"quiet", no_argument, NULL, 'q'},
   {"version", no_argument, 0, 'V'},
   {0, no_argument, NULL, 0}
 };
-const char *opts = "dhqV";
+const char *opts = "ndhqV";
 
 static void
 print_version ()
@@ -1001,6 +1016,9 @@ main (int argc, char **argv)
   while ((opt = getopt_long (argc, argv, opts, longopts, NULL) ) != EOF)
     switch (opt)
       {
+      case 'n':
+	nokill = TRUE;
+	break;
       case 'd':
 	verbose = TRUE;
 	break;
-- 
2.27.0

