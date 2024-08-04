Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id AA56C385842D
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:49:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA56C385842D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA56C385842D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808144; cv=none;
	b=gIiSmP65RHuqVTsTzim56WgIUkb1LgWd2v0nssCiQtQPI35zEDalY3OIn6vBz+Eale3c0ybJjQj3SQFLrWoG65+LUBijohHP5vUUmUVjaggssQRSFU46/pBjnS9L+7qhxDd7YR4rw1SHarrMU6Htta1xdrGAvFInsuoJDItSH+s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808144; c=relaxed/simple;
	bh=LMUeqOlOxYln5Cx+N604KTS8ootsMRNqxkYCJr6wHus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rlONcxEt0Xx23r1W/zLhty7WXrDmpHvHXiUJIxbfOqpypnHYsjF1SANU69QQLA7DMjOAR/hsfqTgVpZ6OH0TmGQvpZRio2/kaBN+U/K6APeM6kfAKmoDmL9nhvuXgpJdBSmJFUGzddPDlrU/IEQ2l/G26PojuCyj0DLLAzeUN4Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1D76
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdffueduteekhffhgfekgfdvteetgffhheevuefhkeegudevveeuleegudfftedunecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1D76; Sun, 4 Aug 2024 22:49:02 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/6] Cygwin: Fix warning about address known to be non-NULL in /proc/locales
Date: Sun,  4 Aug 2024 22:48:24 +0100
Message-ID: <20240804214829.43085-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix a gcc 12 warning about an address known to be non-NULL in
format_proc_locale_proc().

> ../../../../src/winsup/cygwin/fhandler/proc.cc: In function ‘BOOL format_proc_locale_proc(LPWSTR, DWORD, LPARAM)’:
> ../../../../src/winsup/cygwin/fhandler/proc.cc:2156:11: error: the address of ‘iso15924’ will never be NULL [-Werror=address]
>  2156 |       if (iso15924)
>       |           ^~~~~~~~
> ../../../../src/winsup/cygwin/fhandler/proc.cc:2133:11: note: ‘iso15924’ declared here
>  2133 |   wchar_t iso15924[ENCODING_LEN + 1] = { 0 };
>       |           ^~~~~~~~
---
 winsup/cygwin/fhandler/proc.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 8c7a4ab06..f1cd468fc 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -2193,8 +2193,7 @@ format_proc_locale_proc (LPWSTR win_locale, DWORD info, LPARAM param)
       if (!(cp2 = wcschr (cp + 2, L'-')))
         return TRUE;
       /* Otherwise, store in iso15924 */
-      if (iso15924)
-        wcpcpy (wcpncpy (iso15924, cp, cp2 - cp), L";");
+      wcpcpy (wcpncpy (iso15924, cp, cp2 - cp), L";");
     }
   cp = wcsrchr (win_locale, L'-');
   if (cp)
-- 
2.45.1

