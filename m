From: Chris Faylor <cgf@cygnus.com>
To: Corinna Vinschen <corinna@vinschen.de>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Thu, 16 Mar 2000 08:27:00 -0000
Message-id: <20000316112658.A22419@cygnus.com>
References: <38D0E4C2.5F8DA404@vinschen.de>
X-SW-Source: 2000-q1/msg00004.html

On Thu, Mar 16, 2000 at 02:42:26PM +0100, Corinna Vinschen wrote:
>- Calling num_entries() only on non remote drives.

Hmm.  I wonder if this should be configurable somehow.

>There's an error in `rootdir()' function. Not in each case
>it's called with a full path as parameter, a relative path is
>possible, too.

This is not an error in the rootdir() function.  It's an error
in whatever is calling the rootdir function.  I looked through
the source and did not see a situation where it was being called
with a relative path.  Can you show me where that is happening?

cgf
