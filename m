Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 44F13385841D
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:49:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 44F13385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 44F13385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808156; cv=none;
	b=BnQ6uxUOVhSWEyR8b5OS3WU25eQjq4iYX5iNH9kxJp0HcePizo671VhFHPUHZT7gr/7KwqUZSJNV+k/m+dZdw4+noYaNOT6xh9EUZd+G3t3YQ1rDyxfXbtihd6lZ5mwPBYR67GhgQnpKjbG1+rpsG56SqMIuLzv8hinECk0pWBM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808156; c=relaxed/simple;
	bh=U/uyDrHLDS+OlkY/RrtZzhWPLy7aETDOOzFnt5H5fAU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X3bTNssF9Z9b82Ezaupq1ZCe9+XefDlIl2HPvjRlLSl0njj8VIKz+o+fHD5TvbauniKBaxl0EUtGdZQOsx0k+NSaiAUU52RaCxY+KFjfqHESQvb2hYyUv12y4hvYojeiBYzSltMMKQQETMn6Q82ZW9dtgC2JBti4ZhlvovI+zks=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 66944170026F1E42
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepvdffueduteekhffhgfekgfdvteetgffhheevuefhkeegudevveeuleegudfftedunecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1E42; Sun, 4 Aug 2024 22:49:13 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/6] Cygwin: Suppress false positive use-after-free warnings in __set_lc_time_from_win()
Date: Sun,  4 Aug 2024 22:48:27 +0100
Message-ID: <20240804214829.43085-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Supress new use-after-free warnings about realloc(), seen with gcc 12, e.g.:

> In function ‘void rebase_locale_buf(const void*, const void*, const char*, const char*, const char*)’,
>     inlined from ‘int __set_lc_time_from_win(const char*, const lc_time_T*, lc_time_T*, char**, wctomb_p, const char*)’ at ../../../../src/winsup/cygwin/nlsfuncs.cc:705:25:
> ../../../../src/winsup/cygwin/nlsfuncs.cc:338:24: error: pointer ‘new_lc_time_buf’ may be used after ‘void* realloc(void*, size_t)’ [-Werror=use-after-free]
>   338 |       *ptrs += newbase - oldbase;
>       |                ~~~~~~~~^~~~~~~~~
> ../../../../src/winsup/cygwin/nlsfuncs.cc: In function ‘int __set_lc_time_from_win(const char*, const lc_time_T*, lc_time_T*, char**, wctomb_p, const char*)’:
> ../../../../src/winsup/cygwin/nlsfuncs.cc:699:44: note: call to ‘void* realloc(void*, size_t)’ here
>   699 |               char *tmp = (char *) realloc (new_lc_time_buf, len);

We do some calculations using the pointer passed to realloc(), but do
not not dereference it, so this seems safe?

Because use-after-free is a new warning in gcc 12, we only disable it on
gcc 12 or later, to avoid warnings about unknown diagnostic options on
earlier gcc versions.
---
 winsup/cygwin/nlsfuncs.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
index b32fecc8e..cf0e96d2d 100644
--- a/winsup/cygwin/nlsfuncs.cc
+++ b/winsup/cygwin/nlsfuncs.cc
@@ -324,6 +324,10 @@ locale_cmp (const void *a, const void *b)
    structures consist entirely of pointers so they are practically pointer
    arrays.  What we do here is just treat the lc_foo pointers as char ** and
    rebase all char * pointers within, up to the given size of the structure. */
+#pragma GCC diagnostic push
+#if __GNUC__ >= 12
+#pragma GCC diagnostic ignored "-Wuse-after-free"
+#endif
 static void
 rebase_locale_buf (const void *ptrv, const void *ptrvend, const char *newbase,
 		   const char *oldbase, const char *oldend)
@@ -333,6 +337,7 @@ rebase_locale_buf (const void *ptrv, const void *ptrvend, const char *newbase,
     if (*ptrs >= oldbase && *ptrs < oldend)
       *ptrs += newbase - oldbase;
 }
+#pragma GCC diagnostic pop
 
 static wchar_t *
 __getlocaleinfo (wchar_t *loc, LCTYPE type, char **ptr, size_t size)
@@ -699,7 +704,12 @@ __set_lc_time_from_win (const char *name,
 		  if (tmp != new_lc_time_buf)
 		    rebase_locale_buf (_time_locale, _time_locale + 1, tmp,
 				       new_lc_time_buf, lc_time_ptr);
+#pragma GCC diagnostic push
+#if __GNUC__ >= 12
+#pragma GCC diagnostic ignored "-Wuse-after-free"
+#endif
 		  lc_time_ptr = tmp + (lc_time_ptr - new_lc_time_buf);
+#pragma GCC diagnostic pop
 		  new_lc_time_buf = tmp;
 		  lc_time_end = new_lc_time_buf + len;
 		}
-- 
2.45.1

