Return-Path: <cygwin-patches-return-4947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31486 invoked by alias); 11 Sep 2004 04:10:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31463 invoked from network); 11 Sep 2004 04:09:59 -0000
Date: Sat, 11 Sep 2004 04:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040911041122.GA17341@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040910231337.007e0100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040910231337.007e0100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00099.txt.bz2

On Fri, Sep 10, 2004 at 11:13:37PM -0400, Pierre A. Humblet wrote:
>>If the child process has not become fully awake yet it should just exit now.
>
>Not if it is destined to ignore ^C. The group leader will wait until the 
>[grand]child has grown up and its sendsig is != NULL, and then send the
>signal.
>The child will then handle it properly.
>
>The motivation for looking at this was
><http://cygwin.com/ml/cygwin/2004-07/msg01120.html>, as well as personal
>observations. I have run thousands of tests and eveything has gone well.

I think I would be more comfortable with deferring signals around a fork.
It seems like that is the right way to handle this.  Then the parent would
not disappear mysteriously and there would be no need to have the child
wait for the parent.  Your exceptions.cc change would still be required,
however.

There currently is no way to stop signals from being delivered but it
is trivial to add something.

Wouldn't that solve this problem?

cgf
