Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 8F2C439AF4CE
 for <cygwin-patches@cygwin.com>; Fri, 16 Jul 2021 04:50:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8F2C439AF4CE
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 16G4oMpf050428;
 Thu, 15 Jul 2021 21:50:22 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdl9cegw; Thu Jul 15 21:50:13 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: New tool: gmondump
Date: Thu, 15 Jul 2021 21:49:56 -0700
Message-Id: <20210716044957.5298-2-mark@maxrnd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210716044957.5298-1-mark@maxrnd.com>
References: <20210716044957.5298-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 16 Jul 2021 04:50:25 -0000

This new tool was formerly part of 'profiler' but was spun out thanks to
Jon T's reasonable review comment.  Gmondump is more of a debugging tool
than something users might have need for.  Users would more likely use
gprof to make use of symbolic info like function names and source line
numbers.

---
 winsup/utils/gmondump.c | 255 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)
 create mode 100644 winsup/utils/gmondump.c

diff --git a/winsup/utils/gmondump.c b/winsup/utils/gmondump.c
new file mode 100644
index 000000000..e469f01f1
--- /dev/null
+++ b/winsup/utils/gmondump.c
@@ -0,0 +1,255 @@
+/*
+    gmondump.c
+    Displays summary info about given profile data file(s).
+
+    Written by Mark Geisert <mark@maxrnd.com>.
+
+    This file is part of Cygwin.
+
+    This software is a copyrighted work licensed under the terms of the
+    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details.
+*/
+
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include "cygwin/version.h"
+
+typedef unsigned short ushort;
+typedef uint16_t u_int16_t; // Non-standard sized type needed by ancient gmon.h
+#include "gmon.h"
+
+FILE       *ofile;
+const char *pgm = "gmondump";
+int         verbose = 0;
+
+void __attribute__ ((__noreturn__))
+usage (FILE *where)
+{
+  fprintf (where, "\
+Usage: %s [OPTIONS] FILENAME...\n\
+\n\
+Display formatted contents of profile data file(s).\n\
+Such files usually have names starting with \"gmon.out\".\n\
+OPTIONS are:\n\
+\n\
+  -h, --help             Display usage information and exit\n\
+  -v, --verbose          Display more file details (toggle: default false)\n\
+  -V, --version          Display version information and exit\n\
+\n", pgm);
+
+  exit (where == stderr ? 1 : 0 );
+}
+
+void
+note (const char *fmt, ...)
+{
+  va_list args;
+  char    buf[4096];
+
+  va_start (args, fmt);
+  vsprintf (buf, fmt, args);
+  va_end (args);
+
+  fputs (buf, ofile);
+  fflush (ofile);
+}
+
+void
+warn (int geterrno, const char *fmt, ...)
+{
+  va_list args;
+  char    buf[4096];
+
+  va_start (args, fmt);
+  sprintf (buf, "%s: ", pgm);
+  vsprintf (strchr (buf, '\0'), fmt, args);
+  va_end (args);
+  if (geterrno)
+    perror (buf);
+  else
+    {
+      fputs (buf, ofile);
+      fputs ("\n", ofile);
+      fflush (ofile);
+    }
+}
+
+void __attribute__ ((noreturn))
+error (int geterrno, const char *fmt, ...)
+{
+  va_list args;
+
+  va_start (args, fmt);
+  warn (geterrno, fmt, args);
+  va_end (args);
+
+  exit (1);
+}
+
+void
+gmondump1 (char *filename)
+{
+  ushort    *bucket = NULL;
+  int        fd;
+  struct gmonhdr hdr;
+  int        hitbuckets;
+  int        hitcount;
+  int        numbuckets;
+  int        numrawarcs;
+  struct rawarc *rawarc = NULL;
+  int        res;
+  struct stat stat;
+
+  fd = open (filename, O_RDONLY | O_BINARY);
+  if (fd < 0)
+    {
+      note ("file%s %s couldn't be opened; continuing\n",
+            strchr (filename, '*') ? "s" : "", filename);
+      return;
+    }
+
+  /* Read and sanity-check what should be a gmon header. */
+  res = fstat (fd, &stat);
+  if (res < 0)
+    goto notgmon;
+  if (S_IFREG != (stat.st_mode & S_IFMT))
+    goto notgmon;
+  res = read (fd, &hdr, sizeof (hdr));
+  if (res != sizeof (hdr))
+    goto notgmon;
+  if (hdr.lpc >= hdr.hpc)
+    goto notgmon;
+  numbuckets = (hdr.ncnt - sizeof (hdr)) / sizeof (short);
+  if (numbuckets != (hdr.hpc - hdr.lpc) / 4)
+    goto notgmon;
+  numrawarcs = 0;
+  if (stat.st_size != hdr.ncnt)
+    {
+      numrawarcs = stat.st_size - hdr.ncnt;
+      if (numrawarcs !=
+          (int) sizeof (rawarc) * (numrawarcs / (int) sizeof (rawarc)))
+        goto notgmon;
+      numrawarcs /= (int) sizeof (rawarc);
+    }
+
+  /* Looks good, so read and display the profiling info. */
+  bucket = (ushort *) calloc (numbuckets, sizeof (ushort));
+  res = read (fd, bucket, hdr.ncnt - sizeof (hdr));
+  if (res != hdr.ncnt - (int) sizeof (hdr))
+    goto notgmon;
+  hitcount = hitbuckets = 0;
+  for (res = 0; res < numbuckets; ++bucket, ++res)
+    if (*bucket)
+      {
+        ++hitbuckets;
+        hitcount += *bucket;
+      }
+  bucket -= numbuckets;
+
+  note ("file %s, gmon version 0x%x, sample rate %d\n",
+        filename, hdr.version, hdr.profrate);
+  note ("  address range 0x%p..0x%p\n", hdr.lpc, hdr.hpc);
+  note ("  numbuckets %d, hitbuckets %d, hitcount %d, numrawarcs %d\n",
+        numbuckets, hitbuckets, hitcount, numrawarcs);
+
+  /* If verbose is set, display contents of buckets and rawarcs arrays. */
+  if (verbose)
+    {
+      if (hitbuckets)
+        note ("  bucket data follows...\n");
+      char *addr = (char *) hdr.lpc;
+      int   incr = (hdr.hpc - hdr.lpc) / numbuckets;
+      for (res = 0; res < numbuckets; ++bucket, ++res, addr += incr)
+        if (*bucket)
+          note ("    address 0x%p, hitcount %d\n", addr, *bucket);
+      bucket -= numbuckets;
+
+      if (numrawarcs)
+        {
+          rawarc = (struct rawarc *) calloc (numrawarcs, sizeof (rawarc));
+          res = read (fd, rawarc, numrawarcs * (int) sizeof (rawarc));
+          if (res != numrawarcs * (int) sizeof (rawarc))
+            error (0, "unable to read rawarc data");
+          note ("  rawarc data follows...\n");
+          for (res = 0; res < numrawarcs; ++rawarc, ++res)
+            note ("    from 0x%p, self 0x%p, count %d\n",
+                  rawarc->raw_frompc, rawarc->raw_selfpc, rawarc->raw_count);
+        }
+    }
+
+  note ("\n");
+  if (0)
+    {
+notgmon:
+      note ("file %s isn't a profile data file; continuing\n", filename);
+    }
+  if (rawarc)
+    free (rawarc);
+  if (bucket)
+    free (bucket);
+  close (fd);
+}
+
+struct option longopts[] = {
+  {"help",    no_argument, NULL, 'h'},
+  {"verbose", no_argument, NULL, 'v'},
+  {"version", no_argument, NULL, 'V'},
+  {NULL,      0,           NULL, 0  }
+};
+
+const char *const opts = "+hvV";
+
+void __attribute__ ((__noreturn__))
+print_version ()
+{
+  char *year_of_build = strrchr (__DATE__, ' ') + 1;
+  printf ("gmondump (cygwin) %d.%d.%d\n"
+          "Profiler data file viewer\n"
+          "Copyright (C) %s%s Cygwin Authors\n"
+          "This is free software; see the source for copying conditions.  "
+          "There is NO\nwarranty; not even for MERCHANTABILITY or FITNESS "
+          "FOR A PARTICULAR PURPOSE.\n",
+          CYGWIN_VERSION_DLL_MAJOR / 1000,
+          CYGWIN_VERSION_DLL_MAJOR % 1000,
+          CYGWIN_VERSION_DLL_MINOR,
+          strncmp (year_of_build, "2021", 4) ? "2021 - " : "",
+          year_of_build);
+  exit (0);
+}
+
+int
+main(int argc, char **argv)
+{
+  ofile = stdout;
+  int opt;
+
+  while ((opt = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
+    switch (opt)
+      {
+      case 'h':
+        /* Print help and exit. */
+        usage (ofile);
+
+      case 'v':
+        verbose ^= 1;
+        break;
+
+      case 'V':
+        /* Print version and exit. */
+        print_version ();
+
+      default:
+        ;
+      }
+
+  for (int i = optind; i < argc; i++)
+    gmondump1 (argv[i]);
+
+  return 0;
+}
-- 
2.31.1

