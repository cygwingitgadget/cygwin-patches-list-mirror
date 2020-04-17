Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by sourceware.org (Postfix) with ESMTPS id E1550385B835
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 09:31:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E1550385B835
Received: by mail-wr1-x442.google.com with SMTP id i10so2230290wrv.10
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 02:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=gI7j3pQWJyRbo2Ivp4zpMiPR+q5lVc/L1ub2ykoUTmg=;
 b=Ip/a7F932h1IkJLonz3W+J5UccvfzTcECTiPtnJrTMCMOOh/JrE7jEetTsb/GPtrUt
 wQUxiB1no/JERz1vOYJ6D3wn5Ihx7neFKoDYZg+gPR1quvCBlqSjXLqMaYVAOILlfZMB
 Uf0dxwhyGYYVS2Z+80iSP5SGRn7CRS0hPxOKdD3tNYryvXPPGED3c+IRZBHm479dGrIN
 q3+WBk2l7YHI9cN541jLg8XVcco4JPNaY9NMnpxdskzxXN3tpaZM0+kMgrRo/JEPtCj9
 Q21HNHZFL6ERjRvvdk38CxrPKCc7eeMZhELC5Sf7A+i4a2l9qN1FfL0OPcphsGvc9BrF
 9xgg==
X-Gm-Message-State: AGi0PuYzDBIiR8uodO6w/IjBoS2T5qNViAUfbKqMRAHfu+cMz79Qr97r
 WcwxgdLC0OoCNrxMlzEazwjpwAAZ4mQ=
X-Google-Smtp-Source: APiQypKoYS2ztCvJl8XtqbX5p3GlTW8NXx35eT+F18cySdx+HcUiYqgwGZFrrWCwn46drbO0/sgnOg==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr2888141wrp.294.1587115872683; 
 Fri, 17 Apr 2020 02:31:12 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id k5sm17221819wrg.48.2020.04.17.02.31.11
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Apr 2020 02:31:12 -0700 (PDT)
Date: Fri, 17 Apr 2020 11:31:07 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] cygheap_pwdgrp: Don't keep old schemes when parsing
 nsswitch.conf
Message-ID: <20200417113107.00005311@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 17 Apr 2020 09:31:15 -0000

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
---
 winsup/cygwin/uinfo.cc | 5 +++--
 winsup/doc/ntsec.xml   | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 227faa4248..a4fcc33d8d 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -793,9 +793,10 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 	    scheme = gecos_scheme;
 	  if (scheme)
 	    {
-	      uint16_t idx = 0;
+	      for (uint16_t idx = 0; idx < NSS_SCHEME_MAX; ++idx)
+		scheme[idx].method = NSS_SCHEME_FALLBACK;
 
-	      scheme[0].method = scheme[1].method = NSS_SCHEME_FALLBACK;
+	      uint16_t idx = 0;
 	      c = strchr (c, ':') + 1;
 	      c += strspn (c, " \t");
 	      while (*c && idx < NSS_SCHEME_MAX)
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 5287845686..153ff1eac8 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -918,6 +918,11 @@ Apart from this restriction, the remainder of the line can have as
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

