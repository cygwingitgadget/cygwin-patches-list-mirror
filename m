Return-Path: <cygwin-patches-return-8980-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97358 invoked by alias); 20 Dec 2017 23:02:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96636 invoked by uid 89); 20 Dec 2017 23:02:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:sk:smtp-ou, H*RU:sk:smtp-ou, H*r:sk:smtp-ou, HX-HELO:sk:smtp-ou
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 20 Dec 2017 23:02:25 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.240.204])	by shaw.ca with ESMTP	id RnNVezCqSZ8gBRnNWeaOif; Wed, 20 Dec 2017 16:02:23 -0700
X-Authority-Analysis: v=2.2 cv=M/g9E24s c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=BqgCfznX7MUA:10 a=mqKMIRuuQLcA:10 a=QMhygFYVGg9IrQ2laDAA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] winsup/doc/etc.postinstall.cygwin-doc.sh fix shell variable typo
Date: Wed, 20 Dec 2017 23:02:00 -0000
Message-Id: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca>
X-CMAE-Envelope: MS4wfH6v7Cn1MbuhgTZ8ZaH1+wYXonKWXKtnzQ5Gl+sK89t/aRI8623WNDmjuj+nNf53/GdJlDm0lFPLsZo9paQ1yWPitNpp5ammQJF3nIq21FSuqUDKgDXL 1ExzJ648mOpulZu8iGBLCkzNB+ZkGHdxwoPXcO9j1F4nZNrdpXBKj+tX3td1HplqtFEaAVVEbRORF3M0KHzuNI65Wla91ZNufqK3kf/jnJYszSir61bp3NkT cnWj5gouRu96HVEZNWLdog==
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00110.txt.bz2

---
 winsup/doc/etc.postinstall.cygwin-doc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
index 2873d9395..935bd94e1 100755
--- a/winsup/doc/etc.postinstall.cygwin-doc.sh
+++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
@@ -52,7 +52,7 @@ fi
 # create User Guide and API PDF and HTML shortcuts
 while read target name desc
 do
-	[ -r $t ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
+	[ -r $target ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
 done <<EOF
 $doc/cygwin-ug-net.pdf		User\ Guide\ \(PDF\)  Cygwin\ User\ Guide\ PDF
 $html/cygwin-ug-net/index.html	User\ Guide\ \(HTML\) Cygwin\ User\ Guide\ HTML
-- 
2.15.1
