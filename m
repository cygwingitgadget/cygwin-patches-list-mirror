Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 9B5E0385AE44
 for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2022 04:47:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9B5E0385AE44
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 2594lnNQ011458;
 Wed, 8 Jun 2022 21:47:49 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd5sewcd; Wed Jun  8 21:47:42 2022
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Have gmondump support ssp-generated gmon.out
Date: Wed,  8 Jun 2022 21:47:31 -0700
Message-Id: <20220609044731.30872-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 09 Jun 2022 04:47:55 -0000

Cygwin tool ssp generates gmon.out files with different address
resolution than other tools do. Two address bytes per bucket rather than
the usual four address bytes. Gprof can deal with the difference but
gmondump can't because the latter's gmon.out header validation fails.

- Remove the offending portion of the header validation code.
- Make sure all code can handle differing address resolutions.
- Display address resolution in verbose data dumps.
- Change "rawarc" to "struct rawarc" in certain sizeof expressions to
  avoid buffer overrun faults.
- When "-v" (verbose) is specified, note when there is missing bucket
  data or rawarc data.

---
 winsup/utils/gmondump.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/winsup/utils/gmondump.c b/winsup/utils/gmondump.c
index 2d29e826d..16b99594a 100644
--- a/winsup/utils/gmondump.c
+++ b/winsup/utils/gmondump.c
@@ -103,6 +103,7 @@ error (int geterrno, const char *fmt, ...)
 void
 gmondump1 (char *filename)
 {
+  int        addrincr;
   ushort    *bucket = NULL;
   int        fd;
   struct gmonhdr hdr;
@@ -134,16 +135,15 @@ gmondump1 (char *filename)
   if (hdr.lpc >= hdr.hpc)
     goto notgmon;
   numbuckets = (hdr.ncnt - sizeof (hdr)) / sizeof (short);
-  if (numbuckets != (hdr.hpc - hdr.lpc) / 4)
-    goto notgmon;
+  addrincr = (hdr.hpc - hdr.lpc) / numbuckets;
   numrawarcs = 0;
   if (stat.st_size != hdr.ncnt)
     {
       numrawarcs = stat.st_size - hdr.ncnt;
-      if (numrawarcs !=
-          (int) sizeof (rawarc) * (numrawarcs / (int) sizeof (rawarc)))
+      if (numrawarcs != (int) sizeof (struct rawarc) *
+                        (numrawarcs / (int) sizeof (struct rawarc)))
         goto notgmon;
-      numrawarcs /= (int) sizeof (rawarc);
+      numrawarcs /= (int) sizeof (struct rawarc);
     }
 
   /* Looks good, so read and display the profiling info. */
@@ -162,7 +162,8 @@ gmondump1 (char *filename)
 
   note ("file %s, gmon version 0x%x, sample rate %d\n",
         filename, hdr.version, hdr.profrate);
-  note ("  address range %p..%p\n", hdr.lpc, hdr.hpc);
+  note ("  address range %p..%p, address increment %d/bucket\n",
+        hdr.lpc, hdr.hpc, addrincr);
   note ("  numbuckets %d, hitbuckets %d, hitcount %d, numrawarcs %d\n",
         numbuckets, hitbuckets, hitcount, numrawarcs);
 
@@ -171,27 +172,31 @@ gmondump1 (char *filename)
     {
       if (hitbuckets)
         note ("  bucket data follows...\n");
+      else
+        note ("  no bucket data present\n");
       char *addr = (char *) hdr.lpc;
-      int   incr = (hdr.hpc - hdr.lpc) / numbuckets;
-      for (res = 0; res < numbuckets; ++bucket, ++res, addr += incr)
+      for (res = 0; res < numbuckets; ++bucket, ++res, addr += addrincr)
         if (*bucket)
           note ("    address %p, hitcount %d\n", addr, *bucket);
       bucket -= numbuckets;
 
       if (numrawarcs)
         {
-          rawarc = (struct rawarc *) calloc (numrawarcs, sizeof (rawarc));
-          res = read (fd, rawarc, numrawarcs * (int) sizeof (rawarc));
-          if (res != numrawarcs * (int) sizeof (rawarc))
+          rawarc = (struct rawarc *) calloc (numrawarcs,
+                                             sizeof (struct rawarc));
+          res = read (fd, rawarc, numrawarcs * (int) sizeof (struct rawarc));
+          if (res != numrawarcs * (int) sizeof (struct rawarc))
             error (0, "unable to read rawarc data");
           note ("  rawarc data follows...\n");
           for (res = 0; res < numrawarcs; ++rawarc, ++res)
             note ("    from %p, self %p, count %d\n",
                   rawarc->raw_frompc, rawarc->raw_selfpc, rawarc->raw_count);
+          rawarc -= numrawarcs;
         }
+      else
+        note ("  no rawarc data present\n");
     }
 
-  note ("\n");
   if (0)
     {
 notgmon:
@@ -261,7 +266,11 @@ main(int argc, char **argv)
     usage1 (ofile);
 
   for (int i = optind; i < argc; i++)
-    gmondump1 (argv[i]);
+    {
+      gmondump1 (argv[i]);
+      if ((i + 1) < argc)
+        note ("\n");
+    }
 
   return 0;
 }
-- 
2.36.1

