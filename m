Return-Path: <cygwin-patches-return-5168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30966 invoked by alias); 26 Nov 2004 04:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30853 invoked from network); 26 Nov 2004 04:33:15 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 26 Nov 2004 04:33:15 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id DC6151B3E5; Thu, 25 Nov 2004 23:29:08 -0500 (EST)
Date: Fri, 26 Nov 2004 04:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041126042908.GA12730@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120062339.GA31757@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00169.txt.bz2

On Sat, Nov 20, 2004 at 01:23:39AM -0500, Christopher Faylor wrote:
>On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
>>The simplification of the code from removing all of the reparenting
>>considerations is not something that I'm going to give up on easily.
>
>Well, the code seems to be slightly faster now than the old method, so
>that's something.  I think it's also a lot simpler.

I've checked in my revamp of the exec/wait code.  There are still some
other ways to do what I did and maybe I'll experiment with using
multiple threads running WaitForMultipleObjects, but, for now, cygwin is
using the one thread per process technique.

AFAIK, the only problem with the current code is if a parent process
forks a process, calls setuid, and execs a non-cygwin process it is
possible that the parent process won't be able to retrieve the exit
value of the non-cygwin process.

Right now, my reaction to this crucial shortcoming is "oh well" but
if it actually proves to be a problem, I know how to deal with it.

This was a major change but, if wc and ls are to believed, the net
result is a reduction in size of the dll.  I don't detect any change in
behavior as far as timings are concerned but I still need to check
things on a single processor CPU.

cgf
