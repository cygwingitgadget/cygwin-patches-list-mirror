Return-Path: <cygwin-patches-return-8424-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64147 invoked by alias); 19 Mar 2016 17:46:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63863 invoked by uid 89); 19 Mar 2016 17:46:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=33,6, 33,7, HTo:U*cygwin-patches
X-HELO: mail-qg0-f67.google.com
Received: from mail-qg0-f67.google.com (HELO mail-qg0-f67.google.com) (209.85.192.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:21 +0000
Received: by mail-qg0-f67.google.com with SMTP id j92so7782032qgj.1        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=rfa4k24uHvAJ4kkR5r/g0b0ONZjiKfMjT4RN7/pi3yk=;        b=OQmeaymhhsLW05IZU5Z8tLanVSvcl08LMWQtipX+AQb4wimA8r6MpewIhtkdkQ8APZ         16VRzVG/jaNDGB8JsgAuuz+yldh9tTH0fU8Ghx4TeXwGluDLCrxyAvQt/TNEFZh7PPzF         ryQzElRkHz2tLofCWhovld73bZK4gaoC6e+qwRQANvAngwB3oKxyaaJE1pp0aaC5FpvE         4s5L7hlZKISZ9b/DUQ3e0tjMgFga8wxgC5YNnaeqnrA+aQjJKXs6Hoj4hgW0NmFqxyz2         mrbW+7+pO4qByBWNEN4WS8cAlN1zMR3hPT6O3E2cayPkk0gRPMZlXqTWEy14uwKFYM//         RCUQ==
X-Gm-Message-State: AD7BkJLLmS1p8dPtWzNmE3qOIf7NYTyeL40p1AdyGld9NRLO2+rYUiXAHYDlvO4cG2tN4g==
X-Received: by 10.140.155.7 with SMTP id b7mr32516812qhb.14.1458409579065;        Sat, 19 Mar 2016 10:46:19 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.18        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:18 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 11/11] respect datarootdir
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-11-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00127.txt.bz2

Recent versions of autoconf define datadir/infodir in terms of
datarootdir. Add it.

winsup/ChangeLog
* Makefile.in: define datarootdir

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/Makefile.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/Makefile.in b/winsup/Makefile.in
index 29ef22a..1fdf93a 100644
--- a/winsup/Makefile.in
+++ b/winsup/Makefile.in
@@ -33,6 +33,7 @@ endif
 else
 tooldir:=$(exec_prefix)/$(target_alias)
 endif
+datarootdir:=@datarootdir@
 datadir:=@datadir@
 infodir:=@infodir@
 includedir:=@includedir@
-- 
2.7.4
