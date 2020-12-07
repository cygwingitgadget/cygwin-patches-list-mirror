Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 988493846079
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 10:29:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 988493846079
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0B7ATtIN024707;
 Mon, 7 Dec 2020 02:29:55 -0800 (PST) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdEEmJgM; Mon Dec  7 02:29:54 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
Date: Mon,  7 Dec 2020 02:29:36 -0800
Message-Id: <20201207102936.1527-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 07 Dec 2020 10:30:00 -0000

The existing code errors as EINVAL any attempt to set a value for
SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
enable the workaround set_no_getpeereid behavior for Python one has
to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
no way to specify a NULL pointer for 'optval'.

This v2 of patch allows the original working (i.e., allow NULL,0 for
optval,optlen to mean turn off SO_PEERCRED) in addition to the new
working described above.  The sense of the 'if' stmt is reversed for
readability.

---
 winsup/cygwin/fhandler_socket_local.cc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index c94bf828f..964f3e819 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -1430,10 +1430,14 @@ fhandler_socket_local::setsockopt (int level, int optname, const void *optval,
 	     FIXME: In the long run we should find a more generic solution
 	     which doesn't require a blocking handshake in accept/connect
 	     to exchange SO_PEERCRED credentials. */
-	  if (optval || optlen)
-	    set_errno (EINVAL);
-	  else
+	  /* Temporary: Allow SO_PEERCRED to only be zeroed. Two ways to
+	     accomplish this: pass NULL,0 for optval,optlen; or pass the
+	     address,length of an '(int) 0' set up by the caller. */
+	  if ((!optval && !optlen) ||
+		(optlen == (socklen_t) sizeof (int) && !*(int *) optval))
 	    ret = af_local_set_no_getpeereid ();
+	  else
+	    set_errno (EINVAL);
 	  return ret;
 
 	case SO_REUSEADDR:
-- 
2.29.2

