Return-Path: <SRS0=V3+P=FP=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id E97834BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2026 17:16:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E97834BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E97834BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784654182; cv=none;
	b=wVjqgyRd0cWsBCbYPzka6dllEJJmGPcXpJk/JPJ3A0DIe50HuvQd87eYgm1FdvdvcRfxk5GtbnfxFoGZI2zv9UxAnH+Wzl7cvofTNiUX/+M+dD1VIHV2XAdw0tte7dbLejJzSFWzxuVBV0B0xihcXWtq25HpFTWM6118c+MuxWU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784654182; c=relaxed/simple;
	bh=+yv7JUTta9ZY+b8ONXIzsjWQi6wJbM1BAoGg8L4PSIc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MpDP6IjJsWKBQzuWLPgmMnroLFCGYiYg0dLmuxTetjH9EOyBtIZb6FmI1neailwH5o66Acqs0zgoHqrCMTS5+hcg0tspz2AjdLfuLvf1oVGZlvWivden74S/idJyCeqHrH1niOUiR3CQhp4c9pme/jpIhqr2eEHkIPnWSoXwVXk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XOYiwiOt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E97834BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XOYiwiOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784654173; x=1785258973;
	i=johannes.schindelin@gmx.de;
	bh=ehw7kvcnwiZM5p+HetlC6B1qVNZ7lGUJ+2+WB2nIk+E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XOYiwiOtKdliPeDfRpPWVDLIQmsGGjujUK90L42Xk2RALNuP9w/wvYA/lqZSPhGY
	 yZvyN4+5d4slquohBMXEAEVRwnSJWE8ghgRQSzrtTQjQX8PFhvLWIL6nEGfJaLqls
	 Usy041HQysNGJnN+ZtS2rPji9YVdxQOVukksJQhVqS5KIrQKzRwPv7CF73HRo/N1G
	 EXon+aqLPWwGIietCaIEkAVG6zcSpqrDWbDj+Y0FWc02WzY1Ok9x2c2AEkCQFvOXX
	 nIzsWbHpYHazT5FEfbFAq4udCKyXuVU02hSHqxhB3YGpt5QNRLJrwwBH2Vq9ZfgBH
	 JvpOAUF2yi4CvMWOLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1xJ4uz2GHw-00aTkF; Tue, 21
 Jul 2026 19:16:13 +0200
Date: Tue, 21 Jul 2026 19:16:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, kikairoya <kikairoya@gmail.com>
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
In-Reply-To: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
Message-ID: <bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Jx3rfMmiXgAPNpwWD/i7DimtsBuTYnvwZCoJhIyT7aFr9/gdrZE
 aEdPjWKSiFbW0HKw7m+M4K1+Kqpj7w4cFUPf5zMWHRGuAl0K6BMtnP5Z0+FfhhsUkzTigNE
 qnMX/C4qUGvG5gcH+uvxuW80ZgzBjXaoVuuhZ5KxuhSLnLCDSCt+Y3KvBJoelz/RT6McooU
 zfp6bY6bOMh94Rq+HM4LQ==
UI-OutboundReport: notjunk:1;M01:P0:Ed2CKBdg7lM=;MPRnwIQBosCjoLpjTbHB9FGzdiK
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

sorry for getting to reply only after you pushed this to `master`. I
wanted to take the time to double-check a couple of things, and other
responsibilities got into the way.

On Fri, 17 Jul 2026, Takashi Yano wrote:

