From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: WriteFile() whacks st_atime patch
Date: Mon, 10 Sep 2001 13:22:00 -0000
Message-id: <20010910222228.X937@cygbert.vinschen.de>
References: <20010910154431.A792@dothill.com>
X-SW-Source: 2001-q3/msg00120.html

On Mon, Sep 10, 2001 at 03:44:31PM -0400, Jason Tishler wrote:
> Attached is a cleaned up version of the WriteFile() patch that I
> previously posted to cygwin-developers:
> 
>     http://www.cygwin.com/ml/cygwin-developers/2001-09/msg00076.html
> 
> Note that this version only affects disk files.  Additionally, I verified
> that mutt finds new mail even when not configured with --enable-buffy-size
> (Use file size attribute instead of access time).
> 
> I ran some tests to determine the performance impact.  On my machine,
> the GetFileTime()/SetFileTime() pair will add approximately 200 us to
> every write.  I don't know whether or not better Posix conformance is
> worth this performance hit?
> 
> Unfortunately, I did not address the race condition between a writer
> and a reader.  If the reader happens to read while the writer is between
> the GetFileTime() and SetFileTime() in fhandler_disk_file::raw_write(),
> then the new functionality will actually whack st_atime!  So, is it
> better to whack st_atime on every write or only on the occasion when
> the above mentioned race condition occurs?
> 
> Given the above problems, I have very mixed feelings about this patch.
> Is it worth pursuing or should I dropped it?

Frankly, I don't know.  My first guess is to prioritize correctness
over speed and with your patch the functionality seems to be at 
least `more correct'.  Would it perhaps make sense to change
that to something like:

open(): 	CreateFile();
		if (O_WRONLY || O_RDWR)
		  GetFileTime();

read():		ReadFile();
		if (O_RDWR)
		  GetFileTime();

write():	WriteFile();

close():	if (O_WRONLY || O_RDWR)
		  SetFileTime();
		CloseHandle();

???

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
