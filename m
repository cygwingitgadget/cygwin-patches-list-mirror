From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches@Cygwin.Com
Subject: Re: winsup/cygwin/lib/getopt.c -mno-cygwin
Date: Fri, 21 Sep 2001 10:51:00 -0000
Message-id: <20010921135147.C32224@redhat.com>
References: <3BAB474A.36883B32@yahoo.com>
X-SW-Source: 2001-q3/msg00172.html

On Fri, Sep 21, 2001 at 09:57:30AM -0400, Earnie Boyd wrote:
>I would like to propose the following patch.  If someone has time to
>figure out how to not cause Dr. Watson it would be appreciated.  Else,
>the error will live until I can get a round tuit.  This patch allows
>getopt.c -mno-cygwin to build and link into strace.

This does not crash for me.  It builds and runs fine on both linux and
windows.

cgf
