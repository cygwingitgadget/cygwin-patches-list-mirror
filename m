From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: rootdir
Date: Thu, 16 Mar 2000 10:00:00 -0000
Message-id: <38D12124.53280E68@vinschen.de>
References: <38D0E4C2.5F8DA404@vinschen.de> <20000316112658.A22419@cygnus.com> <38D1108D.593F9C71@vinschen.de> <20000316121257.A23537@cygnus.com>
X-SW-Source: 2000-q1/msg00007.html

Chris Faylor wrote:
> On Thu, Mar 16, 2000 at 05:49:17PM +0100, Corinna Vinschen wrote:
> >[...]
> >I've seen this first, when I added the debug output to the end
> >of path_conv::path_conv(). I was really surprised because I was
> >sure that all paths are absolute at this point. For testing
> >purposes simply try `ls -l foo' with foo in your cwd. The resulting
> >path of path_conv::path_conv is "foo" instead of "cwd\foo".
> 
> When I debug this function, full_path contains a fully specified path,
> as it should.  The default behavior of path_conv is to return a relative
> path but it does have the full path available to it internally.

Sorry, correction: I have tried it once more. You are right if
the cwd is on a local drive. I have added a debug_printf(full_path)
at the end of path_conv::path_conv() and I can get a relative path
in full_path if the cwd is on a remote drive that is _not_ mounted
with drive letter:

	cd //server/share
	strace ls -l some_file
=== snip ===
x y [main] ls 1008 path_conv::path_conv: full_path = some_file
=== snap ===

but:

	net use z: \\server\share
	cd /cygdrive/z
	strace ls -l some_file
=== snip ===
x y [main] ls 1013 path_conv::path_conv: full_path = z:\some_file
=== snap ===

Corinna
