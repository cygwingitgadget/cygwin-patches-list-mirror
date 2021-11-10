Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 01CDA3858D35
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 20:32:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 01CDA3858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFKbB-1mw9jr2qlN-00Fk1G for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021
 21:32:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E75D0A80966; Wed, 10 Nov 2021 21:32:53 +0100 (CET)
From: corinna-cygwin@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: drop unused isabspath_u and iswabspath macros
Date: Wed, 10 Nov 2021 21:32:52 +0100
Message-Id: <20211110203253.2933679-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lltGPCFX9QEk38Dlgc/Czfsn6DFLRsHCkuTewG0xMNfZjNEWTW3
 wPjuHWGTxK74IZjI1dgacLoZbfH3bS+AYA7xQHs367QsAX/ZTX1pQybtveg4AFq+NoXjBqn
 SaWloJLHznUZoEpJfWLR3uqd5g37zTvgSMK3dBg7pBuI/ID9QT1ihBBPL/UINDKDOerriAA
 QLVHqPAqUxpmGtVwOpWYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UhgCeD/pTSg=:VRnyGWUkUSJvP9h8tJEJUQ
 8v2dS6l5eo6lWqQ6eyyVgzlYoIMKYy80h24dcqyeKxA5LiNEpRAZXftwQ/ETPiCCGeW3Rd3Zt
 uwxzEjd/gsQq3Uv2tvwTO/+/GBNP9JoPsokmu31HawYh9R5PgQeqiQRdxIwbFNJ0ZNQ/MYkZt
 RKnLE4VkXwIciZIFVeWdy1x+4Udv/My5JVV/mY3VNt8MLwp03jvxRwsQnIWlko9neQ1C4en+2
 N+9VJ6OiOge4IAGcd/EyS3COyMn3qHJ6FJRVXhT1KxtbbCUKfeiFsbfZGm71riOxZtKi8nUnc
 PPemNing8h9tWpw5s8z+hmb4tE8k2tM9yytiL34oYVfDGHdfwXzDTGb/7KvYwDKDcL03iIMH4
 2seKyOVt8kutrL2WYIUhl/SJFSbfwiFX6/3nEyw76HktVYTP8PlUywglR6tfYkgvMIbzWlB2G
 bGSFkinCkZDjgkdJQ3La1pjmLCWUb8FemH/998mu+8MHj8yD5HT0cZYD35zn9fpxnliJeA+wE
 NhOHEf4Mhf8jRfsGv8Nzh0sIzB3JpA6fRFwij0mp33aoaHZVnDyHj5rmtpG3smfhW4iGfEe9b
 ElnaWxkvsYH40BN5a8HZ74k4MiRiEsN8MOBXdjy2UgyaRtpBT2eEe/zyiQIAVdxvhf1fN6ohx
 E4Oom+W8/QHELjQZ5xxWEabEZQVJ3Hec8uICcEKb22TBSyao2aH86Uc5JQsdvKE0Z6eCJkFvS
 wVc31DxKgQ8tBAWE
X-Spam-Status: No, score=-55.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 10 Nov 2021 20:32:57 -0000

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/winsup.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index abdef35261ca..f6fea6313d56 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -139,18 +139,6 @@ extern int cygserver_running;
 #undef issep
 #define issep(ch) (strchr (" \t\n\r", (ch)) != NULL)
 
-/* Every path beginning with / or \, as well as every path being X:
-   or starting with X:/ or X:\ */
-#define isabspath_u(p) \
-  ((p)->Length && \
-   (iswdirsep ((p)->Buffer[0]) || \
-    ((p)->Length > sizeof (WCHAR) && iswalpha ((p)->Buffer[0]) \
-    && (p)->Buffer[1] == L':' && \
-    ((p)->Length == 2 * sizeof (WCHAR) || iswdirsep ((p)->Buffer[2])))))
-
-#define iswabspath(p) \
-  (iswdirsep (*(p)) || (iswalpha (*(p)) && (p)[1] == L':' && (!(p)[2] || iswdirsep ((p)[2]))))
-
 #define isabspath(p) \
   (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && (!(p)[2] || isdirsep ((p)[2]))))
 
-- 
2.31.1

