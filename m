From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@Cygwin.Com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 11:55:00 -0000
Message-id: <3BAB8D40.D1DF3161@yahoo.com>
References: <3BAB474A.36883B32@yahoo.com> <20010921135147.C32224@redhat.com>
X-SW-Source: 2001-q3/msg00173.html

Did you try `strace -j'?  The valid options work the invalid option
brings up Dr. Watson.

Earnie.

Christopher Faylor wrote:
> 
> On Fri, Sep 21, 2001 at 09:57:30AM -0400, Earnie Boyd wrote:
> >I would like to propose the following patch.  If someone has time to
> >figure out how to not cause Dr. Watson it would be appreciated.  Else,
> >the error will live until I can get a round tuit.  This patch allows
> >getopt.c -mno-cygwin to build and link into strace.
> 
> This does not crash for me.  It builds and runs fine on both linux and
> windows.
> 
> cgf

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

