From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: win95 and pshared mutex support for pthreads
Date: Tue, 24 Apr 2001 15:15:00 -0000
Message-id: <01ba01c0cd0c$26b7b850$0200a8c0@lifelesswks>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de> <20010424233314.B23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00147.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, April 25, 2001 7:33 AM
Subject: Re: win95 and pshared mutex support for pthreads


> On Tue, Apr 24, 2001 at 11:22:02PM +0200, Corinna Vinschen wrote:
> > Chris, I assume that it's not a showstopper but I will patch
> > it for 1.3.2.  My upcoming changes to the security code will
> > need reentrant getpwxxx and getgrxxx functions.
>
>
> OOOPS! Wait, the getpwuid_r and getpwnam_r can't work!
>
> Look at that code:
>
>   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir)
+ strlen (temppw->pw_shell);
>
> What about the \0 bytes?

I wasn't sure so I _tested_ the output. And no overruns occured.

>   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir)
+ strlen (temppw->pw_shell) + 3;
>
>   pwd->pw_name = buffer;
>   pwd->pw_dir = buffer + strlen (temppw->pw_name);
>
> Shouldn't that be
>
>   pwd->pw_dir = buffer + strlen (temppw->pw_name) + 1
>
> ?

Have you tested this Corinna?

===
#include <sys/types.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>

int
main (void)
{
  char localbuf[ 51];
  struct passwd pwd, *res;
  int rv;

  rv = getpwnam_r("administrator", &pwd, localbuf, 51, &res);

  if (res)
  {
    printf ("found
%s\n%d\n%d\n%s\n%s\n",res->pw_name,res->pw_uid,res->pw_gid,
        res->pw_dir, res->pw_shell);
    return 0;
  }
  else
  printf("couldn't find user administrator, error %d\n",rv);
  return 1;
}
===



>   pwd->pw_shell = buffer + strlen (temppw->pw_name) + strlen
(temppw->pw_dir);
>
> and that one
>
>   pwd->pw_shell = pwd->pw_dir + strlen (temppw->pw_dir) + 1;
>
> ?
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin
to
> Cygwin Developer
mailto:cygwin@cygwin.com
> Red Hat, Inc.
>
