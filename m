Return-Path: <cygwin-patches-return-8990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62921 invoked by alias); 22 Dec 2017 18:36:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62460 invoked by uid 89); 22 Dec 2017 18:36:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=quietly, PDF, HTo:U*cygwin-patches, site
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Dec 2017 18:36:11 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.240.204])	by shaw.ca with ESMTP	id SSAyeA8MbS7BpSSAzewX3z; Fri, 22 Dec 2017 11:36:10 -0700
X-Authority-Analysis: v=2.2 cv=NKylwwyg c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=BqgCfznX7MUA:10 a=mqKMIRuuQLcA:10 a=w_pzkKWiAAAA:8 a=ukVAaEYBDQYfxMrOdhsA:9 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 2/2] cleanup winsup/doc/etc.{postinstall,preremove}.cygwin-doc.sh quote test variables, correct utility paths, define site in preremove
Date: Fri, 22 Dec 2017 18:36:00 -0000
Message-Id: <20171222183556.4268-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca>
X-CMAE-Envelope: MS4wfPI75lMzWfP4QkMnhz9Y/t0i6AisF9ONZKBEUgEpRn4pVCDMfEJ+p48jGhuS0Phto8+JOab4n3bDSHXBObYXQx9JceFb6ovGbzmN6SB9p6gf9vLNl9kX 0nKTIbauEpLjkWMoSUuV3MSjVHo6qNw/0Mgu93BplAF1CbGRDQA3bJJDCR0udP2ivAo2juzAZJ4B4PulwFQmJkl2jCN8U/6DWSmU35Jqw8q0ma7vquqZ6PaU GRPmxOmtCqiEf//SDddBow==
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00120.txt.bz2

---
 winsup/doc/etc.postinstall.cygwin-doc.sh | 10 +++++-----
 winsup/doc/etc.preremove.cygwin-doc.sh   |  5 +++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
index 935bd94e1..de7d9e0c3 100755
--- a/winsup/doc/etc.postinstall.cygwin-doc.sh
+++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
@@ -10,9 +10,9 @@
 
 doc=/usr/share/doc/cygwin-doc
 site=https://cygwin.com
-cygp=/bin/cygpath
-mks=/bin/mkshortcut
-launch=/bin/cygstart
+cygp=/usr/bin/cygpath
+mks=/usr/bin/mkshortcut
+launch=/usr/bin/cygstart
 
 html=$doc/html
 
@@ -29,7 +29,7 @@ done
 # check for programs
 for p in $cygp $mks $launch
 do
-	if [ ! -x $p ]
+	if [ ! -x "$p" ]
 	then
 		echo "Can't find program '$p'"
 		exit 2
@@ -52,7 +52,7 @@ fi
 # create User Guide and API PDF and HTML shortcuts
 while read target name desc
 do
-	[ -r $target ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
+	[ -r "$target" ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
 done <<EOF
 $doc/cygwin-ug-net.pdf		User\ Guide\ \(PDF\)  Cygwin\ User\ Guide\ PDF
 $html/cygwin-ug-net/index.html	User\ Guide\ \(HTML\) Cygwin\ User\ Guide\ HTML
diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.preremove.cygwin-doc.sh
index 09e0c9efc..5e47eb579 100755
--- a/winsup/doc/etc.preremove.cygwin-doc.sh
+++ b/winsup/doc/etc.preremove.cygwin-doc.sh
@@ -9,7 +9,8 @@
 # exits quietly if directory does not exist as presumably no shortcuts desired
 
 doc=/usr/share/doc/cygwin-doc
-cygp=/bin/cygpath
+site=https://cygwin.com
+cygp=/usr/bin/cygpath
 rm=/bin/rm
 
 html=$doc/html
@@ -17,7 +18,7 @@ html=$doc/html
 # check for programs
 for p in $cygp $rm
 do
-	if [ ! -x $p ]
+	if [ ! -x "$p" ]
 	then
 		echo "Can't find program '$p'"
 		exit 2
-- 
2.15.1
