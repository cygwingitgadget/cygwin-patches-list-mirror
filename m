From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Thu, 16 Mar 2000 09:00:00 -0000
Message-id: <38D1108D.593F9C71@vinschen.de>
References: <38D0E4C2.5F8DA404@vinschen.de> <20000316112658.A22419@cygnus.com>
X-SW-Source: 2000-q1/msg00005.html

Chris Faylor wrote:
> 
> On Thu, Mar 16, 2000 at 02:42:26PM +0100, Corinna Vinschen wrote:
> >- Calling num_entries() only on non remote drives.
> 
> Hmm.  I wonder if this should be configurable somehow.

I agree, but I would do it later in a context, where we
make some more stuff configurable.

> >There's an error in `rootdir()' function. Not in each case
> >it's called with a full path as parameter, a relative path is
> >possible, too.
> 
> This is not an error in the rootdir() function.  It's an error
> in whatever is calling the rootdir function.  I looked through
> the source and did not see a situation where it was being called
> with a relative path.  Can you show me where that is happening?

I've seen this first, when I added the debug output to the end
of path_conv::path_conv(). I was really surprised because I was
sure that all paths are absolute at this point. For testing
purposes simply try `ls -l foo' with foo in your cwd. The resulting
path of path_conv::path_conv is "foo" instead of "cwd\foo".
Unfortunately, the absolute path is essential for many checks...

Hope, this helps,
Corinna
