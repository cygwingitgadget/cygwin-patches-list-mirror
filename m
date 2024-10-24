Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1796D3858D21; Thu, 24 Oct 2024 10:21:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1796D3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729765267;
	bh=v5jbYCnobbhgP3DqHWTjcf3WZli1S7lVES9ek/LewoI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=LHdNKrwht9szfRSWqfWY83FwEDmECYbmtGkyu7Ne8OmXC8BowKEEb4BWZPvrlE9dM
	 OfmaXan9CevKSFB8c0q23p5FZ72nvqLazPJDPYbAfQMaQBFo/W2OCB2QOTNKyWi9iZ
	 a8OdbQNWThjOSkJKkhmQI8uLF15RumGgMgdMViUw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EB693A80965; Thu, 24 Oct 2024 12:21:04 +0200 (CEST)
Date: Thu, 24 Oct 2024 12:21:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
 <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="htsT6rwr7GCm+FE5"
Content-Disposition: inline
In-Reply-To: <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>


--htsT6rwr7GCm+FE5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Oct 24 17:58, Takashi Yano wrote:
> On Wed, 23 Oct 2024 11:00:33 +0200
> Corinna Vinschen wrote:
> > This new implementation of raw_write() skips the mechanism added in
> > commit 170e6badb621 ("Cygwin: pipe: improve writing when pipe buffer is
> > almost full") for non-blocking pipes, if the pipe has less space than
> > is requested by user-space.
> > 
> > Rather than trying to write multiple of 4K chunks or smaller multiple of
> > 2 chunks if < 4K, it just writes as much as possible in one go, i.e.
> > 
> > Before:
> > 
> >   $ ./x 40000
> >   pipe capacity: 65536
> >   write: writable 1, 40000 25536
> >   write: writable 1, 24576 960
> >   write: writable 0, 512 448
> >   write: writable 0, 256 192
> >   write: writable 0, 128 64
> >   write: writable 0, 64 0
> >   write: writable 0, -1 / Resource temporarily unavailable
> > 
> > After:
> > 
> >   $ ./x 40000
> >   pipe capacity: 65536
> >   write: writable 1, 40000 25536
> >   write: writable 1, 25536 0
> >   write: writable 0, -1 / Resource temporarily unavailable
> > 
> > This way, we get into the EAGAIN case much faster again, which was
> > one reason for 170e6badb621.
> > 
> > Does this make more sense, and if so, why?  If this is really the
> > way to go, the comment starting at line 634 (after applying your patch)
> > will have to be changed as well.
> 
> Perhaps, I did not understand intent of 170e6badb621. Could you please
> provide the test program (./x)? I will check my code.

I attached it.  If you call it with just the number of bytes per write,
e.g. `./x 12345', the writes are blocking.  If you add another parameter,
e.g. `./x 12345 1', the writes are nonblocking.

> > > +  int64_t unique_id = 0;
> > 
> > unique_id will be set by the following nt_create() anyway.
> > Is there a case where it's not set?  I don't see this.
> 
> Without initialization, compiler complains... due to false positive?

It does for you?  For some reason it doesn't complain for me.
I'm using a gcc 12.4.0 cross compiler on Linux.  Weird.

Anyway, if it complains for you, it's ok to initialize, of course.


Corinna

--htsT6rwr7GCm+FE5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="x.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/select.h>

char buf[32 * 4096];

void
handler (int sig)
{
  fprintf (stderr, "SIGALRM ");
}

int
main (int argc, char **argv)
{
  int fd[2], max;
  ssize_t ret;
  ssize_t to_write, written = 0;
  struct sigaction sa = { 0 };
  fd_set fds;
  struct timeval tv = { 0 };

  int nonblock = (argc == 3) ? O_NONBLOCK : 0;

  if (argc < 2 || argc > 3)
    return 1;
  if (pipe2 (fd, nonblock) == -1)
    return 2;
  to_write = strtol (argv[1], NULL, 0);
  if (to_write < 1 || to_write > sizeof buf)
    return 3;
  sa.sa_handler = handler;
  if (sigaction (SIGALRM, &sa, NULL) == -1)
    return 4;
  max = 65536;//fcntl (fd[1], F_GETPIPE_SZ);
  fprintf (stderr, "pipe capacity: %d\n", max);
  do
    {
      sleep (1);
      alarm (2);
      FD_ZERO (&fds);
      FD_SET (fd[1], &fds);
      ret = select (fd[1] + 1, NULL, &fds, NULL, &tv);
      fprintf (stderr, "write: writable %d, ", FD_ISSET (fd[1], &fds));
      ret = write (fd[1], buf, to_write);
      alarm (0);
      if (ret < 0)
	fprintf (stderr, "%zd / %s\n", ret, strerror (errno));
      else
	{
	  written += ret;
	  fprintf (stderr, "%zd %zd\n", ret, (ssize_t) max - written);
	}
    }
  while (ret >= 0);
}

--htsT6rwr7GCm+FE5--
