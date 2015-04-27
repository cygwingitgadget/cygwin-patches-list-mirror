Return-Path: <cygwin-patches-return-8135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52814 invoked by alias); 27 Apr 2015 08:47:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52793 invoked by uid 89); 27 Apr 2015 08:47:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-qg0-f42.google.com
Received: from mail-qg0-f42.google.com (HELO mail-qg0-f42.google.com) (209.85.192.42) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 27 Apr 2015 08:47:11 +0000
Received: by qgfi89 with SMTP id i89so46720434qgf.1        for <cygwin-patches@cygwin.com>; Mon, 27 Apr 2015 01:47:09 -0700 (PDT)
X-Received: by 10.140.233.140 with SMTP id e134mr7028338qhc.63.1430124429506;        Mon, 27 Apr 2015 01:47:09 -0700 (PDT)
Received: from executor.depaulo.org (pool-96-245-198-248.phlapa.fios.verizon.net. [96.245.198.248])        by mx.google.com with ESMTPSA id n83sm11176232qkh.31.2015.04.27.01.47.08        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 27 Apr 2015 01:47:08 -0700 (PDT)
From: Mike DePaulo <mikedep333@gmail.com>
To: cygwin-patches@cygwin.com
Cc: Mike DePaulo <mikedep333@gmail.com>
Subject: [PATCH] * cygserver.xml: Add new section. How to install Cygserver.
Date: Mon, 27 Apr 2015 08:47:00 -0000
Message-Id: <1430124378-16484-2-git-send-email-mikedep333@gmail.com>
In-Reply-To: <1430124378-16484-1-git-send-email-mikedep333@gmail.com>
References: <1430124378-16484-1-git-send-email-mikedep333@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00036.txt.bz2

---
 winsup/doc/cygserver.xml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/winsup/doc/cygserver.xml b/winsup/doc/cygserver.xml
index 6a4ec4e..2367a60 100644
--- a/winsup/doc/cygserver.xml
+++ b/winsup/doc/cygserver.xml
@@ -179,6 +179,19 @@
 
 </sect2>
 
+<sect2 id="install-cygserver"><title>How to install Cygserver</title>
+
+<para>
+  Cygserver is part of the base <emphasis role='bold'>cygwin</emphasis> package.
+  Therefore, whenever Cygwin is installed, so is Cygserver.
+</para>
+<para>
+  You may want to install Cygserver as a service. See
+  <xref linkend="start-cygserver"></xref>.
+</para>
+
+</sect2>
+
 <sect2 id="start-cygserver"><title>How to start Cygserver</title>
 
 <para>
-- 
2.1.4
