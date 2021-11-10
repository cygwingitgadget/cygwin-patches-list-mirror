Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 5F3E03858407
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 20:32:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5F3E03858407
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCKJw-1muDvo2O7W-009OO0 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021
 21:32:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EAF1EA80D3D; Wed, 10 Nov 2021 21:32:53 +0100 (CET)
From: corinna-cygwin@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: introduce isabspath_strict macro
Date: Wed, 10 Nov 2021 21:32:53 +0100
Message-Id: <20211110203253.2933679-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dziy9bWkTrw5Ek+/tcXMteQeSS0tDZli21Gq8B/LW501QGCrh5B
 8c4RVPL5Z5n0a4F4S8AoduzRBnYHAZ9b90tMcz+dAVlxFkpwzX6u54e6OaFnvx12/k3hYkS
 v6zWNFEIUfRkzrie98jOX7G/z2JyPeSF9Af0bl+RQV6VcpjkXNXGsUwK3vnbUIBonFacDJm
 q22tXU+e0EZB3qPFPKKXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CvHTcwHCrLg=:HFfGqoLHdx1v9KVH5j8FQy
 FAmaNgPFdpow9LEYSG/9AiK5ZEWytqtR+GroJU9SeazXXjNNu7DnGBQDyQB53Ci64n0rfKyFo
 0Ykm9vFKoU8AJ0TxKVsREKlv2dB167dzv5ovfZ2LDWWev7Az4zjXLqbcLHNuOezc0cj4uUG+n
 39NxNtLYp48J3jVH9se7vgyP9WnB6yS0LD7bkz1wpBTbWIVDWpal2E5gFf1s6IbkqvNL6BkoW
 wSkSCmh8nXhQSzpKP6imqhVXFLIWcoT2LD1MdwNh6LpRd9jaZnBgxJtzRUk3PGyBmhRKY2e5R
 z7ZdMwQUeIOt8lFcb0mX//tPjwtAViBnLK3RUuro9DvfcCUYuuHqJxCDAM1hAC4iBGLx7guLe
 L8HJO3+FP++4R49ApZNllofnIaN/SdGzBnwC5Rgydz9pZpdFYTM1JH3349EK8Umb+NyDiqOx0
 YTRrZSt25r8awNtYJMzois+q/gajixv3SeadwIcAaYqpudmfIuuZgukwAYxBAKKs80cRdgCQw
 woFdDTNmxwS/x9zbPVGfX12I++26JdABRNGnhH28gcElINprIns8MfW0HfzVR5LKCAh4VJ8un
 aocQzosMxPUz+s+U1RWEjAVdsPPB61EHEQYIunQZHhIFPGyu6Y55UReBxasM2ZEQnS/Kuqc/Y
 px8s85BkvVf5xjWOBLCDJPBSfF1hRXGsSxRYOstTcQGTSO1DKLYeV+9/hDBnfTxlMIFDE2GQY
 IImvDwU31PiWmO1Q
X-Spam-Status: No, score=-55.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 10 Nov 2021 20:32:58 -0000

From: Corinna Vinschen <corinna@vinschen.de>

isabspath handles a path "X:", without trailing slas or backslash,
as absolute path.  This breaks some scenarios with relative paths
starting with "X:".  For instance, fstatat will mishandle a call
with valid dirfd and "c:" as path.

The reason is that gen_full_path_at() will check for isabspath("C:")
which returns true.  So the path will be used verbatim in fstatat,
rather than being converted to a path "<dirfd-path>/c:".

So, introduce isabspath_strict, which returns true for paths starting
with "X:" only if the next char is actually a slash or backslash.
Use it from gen_full_path_at().

This still fixes only half the problem.  The right thing would have been
to disallow using DOS paths in the first place.  Unfortunately it's much
too late for that.

Addresses: https://cygwin.com/pipermail/cygwin/2021-November/249837.html
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/syscalls.cc | 2 +-
 winsup/cygwin/winsup.h    | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 7a48e422e8f4..661c143479e4 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4714,7 +4714,7 @@ gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
 	  return -1;
 	}
     }
-  if (pathname && isabspath (pathname))
+  if (pathname && isabspath_strict (pathname))
     stpcpy (path_ret, pathname);
   else
     {
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index f6fea6313d56..1f265ec28934 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -139,9 +139,17 @@ extern int cygserver_running;
 #undef issep
 #define issep(ch) (strchr (" \t\n\r", (ch)) != NULL)
 
+/* Treats "X:" as absolute path.
+   FIXME: We should drop the notion that "X:" is a valid absolute path.
+   Only "X:/" and "X:\\" should be (see isabspath_strict below).  The
+   problem is to find out if we have code depending on this behaviour. */
 #define isabspath(p) \
   (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && (!(p)[2] || isdirsep ((p)[2]))))
 
+/* Treats "X:/" and "X:\\" as absolute paths, but not "X:" */
+#define isabspath_strict(p) \
+  (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && isdirsep ((p)[2])))
+
 /******************** Initialization/Termination **********************/
 
 class per_process;
-- 
2.31.1

