From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: win95 and pshared mutex support for pthreads
Date: Wed, 25 Apr 2001 01:15:00 -0000
Message-id: <20010425101554.H23753@cygbert.vinschen.de>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de> <20010424233314.B23753@cygbert.vinschen.de> <01ba01c0cd0c$26b7b850$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00150.html

On Wed, Apr 25, 2001 at 08:16:02AM +1000, Robert Collins wrote:
> ----- Original Message -----
> I wasn't sure so I _tested_ the output. And no overruns occured.

It's not an overrun problem in first place.

> Have you tested this Corinna?

I have. My testcode:

===============================================
#include <unistd.h>
#include <stdio.h>
#include <pwd.h>

int
main(int argc, char **argv)
{
  struct passwd pw, *ret;
  char buffer[256];

  if (getpwuid_r (100, &pw, buffer, 256, &ret))
    perror ("getpwuid_r");
  else
    {
      printf ("pw_name: <%s>\n", pw.pw_name);
      printf ("pw_dir: <%s>\n", pw.pw_dir);
      printf ("pw_shell: <%s>\n", pw.pw_shell);
    }
  return 0;
}
===============================================

Uid 100 is my own entry in /etc/passwd.

With my changes, the output is:

    pw_name: <corinna>
    pw_dir: </home/corinna>
    pw_shell: </bin/tcsh>


Your version prints:

    pw_name: <corinna/home/corinna/bin/tcsh>
    pw_dir: </home/corinna/bin/tcsh>
    pw_shell: </bin/tcsh>

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
