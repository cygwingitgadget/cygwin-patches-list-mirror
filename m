Return-Path: <SRS0=eTgR=D6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id 8C1704BA2E0C
	for <cygwin-patches@cygwin.com>; Tue,  2 Jun 2026 11:20:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8C1704BA2E0C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8C1704BA2E0C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780399218; cv=none;
	b=JSr9HrAu6JC73nM5Gx7p3w74vEF/m4+TvGBcLJODSnBvkLk6kl1lbZc98OcWhLjjhCa4poPjUL7r7f/YGQC4A/TCNMMbCRIRI9jGgtATQZGE1QONnp1fbJ4NorWrc7otEmM4MImJPtHOa+R43qlkv80bzuBUXfantI39MiYpYaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780399218; c=relaxed/simple;
	bh=sAMt5pBUCFn5ZuxcVlUfCqmP49depNmNANSwE1op0dQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V92kmK+6tF8/q0ni7PHtxdm/xPm/D7k/x7rV3iygVE8PaZ7EPpSjVJSOFxn4OiVTIkiKCqJekiVM/M07OospBDLyEungKlUYSR/jj3CJEKhQPLIO77EQz9tfGXtvy8fe5m2DTqwa0P2jtGxaWFk71eNZkmKPpO/OowPlrYe+Zqk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C1704BA2E0C
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527801BD6180
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGBvDXiEhokyhYBHhOPiwYkuclryi+bsuTgXm/ZkDYRcvuECuPza9CxVnB0eiHhr2uMnVNUhsvqNoASjKCw0Z6USmYwJZJ0J9fpSnfv1pzX2hQgKKzlLbzxAC+MgqVPLPE3duj1WvtrF5EjunzjBDB0qKND+SW8Yqo6SAx+Jy7SiaR7emSKxcst+tDV/H/VQtPjrTP1GoCvISyjI3NBAqh65+jDWjHAUpkdyR6PnwrS0snDUY0UdzUrLdOHD2kpw1d7lkfaDtQSp5ZOgsIEAqcchKJVc59oj9vi9MM2iPcx3wQC/7f5cCmgXOQ5QyCVwStl1hE0CoEEZLZyU6n80t18hAbUG9e4Q+lWskdqbvgm2UcObB12TkvKSsGcL6WMd/VzUTFbzmV2DA/vYBM9Zlcn0XYC9ms7UKcB8h407X6fCN36SV2KQTxvgYypyZuQ3H9rb2FgtxqmXKogj/q4iT0xaX1AHRMtpP2H11XB8nPhlU0r7rsm/B/L4J2L7loNJaTV6eH2FHWEEOveQXGX1yMW6Hq7pMk/2QH3QNEGCqlnvagsjvSfaOnV8vrkjnvBzahLS8/dTzknbGSbMUiMaLdFghHZoRmNYJFq2kCShniz9paBdrEppBCAZAw2V1XluvjECecSgq8tsJHhglY4ouXadNJxTqXl9DZ8prUfy3fvrg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (83.105.142.8) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527801BD6180; Tue, 2 Jun 2026 12:20:11 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: cygcheck: fix a new warning with gcc 16
Date: Tue,  2 Jun 2026 12:20:07 +0100
Message-ID: <20260602112007.1279-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The mingW-targetted gcc available in Fedora is now gcc 16.

> ../../../../../winsup/utils/mingw/cygcheck.cc: In function 'void dump_sysinfo()':
> ../../../../../winsup/utils/mingw/cygcheck.cc:1716:11: error: variable 'count_path_items' set but not used [-Werror=unused-but-set-variable=]

As far as I can tell, the value of count_path_items we compute has never
been used.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/utils/mingw/cygcheck.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
index d17909bfc..e6374d712 100644
--- a/winsup/utils/mingw/cygcheck.cc
+++ b/winsup/utils/mingw/cygcheck.cc
@@ -1713,7 +1713,6 @@ dump_sysinfo ()
   else
     {
       char sep = strchr (s, ';') ? ';' : ':';
-      int count_path_items = 0;
       while (1)
 	{
 	  for (e = s; *e && *e != sep; e++);
@@ -1721,7 +1720,6 @@ dump_sysinfo ()
 	    printf ("\t%.*s\n", (int) (e - s), s);
 	  else
 	    puts ("\t.");
-	  count_path_items++;
 	  if (!*e)
 	    break;
 	  s = e + 1;
-- 
2.51.0

