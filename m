Return-Path: <cygwin-patches-return-5280-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4962 invoked by alias); 24 Dec 2004 02:25:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3999 invoked from network); 24 Dec 2004 02:25:38 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 24 Dec 2004 02:25:38 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 918CA1B401; Thu, 23 Dec 2004 21:27:10 -0500 (EST)
Date: Fri, 24 Dec 2004 02:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041224022710.GB20554@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org> <41C9C088.9E9B16E3@phumblet.no-ip.org> <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00281.txt.bz2

On Thu, Dec 23, 2004 at 06:23:06PM -0500, Pierre A. Humblet wrote:
>I have run some more tests with a built from cvs this afternoon
>and peeked at some of the changes, so here is some feedback.
>
>When a process is terminated from Windows, the reported exit code
>is 0. This can easily be fixed by initializing exitcode to
>the value it should take when a process is terminated.

Ok.  I see that the old version of cygwin exited with a status of 1.
I think it is more appropriate to exit with a SIGTERM.

The side effect of doing things this way is that the program will seem
to have exited with a SIGTERM value if it calls ExitProcess, too.
That is a depature from previous behavior that I'm sure I'll hear about.

>If my spawn(P_DETACH) program of yesterday is terminated from 
>Windows during the sleep interval, then the parent process does
>not notice the termination and keeps waiting.

I think I already mentioned this as a side effect of the new code.

>This can be fixed with my lunch time ideas of yesterday.
>Looking at the code, I saw that most of them were already 
>implemented. The only changes are:
>1) remove child_proc_info->parent_wr_proc_pipe stuff
>2) in pinfo::wait, duplicate into non-inheritable wr_proc_pipe

As may not be too surprising, I already considered creating the pipe
before creating the process (somehow I am hearing echoes of John Kerry
here).  I actually coded it that way to begin with but then chose to go
with the current plan.

I'll have to think about my reasons for not implementing it that way.
I don't remember what they are right now.

cgf