> [...]
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 2bea79768..e3ba8c65c 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1451,6 +1451,7 @@ extern "C" int
>  open (const char *unix_path, int flags, ...)
>  {
>    int res =3D -1;
> +  int fd =3D -1;
>    va_list ap;
>    mode_t mode =3D 0;
>    fhandler_base *fh =3D NULL;
> @@ -1550,9 +1551,12 @@ open (const char *unix_path, int flags, ...)
>        /* Reserve an fdtable entry here, before calling open_with_arch()=
 below.
>           Otherwise there's a tiny chance of hitting OPEN_MAX further on=
 which
>           could create a new file without any way for Cygwin to refer to=
 it. */
> -      cygheap_fdnew fd;
> +      cygheap->fdtab.lock();
> +      fd =3D cygheap->fdtab.find_unused_handle ();
>        if (fd < 0)
> -        __leave;		/* errno already set */
> +	__leave;		/* errno already set */
> +      cygheap->fdtab[fd] =3D fh; /* tentative setting to mark as used *=
/
> +      cygheap->fdtab.unlock();
> =20
>        if (fh->dev () =3D=3D FH_PROCESSFD && fh->pc.follow_fd_symlink ()=
)
>  	{

I see three problems here:

When `fd` is negative, the `unlock()` right below is skipped, and
`__endtry` only unlocks for non-negative ones. So an `open()` that ran out
of descriptors returns with the fdtab still locked, and the next fdtab
operation on any other thread waits for good. `cygheap_fdnew` used to
release the lock in that case; this one does not. I reproduced [*1*] it
three times out of three on a local build. It stays invisible while
single-threaded, because the muto is reentrant -- which is also why the
OPEN_MAX test still passes.

The tentative assignment puts `fh` into the table with a zero reference
count, then drops the lock across `open_with_arch()`, which for a FIFO
waits for the other end. Any lookup in that window -- an `fcntl()`, a
`close()`, a `close_range()` -- raises the count from zero to one and
lowers it straight back, freeing `fh` while `open()` is still using it and
leaving the slot pointing at nothing valid. I reproduced [*2*] it by
querying the descriptor from a second thread while the open was waiting:
the process ended with an access violation (status 0xC0000005), and the
same run without the query was clean.

The `FH_PROCESSFD` branch shows the same thing with no threads at all: it
deletes `fh` and repoints the local variable at the reopened handler, but
the table still refers to the deleted one until the re-assignment further
down.

> @@ -1580,13 +1584,23 @@ open (const char *unix_path, int flags, ...)
>  	try_to_bin (fh->pc, fh->get_handle (), DELETE,
>  		    FILE_OPEN_FOR_BACKUP_INTENT);
> =20
> -      fd =3D fh;
> +      cygheap->fdtab.lock ();
> +      cygheap->fdtab[fd] =3D fh;
> +      fh->inc_refcnt ();
> +      cygheap->fdtab.unlock ();
> +
>        if (fd <=3D 2)
>  	set_std_handle (fd);
>        res =3D fd;
>      }
>    __except (EFAULT) {}
>    __endtry
> +    if (res < 0 && fd >=3D 0)
> +      {
> +	cygheap->fdtab.lock ();
> +	cygheap->fdtab[fd] =3D NULL; /* Mark as unused */
> +	cygheap->fdtab.unlock ();
> +      }
>    if (res < 0 && fh)
>      delete fh;
>    syscall_printf ("%R =3D open(%s, %y)", res, unix_path, flags);

This is the first point where the slot and its reference count agree
again; Too late for anything that looked in between. And the cleanup only
runs for non-negative descriptors, so it never covers the case above.

Since it is already in `master`, a follow-up patch probably makes most
sense. Two things to fix: release the lock when no descriptor is
available, and stop a reserved-but-not-yet-open descriptor from looking
like a fully open one to the rest of the fdtable. Reviving the old integer
marker would mean teaching every consumer of the table about it, so it is
not a drop-in.

Ciao,
Johannes

Footnotes:

[*1*] I let GPT 5.6 write the code to reproduce this (it's a bit verbose,
as AI-generated code tends to be, but looked correct to me, hopefully you
find it useful; Originally I wanted to condense this into a better form,
but I realized that I simply lack the time to do so):

=2D- snip --
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <pthread.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

static pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t condition =3D PTHREAD_COND_INITIALIZER;
static int requested_stage;
static int completed_stage;
static int stage_result[3];
static int stage_errno[3];

