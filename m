Return-Path: <cygwin-patches-return-5135-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4431 invoked by alias); 16 Nov 2004 05:41:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3877 invoked from network); 16 Nov 2004 05:41:34 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Nov 2004 05:41:34 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 39D391B3E5; Tue, 16 Nov 2004 00:41:56 -0500 (EST)
Date: Tue, 16 Nov 2004 05:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041116054156.GA17214@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114051158.GG7554@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00136.txt.bz2

On Sun, Nov 14, 2004 at 12:11:58AM -0500, Christopher Faylor wrote:
>When I get the code to a point that it can run configure, I'll do a
>benchmark and see how bad this technique is.  If there is not a
>noticeable degradation, I think I'll probably duplicate the scenario of
>last year and checkin this revamp which, I believe will eliminate the
>security problem that you were talking about.

Well, my initial implementation was a little slower than 1.5.12, which
was encouraging since there was still stuff that I could do to speed
things up.  For instance, it occurred to me that all of the
synchronization in spawn_guts and waitsig could go away (with one
exception), so I got rid of it.

And, things got a little slower.

So, I realized that I could get rid of a thread synchronization problem
by always putting the pinfo for the new process in an static array.
This also eliminated the need to do anything other than send a signal
when the child was stopped or terminated.

I was getting pretty excited about all of the code that was disappearing
until I ran the benchmark.

Yep.  Things are *a lot* slower now.

Time for bed and dreams about threads and processes...

cgf
