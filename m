Return-Path: <cygwin-patches-return-4954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12699 invoked by alias); 11 Sep 2004 18:20:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12670 invoked from network); 11 Sep 2004 18:20:21 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Sat, 11 Sep 2004 18:20:00 -0000
In-Reply-To: <20040910204850.AFD08E538@carnage.curl.com>
       from "Bob Byrnes" (Sep 10,  4:48pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040911182020.A6F2AE538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00106.txt.bz2

> I'll do some stracing to see what sftp is doing (that scp and ssh are not).

OK, I now have at least a partial understanding of what's happening, but
I need to do some additional experiments to learn more and work out a
solution.

sftp runs ssh, with a pair of pipes connecting the two programs,
one in each direction.  ssh uses a (bidirectional) socket to talk
to sshd on the server.

Here's some lame ascii art:

    +------+>>>>>>pipe>>>>>>+-----+
    | sftp |                | ssh +<><><><>socket<><><><>
    +------+<<<<<<pipe<<<<<<+-----+

When the inbound transfer stalls, I see sftp performing a blocking
read on the ssh->sftp pipe.  It seems to be reading 16k chunks (even
though the default buffer size is supposed to be 32k ... see below).

ssh is using select to monitor both pipes and the socket, but the
ssh->sftp pipe doesn't select writable for long periods of time,
because NtQueryInformationFile reports that the pipe is full.
That's odd: why isn't the data in transit within the pipe delivered
to the reading sftp process?

I think this is related to buffering for pipes.  The MSDN docs for
CreateNamedPipe say that "the system enhances the efficiency of network
operations by buffering data until a minimum number of bytes accumulate
or until a maximum time elapses," if FILE_FLAG_WRITE_THROUGH is disabled,
and this matches the behavior that I'm seeing.  I wish the docs would
have specified the miniimum number of bytes, or the maximum time, or
provided a means of controlling this behavior.

But the docs also say that "Write-through mode ... affects only write
operations on byte-type pipes and, then, only when the client and server
processes are on different computers."  I guess this means that local
pipes always do buffering as described in the previous paragraph, and
this can't be disabled using FILE_FLAG_WRITE_THROUGH.

Anyway, NtQueryInformationFile apparently reports on the state of the
buffered data on the ssh side of the pipe, which seems reasonable.

This understanding at least answers a bunch of questions ...

    --  Why did we start noticing this problem when we applied my patch
        implementing select for write on pipes?  Because previously,
        select would always say the pipe is writable, and ssh would
        do the write even though the pipe appeared full, and this
        would flush the pipe buffer.

    --  Why is only sftp affected, not scp, or ssh with programs like rsync? 
        I think because sftp does blocking I/O in fairly large chunks,
        without using select.

    --  Why are only inbound sftp transfers affected?  Because for outbound
        transfers, sftp does large blocking writes (without using select),
        and this flushes the pipe buffer.

As a further confirmation, I tried running sftp -B 8192 and sftp -B 12288
to do I/O in smaller chunks, and the problem disappears.

My Cygwin DLL still has support for the CYGWIN_PIPEBUFSIZE environment
variable, so I also used that to quickly try 32k pipe buffers (instead
of the default 16k size), and the problem also disappears.

When I say that the problem disappears, I mean that the inbound sftp
transfers are as fast as outbound, or any other method that I've tried.

ssh and rsync tend to write in smaller chunks; I think this is fairly
common, since the POSIX specs for atomic writes on pipes tend to
encourage smaller chunks by mandating more stringent behavior for
writes of size <= PIPE_BUF (which is typically only 4k).

So, what should we do now?  We need a reliable way to tell if writes
will block, for both select and nonblocking I/O.  I've been using
NtQueryInformationFile to see how much space is available (analogous
to use of PeekNamedPipe for reads), but we need to control how pipe
buffering is done.

I'll do some experiments ... maybe we can use something like FlushFileBuffers
before NtQueryInformationFile to induce data transfer to any pending reads on
the other side of the pipe, although I'm concerned that this might block
when there is no pending read, and that would be bad.

Other, better ideas would be most welcome!

--
Bob