static void
set_deadline (struct timespec *deadline, int seconds)
{
  clock_gettime (CLOCK_REALTIME, deadline);
  deadline->tv_sec +=3D seconds;
}

static int
wait_for_stage (int stage, int seconds)
{
  struct timespec deadline;
  int result =3D 0;

  set_deadline (&deadline, seconds);
  pthread_mutex_lock (&mutex);
  while (completed_stage < stage)
    {
      int err =3D pthread_cond_timedwait (&condition, &mutex, &deadline);
      if (err =3D=3D ETIMEDOUT)
        {
          result =3D ETIMEDOUT;
          break;
        }
      if (err)
        {
          result =3D err;
          break;
        }
    }
  pthread_mutex_unlock (&mutex);
  return result;
}

static void
request_stage (int stage)
{
  pthread_mutex_lock (&mutex);
  requested_stage =3D stage;
  pthread_cond_broadcast (&condition);
  pthread_mutex_unlock (&mutex);
}

static void *
descriptor_thread (void *unused)
{
  (void) unused;

  for (int stage =3D 1; stage <=3D 2; stage++)
    {
      pthread_mutex_lock (&mutex);
      while (requested_stage < stage)
        pthread_cond_wait (&condition, &mutex);
      pthread_mutex_unlock (&mutex);

      errno =3D 0;
      int result =3D close (-1);
      int saved_errno =3D errno;

      pthread_mutex_lock (&mutex);
      stage_result[stage] =3D result;
      stage_errno[stage] =3D saved_errno;
      completed_stage =3D stage;
      pthread_cond_broadcast (&condition);
      pthread_mutex_unlock (&mutex);
    }
  return NULL;
}

int
main (void)
{
  pthread_t thread;
  int opened =3D 0;
  int failure_errno =3D 0;

  setvbuf (stdout, NULL, _IONBF, 0);

  if (pthread_create (&thread, NULL, descriptor_thread, NULL))
    {
      perror ("pthread_create");
      return 1;
    }

  request_stage (1);
  if (wait_for_stage (1, 3))
    {
      printf ("baseline descriptor operation did not complete\n");
      return 1;
    }
  printf ("baseline close(-1): result=3D%d errno=3D%d\n",
          stage_result[1], stage_errno[1]);
  if (stage_result[1] !=3D -1 || stage_errno[1] !=3D EBADF)
    return 1;

  for (; opened < OPEN_MAX + 16; opened++)
    {
      errno =3D 0;
      if (open ("/dev/null", O_RDONLY) < 0)
        {
          failure_errno =3D errno;
          break;
        }
    }

  printf ("descriptor allocation stopped after %d opens: errno=3D%d\n",
          opened, failure_errno);
  if (failure_errno !=3D EMFILE)
    return 1;

  request_stage (2);
  if (wait_for_stage (2, 3) =3D=3D ETIMEDOUT)
    {
      printf ("second-thread descriptor operation remained waiting\n");
      return 0;
    }

  printf ("second-thread close(-1): result=3D%d errno=3D%d\n",
          stage_result[2], stage_errno[2]);
  return 2;
}
=2D- snap --

[*2*] Also here, I let GPT 5.6 write the code for reproducing the issue:

=2D- snip --
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>

static const char *fifo_name =3D "fifo-fd-lookup-check.pipe";
static pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t condition =3D PTHREAD_COND_INITIALIZER;
static int start_writer;
static int writer_done;
static int writer_fd =3D -1;
static int writer_errno;

static int
before_deadline (const struct timespec *deadline)
{
  struct timespec now;

  clock_gettime (CLOCK_MONOTONIC, &now);
  return now.tv_sec < deadline->tv_sec
         || (now.tv_sec =3D=3D deadline->tv_sec
             && now.tv_nsec < deadline->tv_nsec);
}

