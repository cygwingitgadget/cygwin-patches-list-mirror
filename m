From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Improper static on function in winsup/cygwin/path.cc
Date: Sun, 03 Jun 2001 18:32:00 -0000
Message-id: <20010603213220.A30439@redhat.com>
References: <002001c0ec59$ec9fbd30$1a6e1a3f@ca.boeing.com>
X-SW-Source: 2001-q2/msg00276.html

Thanks.  The static definition should actually be removed entirely.
I've temporarily declared this in cygheap.h, until I can think of a better
way to handle this.

cgf

On Sun, Jun 03, 2001 at 11:09:42AM -0700, Michael A. Chase wrote:
>path_prefix_p() is referred to in winsup/cygwin/cygheap.h as extern, so it
>shouldn't be declared static in winsup/cygwin/path.cc.
