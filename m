Return-Path: <cygwin-patches-return-8139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19680 invoked by alias); 21 May 2015 16:44:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19200 invoked by uid 89); 21 May 2015 16:44:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0202.bt.lon5.cpcloud.co.uk
Received: from rgout0202.bt.lon5.cpcloud.co.uk (HELO rgout0202.bt.lon5.cpcloud.co.uk) (65.20.0.201) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 May 2015 16:44:38 +0000
X-OWM-Source-IP: 31.51.206.76(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090202.555E0B73.0069,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.5.13.155416:17:27.888,ip=31.51.206.76,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[76.206.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.206.76) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55531E0501183C24; Thu, 21 May 2015 17:44:35 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update the estimate of the size of installing everything
Date: Thu, 21 May 2015 16:44:00 -0000
Message-Id: <1432226663-19744-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00040.txt.bz2

Update the estimate of the size of installing everything from "hundreds of
megabytes" to "tens of gigabytes", just in case someone should think it's a
good idea with contemporary hard disk sizes :)

2015-05-21  Jon Turney  <jon.turney@dronecode.org.uk>

	* ov-ex-unix.xml: Update the estimate of the size of installing
	everything.
	* ov-ex-win.xml: Ditto.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ov-ex-unix.xml | 2 +-
 winsup/doc/ov-ex-win.xml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/ov-ex-unix.xml b/winsup/doc/ov-ex-unix.xml
index 75a0ff6..7459381 100644
--- a/winsup/doc/ov-ex-unix.xml
+++ b/winsup/doc/ov-ex-unix.xml
@@ -39,7 +39,7 @@ at the Cygwin web site.
 Another option is to install everything by clicking on the
 <literal>Default</literal> field next to the <literal>All</literal>
 category. However, be advised that this will download and install
-several hundreds of megabytes of software to your computer. The best
+several tens of gigabytes of software to your computer. The best
 plan is probably to click on individual categories and install either
 entire categories or packages from the categories themselves.
 After installation, you can find Cygwin-specific documentation in
diff --git a/winsup/doc/ov-ex-win.xml b/winsup/doc/ov-ex-win.xml
index c9371a9..469fef3 100644
--- a/winsup/doc/ov-ex-win.xml
+++ b/winsup/doc/ov-ex-win.xml
@@ -30,7 +30,7 @@ what is installed or updated.
 Another option is to install everything by clicking on the
 <literal>Default</literal> field next to the <literal>All</literal>
 category. However, be advised that this will download and install
-several hundreds of megabytes of software to your computer. The best
+several tens of gigabytes of software to your computer. The best
 plan is probably to click on individual categories and install either
 entire categories or packages from the categories themselves.
 After installation, you can find Cygwin-specific documentation in
-- 
2.1.4
