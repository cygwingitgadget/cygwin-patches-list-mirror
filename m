Return-Path: <cygwin-patches-return-5136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16175 invoked by alias); 16 Nov 2004 15:41:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16047 invoked from network); 16 Nov 2004 15:40:46 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 16 Nov 2004 15:40:46 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I7A3JQ-0000DA-DH
	for cygwin-patches@cygwin.com; Tue, 16 Nov 2004 10:40:43 -0500
Message-ID: <419A1F7B.8D59A9C9@phumblet.no-ip.org>
Date: Tue, 16 Nov 2004 15:41:00 -0000
From: "Pierre A. Humblet" <pierre.humblet@ieee.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00137.txt.bz2



Christopher Faylor wrote:
> 
> On Sun, Nov 14, 2004 at 12:11:58AM -0500, Christopher Faylor wrote:
> >When I get the code to a point that it can run configure, I'll do a
> >benchmark and see how bad this technique is.  If there is not a
> >noticeable degradation, I think I'll probably duplicate the scenario of
> >last year and checkin this revamp which, I believe will eliminate the
> >security problem that you were talking about.
> 
> Well, my initial implementation was a little slower than 1.5.12, which
> was encouraging since there was still stuff that I could do to speed
> things up.  For instance, it occurred to me that all of the
> synchronization in spawn_guts and waitsig could go away (with one
> exception), so I got rid of it.
> 
> And, things got a little slower.
> 
> So, I realized that I could get rid of a thread synchronization problem
> by always putting the pinfo for the new process in an static array.
> This also eliminated the need to do anything other than send a signal
> when the child was stopped or terminated.
> 
> I was getting pretty excited about all of the code that was disappearing
> until I ran the benchmark.
> 
> Yep.  Things are *a lot* slower now.
> 
> Time for bed and dreams about threads and processes...

I hope you had a great idea! 

FWIW, more than 64 processes can also be supported in the current framework
by starting one wait_subproc thread per 63 subprocesses.
The threads can probably all share the same events array (with
event[0] copied (or duplicated?) at 64, 128, ...), passing different
segments to WFMO. The threads would be started on demand, decreasing
the overhead in the usual case where a process does not fork.

It doesn't look complicated at all (pass an argument to the thread
to indicate its segment) , but it won't be as simple as having
one monitoring thread per subprocess and no reparenting.

Pierre
