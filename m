From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@Cygwin.Com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 12:20:00 -0000
Message-id: <20010921152059.A3866@redhat.com>
References: <3BAB474A.36883B32@yahoo.com> <20010921135147.C32224@redhat.com> <3BAB8D40.D1DF3161@yahoo.com>
X-SW-Source: 2001-q3/msg00174.html

On Fri, Sep 21, 2001 at 02:56:00PM -0400, Earnie Boyd wrote:
>Did you try `strace -j'?  The valid options work the invalid option
>brings up Dr. Watson.

Yes.  I tried using options that didn't exist since that is the reason
for the _argv patch.

cgf
