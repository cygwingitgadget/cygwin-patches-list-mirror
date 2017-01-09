Return-Path: <cygwin-patches-return-8666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107107 invoked by alias); 9 Jan 2017 16:37:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107096 invoked by uid 89); 9 Jan 2017 16:37:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=cred, HTo:U*cygwin-patches
X-HELO: mail-wj0-f196.google.com
Received: from mail-wj0-f196.google.com (HELO mail-wj0-f196.google.com) (209.85.210.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 16:37:00 +0000
Received: by mail-wj0-f196.google.com with SMTP id dh1so4787119wjb.3        for <cygwin-patches@cygwin.com>; Mon, 09 Jan 2017 08:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=i2Jxozv2P73or6jTetxcWfoY+rrMiFDDmZzY33LeWlI=;        b=SWWpf2ti0KnyJZZ98EjCXlgOrvGnlGMeRt4j0q1DuOISB4vZ2fP9/Yn6mcn/nwhBaY         6r7L4LROJgQq/PUEPkYk8fZ1MuD1dH647OcFBjFU8XN13o6KYQiw9qhZPTMKDDfQmWu7         ebt6sf2BxYpjUmV1vFJWr/1dPS64JpuD+ohhVFXVAGA3FVn8dTEw44hq/Zd6MvBxmaQe         IXhbVzoXFI5G5YVCfDAA+DMC+Z3q61Qy4OF4nhcvyVgjA+Q68J53Mihg7c1l9J/4UUHC         1q5tKH6T/5qFogvnC/JFbIchuYVlM5T7b61p4p4Cr2AhqOoFoNX9VgDJKLlPr1rDdZtO         cgYg==
X-Gm-Message-State: AIkVDXKGJJbCfkAey6faYJbfrrdm98gtqwdFGxC0VW4G+sBMBwezg6Bus5ok+9Ui4u4uAg==
X-Received: by 10.194.8.226 with SMTP id u2mr66248258wja.91.1483979818623;        Mon, 09 Jan 2017 08:36:58 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id x135sm1399901wme.23.2017.01.09.08.36.57        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Mon, 09 Jan 2017 08:36:57 -0800 (PST)
From: Erik Bray <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Cc: Erik Bray <erik.m.bray@gmail.com>
Subject: [PATCH] Return the correct value for getsockopt(SO_REUSEADDR) after setting setsockopt(SO_REUSEADDR, 1).
Date: Mon, 09 Jan 2017 16:37:00 -0000
Message-Id: <20170109163647.86144-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00007.txt.bz2

From: Erik M. Bray <erik.bray@lri.fr>

---
 winsup/cygwin/net.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index e4805d3..b02f9e3 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -925,6 +925,14 @@ cygwin_getsockopt (int fd, int level, int optname, void *optval,
 	  res = fh->getpeereid (&cred->pid, &cred->uid, &cred->gid);
 	  __leave;
 	}
+      else if (optname == SO_REUSEADDR && level == SOL_SOCKET)
+    {
+      unsigned int *reuseaddr = (unsigned int *) optval;
+      *reuseaddr = fh->saw_reuseaddr();
+      *optlen = sizeof(*reuseaddr);
+      res = 0;
+      __leave;
+    }
       /* Old applications still use the old WinSock1 IPPROTO_IP values. */
       if (level == IPPROTO_IP && CYGWIN_VERSION_CHECK_FOR_USING_WINSOCK1_VALUES)
 	optname = convert_ws1_ip_optname (optname);
-- 
2.8.3
