Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-040.btinternet.com (mailomta31-sa.btinternet.com
 [213.120.69.37])
 by sourceware.org (Postfix) with ESMTPS id C20AF385F01D
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 16:43:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C20AF385F01D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-040.btinternet.com with ESMTP id
 <20200319164352.EPMB30239.sa-prd-fep-040.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Thu, 19 Mar 2020 16:43:52 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.134]
X-OWM-Source-IP: 31.51.206.134 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudefledgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdgthihgfihinhdqughotgdrshhhnecukfhppeefuddrhedurddvtdeirddufeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddufeegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.134) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5E3A241106ADDDF8; Thu, 19 Mar 2020 16:43:52 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64 installs
Date: Thu, 19 Mar 2020 16:43:41 +0000
Message-Id: <20200319164341.3313-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200319154500.GG778468@calimero.vinschen.de>
References: <20200319154500.GG778468@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-23.7 required=5.0 tests=FORGED_SPF_HELO, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
 SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 19 Mar 2020 16:43:55 -0000

This aligns the shortcuts to documentation with the setup changes in
https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html

v2:
Create/remove the Start Menu directory as needed/possible
Correctly use that directory when making shortcuts
---
 winsup/doc/etc.postinstall.cygwin-doc.sh | 12 ++++++------
 winsup/doc/etc.preremove.cygwin-doc.sh   |  5 ++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
index de7d9e0c3..97f88a16d 100755
--- a/winsup/doc/etc.postinstall.cygwin-doc.sh
+++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
@@ -37,10 +37,11 @@ do
 done
 
 # Cygwin Start Menu directory
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin"
+case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
 
-# check Cygwin Start Menu directory exists
-[ -d "$smpc_dir/" ] || exit 0
+# ensure Cygwin Start Menu directory exists
+/usr/bin/mkdir -p "$smpc_dir"
 
 # check Cygwin Start Menu directory writable
 if [ ! -w "$smpc_dir/" ]
@@ -52,7 +53,7 @@ fi
 # create User Guide and API PDF and HTML shortcuts
 while read target name desc
 do
-	[ -r "$target" ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
+	[ -r "$target" ] && $mks $CYGWINFORALL -P -n "Cygwin${wow64}/$name" -d "$desc" -- $target
 done <<EOF
 $doc/cygwin-ug-net.pdf		User\ Guide\ \(PDF\)  Cygwin\ User\ Guide\ PDF
 $html/cygwin-ug-net/index.html	User\ Guide\ \(HTML\) Cygwin\ User\ Guide\ HTML
@@ -63,9 +64,8 @@ EOF
 # create Home Page and FAQ URL link shortcuts
 while read target name desc
 do
-	$mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -a $target -- $launch
+	$mks $CYGWINFORALL -P -n "Cygwin${wow64}/$name" -d "$desc" -a $target -- $launch
 done <<EOF
 $site/index.html	Home\ Page	Cygwin\ Home\ Page\ Link
 $site/faq.html		FAQ	Cygwin\ Frequently\ Asked\ Questions\ Link
 EOF
-
diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.preremove.cygwin-doc.sh
index 5e47eb579..b098e6dac 100755
--- a/winsup/doc/etc.preremove.cygwin-doc.sh
+++ b/winsup/doc/etc.preremove.cygwin-doc.sh
@@ -26,7 +26,8 @@ do
 done
 
 # Cygwin Start Menu directory
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin"
+case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
 
 # check Cygwin Start Menu directory still exists
 [ -d "$smpc_dir/" ] || exit 0
@@ -52,3 +53,5 @@ $site/index.html	Home\ Page	Cygwin\ Home\ Page\ Link
 $site/faq.html		FAQ	Cygwin\ Frequently\ Asked\ Questions\ Link
 EOF
 
+# remove Cygwin Start Menu directory if empty
+/usr/bin/rmdir --ignore-fail-on-non-empty "${smpc_dir}"
-- 
2.21.0

