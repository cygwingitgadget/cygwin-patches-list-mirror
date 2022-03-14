Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 5E0103857829
 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022 10:58:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5E0103857829
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 22EAvrPT015096;
 Mon, 14 Mar 2022 19:57:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 22EAvrPT015096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647255479;
 bh=tSkJoozRKnNQl0jlHHwBnxO7K06cX5IFCv4oOzuNlIw=;
 h=From:To:Cc:Subject:Date:From;
 b=2UlnhVjC9HH/EIdNvSOOv0Dpe/j6e+BfzLGJng0EXPzqNETkfUUrUQt2LsDmihGcT
 EPRfmCqUCtd5hraDouqJqI2Km32fgi8kHT924C1TcItMxxiVAQ8/Wa5shJDHJ91Urr
 ZPzjF6ESSYHLKJKWLplfB9Upu33Crf8HHa1ZhJ9lG/YCjhg8zLIRIJvAu+S2X27Gcs
 XIKbZ1vog2o3p1vFsDUG36RutNUUW14DOPH50lBprGGB6SB4MI1kCXi80azugCNV0f
 mo7ISFGgbhYbSoFYg9lFs1L6MpL/9Y4Ij3Ns/cYn+Fdup+bFWchI2s/nfg/eBHnXDk
 9xegE/Q9H+ojQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: path: Add fallback for DFS mounted drive.
Date: Mon, 14 Mar 2022 19:57:44 +0900
Message-Id: <20220314105744.739-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 14 Mar 2022 10:58:15 -0000

- If UNC path for DFS is mounted to a drive with drive letter, the
  error "Too many levels of symbolic links" occurs when accessing
  to that drive. This is because GetDosDeviceW() returns unexpected
  string such as "\Device\Mup\DfsClient\;Z:000000000003fb89\dfsserver
  \dfs\linkname" for the mounted UNC path "\??\UNC\fileserver\share".
  This patch adds a workaround for this issue.

  Addresses: https://cygwin.com/pipermail/cygwin/2022-March/250979.html
---
 winsup/cygwin/path.cc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 4ad4e0821..dd8f6c043 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3527,7 +3527,7 @@ restart:
 		      int remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
 		      if (remlen < 3)
 			goto file_not_symlink; /* fallback */
-		      remlen -= 2;
+		      remlen -= 2; /* Two L'\0' */
 
 		      if (remote[remlen - 1] == L'\\')
 			remlen--;
@@ -3535,20 +3535,27 @@ restart:
 		      UNICODE_STRING rpath;
 		      RtlInitCountedUnicodeString (&rpath, remote,
 						   remlen * sizeof (WCHAR));
+		      const int uncp_len =
+			ro_u_uncp.Length / sizeof (WCHAR) - 1;
 		      if (RtlEqualUnicodePathPrefix (&rpath, &ro_u_uncp, TRUE))
-			remlen -= 6;
+			{
+			  remlen -= uncp_len;
+			  p = remote + uncp_len;
+			}
 		      else if ((p = wcschr (remote, L';'))
 			       && p + 3 < remote + remlen
 			       && wcsncmp (p + 1, drive, 2) == 0
 			       && (p = wcschr (p + 3, L'\\')))
-			remlen -= p - remote - 1;
+			remlen -= p - remote;
 		      else
 			goto file_not_symlink; /* fallback */
+		      if (wcsncasecmp (fpath.Buffer + uncp_len, p, remlen))
+			goto file_not_symlink; /* fallback (not expected) */
 		      /* Hackfest */
 		      fpath.Buffer[4] = drive[0]; /* Drive letter */
 		      fpath.Buffer[5] = L':';
-		      WCHAR *to = fpath.Buffer + 6;
-		      WCHAR *from = to + remlen;
+		      WCHAR *to = fpath.Buffer + 6; /* Next to L':' */
+		      WCHAR *from = fpath.Buffer + uncp_len + remlen;
 		      memmove (to, from,
 			       (wcslen (from) + 1) * sizeof (WCHAR));
 		      fpath.Length -= (from - to) * sizeof (WCHAR);
-- 
2.35.1

