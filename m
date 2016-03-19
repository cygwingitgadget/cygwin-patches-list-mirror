Return-Path: <cygwin-patches-return-8417-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63157 invoked by alias); 19 Mar 2016 17:46:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63121 invoked by uid 89); 19 Mar 2016 17:46:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=evaluates, UD:Right, HTo:U*cygwin-patches
X-HELO: mail-qk0-f196.google.com
Received: from mail-qk0-f196.google.com (HELO mail-qk0-f196.google.com) (209.85.220.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:15 +0000
Received: by mail-qk0-f196.google.com with SMTP id e124so5022177qkc.3        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=o2z+mtDRyIyB0PBzPj5MFUYraFlRB8fLs5gQTQrIUFo=;        b=nEWVDwI/csieAHtZcI4TPEr0go83fccTBH3fgGa38FQPMU0LWe2rnydwJEBNcpYZ6m         dpoBfTNmvAigBh5czyGMktecI3Pom7WsuVoOgV1C2eFkEByho1BStYsSpORKH78tNWLs         8Mmd4sMWJ8MR4uOw5IuphPrEHxlmx7VM160u9CZJ/iW4CcX7SuWCSi/0Aqh/U0WZgKIE         8eZg+iWYCJ5ajj4ElUHM7nqeMD7mitUUJp2koovqKIOJZ7HrKW+jKlLksm264h9A9Bay         4vcYI2GZ+O+iTG7tZZHvHzxyGwYKqPIh25e+VJGtTXo+DUrK6YE2n+XiNQ/d6qHy6/Yg         zFCA==
X-Gm-Message-State: AD7BkJKHYehqQxN5X5d0F+PQCdgkTU6+E+bftXAk1hOZbQr7U2mhZZiEQBlj0vJwGKskZg==
X-Received: by 10.55.217.208 with SMTP id q77mr30529396qkl.106.1458409573280;        Sat, 19 Mar 2016 10:46:13 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.12        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:12 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 02/11] Remove dead code from fhandler_console.
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-2-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00123.txt.bz2

This if is unconditionally false, so remove it.

winsup/cygwin/fhandler_console.cc: In member function 'bool dev_console::fillin(HANDLE)':
winsup/cygwin/fhandler_console.cc:740:22: error: self-comparison always evaluates to false [-Werror=tautological-compare]
       if (b.dwSize.Y != b.dwSize.Y || b.dwSize.X != b.dwSize.X)
           ~~~~~~~~~~~^~~~~~~~~~~~~
winsup/cygwin/fhandler_console.cc:740:50: error: self-comparison always evaluates to false [-Werror=tautological-compare]
       if (b.dwSize.Y != b.dwSize.Y || b.dwSize.X != b.dwSize.X)
                                       ~~~~~~~~~~~^~~~~~~~~~~~~

winsup/cygwin/ChangeLog
* fhandle_console.cc (fillin): remove dead code

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/fhandler_console.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index ef2d1c5..41af223 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -746,8 +746,6 @@ dev_console::fillin (HANDLE h)
     {
       dwWinSize.Y = 1 + b.srWindow.Bottom - b.srWindow.Top;
       dwWinSize.X = 1 + b.srWindow.Right - b.srWindow.Left;
-      if (b.dwSize.Y != b.dwSize.Y || b.dwSize.X != b.dwSize.X)
-	dwEnd.X = dwEnd.Y = 0;
       if (b.dwCursorPosition.Y > dwEnd.Y
 	  || (b.dwCursorPosition.Y >= dwEnd.Y && b.dwCursorPosition.X > dwEnd.X))
 	dwEnd = b.dwCursorPosition;
-- 
2.7.4
