Return-Path: <cygwin-patches-return-4480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11787 invoked by alias); 7 Dec 2003 13:20:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11778 invoked from network); 7 Dec 2003 13:20:02 -0000
Date: Sun, 07 Dec 2003 13:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Create Global Privilege
Message-ID: <20031207132000.GR1640@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net> <3.0.5.32.20031126104557.00838210@incoming.verizon.net> <20031129230722.GB6964@cygbert.vinschen.de> <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net> <3.0.5.32.20031204221654.0082c250@incoming.verizon.net> <3.0.5.32.20031205080236.0082c420@incoming.verizon.net> <3.0.5.32.20031205212917.008395e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031205212917.008395e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00199.txt.bz2

On Fri, Dec 05, 2003 at 09:29:17PM -0500, Pierre A. Humblet wrote:
> Sure, here it is. BTW, F_SETLKW is yucky, at least on NT4. Not only
> the fcntl call isn't interruptible but the process itself can't be 
> killed with kill -9 while waiting. The sig thread itself waits during
> the close() call in the exit sequence.

I'm aware of this and it makes me not exactly happy.  A workaround
might be a bit tricky.  Using the Async I/O facility of LockFileEx
requires to call CreateFile already with FILE_FLAG_OVERLAPPED.  This
in turn requires to rewrite ReadFile and WriteFile calls to use
overlapped IO as well.

> 2003-12-06  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* syscalls.cc (locked_append): New.
> 	(updwtmp): Remove mutex code and call locked_append.
> 	(pututline): Ditto.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
