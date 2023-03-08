Return-Path: <SRS0=6j3Y=7A=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta17-sa.btinternet.com [213.120.69.23])
	by sourceware.org (Postfix) with ESMTPS id 7E1B53858289
	for <cygwin-patches@cygwin.com>; Wed,  8 Mar 2023 14:17:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7E1B53858289
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230308141733.ENVL13453.sa-prd-fep-047.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 8 Mar 2023 14:17:33 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6406812D002EE769
X-Originating-IP: [86.139.167.71]
X-OWM-Source-IP: 86.139.167.71 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheehtddtueekfeeuuedtjeeluedvledvkeegheekjeevhfduiedtuedvieevtdegnecuffhomhgrihhnpegthihgfihinhdqughotgdrshhhnecukfhppeekiedrudefledrudeijedrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrjedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdejuddrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhr
	nhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdeg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.71) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 6406812D002EE769; Wed, 8 Mar 2023 14:17:33 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: Update postinstall/preremove scripts
Date: Wed,  8 Mar 2023 14:17:19 +0000
Message-Id: <20230308141719.7361-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update postinstall/preremove scripts to use CYGWIN_START_MENU_SUFFIX and
CYGWIN_SETUP_OPTIONS.
---
 winsup/doc/etc.postinstall.cygwin-doc.sh | 19 +++++++++++++++----
 winsup/doc/etc.preremove.cygwin-doc.sh   |  8 ++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
index 97f88a16d..313c1d3ff 100755
--- a/winsup/doc/etc.postinstall.cygwin-doc.sh
+++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
@@ -36,9 +36,20 @@ do
 	fi
 done
 
+# setup was run with options not to create startmenu items
+case ${CYGWIN_SETUP_OPTIONS} in
+  *no-startmenu*)
+    exit 0
+    ;;
+esac
+
 # Cygwin Start Menu directory
-case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
+if [ ! -v CYGWIN_START_MENU_SUFFIX ]
+then
+  case $(uname -s) in *-WOW*) CYGWIN_START_MENU_SUFFIX=" (32-bit)" ;; esac
+fi
+
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${CYGWIN_START_MENU_SUFFIX}"
 
 # ensure Cygwin Start Menu directory exists
 /usr/bin/mkdir -p "$smpc_dir"
@@ -53,7 +64,7 @@ fi
 # create User Guide and API PDF and HTML shortcuts
 while read target name desc
 do
-	[ -r "$target" ] && $mks $CYGWINFORALL -P -n "Cygwin${wow64}/$name" -d "$desc" -- $target
+	[ -r "$target" ] && $mks $CYGWINFORALL -P -n "Cygwin${CYGWIN_START_MENU_SUFFIX}/$name" -d "$desc" -- $target
 done <<EOF
 $doc/cygwin-ug-net.pdf		User\ Guide\ \(PDF\)  Cygwin\ User\ Guide\ PDF
 $html/cygwin-ug-net/index.html	User\ Guide\ \(HTML\) Cygwin\ User\ Guide\ HTML
@@ -64,7 +75,7 @@ EOF
 # create Home Page and FAQ URL link shortcuts
 while read target name desc
 do
-	$mks $CYGWINFORALL -P -n "Cygwin${wow64}/$name" -d "$desc" -a $target -- $launch
+	$mks $CYGWINFORALL -P -n "Cygwin${CYGWIN_START_MENU_SUFFIX}/$name" -d "$desc" -a $target -- $launch
 done <<EOF
 $site/index.html	Home\ Page	Cygwin\ Home\ Page\ Link
 $site/faq.html		FAQ	Cygwin\ Frequently\ Asked\ Questions\ Link
diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.preremove.cygwin-doc.sh
index b098e6dac..cac29ee21 100755
--- a/winsup/doc/etc.preremove.cygwin-doc.sh
+++ b/winsup/doc/etc.preremove.cygwin-doc.sh
@@ -26,8 +26,12 @@ do
 done
 
 # Cygwin Start Menu directory
-case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
+if [ ! -v CYGWIN_START_MENU_SUFFIX ]
+then
+  case $(uname -s) in *-WOW*) CYGWIN_START_MENU_SUFFIX=" (32-bit)" ;; esac
+fi
+
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${CYGWIN_START_MENU_SUFFIX}"
 
 # check Cygwin Start Menu directory still exists
 [ -d "$smpc_dir/" ] || exit 0
-- 
2.39.0

