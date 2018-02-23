Return-Path: <cygwin-patches-return-9035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24797 invoked by alias); 23 Feb 2018 13:23:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24059 invoked by uid 89); 23 Feb 2018 13:23:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.6 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=guardian, Guardian, Presentation, shield
X-HELO: mail-wm0-f41.google.com
Received: from mail-wm0-f41.google.com (HELO mail-wm0-f41.google.com) (74.125.82.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Feb 2018 13:23:22 +0000
Received: by mail-wm0-f41.google.com with SMTP id h21so4642606wmd.1        for <cygwin-patches@cygwin.com>; Fri, 23 Feb 2018 05:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=lsVnECZw8ObIiVBsZnM18S29TeKWJIJR5N3a0pruiRA=;        b=jm19mvduTKszpQLHQCgF9pq8xpbQZu0HrdEicdsXNEdRVihpDNiIn+Oz85Da6wxzAS         0+fvExL5l/Nf35Dl6aKDOvUOTeQJLaGHmSKwoMD7Vl+ntVWbpqFVGhp1gi6lsCTUCrKK         Q3+3Jo7X5oGa9KWo8kwElPLPALrR4CXhL2vu+2qJVY3Dy/UMFTYboUQHMg/TQGHMpEgb         +kT9pkCMMJ4SOzxDYOr4rba45+bzpasiUCZ2EL8uqR5iUsXCc9aNEnI+e846hmqOL1Q/         6lGSxCb8OUEwYlPwBtewZ8xHnfDSiIyfcosxMwFkdG0yoIf8t4FhD/Pr+jpTkqzRQgJg         Htxw==
X-Gm-Message-State: APf1xPAEYi+ENb0C0PzVoUd70FZ/Zzdp96ggVy64bxgE4ccRzzWErcaK	oghX7CcfoRDMHU/DPm3ATuMa6g9Y
X-Google-Smtp-Source: AH8x224CxMDzdFkx21Ps8fCSy/iJnlVGR966Ch6BwGAoJ/k6C+uxtwKjYSXeXnxbLa3895mhXAAcVw==
X-Received: by 10.28.52.9 with SMTP id b9mr1926131wma.114.1519392200248;        Fri, 23 Feb 2018 05:23:20 -0800 (PST)
Received: from localhost.localdomain ([164.215.120.147])        by smtp.gmail.com with ESMTPSA id m187sm2587866wmg.0.2018.02.23.05.23.18        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Fri, 23 Feb 2018 05:23:19 -0800 (PST)
From: david.macek.0@gmail.com
To: cygwin-patches@cygwin.com
Cc: David Macek <david.macek.0@gmail.com>
Subject: [PATCH] doc/faq-using.xml: Add BeyondTrust and Cylance to BLODA
Date: Fri, 23 Feb 2018 13:23:00 -0000
Message-Id: <20180223132244.19372-1-david.macek.0@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00043.txt.bz2

From: David Macek <david.macek.0@gmail.com>

Cylance:
- https://github.com/git-for-windows/git/issues/1244
- https://cygwin.com/ml/cygwin/2017-04/msg00238.html

BeyondTrust:
- https://cygwin.com/ml/cygwin/2017-04/msg00092.html
- https://cygwin.com/ml/cygwin/2017-05/msg00422.html
---
 winsup/doc/faq-using.xml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index f583b36ef..4fca00525 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1269,6 +1269,7 @@ behaviour which affect the operation of other programs, such as Cygwin.
 <listitem><para>ATI Catalyst (some versions)</para></listitem>
 <listitem><para>AVAST (disable FILESYSTEM and BEHAVIOR realtime shields)</para></listitem>
 <listitem><para>Avira AntiVir</para></listitem>
+<listitem><para>BeyondTrust PowerBroker</para></listitem>
 <listitem><para>BitDefender</para></listitem>
 <listitem><para>Bufferzone from Trustware</para></listitem>
 <listitem><para>ByteMobile laptop optimization client</para></listitem>
@@ -1277,6 +1278,7 @@ behaviour which affect the operation of other programs, such as Cygwin.
 <listitem><para>ConEmu (try disabling "Inject ConEmuHk" or see <ulink url="https://conemu.github.io/en/ConEmuHk.html#Third_party_problems">ConEmuHk documentation</ulink>)</para></listitem>
 <listitem><para>Citrix Metaframe Presentation Server/XenApp (see <ulink url="http://support.citrix.com/article/CTX107825">Citrix Support page</ulink>)</para></listitem>
 <listitem><para>Credant Guardian Shield</para></listitem>
+<listitem><para>CylancePROTECT</para></listitem>
 <listitem><para>Earthlink Total-Access</para></listitem>
 <listitem><para>Forefront TMG</para></listitem>
 <listitem><para>Google Desktop</para></listitem>
-- 
2.16.2.windows.1
