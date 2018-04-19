Return-Path: <cygwin-patches-return-9052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104067 invoked by alias); 19 Apr 2018 08:04:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103807 invoked by uid 89); 19 Apr 2018 08:04:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=retry, retired, arrival, About
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 08:04:44 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w3J84bub056872;	Thu, 19 Apr 2018 01:04:37 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdm1DWWI; Thu Apr 19 01:04:34 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2 1/3] Posix asynchronous I/O support: aio files
Date: Thu, 19 Apr 2018 08:04:00 -0000
Message-Id: <20180419080402.10932-2-mark@maxrnd.com>
In-Reply-To: <20180419080402.10932-1-mark@maxrnd.com>
References: <20180419080402.10932-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00009.txt.bz2

This is the core of the AIO implementation: aio.cc and aio.h.  The
latter is used within Cygwin by aio.cc and the fhandler* modules, as
well as by user programs wanting the AIO functionality.

This is the 2nd WIP patch set for AIO.  The string XXX marks issues
I'm specifically requesting comments on, but feel free to comment or
suggest changes on any of this code.
---
 winsup/cygwin/aio.cc        | 802 ++++++++++++++++++++++++++++++++++++++++++++
 winsup/cygwin/include/aio.h |  83 +++++
 2 files changed, 885 insertions(+)
 create mode 100644 winsup/cygwin/aio.cc
 create mode 100644 winsup/cygwin/include/aio.h

diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
new file mode 100644
index 000000000..2749104fa
--- /dev/null
+++ b/winsup/cygwin/aio.cc
@@ -0,0 +1,802 @@
+/* aio.cc: Posix asynchronous i/o functions.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+#include <aio.h>
+#include <fcntl.h>
+#include <semaphore.h>
+#include <unistd.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* 'aioinitialized' is a thread-safe status of AIO feature initialization:
+ * 0 means uninitialized, >0 means initializing, <0 means initialized
+ */
+static NO_COPY volatile int  aioinitialized = 0;
+static NO_COPY pid_t         mypid;
+
+/* This implementation supports two flavors of asynchronous operation:
+ * "inline" and "queued".  Inline AIOs are used when:
+ *     (1) fd refers to a local disk file opened in binary mode,
+ *     (2) no more than AIO_MAX inline AIOs will be in progress at same time.
+ * In all other cases queued AIOs will be used.
+ *
+ * An inline AIO is performed by the calling thread as a pread|pwrite on a
+ * shadow fd that permits Windows asynchronous i/o, with event notification
+ * on completion.  Event arrival causes AIO context for the fd to be updated.
+ *
+ * A queued AIO is performed by an AIO worker thread using pread|pwrite on a 
+ * shadow fd that permits Windows async i/o, with event notification on
+ * completion.  Event arrival causes AIO context for the fd to be updated.
+ */
+
+/* These variables support inline AIO operations */
+static NO_COPY HANDLE            evt_handles[AIO_MAX];
+static NO_COPY struct aiocb     *evt_aiocbs[AIO_MAX];
+static NO_COPY CRITICAL_SECTION  slotcrit;
+
+/* These variables support queued AIO operations */
+static NO_COPY sem_t         worksem;   /* indicates whether AIOs are queued */
+static NO_COPY struct aiocb *worklisthd = NULL;  /* head of pending AIO list */
+static NO_COPY struct aiocb *worklisttl = NULL;  /* tail of pending AIO list */
+static NO_COPY CRITICAL_SECTION  workcrit;      /* lock for pending AIO list */
+//XXX Investigate TAILQ* macros in <sys/queue.h> for worklist mgmt
+
+//XXX Generally I don't like forward ref declarations. Need to reorder funcs.
+static int aioqueue (struct aiocb *);
+static int asyncread (struct aiocb *);
+static int asyncwrite (struct aiocb *);
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
+  return aio;
+}
+
+static int
+aiogetslot (struct aiocb *aio)
+{
+  int slot;
+
+  /* Get free slot for this inline AIO; if none available AIO will be queued */
+  EnterCriticalSection (&slotcrit);
+  for (slot = 0; slot < AIO_MAX; ++slot)
+    if (evt_aiocbs[slot] == NULL)
+      {
+        evt_aiocbs[slot] = aio;
+        LeaveCriticalSection (&slotcrit);
+        return slot;
+      }
+
+  LeaveCriticalSection (&slotcrit);
+  return -1;
+}
+
+static void
+aionotify (struct aiocb *aio)
+{
+  /* if signal notification wanted, send AIO-complete signal */
+  //XXX Is sigqueue() the best way to send signo+value within same process?
+  if (aio->aio_sigevent.sigev_notify == SIGEV_SIGNAL)
+    sigqueue (mypid,
+              aio->aio_sigevent.sigev_signo,
+              aio->aio_sigevent.sigev_value);
+
+  /* if this op is on LIO list and is last op, send LIO-complete signal */
+  if (aio->aio_liocb)
+    {
+      if (1 == InterlockedExchangeAdd (&aio->aio_liocb->lio_count, -1))
+        {
+          /* LIO's count has decremented to zero */
+          if (aio->aio_liocb->lio_sigevent->sigev_notify == SIGEV_SIGNAL)
+            sigqueue (mypid,
+                      aio->aio_liocb->lio_sigevent->sigev_signo,
+                      aio->aio_liocb->lio_sigevent->sigev_value);
+
+          free (aio->aio_liocb);
+          aio->aio_liocb = NULL;
+        }
+    }
+}
+
+static DWORD WINAPI __attribute__ ((noreturn))
+aiowaiter (void *unused)
+{ /* called on its own cygthread; runs until program exits */
+  struct aiocb *aio;
+  DWORD         res;
+  int           slot;
+  NTSTATUS      status;
+
+  while (1)
+    {
+      /* wait forever for at least one event to be set */
+      res = WaitForMultipleObjects(AIO_MAX, evt_handles, FALSE, INFINITE);
+      switch (res)
+        {
+          case WAIT_FAILED:
+            api_fatal ("aiowaiter fatal error, %E");
+
+          default:
+            if (res < WAIT_OBJECT_0 || res >= WAIT_OBJECT_0 + AIO_MAX)
+              api_fatal ("aiowaiter unexpected WFMO result %d", res);
+            slot = res - WAIT_OBJECT_0;
+
+            /* Free up the slot used for this inline AIO */
+            EnterCriticalSection (&slotcrit);
+            aio = evt_aiocbs[slot];
+            evt_aiocbs[slot] = NULL;
+            LeaveCriticalSection (&slotcrit);
+            debug_printf ("retired aio %p", aio);
+
+            /* Capture Windows status and convert to Cygwin status */
+            status = aio->aio_win_iosb.Status;
+            if (NT_SUCCESS (status))
+              {
+                aio->aio_rbytes = aio->aio_win_iosb.Information;
+                aio->aio_errno = 0;
+              }
+            else
+              {
+                aio->aio_rbytes = -1;
+                aio->aio_errno = geterrno_from_nt_status (status);
+              }
+
+            /* send completion signal if user requested it */
+            aionotify (aio);
+        }
+    }
+}
+
+static DWORD WINAPI __attribute__ ((noreturn))
+aioworker (void *unused)
+{ /* multiple instances; called on own cygthreads; runs 'til program exits */
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
+      //XXX Historical commentary to be removed before final ship of this code:
+      //XXX
+      //XXX About to use read|write.  Should we require aio_offset to be zero?
+      //XXX Or ignore aio_offset?  Or manually seek/op/reseek on seekable fds?
+      //XXX [time passes for testing]
+      //XXX Crap! Must seek/op/reseek or all the writes append to the file!
+      //XXX Or turn these back into pread|pwrite as originally here. If those
+      //XXX fail here, then do seek/op/reseek. That should work out OK.
+      //XXX Could they be made inline AIOs here, just initiated from threads?
+      debug_printf ("starting aio %p", aio);
+      aio->aio_errno = EBUSY; /* mark AIO as physically underway now */
+      switch (aio->aio_lio_opcode)
+        {
+          case LIO_NOP:
+            aio->aio_rbytes = 0;
+            break;
+
+          case LIO_READ:
+            aio->aio_rbytes = asyncread (aio);
+            break;
+
+          case LIO_WRITE:
+            aio->aio_rbytes = asyncwrite (aio);
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
+      /* if we had no slot for inline async AIO, re-queue it */
+      if (aio->aio_errno == ENOBUFS)
+        {
+          usleep (1000); //XXX No, leads to unrest. Wait on an event or sem */
+          aio->aio_errno = EINPROGRESS;
+          aioqueue (aio); // re-queue this AIO
+          goto look4work;
+        }
+
+      /* if we're not permitted to seek on given fd, do the op manually */
+      if (aio->aio_errno == ESPIPE)
+        {
+	  //XXX Wait a minute. ESPIPE can mean "pread|pwrite not yet
+	  //XXX implemented for this device type" or it can mean "can't seek
+	  //XXX on this device type".  Those require different actions here.
+	  //
+	  //XXX For the is-seekable case:
+	  //XXX if aio_offset != 0, save current file position
+	  //XXX if aio_offset != 0, set new file position
+	  //XXX do op
+	  //XXX if aio_offset != 0, set saved file position
+	  //XXX Not quite; what if aio_offset zero is actually intended by app?
+	  //
+	  //XXX For the non-seekable case:
+	  //XXX do op as if aio_offset doesn't matter?
+        }
+
+      /* send completion signal if user requested it */
+      aionotify (aio);
+      debug_printf ("completed aio %p", aio);
+      goto look4work;
+    }
+}
+
+static void
+aioinit (void)
+{
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
+          InitializeCriticalSection (&slotcrit);
+          InitializeCriticalSection (&workcrit);
+          sem_init (&worksem, 0, 0);
+          mypid = getpid (); 
+          /* create AIO_MAX number of aioworker threads for queued AIOs */
+          //XXX Another option is #threads == 1 + #cores
+          while (i--)
+            {
+              __small_sprintf (&tnames[i * 8], "aio%d", AIO_MAX - i);
+              if (!new cygthread (aioworker, NULL, &tnames[i * 8]))
+                api_fatal ("couldn't create an aioworker thread, %E");
+            }
+
+          /* initialize event handles array for inline AIOs */
+          for (i = 0; i < AIO_MAX; ++i)
+            {
+              /* events are non-inheritable, auto-reset, init unset, unnamed */
+              evt_handles[i] = CreateEvent (NULL, FALSE, FALSE, NULL);
+              if (!evt_handles[i])
+                api_fatal ("couldn't create an event, %E");
+            }
+
+          /* create aiowaiter thread; waits for inline AIO completion events */
+          if (!new cygthread (aiowaiter, NULL, "aio"))
+            api_fatal ("couldn't create aiowaiter thread, %E");
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
+}
+
+static int
+aioqueue (struct aiocb *aio)
+{ /* add an AIO to the worklist, to be serviced by a worker thread */
+  if (aioinitialized >= 0)
+    aioinit ();
+
+  EnterCriticalSection (&workcrit);
+  enqueue (aio);
+  LeaveCriticalSection (&workcrit);
+
+  debug_printf ("queued aio %p", aio);
+  sem_post (&worksem);
+
+  return 0;
+}
+
+int
+aio_cancel (int fildes, struct aiocb *aio)
+{
+  int           aiocount = 0;
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
+      case ENOBUFS: /* This state for internal use only; not visible to app */
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
+static int
+asyncread (struct aiocb *aio)
+{ /* Try to initiate an inline async read, whether from app or worker thread */
+  ssize_t       res = 0;
+  int           slot = 0;
+
+  cygheap_fdget cfd (aio->aio_fildes);
+  if (cfd < 0)
+    res = -1; /* errno has been set to EBADF */
+  else
+    {
+      slot = aiogetslot (aio);
+      if (slot >= 0)
+        {
+          aio->aio_errno = EBUSY; /* mark AIO as physically underway now */
+          aio->aio_win_event = evt_handles[slot];
+          res = cfd->pread ((void *) aio->aio_buf, aio->aio_nbytes,
+                            aio->aio_offset, (void *) aio);
+          //XXX Can we have a variant pread method that takes 1 arg: *aio?
+        }
+      else
+        {
+          set_errno (ENOBUFS);
+          res = -1;
+        }
+    }
+
+  return res;
+}
+
+int
+aio_read (struct aiocb *aio)
+{
+  ssize_t       res = 0;
+
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  if (aioinitialized >= 0)
+    aioinit ();
+
+  /* Try to launch inline async read; only on ESPIPE is it queued */
+  pthread_testcancel ();
+  res = asyncread (aio);
+
+  /* If async read couldn't be launched, queue the AIO for a worker thread */
+  if (res == -1 && (get_errno () == ESPIPE || get_errno () == ENOBUFS))
+    {
+      aio->aio_lio_opcode = LIO_READ;
+      aio->aio_liocb = NULL;
+      aio->aio_errno = EINPROGRESS;
+      aio->aio_rbytes = -1;
+
+      res = aioqueue (aio);
+    }
+
+  return res;
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
+      case EBUSY:       /* AIO is currently underway (internal state) */
+      case ENOBUFS:     /* AIO is currently underway (internal state) */
+      case EINPROGRESS: /* AIO has been queued successfully */
+        set_errno (EINPROGRESS);
+        return -1;
+
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
+aiosuspend (const struct aiocb *const aiolist[],
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
+
+retry:
+  sigemptyset (&sigmask);
+  aiocount = 0;
+  for (i = 0; i < nent; ++i)
+    if (aiolist[i] && aiolist[i]->aio_liocb)
+      {
+        if (aiolist[i]->aio_errno == EINPROGRESS ||
+            aiolist[i]->aio_errno == ENOBUFS ||
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
+  goto retry;
+}
+
+int
+aio_suspend (const struct aiocb *const aiolist[],
+             int nent, const struct timespec *timeout)
+{
+  int result;
+
+  if (nent < 0 /*XXX maybe delete this: || nent > AIO_LISTIO_MAX*/)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  pthread_testcancel ();
+  result = aiosuspend (aiolist, nent, timeout);
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
+static int
+asyncwrite (struct aiocb *aio)
+{ /* Try to initiate an inline async write, whether from app or worker thread */
+  ssize_t       res = 0;
+  int           slot = 0;
+
+  cygheap_fdget cfd (aio->aio_fildes);
+  if (cfd < 0)
+    res = -1; /* errno has been set to EBADF */
+  else
+    {
+      slot = aiogetslot (aio);
+      if (slot >= 0)
+        {
+          aio->aio_errno = EBUSY; /* mark AIO as physically underway now */
+          aio->aio_win_event = evt_handles[slot];
+          res = cfd->pwrite ((void *) aio->aio_buf, aio->aio_nbytes,
+                             aio->aio_offset, (void *) aio);
+          //XXX Can we have a variant pwrite method that takes 1 arg: *aio?
+        }
+      else
+        {
+          set_errno (ENOBUFS);
+          res = -1;
+        }
+    }
+
+  return res;
+}
+
+int
+aio_write (struct aiocb *aio)
+{
+  ssize_t       res = 0;
+
+  if (!aio)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  if (aioinitialized >= 0)
+    aioinit ();
+
+  /* Try to launch inline async write; only on ESPIPE is it queued */
+  pthread_testcancel ();
+  res = asyncwrite (aio);
+
+  /* If async write couldn't be launched, queue the AIO for a worker thread */
+  if (res == -1 && (get_errno () == ESPIPE || get_errno () == ENOBUFS))
+    {
+      aio->aio_lio_opcode = LIO_WRITE;
+      aio->aio_liocb = NULL;
+      aio->aio_errno = EINPROGRESS;
+      aio->aio_rbytes = -1;
+
+      res = aioqueue (aio);
+    }
+
+  return res;
+}
+
+int
+lio_listio (int mode, struct aiocb *__restrict const aiolist[__restrict],
+            int nent, struct sigevent *__restrict sig)
+{
+  struct aiocb *aio;
+  int           aiocount;
+  int           i;
+  struct liocb *lio;
+
+  pthread_testcancel ();
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
+            aio_read (aio);
+            ++aiocount;
+            continue;
+
+          case LIO_WRITE:
+            aio_write (aio);
+            ++aiocount;
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
+      /* at least one AIO has been launched or queued */
+      if (aiocount)
+        return 0;
+
+      /* no AIOs have been launched or queued */
+      set_errno (EAGAIN);
+      return -1;
+    }
+
+  /* else mode is LIO_WAIT so wait for all AIOs to complete or error */
+  while (nent)
+    {
+      i = aiosuspend ((const struct aiocb *const *) aiolist, nent, NULL);
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
+#endif
diff --git a/winsup/cygwin/include/aio.h b/winsup/cygwin/include/aio.h
new file mode 100644
index 000000000..f9d856822
--- /dev/null
+++ b/winsup/cygwin/include/aio.h
@@ -0,0 +1,83 @@
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
+//XXX Need a way to tell if compiling apart from cygwin1.dll. Kluge alert:
+#ifndef NT_SUCCESS
+#include <w32api/winternl.h> // for HANDLE and IO_STATUS_BLOCK in user space
+#endif
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
+    HANDLE               aio_win_event;
+    IO_STATUS_BLOCK      aio_win_iosb;
+    ssize_t              aio_rbytes;
+    int                  aio_errno;
+    /* the remaining elements of aiocb are defined by Posix */
+    int                  aio_lio_opcode;
+    int                  aio_reqprio; //XXX How/Whether to implement this
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
+int     lio_listio  (int, struct aiocb *__restrict const [__restrict], int,
+                        struct sigevent *__restrict);
+
+#ifdef __cplusplus
+}
+#endif
+#endif /* _AIO_H */
-- 
2.16.2
