Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id AF2AF385801A
 for <cygwin-patches@cygwin.com>; Thu,  9 Dec 2021 11:16:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AF2AF385801A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 1B9BFaHf019660;
 Thu, 9 Dec 2021 20:15:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B9BFaHf019660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639048542;
 bh=5RkoWk/fM9+jxNlgDXoyWrF1y0rSam4iK2OF9iSQqHw=;
 h=From:To:Cc:Subject:Date:From;
 b=fdzP7S49uSxRYxRMxcsrlSQSrqes6wJ572slXL3BlWOv8kTHRaRnZgYzyh4uv5kAa
 zpA+OAZdqKBKfSDSCeL+StfvMlty8uzV1MiqT7IRrpKzVGxO4+TwS+GTOYYm8wXu9c
 aaLn2cBHY5TMOkDMmwFLr2aW294g/L4PSXIGD1876/sUid+TEhqQlHBretQwK/bFb1
 QzUhyFEIc/EQYV4VbeRnA7FPF+n2wZBMiAyvJh6KEYqKh0O81D7q9UhE3vITqgYUBs
 fiQHs/WqKPLIu6v3/uuwQ864RVIjuQwsA3c8hrSN8wicdtCXgWNsr3FU/FjsIKFTtR
 FHfhudAwIvO/A==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: path: Fix path conversion of virtual drive.
Date: Thu,  9 Dec 2021 20:15:27 +0900
Message-Id: <20211209111527.15917-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 09 Dec 2021 11:16:11 -0000

- The last change in path.cc introduced a bug that causes an error
  when accessing a virtual drive which mounts UNC path such as
  "\\server\share\dir" rather than "\\server\share". This patch
  fixes the issue.
---
 winsup/cygwin/path.cc | 56 +++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index eb1255849..4f82dbebb 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3507,29 +3507,43 @@ restart:
 		  if (RtlEqualUnicodePathPrefix (&fpath, &ro_u_uncp, TRUE)
 		      && !RtlEqualUnicodePathPrefix (&upath, &ro_u_uncp, TRUE))
 		    {
-		      /* ...get the remote path from the volume path name,
-			 replace remote path with drive letter, check again. */
+		      /* ...get the remote path, replace remote path
+			 with drive letter, check again. */
+		      WCHAR drive[3] =
+			{(WCHAR) towupper (upath.Buffer[4]), L':', L'\0'};
 		      WCHAR remote[MAX_PATH];
 
-		      fpbuf[1] = L'\\';
-		      BOOL r = GetVolumePathNameW (fpbuf, remote, MAX_PATH);
-		      fpbuf[1] = L'?';
-		      if (r)
-			{
-			  int remlen = wcslen (remote);
-			  if (remote[remlen - 1] == L'\\')
-			    remlen--;
-			  /* Hackfest */
-			  fpath.Buffer[4] = upath.Buffer[4]; /* Drive letter */
-			  fpath.Buffer[5] = L':';
-			  WCHAR *to = fpath.Buffer + 6;
-			  WCHAR *from = to + remlen - 6;
-			  memmove (to, from,
-				   (wcslen (from) + 1) * sizeof (WCHAR));
-			  fpath.Length -= (from - to) * sizeof (WCHAR);
-			  if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
-			    goto file_not_symlink;
-			}
+
+		      int remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
+		      if (!remlen)
+			goto file_not_symlink; /* fallback */
+		      remlen -= 2;
+
+		      if (remote[remlen - 1] == L'\\')
+			remlen--;
+		      WCHAR *p;
+		      UNICODE_STRING rpath;
+		      RtlInitCountedUnicodeString (&rpath, remote,
+						   remlen * sizeof (WCHAR));
+		      if (RtlEqualUnicodePathPrefix (&rpath, &ro_u_uncp, TRUE))
+			remlen -= 6;
+		      else if ((p = wcschr (remote, L';'))
+			       && p + 3 < remote + remlen
+			       && wcsncmp (p + 1, drive, 2) == 0
+			       && (p = wcschr (p + 3, L'\\')))
+			remlen -= p - remote - 1;
+		      else
+			goto file_not_symlink; /* fallback */
+		      /* Hackfest */
+		      fpath.Buffer[4] = drive[0]; /* Drive letter */
+		      fpath.Buffer[5] = L':';
+		      WCHAR *to = fpath.Buffer + 6;
+		      WCHAR *from = to + remlen;
+		      memmove (to, from,
+			       (wcslen (from) + 1) * sizeof (WCHAR));
+		      fpath.Length -= (from - to) * sizeof (WCHAR);
+		      if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
+			goto file_not_symlink;
 		    }
 		  issymlink = true;
 		  /* upath.Buffer is big enough and unused from this point on.
-- 
2.34.1

