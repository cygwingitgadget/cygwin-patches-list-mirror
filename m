Return-Path: <cygwin-patches-return-4959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1348 invoked by alias); 13 Sep 2004 18:09:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1234 invoked from network); 13 Sep 2004 18:09:38 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Mon, 13 Sep 2004 18:09:00 -0000
In-Reply-To: <20040912144258.GB11786@cygbert.vinschen.de>
       from Corinna Vinschen (Sep 12,  4:42pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040913180937.400E2E538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00111.txt.bz2

On Sep 12,  4:42pm, Corinna Vinschen wrote:
-- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
>
> Do I understand that right?  sftp is in the blocking read on the pipe,
> there is data in the pipe and nevertheless read doesn't return?  That's
> odd.

Yes, very.  I'm still experimenting, so the following description
should be considered tentative:

ReadFile seems to want to return the number of bytes requested, not
a partial amount, at least the way we're using it with pipes now.

Bytes in the pipe seem to be buffered on the write side until there
are enough to satisfy the read, or the pipe fills (or maybe there is
some other high-water mark, but it is very close to full).  The system
also seems to empty the buffer after a certain amount of time ... I'm
not sure about the interval, but it's fairly long.

This all works most of the time.  But it interacts badly with the
POSIX atomic write requirements related to PIPE_BUF.  In particular,
select should say that a pipe is not writable when there is < PIPE_BUF
space available (and our implementation does this).

So, when sftp does a large blocking read (at least 16k, which is the
size of the pipe buffer), and ssh almost fills the pipe, then select
stops further writes from happening, and we only deliver data when
the timer expires, which is why transfers are so slow.

This also explains why the problem disappears when we use sftp -B to
reduce the size of the reads, because the data is delivered before
the pipe fills to within PIPE_BUF bytes.  And similarly when I increase
the size of the pipe buffer.

Most other programs that use select or nonblocking I/O aren't affected,
because they only try to read whatever is already in the pipe, and
they get the data immediately.

> |                                         I guess this means that local
> | pipes always do buffering as described in the previous paragraph, and
> | this can't be disabled using FILE_FLAG_WRITE_THROUGH.
> 
> Did you try that?

I haven't yet, but I will.  Disabling buffering would fix the problem.
Or if we could somehow control the buffering parameters (the high-water
mark or the timer), that would also probably be sufficient.  In particular,
setting the high-water mark to reserve PIPE_BUF bytes would be perfect.
I want to try FlushFileBuffers too, but we can't let it block (hmmm ...
maybe in a separate thread?).

The real problem is that NtQueryInformationFile returns information
about the data buffered on the write side of the pipe, and that
doesn't account for the possibility that a large read might already
be blocked on the other side, which effectively means that more space
is actually available.  If we could determine the amount of requested
data for the read, that would help.  The system must know, since it
seems to affect the buffering algorithm, but I don't know offhand how
to get at the info.

> Dunno if that's a *better* idea, but would it be reasonable to try changing
> pipes to use overlapped I/O?

Maybe, but that seems complicated.  I'm hoping for something simpler.

>                               Or what if a read from a pipe always asks for
> the number of available bytes using NtQueryInformationFile and then only
> actually reads this number of bytes and returns that to the caller?
> 
-- End of excerpt from Corinna Vinschen

That's similar to nonblocking reads, and it might work, and I guess for
blocking reads we would never attempt to read more than the size of the
pipe minus PIPE_BUF.  If we don't want to return partial data, then we
could redo reads until all of the data is delivered to the calling
program, but I think partial reads should be OK.

On the read side, we'd use PeekNamedPipe instead of NtQueryInformationFile.

--
Bob
