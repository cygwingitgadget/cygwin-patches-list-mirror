From: Jason Tishler <jason@tishler.net>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: WriteFile() whacks st_atime patch
Date: Mon, 10 Sep 2001 12:43:00 -0000
Message-id: <20010910154431.A792@dothill.com>
X-SW-Source: 2001-q3/msg00119.html

Attached is a cleaned up version of the WriteFile() patch that I
previously posted to cygwin-developers:

    http://www.cygwin.com/ml/cygwin-developers/2001-09/msg00076.html

Note that this version only affects disk files.  Additionally, I verified
that mutt finds new mail even when not configured with --enable-buffy-size
(Use file size attribute instead of access time).

I ran some tests to determine the performance impact.  On my machine,
the GetFileTime()/SetFileTime() pair will add approximately 200 us to
every write.  I don't know whether or not better Posix conformance is
worth this performance hit?

Unfortunately, I did not address the race condition between a writer
and a reader.  If the reader happens to read while the writer is between
the GetFileTime() and SetFileTime() in fhandler_disk_file::raw_write(),
then the new functionality will actually whack st_atime!  So, is it
better to whack st_atime on every write or only on the occasion when
the above mentioned race condition occurs?

Given the above problems, I have very mixed feelings about this patch.
Is it worth pursuing or should I dropped it?

Thanks,
Jason
