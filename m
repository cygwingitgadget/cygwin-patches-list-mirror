Return-Path: <cygwin-patches-return-5312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6561 invoked by alias); 22 Jan 2005 20:59:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6192 invoked from network); 22 Jan 2005 20:58:46 -0000
Received: from unknown (HELO mail-ext.curl.com) (66.228.88.132)
  by sourceware.org with SMTP; 22 Jan 2005 20:58:46 -0000
Received: (qmail 6994 invoked from network); 22 Jan 2005 15:58:45 -0500
Received: from carnage.curl.com (10.228.88.18)
  by mr-burns.curl.com with SMTP; 22 Jan 2005 15:58:45 -0500
Received: by carnage.curl.com (Postfix, from userid 532)
	id A3967E54A; Sat, 22 Jan 2005 15:58:45 -0500 (EST)
From: "Bob Byrnes" <byrnes@curl.com>
Date: Sat, 22 Jan 2005 20:59:00 -0000
In-Reply-To: <20050121173426.GA16347@cygbert.vinschen.de>
       from Corinna Vinschen (Jan 21,  6:34pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: RE: ssh problem on Windows XP]
Message-Id: <20050122205845.A3967E54A@carnage.curl.com>
X-SW-Source: 2005-q1/txt/msg00015.txt.bz2

On Jan 21,  6:34pm, Corinna Vinschen wrote:
-- Subject: [Fwd: RE: ssh problem on Windows XP]
>
> is there any chance that we get a fix in the next couple of weeks?

I remain absolutely committed to fixing the problems that have been
reported, but I can't say that I'll have a fix in that timeframe,
because I have some urgent deadlines for other projects.  Maybe
early to mid-February?

> If we don't get a patch, I'm inclined to revert the pipe patch before
> we release 1.5.13.

Instead of reverting the entire patch, if you want to restore the old
behavior (select always returning true for writes on pipes), you could
add a small piece of code to "short-circuit" the NtQueryInformationFile
logic that I added.

That would make it much easier for me to apply my fix when it's available,
because I could just remove the "short-circuit" when I add a test to
detect the problem, which I think I understand completely, and have
described in an earlier posting: NtQueryInformationFile acts strangely
when there is a pending, blocking read on the other end of the pipe.
I need time to finish prototyping the new test, however.

> Btw., didn't you announce more pipe patches yet to come?  Is it possible
> that you already have a patch which will get that working again?  I'm
> still hoping for something more satisfying than reverting...
> 
-- End of excerpt from Corinna Vinschen

Yes, I have more patches, but they don't fix the outstanding problem
with the first patch (I would have certainly sent the fix if I had one).
All of my fixes are related to detecting and avoiding deadlocks, and I
have some that are not pipe related.

In case anyone is curious, let me relate the story of what started all
of this ...

At Curl (where I work), we have a pool of about a dozen Windows servers
that we use for automated builds of our products.  Each build starts by
rsync-ing the sources from a Linux server to a Windows build server (over
ssh), then we launch make via ssh and collect std{out,err} over an ssh
channel, and finally the build finishes by rsync-ing the build tree back
from the Windows build server to the Linux build server, again over ssh.

Our Windows build servers are in almost continuous use.  As you
can imagine, this setup acts as a severe stress test for Cygwin.
Unfortunately, last year Cygwin deadlocks were killing our productivity:
at least 25% of our builds were wedging, which was completely
unacceptable.

So, I rolled up my sleeves, installed a Cygwin DLL with all of the
debugging symbols, and went to work investigating and fixing each deadlock
that I encountered.

It soon became apparent that pipes were a major problem.  We observed
deadlocks because select for writes on pipes always returned true,
so I implemented a fix (that's the first patch).  Similar deadlocks
occurred because nonblocking writes on pipes could block, so I added
an implementation for nonblocking writes too (a second patch, which I
submitted, but was never applied, because we wanted to investigate the
reported problems with the first patch).

Later, I found that Cygwin is burned by unfortunate winsock behavior
that we had already encountered in other contexts: it sometimes assigns a
local port that can't actually be used immediately, because it is still
in TIME_WAIT, so connect fails with EADDRINUSE.  I fixed one nasty case
where this phenomenon can cause a missed notification in the code for
select on sockets (a third patch), and another that caused socketpair
to fail sporadically (a fourth patch).

The improvement in Cygwin's behavior with these four patches has been
dramatic at Curl.  Our builds almost never experience deadlocks now.  I am
eager to contribute them to the rest of the world, but I recognize that
I need to fix the first patch before we apply the rest, and I will do it.

Our patches have been extensively tested, but we missed the problem
that occurs for pending, nonblocking reads, because our automated builds
don't use commands like sftp, unison, etc.  Most of the other commands
seem to use nonblocking I/O on pipes (often with select), and that works
with my patches.

--
Bob
