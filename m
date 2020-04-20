Return-Path: <david.macek.0@gmail.com>
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by sourceware.org (Postfix) with ESMTPS id 4C45B3858D31
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 17:21:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4C45B3858D31
Received: by mail-wm1-x341.google.com with SMTP id x4so418600wmj.1
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=tnUBU9LEEG4wGXNjjYprH47Ufw9TuMvumPYxnrqDgKY=;
 b=KgRRWZqnnv7FGSXbyMaTAcsKsbkvEHdDta/k2sn6w1ZqOdXlw6uruo7kdA8P80gT1W
 MWJZwpMZShwuY6+2f6+sQH+9dXOpaiF0bUgY8BM5SVJ6bjTuQi4LmeS0sw76Rqvnp6Z/
 KEJX3ywVejNp8xThN6ug0jexTedUseX7o2OOfJJABYhZ3Qt+FguWfAznK6zwRpzk5rG8
 ApggKbKP41Zu/XaYInuRTdtU6Yx6Ra88CaOe/l3uGnP1LKFulcKYjXi+33LceHGPtVbJ
 Wr3Ev0Si9VIrJ2ZjAfw1Ntwgw8qWHTjsdQhEypsk0kec/eppGx2nbPuc2oM9YaOS6AzW
 17pQ==
X-Gm-Message-State: AGi0PuYY0TyQjCsxZUp5zCK2/r/upS7ftO1ia6BDu+Oi7hzAbbxet4ub
 kVt/VeVa8iqDbmAsF8vuOZSlGVj9mLA=
X-Google-Smtp-Source: APiQypLvxEGjhxyfzKrjXzZnlKVY9nmMINFg+eCy60yiz9oG2xNHVwJ8ys2nT0d3lp+vdUnUEUVrdQ==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr335418wmg.177.1587403264026; 
 Mon, 20 Apr 2020 10:21:04 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id m1sm175166wro.64.2020.04.20.10.21.03
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 10:21:03 -0700 (PDT)
Date: Mon, 20 Apr 2020 19:21:00 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3 v2] Cygwin: accounts: Don't keep old schemes when
 parsing nsswitch.conf
Message-ID: <20200420192056.00000e76@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Apr 2020 17:21:07 -0000

The implicit assumption seemed to be that any subsequent occurence of
the same setting in nsswitch.conf is supposed to rewrite the previous
ones completely.  This was not the case if the third or any further
schema was previously defined and the last line defined less than that
(but at least 2), for example:

```
db_home: windows cygwin /myhome/%U
db_home: cygwin desc
```

Let's document this behavior as well.

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/cygwin/uinfo.cc | 7 +++----
 winsup/doc/ntsec.xml   | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 2d5fc488bb..b733a6ee87 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -790,12 +790,12 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 	    scheme = gecos_scheme;
 	  if (scheme)
 	    {
-	      uint16_t idx = 0;
+	      for (uint16_t idx = 0; idx < NSS_SCHEME_MAX; ++idx)
+		scheme[idx].method = NSS_SCHEME_FALLBACK;
 
-	      scheme[0].method = scheme[1].method = NSS_SCHEME_FALLBACK;
 	      c = strchr (c, ':') + 1;
 	      c += strspn (c, " \t");
-	      while (*c && idx < NSS_SCHEME_MAX)
+	      for (uint16_t idx = 0; *c && idx < NSS_SCHEME_MAX; ++idx)
 		{
 		  if (NSS_CMP ("windows"))
 		    scheme[idx].method = NSS_SCHEME_WINDOWS;
@@ -826,7 +826,6 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		    }
 		  c += strcspn (c, " \t");
 		  c += strspn (c, " \t");
-		  ++idx;
 		}
 	    }
 	}
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 032bebe4dc..b5996567f8 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -915,6 +915,11 @@ Apart from this restriction, the remainder of the line can have as
 many spaces and TABs as you like.
 </para>
 
+<para>
+When the same keyword occurs multiple times, the last one wins, as if the
+previous ones were ignored.
+</para>
+
 </sect4>
 
 <sect4 id="ntsec-mapping-nsswitch-pwdgrp"><title id="ntsec-mapping-nsswitch-pwdgrp.title">The <literal>passwd:</literal> and <literal>group:</literal> settings</title>
-- 
2.26.1.windows.1

