Return-Path: <cygwin-patches-return-8505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128851 invoked by alias); 30 Mar 2016 13:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128838 invoked by uid 89); 30 Mar 2016 13:16:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=63,7, HTo:U*cygwin-patches
X-HELO: mail-qk0-f174.google.com
Received: from mail-qk0-f174.google.com (HELO mail-qk0-f174.google.com) (209.85.220.174) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 30 Mar 2016 13:16:00 +0000
Received: by mail-qk0-f174.google.com with SMTP id x64so19315582qkd.1        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2016 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=6ktgC4WfblfNGu93n2sv4wv86TFaSRkJmqYTQ2JisIg=;        b=XPODEfaDvfZi8D/GYHfYyOvVH0//krGsoM1WI5DpGC3MGV5PmrPJ7SuJ+SjV3nLdmy         pU4GbQyhhenrMWmVVoM+b2qoWYnvy35KA+EOPFy/7mY6y6LsfWM2wah6aPF4u/EMe+B5         Mj9iksxpecOFabsnHmu0OJshsW62RoxT0hp7cdDNTUBhArRhCVhmFs71m50LCmf53cDT         QQulq/z/Sr20um2DYVBk2N0v1QPJ2BDBRQ5FEicIKz+CvfzOCUmFJ7GTtPLG5qlMhUwA         46O6HqAHZ8ksRASbA7Ldt60zM25AVbs2vixQAn9Z5nNPtvun2yktrdEZaNYKxb/EC5l2         NrGQ==
X-Gm-Message-State: AD7BkJIZOlLeRqfr67kaZcukPt++m6L8R1vqraowknmc7v60IaweWtpg2fSBJEjI6srU4A==
X-Received: by 10.55.207.217 with SMTP id v86mr9642786qkl.16.1459343758385;        Wed, 30 Mar 2016 06:15:58 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id g50sm1709098qgg.40.2016.03.30.06.15.57        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Wed, 30 Mar 2016 06:15:57 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH] fix typo in netinit/ip.h
Date: Wed, 30 Mar 2016 13:16:00 -0000
Message-Id: <1459343755-15162-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00211.txt.bz2

The type for the ip_tos member was typoed, fix it.

winsup/cygwin/ChangeLog:
include/netinet/ip.h: fix type of ip_tos

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/include/netinet/ip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/include/netinet/ip.h
index b952d53..1f6ebbe 100644
--- a/winsup/cygwin/include/netinet/ip.h
+++ b/winsup/cygwin/include/netinet/ip.h
@@ -63,7 +63,7 @@ struct ip {
 		     ip_hl:4;		/* header length */
 #endif
 #endif /* not _IP_VHL */
-	u_int_8   ip_tos;		/* type of service */
+	u_int8_t   ip_tos;		/* type of service */
 	u_int16_t ip_len;		/* total length */
 	u_int16_t ip_id;		/* identification */
 	u_int16_t ip_off;		/* fragment offset field */
-- 
2.8.0