static void *
open_writer (void *unused)
{
  (void) unused;

  pthread_mutex_lock (&mutex);
  while (!start_writer)
    pthread_cond_wait (&condition, &mutex);
  pthread_mutex_unlock (&mutex);

  errno =3D 0;
  int fd =3D open (fifo_name, O_WRONLY);
  int saved_errno =3D errno;

  pthread_mutex_lock (&mutex);
  writer_fd =3D fd;
  writer_errno =3D saved_errno;
  writer_done =3D 1;
  pthread_cond_broadcast (&condition);
  pthread_mutex_unlock (&mutex);
  return NULL;
}

int
main (void)
{
  pthread_t writer;
  struct timespec poll_deadline;
  struct timespec pause =3D { 0, 1000000 };
  struct timespec wait_deadline;
  int anchor;
  int expected_fd;
  int query_result =3D -1;
  int reader_fd;

  setvbuf (stdout, NULL, _IONBF, 0);
  unlink (fifo_name);
  if (mkfifo (fifo_name, 0600))
    {
      perror ("mkfifo");
      return 1;
    }

  anchor =3D open ("/dev/null", O_RDONLY);
  if (anchor < 0)
    {
      perror ("open /dev/null");
      return 1;
    }
  if (pthread_create (&writer, NULL, open_writer, NULL))
    {
      perror ("pthread_create");
      return 1;
    }

  expected_fd =3D dup (anchor);
  if (expected_fd < 0)
    {
      perror ("dup");
      return 1;
    }
  close (expected_fd);
  printf ("expected FIFO writer descriptor: %d\n", expected_fd);

  pthread_mutex_lock (&mutex);
  start_writer =3D 1;
  pthread_cond_broadcast (&condition);
  pthread_mutex_unlock (&mutex);

  clock_gettime (CLOCK_MONOTONIC, &poll_deadline);
  poll_deadline.tv_sec +=3D 5;
  while (before_deadline (&poll_deadline))
    {
      errno =3D 0;
      query_result =3D fcntl (expected_fd, F_GETFD);
      if (query_result >=3D 0)
        break;
      if (errno !=3D EBADF)
        {
          printf ("fcntl(%d, F_GETFD): result=3D%d errno=3D%d\n",
                  expected_fd, query_result, errno);
          return 1;
        }
      nanosleep (&pause, NULL);
    }

  pthread_mutex_lock (&mutex);
  int completed_before_reader =3D writer_done;
  pthread_mutex_unlock (&mutex);
  printf ("provisional descriptor query: result=3D%d writer_done=3D%d\n",
          query_result, completed_before_reader);
  if (query_result < 0 || completed_before_reader)
    return 1;

  reader_fd =3D open (fifo_name, O_RDONLY | O_NONBLOCK);
  printf ("reader open: fd=3D%d errno=3D%d\n", reader_fd, errno);
  if (reader_fd < 0)
    return 1;

  clock_gettime (CLOCK_REALTIME, &wait_deadline);
  wait_deadline.tv_sec +=3D 5;
  pthread_mutex_lock (&mutex);
  while (!writer_done)
    {
      int err =3D pthread_cond_timedwait (&condition, &mutex, &wait_deadli=
ne);
      if (err)
        break;
    }
  int completed_after_reader =3D writer_done;
  int result_fd =3D writer_fd;
  int result_errno =3D writer_errno;
  pthread_mutex_unlock (&mutex);

  printf ("writer completion: done=3D%d fd=3D%d errno=3D%d\n",
          completed_after_reader, result_fd, result_errno);
  if (!completed_after_reader)
    return 2;

  if (result_fd >=3D 0)
    {
      int close_result =3D close (result_fd);
      printf ("writer close: result=3D%d errno=3D%d\n", close_result, errn=
o);
    }
  close (reader_fd);
  close (anchor);
  pthread_join (writer, NULL);
  unlink (fifo_name);
  return 0;
}
=2D- snap --

> --=20
> 2.51.0
>=20
>=20
