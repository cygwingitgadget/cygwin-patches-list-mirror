From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Sat, 18 Mar 2000 14:07:00 -0000
Message-id: <38D3FDF9.FD23FE04@vinschen.de>
References: <38D0E4C2.5F8DA404@vinschen.de> <20000316112658.A22419@cygnus.com>
X-SW-Source: 2000-q1/msg00011.html

Chris Faylor wrote:
> 
> On Thu, Mar 16, 2000 at 02:42:26PM +0100, Corinna Vinschen wrote:
> >- Calling num_entries() only on non remote drives.
> 
> Hmm.  I wonder if this should be configurable somehow.

You remember this patch?

It wasn't _that_ kind of solution to set st_nlink to 2 in case
of remote directories!

Unfortunatley find(1) command takes st_nlink into account to get
the information if it's worth to search for subdirectories.

In case of st_nlink == 2 it knows that the subdir count is 0,
so the depth search has a surprising fast end...

I have now patched my patch to set st_nlink to the fixed value of
1 on remote directories. This is

- as fast as with the fixed value of 2,
- in a compatible way as wrong as Win32,
- doesn't disturb the work of find.

So I will check it in if you don't mind.

Corinna
