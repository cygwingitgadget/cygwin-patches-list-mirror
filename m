Return-Path: <SRS0=Fhgt=HF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta21-re.btinternet.com [213.120.69.114])
	by sourceware.org (Postfix) with ESMTPS id 872A53858D32
	for <cygwin-patches@cygwin.com>; Fri, 24 Nov 2023 17:07:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 872A53858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 872A53858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700845637; cv=none;
	b=GMth7L2nRDss2tsqW898YIuZA2sUrGo9heSNyaqatCD2Qhp1f8ebbVAgaqMiP5vOPcbeQCPGOhYmzuMowM4EDkX5KIURf+aqLEnaLLLZx6oFDPGZA7ErkDinPXSuDf0JjNyB/hqWhmouoxeKan/PU+LznrM0HtQar5WI9SIjN7I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700845637; c=relaxed/simple;
	bh=DIZ7jGXT2PDVJ1w8ksOgOLiV7A+u/Q7qgg6Z9xK+MLw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xs8qJ5g84osu7T0C3UPtmVO2FrQW5WbecJpbXnx8HJv3S6MFJ0dXk9bDbFaWUkIMtvhPzG7YeWoRHeYod84ui2ew/xngqwHEoFr2fj8k4lghrge9AP8S7jZPGDZdQblKikI70aax+Wg+5Tn+owUWRCJFSG9XRdQR6xHMxtzm378=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20231124170713.ONYL18910.re-prd-fep-043.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 24 Nov 2023 17:07:13 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64D174D30B45B1FB
X-Originating-IP: [81.129.146.217]
X-OWM-Source-IP: 81.129.146.217 (GB)
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddruddvledrudegiedrvddujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddvudejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqddvudejrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdp
	ghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.217) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64D174D30B45B1FB; Fri, 24 Nov 2023 17:07:13 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Add '--names-only' flag to cygcheck
Date: Fri, 24 Nov 2023 17:06:56 +0000
Message-ID: <20231124170657.28490-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add '--names-only' flag to cygcheck, to output just the bare package
names.
---

Notes:
    Rather than more hacky aftermarket solutions, let's make cygcheck output
    something more useful for feeding into setup.
    
    Next step would be to adjust setup's argument parsing so 'setup -P
    "$(cygcheck -n)"' works as expected.

 winsup/utils/mingw/cygcheck.cc   | 18 +++++++++++++-----
 winsup/utils/mingw/dump_setup.cc | 17 +++++++++++------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
index 9d6f19203..1dde2ecba 100644
--- a/winsup/utils/mingw/cygcheck.cc
+++ b/winsup/utils/mingw/cygcheck.cc
@@ -55,6 +55,7 @@ int givehelp = 0;
 int keycheck = 0;
 int check_setup = 0;
 int dump_only = 0;
+int names_only = 0;
 int find_package = 0;
 int list_package = 0;
 int grep_packages = 0;
@@ -84,7 +85,7 @@ typedef __int64 longlong;
 #endif
 
 /* In dump_setup.cc  */
-void dump_setup (int, char **, bool);
+void dump_setup (int, char **, bool, bool);
 void package_find (int, char **);
 void package_list (int, char **);
 /* In bloda.cc  */
@@ -2913,7 +2914,8 @@ At least one command option or a PROGRAM is required, as shown above.\n\
   PROGRAM              list library (DLL) dependencies of PROGRAM\n\
   -c, --check-setup    show installed version of PACKAGE and verify integrity\n\
                        (or for all installed packages if none specified)\n\
-  -d, --dump-only      just list packages, do not verify (with -c)\n\
+  -d, --dump-only      do not verify packages (with -c)\n\
+  -n, --names-only     just list package names (implies -c -d)\n\
   -s, --sysinfo        produce diagnostic system information (implies -c)\n\
   -r, --registry       also scan registry for Cygwin settings (with -s)\n\
   -k, --keycheck       perform a keyboard check session (must be run from a\n\
@@ -2962,6 +2964,7 @@ Notes:\n\
 struct option longopts[] = {
   {"check-setup", no_argument, NULL, 'c'},
   {"dump-only", no_argument, NULL, 'd'},
+  {"names-only", no_argument, NULL, 'n'},
   {"sysinfo", no_argument, NULL, 's'},
   {"registry", no_argument, NULL, 'r'},
   {"verbose", no_argument, NULL, 'v'},
@@ -2985,7 +2988,7 @@ struct option longopts[] = {
   {0, no_argument, NULL, 0}
 };
 
-static char opts[] = "cdsrvkfliephV";
+static char opts[] = "cdnsrvkfliephV";
 
 static void
 print_version ()
@@ -3093,6 +3096,11 @@ main (int argc, char **argv)
       case 'd':
 	dump_only = 1;
 	break;
+      case 'n':
+	check_setup = 1;
+	dump_only = 1;
+	names_only = 1;
+	break;
       case 'r':
 	registry = 1;
 	break;
@@ -3205,7 +3213,7 @@ main (int argc, char **argv)
     }
 
   if (check_setup)
-    dump_setup (verbose, argv, !dump_only);
+    dump_setup (verbose, argv, !dump_only, names_only);
   else if (find_package)
     package_find (verbose, argv);
   else if (list_package)
@@ -3224,7 +3232,7 @@ main (int argc, char **argv)
       if (!check_setup)
 	{
 	  puts ("");
-	  dump_setup (verbose, NULL, !dump_only);
+	  dump_setup (verbose, NULL, !dump_only, FALSE);
 	}
 
       if (!givehelp)
diff --git a/winsup/utils/mingw/dump_setup.cc b/winsup/utils/mingw/dump_setup.cc
index 06aa06f81..050679a0d 100644
--- a/winsup/utils/mingw/dump_setup.cc
+++ b/winsup/utils/mingw/dump_setup.cc
@@ -466,11 +466,13 @@ get_installed_packages (char **argv, size_t *count)
 }
 
 void
-dump_setup (int verbose, char **argv, bool check_files)
+dump_setup (int verbose, char **argv, bool check_files, bool names_only)
 {
   pkgver *packages = get_installed_packages (argv);
 
-  puts ("Cygwin Package Information");
+  if (!names_only)
+    puts ("Cygwin Package Information");
+
   if (packages == NULL)
     {
       puts ("No setup information found");
@@ -484,12 +486,15 @@ dump_setup (int verbose, char **argv, bool check_files)
 	puts ("");
     }
 
-  printf ("%-*s %-*s%s\n", package_len, "Package",
-			   check_files ? version_len : 7, "Version",
-			   check_files ? "     Status" : "");
+  if (!names_only)
+    printf ("%-*s %-*s%s\n", package_len, "Package",
+	    check_files ? version_len : 7, "Version",
+	    check_files ? "	Status" : "");
   for (int i = 0; packages[i].name; i++)
     {
-      if (check_files)
+      if (names_only)
+	printf ("%s\n", packages[i].name);
+      else if (check_files)
 	printf ("%-*s %-*s%s\n", package_len, packages[i].name,
 		version_len, packages[i].ver,
 		check_package_files (verbose, packages[i].name)
-- 
2.42.1

