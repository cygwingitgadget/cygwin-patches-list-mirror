Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 729604BA2E18; Tue, 31 Mar 2026 10:07:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 729604BA2E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774951648;
	bh=gXgfGPVuNAMZV1jlgn37QWrr2p/5SckXMxthqov4bJM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WuduOC81yYiVYq1rob6xucy57nRpoyUIauM+9NojfearweLndv/UcAegvqR9VOCJ2
	 1KKvB0HboyS/dcPRmJQfVc/tPhcFoCqGE/5Rva7YLBHykK/WI1mTo1/zgUgdznCV+5
	 lQa2q1Uu5V5O39Y/Wi1MGiOkty+Uh6Qcl/n94aBU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 857EBA80BDF; Tue, 31 Mar 2026 12:07:26 +0200 (CEST)
Date: Tue, 31 Mar 2026 12:07:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: add _Fork() system call per POSIX.1-2024
Message-ID: <acuc3jA9ekjC9ZIV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jon Turney <jon.turney@dronecode.org.uk>
References: <20260330144113.1636278-1-corinna-cygwin@cygwin.com>
 <bd7fc7cf-ac28-44b4-b1e8-bb22641f1962@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd7fc7cf-ac28-44b4-b1e8-bb22641f1962@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

thanks for reviewing!

On Mar 30 21:29, Jon Turney wrote:
> On 30/03/2026 15:41, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > The _Fork() function shall be equivalent to fork(), except that fork
> > handlers established by means of the pthread_atfork() function shall
> > not be called and _Fork() shall be async-signal-safe.  Our fork()
> > already is async-signal-safe, so just make sure the pthread_atfork()
> > handlers are not called.
> 
> Nice.
> 
> [...]
> > diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> > index 48e8b7557d00..82ad3aaf0899 100644
> > --- a/winsup/cygwin/fork.cc
> > +++ b/winsup/cygwin/fork.cc
> > @@ -31,7 +31,7 @@ details. */
> >   /* FIXME: Once things stabilize, bump up to a few minutes.  */
> >   #define FORK_WAIT_TIMEOUT (300 * 1000)     /* 300 seconds */
> > -static int dofork (void **proc, bool *with_forkables);
> > +static int dofork (void **proc, bool is__Fork, bool *with_forkables);
> 
> This looks fine.
> 
> Maybe the new parameter should be named to indicate what extra step it
> enables, rather than what API we're executing? (So, like, do_atfork_handlers
> or something? Or maybe that's less clear)

Actually, I think this is a great idea.  do__Fork is a bit clumsy.  I
renamed the variables to do_atfork_handlers throughout and will push it
with this change in a bit.

> If you have a STC you used to test this you want to share, maybe I can look
> at adding that to testsuite.

Pretty simple:

$ cat > atforktest.c <<EOF
#define _GNU_SOURCE
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int pre = 0;
int pnt = 0;
int chld = 0;

void
prepare (void)
{
  pre = 1;
}

void
parent (void)
{
  pnt = 1;
}

void
child (void)
{
  chld = 1;
}

int
main (int argc, char **argv)
{
  pthread_atfork (prepare, parent, child);

  printf ("Calling %s\n", argc > 1 ? "_Fork()" : "fork()");
  switch (argc > 1 ? _Fork () : fork ())
    {
    case -1:
      printf ("error %d %s\n", errno, strerror (errno));
      return 1;
    case 0:
      printf ("child : prepare %d, parent %d, child %d\n", pre, pnt, chld);
      break;
    default:
      sleep (1);
      printf ("parent: prepare %d, parent %d, child %d\n", pre, pnt, chld);
      break;
    }
  return 0;
}
EOF
$ gcc -g -o atforktest atforktest.c
$ ./atforktest.exe
Calling fork()
child : prepare 1, parent 0, child 1
parent: prepare 1, parent 1, child 0
$ ./atforktest.exe 1
Calling _Fork()
child : prepare 0, parent 0, child 0
parent: prepare 0, parent 0, child 0
$


Thanks,
Corinna
