Return-Path: <cygwin-patches-return-9041-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5794 invoked by alias); 29 Mar 2018 05:32:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4954 invoked by uid 89); 29 Mar 2018 05:32:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 29 Mar 2018 05:32:09 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w2T5W82i090436;	Wed, 28 Mar 2018 22:32:08 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdkC0muo; Wed Mar 28 21:32:02 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Posix asynchronous I/O support, part 2
Date: Thu, 29 Mar 2018 05:32:00 -0000
Message-Id: <20180329053153.6620-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00049.txt.bz2

---
 winsup/cygwin/include/aio.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 winsup/cygwin/include/aio.h

diff --git a/winsup/cygwin/include/aio.h b/winsup/cygwin/include/aio.h
new file mode 100644
index 000000000..d6ca56517
--- /dev/null
+++ b/winsup/cygwin/include/aio.h
@@ -0,0 +1,78 @@
+/* aio.h: Support for Posix asynchronous i/o routines.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _AIO_H
+#define _AIO_H
+
+#include <sys/features.h>
+#include <sys/signal.h>
+#include <sys/types.h>
+#include <limits.h> // for AIO_LISTIO_MAX, AIO_MAX, and AIO_PRIO_DELTA_MAX
+
+/* defines for return value of aio_cancel() */
+#define AIO_ALLDONE     0
+#define AIO_CANCELED    1
+#define AIO_NOTCANCELED 2
+
+/* defines for 'mode' argument of lio_listio() */
+#define LIO_NOWAIT      0
+#define LIO_WAIT        1
+
+/* defines for 'aio_lio_opcode' element of struct aiocb */
+#define LIO_NOP         0
+#define LIO_READ        1
+#define LIO_WRITE       2
+
+#ifdef __cplusplus
+#define restrict /* meaningless in C++ */
+extern "C" {
+#endif
+
+/* struct liocb is Cygwin-specific */
+struct liocb {
+    volatile int         lio_count;
+    struct sigevent     *lio_sigevent;
+};
+
+/* struct aiocb is defined by Posix */
+struct aiocb {
+    /* these elements of aiocb are Cygwin-specific */
+    struct aiocb        *aio_prev;
+    struct aiocb        *aio_next;
+    struct liocb        *aio_liocb;
+    ssize_t              aio_rbytes;
+    int                  aio_errno;
+    /* the remaining elements of aiocb are defined by Posix */
+    int                  aio_lio_opcode;
+    int                  aio_reqprio;
+    int                  aio_fildes;
+    volatile void       *aio_buf;
+    size_t               aio_nbytes;
+    off_t                aio_offset;
+    struct sigevent      aio_sigevent;
+};
+
+/* function prototypes as defined by Posix */
+int     aio_cancel  (int, struct aiocb *);
+int     aio_error   (const struct aiocb *);
+#ifdef _POSIX_SYNCHRONIZED_IO
+int     aio_fsync   (int, struct aiocb *);
+#endif
+int     aio_read    (struct aiocb *);
+ssize_t aio_return  (struct aiocb *);
+int     aio_suspend (const struct aiocb *const [], int,
+                        const struct timespec *);
+int     aio_write   (struct aiocb *);
+int     lio_listio  (int, struct aiocb *restrict const [restrict], int,
+                        struct sigevent *restrict);
+
+#ifdef __cplusplus
+}
+#undef restrict
+#endif
+#endif /* _AIO_H */
-- 
2.16.2
