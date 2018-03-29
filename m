Return-Path: <cygwin-patches-return-9042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34093 invoked by alias); 29 Mar 2018 05:32:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32049 invoked by uid 89); 29 Mar 2018 05:32:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT autolearn=ham version=3.3.2 spammy=1000000, waited, 999999
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 29 Mar 2018 05:32:29 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w2T5WSPx090446;	Wed, 28 Mar 2018 22:32:28 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdHppi8F; Wed Mar 28 21:32:25 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Posix asynchronous I/O support, part 3
Date: Thu, 29 Mar 2018 05:32:00 -0000
Message-Id: <20180329053217.1100-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00050.txt.bz2

---
 winsup/cygwin/aio.cc | 580 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 580 insertions(+)
 create mode 100644 winsup/cygwin/aio.cc

diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
new file mode 100644
index 000000000..01bf2e479
--- /dev/null
+++ b/winsup/cygwin/aio.cc
@@ -0,0 +1,580 @@
+/* aio.cc: Posix asynchronous i/o functions.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#undef AIODEBUG
+
+#include "winsup.h"
+#include <aio.h>
+#include <fcntl.h>
+#include <semaphore.h>
+#include <unistd.h>
+
+#ifdef __cplusplus
+#define restrict /* meaningless in C++ */
+extern "C" {
+#endif
+
+static NO_COPY pid_t         mypid;
+static NO_COPY sem_t         worksem;   /* indicates whether AIOs are queued */
+static NO_COPY struct aiocb *worklisthd = NULL;  /* head of pending AIO list */
+static NO_COPY struct aiocb *worklisttl = NULL;  /* tail of pending AIO list */
+static NO_COPY CRITICAL_SECTION  workcrit;      /* lock for pending AIO list */
+
+#ifdef AIODEBUG
+static void
+showqueue ()
+{
+  /* critical section 'workcrit' is held on entry */
+  struct aiocb *aio = worklisthd;
+
+  small_printf ("%p", aio);
+  while (aio)
+    {
+      aio = aio->aio_next;
+      small_printf ("->%p", aio);
+    }
+  small_printf (" tl:%p\n", worklisttl);
+}
+#endif /* AIODEBUG */
+
+static struct aiocb *
+enqueue (struct aiocb *aio)
+{
+  /* critical section 'workcrit' is held on entry */
+  aio->aio_prev = worklisttl;
+  aio->aio_next = NULL;
+
+  if (!worklisthd)
+    worklisthd = aio;
+  if (worklisttl)
+    worklisttl->aio_next = aio;
+  worklisttl = aio;
+
+#ifdef AIODEBUG
+  showqueue ();
+#endif
+  return aio;
+}
+
+static struct aiocb *
+dequeue (struct aiocb *aio)
+{
+  /* critical section 'workcrit' is held on entry */
+  if (aio->aio_prev)
+    aio->aio_prev->aio_next = aio->aio_next;
+  if (aio->aio_next)
+    aio->aio_next->aio_prev = aio->aio_prev;
+
+  if (aio == worklisthd)
+    worklisthd = aio->aio_next;
+  if (aio == worklisttl)
+    worklisttl = aio->aio_prev;
+
+  aio->aio_prev = aio->aio_next = NULL;
+
+#ifdef AIODEBUG
+  showqueue ();
+#endif
+  return aio;
+}
+
+static DWORD WINAPI __attribute__ ((noreturn))
+aioworker (void *unused)
+{ /* called on its own cygthread; runs until program exits */
+  struct aiocb *aio;
+
+  while (1)
+    {
+      /* park here until there's work to do */
+      sem_wait (&worksem);
+
+look4work:
+      EnterCriticalSection (&workcrit);
+      if (!worklisthd)
+        {
+          /* another aioworker picked up the work already */
+          LeaveCriticalSection (&workcrit);
+          continue;
+        }
+
+      aio = dequeue (worklisthd);
+      LeaveCriticalSection (&workcrit);
+
+#ifdef AIODEBUG
+      small_printf ("starting aio %p\n", aio);
+#endif
+      aio->aio_errno = EBUSY; /* mark AIO as physically underway now */
+      switch (aio->aio_lio_opcode)
+        {
+          case LIO_NOP:
+            aio->aio_rbytes = 0;
+            break;
+
+          case LIO_READ:
+            aio->aio_rbytes = pread (aio->aio_fildes, (void *) aio->aio_buf,
+                                     aio->aio_nbytes, aio->aio_offset);
+            break;
+
+          case LIO_WRITE:
+            aio->aio_rbytes = pwrite (aio->aio_fildes, (void *) aio->aio_buf,
+                                      aio->aio_nbytes, aio->aio_offset);
+            break;
+
+          default:
+            errno = EINVAL;
+            aio->aio_rbytes = -1;
+            break;
+        }
+
+      /* if operation errored, save error number, else clear it */
+      if (aio->aio_rbytes == -1)
+        aio->aio_errno = get_errno ();
+      else
+        aio->aio_errno = 0;
+
+      /* if signal notification wanted, send AIO-complete signal */
+      if (aio->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
+        sigqueue (mypid,
+                  aio->aio_sigevent.sigev_signo,
+                  aio->aio_sigevent.sigev_value);
+
+      /* if this op is on LIO list and is last op, send LIO-complete signal */
+      if (aio->aio_liocb)
+        {
+          if (1 == InterlockedExchangeAdd (&aio->aio_liocb->lio_count, -1))
+            {
+              /* LIO's count has decremented to zero */
+              if (aio->aio_liocb->lio_sigevent->sigev_notify == SIGEV_SIGNAL)
+                sigqueue (mypid,
+                          aio->aio_liocb->lio_sigevent->sigev_signo,
+                          aio->aio_liocb->lio_sigevent->sigev_value);
+
+              free (aio->aio_liocb);
+              aio->aio_liocb = NULL;
+            }
+        }
+
+      goto look4work;
+    }
+}
+
+static int
+aiostart (struct aiocb *aio)
+{
+  /* 'aioinitialized' is a thread-safe status of AIO feature initialization:
+     0 means uninitialized, >0 means initializing, <0 means initialized */
+  static NO_COPY volatile int aioinitialized = 0;
+
+  /* first a cheap test to speed processing after initialization completes */
+  if (aioinitialized >= 0)
+    {
+      /* guard against multiple threads initializing at same time */
+      if (0 == InterlockedExchangeAdd (&aioinitialized, 1))
+        {
+          int       i = AIO_MAX;
+          char     *tnames = (char *) malloc (AIO_MAX * 8);
+
+          if (!tnames)
+            api_fatal ("couldn't create aioworker tname table");
+
+          InitializeCriticalSection (&workcrit);
+          sem_init (&worksem, 0, 0);
+          mypid = getpid ();
+
+          /* create AIO_MAX number of aioworker threads */
+          while (i--)
+            {
+              __small_sprintf (&tnames[i * 8], "aio%d", AIO_MAX - i);
+              if (!new cygthread (aioworker, NULL, &tnames[i * 8]))
+                api_fatal ("couldn't create an aioworker thread, %E");
+            }
+
+          /* indicate we have completed initialization */
+          InterlockedExchange (&aioinitialized, -1);
+        }
+      else
+        /* if 'aioinitialized' is greater than zero, another thread is
+           initializing for us; wait until 'aioinitialized' goes negative */
+        while (InterlockedExchangeAdd (&aioinitialized, 0) >= 0)
+          usleep (1000);
+    }
+
+  EnterCriticalSection (&workcrit);
+  enqueue (aio);
+  LeaveCriticalSection (&workcrit);
+
+#ifdef AIODEBUG
+  small_printf ("queued aio %p\n", aio);
+#endif
+
+  sem_post (&worksem);
+
+  return 0;
+}
+
+int
+aio_cancel (int fildes, struct aiocb *aio)
+{
+  int           aiocount = 0;
+  pid_t         mypid = cygwin_winpid_to_pid (GetCurrentProcessId ());
+  struct aiocb *ptr;
+
+  /* Note 'aio' is allowed to be NULL here; it's used as a wildcard */
+restart:
+  EnterCriticalSection (&workcrit);
+  ptr = worklisthd;
+
+  while (ptr)
+    {
+      if (ptr->aio_fildes == fildes && (!aio || ptr == aio))
+        {
+          /* this queued AIO qualifies for cancellation */
+          ptr = dequeue (ptr);
+          LeaveCriticalSection (&workcrit);
+
+          ptr->aio_errno = ECANCELED;
+          ptr->aio_rbytes = -1;
+
+          /* if signal notification wanted, send AIO-canceled signal */
+          if (ptr->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
+            sigqueue (mypid,
+                      ptr->aio_sigevent.sigev_signo,
+                      ptr->aio_sigevent.sigev_value);
+
+          ++aiocount;
+          goto restart;
+        }
+      ptr = ptr->aio_next;
+    }
+
+  LeaveCriticalSection (&workcrit);
+
+  /* Note AIO_NOTCANCELED is not possible in this implementation.  That's
+     because AIOs are dequeued to execute; the worklist search above won't
+     find an AIO that's been dequeued from the worklist. */
+  if (aiocount)
+    return AIO_CANCELED;
+  else
+    return AIO_ALLDONE;
+}
+
+int
+aio_error (const struct aiocb *aio)
+{
+  int err;
+
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  switch (aio->aio_errno)
+    {
+      case EBUSY: /* This state for internal use only; not visible to app */
+        err = EINPROGRESS;
+        break;
+
+      default:
+        err = aio->aio_errno;
+    }
+
+  return err;
+}
+
+#ifdef _POSIX_SYNCHRONIZED_IO
+int
+aio_fsync (int mode, struct aiocb *aio)
+{
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  switch (mode)
+    {
+#if defined(O_SYNC)
+      case O_SYNC:
+        aio->aio_rbytes = fsync (aio->aio_fildes);
+        break;
+
+#if defined(O_DSYNC) && O_DSYNC != O_SYNC
+      case O_DSYNC:
+        aio->aio_rbytes = fdatasync (aio->aio_fildes);
+        break;
+#endif
+#endif
+
+      default:
+        set_errno (EINVAL);
+        return -1;
+    }
+
+  if (aio->aio_rbytes == -1)
+    aio->aio_errno = get_errno ();
+
+  return aio->aio_rbytes;
+}
+#endif /* _POSIX_SYNCHRONIZED_IO */
+
+int
+aio_read (struct aiocb *aio)
+{
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  //XXX Try to launch async read right here; only on ESPIPE is it queued
+
+  aio->aio_lio_opcode = LIO_READ;
+  aio->aio_liocb = NULL;
+  aio->aio_errno = EINPROGRESS;
+  aio->aio_rbytes = -1;
+
+  return aiostart (aio);
+}
+
+ssize_t
+aio_return (struct aiocb *aio)
+{
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  switch (aio->aio_errno)
+    {
+      case EBUSY:       /* AIO is currently underway */
+      case EINPROGRESS: /* AIO has been queued successfully */
+      case EINVAL:      /* aio_return() has already been called on this AIO */
+        set_errno (aio->aio_errno);
+        return -1;
+
+      default:          /* AIO has completed, successfully or not */
+        ;
+    }
+
+  /* This AIO has completed so grab any error status if present */
+  if (aio->aio_rbytes == -1)
+    set_errno (aio->aio_errno);
+
+  /* Set this AIO's errno so later aio_return() calls on this AIO fail */
+  aio->aio_errno = EINVAL;
+
+  return aio->aio_rbytes;
+}
+
+static int
+suspend (const struct aiocb *const aiolist[],
+         int nent, const struct timespec *timeout)
+{
+  /* Returns lowest list index of completed aios, else 'nent' if all completed.
+     If none completed on entry, wait for interval specified by 'timeout'. */
+  int       aiocount;
+  int       i;
+  DWORD     msecs = 0;
+  int       result;
+  sigset_t  sigmask;
+  siginfo_t si;
+  DWORD     time0, time1;
+  struct timespec *to = (struct timespec *) timeout;
+
+  if (to)
+    msecs = (1000 * to->tv_sec) + ((to->tv_nsec + 999999) / 1000000);
+  sigemptyset (&sigmask);
+retry:
+  aiocount = 0;
+  for (i = 0; i < nent; ++i)
+    if (aiolist[i] && aiolist[i]->aio_liocb)
+      {
+        if (aiolist[i]->aio_errno == EINPROGRESS ||
+            aiolist[i]->aio_errno == EBUSY)
+          {
+            ++aiocount;
+            if (aiolist[i]->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
+              sigaddset (&sigmask, aiolist[i]->aio_sigevent.sigev_signo);
+          }
+        else
+          return i;
+      }
+
+  if (aiocount == 0)
+    return nent;
+
+  if (to && msecs == 0)
+    {
+      set_errno (EAGAIN);
+      return -1;
+    }
+
+  time0 = GetTickCount ();
+  result = sigtimedwait (&sigmask, &si, to);
+  if (result == -1)
+    return -1; /* return with errno set by failed sigtimedwait() */
+  time1 = GetTickCount ();
+
+  /* adjust timeout to account for time just waited */
+  msecs -= (time1 - time0);
+  if (msecs < 0)
+    msecs = 0;
+  to->tv_sec = msecs / 1000;
+  to->tv_nsec = (msecs % 1000) * 1000000;
+
+  sigemptyset (&sigmask);
+  goto retry;
+}
+
+int
+aio_suspend (const struct aiocb *const aiolist[],
+             int nent, const struct timespec *timeout)
+{
+  int result;
+
+  if (nent < 0 || nent > AIO_LISTIO_MAX)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  result = suspend (aiolist, nent, timeout);
+
+  /* if there was an error, or no AIOs completed before or during timeout */
+  if (result == -1)
+    return result; /* If no AIOs completed, errno has been set to EAGAIN */
+
+  /* else if all AIOs have completed */
+  else if (result == nent)
+    return 0;
+
+  /* else at least one of the AIOs completed */
+  else
+    return 0;
+}
+
+int
+aio_write (struct aiocb *aio)
+{
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  //XXX Try to launch async write right here; only on ESPIPE is it queued
+
+  aio->aio_lio_opcode = LIO_WRITE;
+  aio->aio_liocb = NULL;
+  aio->aio_errno = EINPROGRESS;
+  aio->aio_rbytes = -1;
+
+  return aiostart (aio);
+}
+
+int
+lio_listio (int mode, struct aiocb *restrict const aiolist[restrict],
+            int nent, struct sigevent *restrict sig)
+{
+  struct aiocb *aio;
+  int           aiocount;
+  int           i;
+  struct liocb *lio;
+
+  if ((mode != LIO_WAIT && mode != LIO_NOWAIT) || 
+      (nent < 0 || nent > AIO_LISTIO_MAX))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (sig && nent && mode == LIO_NOWAIT)
+    {
+      lio = (struct liocb *) malloc (sizeof (struct liocb));
+      if (!lio)
+        {
+          set_errno (ENOMEM);
+          return -1;
+        }
+
+      lio->lio_count = nent;
+      lio->lio_sigevent = sig;
+    }
+  else
+    lio = NULL;
+
+  aiocount = 0;
+  for (i = 0; i < nent; ++i)
+    {
+      aio = (struct aiocb *) aiolist[i];
+      if (!aio)
+        {
+          if (lio)
+            InterlockedDecrement (&lio->lio_count);
+          continue;
+        }
+
+      aio->aio_liocb = NULL;
+      switch (aio->aio_lio_opcode)
+        {
+          case LIO_NOP:
+            if (lio)
+              InterlockedDecrement (&lio->lio_count);
+            continue;
+
+          case LIO_READ:
+            /* fall thru */
+          case LIO_WRITE:
+            aio->aio_errno = EINPROGRESS;
+            aio->aio_rbytes = -1;
+            aio->aio_liocb = lio;
+
+            ++aiocount;
+            aiostart (aio);
+            continue;
+
+          default:
+            break;
+        }
+
+      if (lio)
+        InterlockedDecrement (&lio->lio_count);
+      aio->aio_errno = EINVAL;
+      aio->aio_rbytes = -1;
+    }
+
+  /* mode is LIO_NOWAIT so return some kind of answer immediately */
+  if (mode == LIO_NOWAIT)
+    {
+      /* at least one AIO has been queued */
+      if (aiocount)
+        return 0;
+
+      /* no AIOs have been queued */
+      set_errno (EAGAIN);
+      return -1;
+    }
+
+  /* else mode is LIO_WAIT so wait for all AIOs to complete or error */
+  while (nent)
+    {
+      i = suspend ((const struct aiocb *const *) aiolist, nent, NULL);
+      if (i == nent)
+        break;
+      else
+        aiolist[i]->aio_liocb = NULL; /* avoids repeating notify on this AIO */
+    }
+
+  return 0;
+}
+
+#ifdef __cplusplus
+}
+#undef restrict
+#endif
-- 
2.16.2
