Return-Path: <cygwin-patches-return-4949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8492 invoked by alias); 11 Sep 2004 05:08:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8482 invoked from network); 11 Sep 2004 05:08:35 -0000
Date: Sat, 11 Sep 2004 05:08:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040911050957.GA17449@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040910231337.007e0100@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040910231337.007e0100@incoming.verizon.net> <3.0.5.32.20040911002926.007e2810@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040911002926.007e2810@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00101.txt.bz2

On Sat, Sep 11, 2004 at 12:29:26AM -0400, Pierre A. Humblet wrote:
>In fact the way signals are delivered is current asymmetric:
>- Default actions are handled by the sigthread asynchronously of the
>mainthread.

I don't know what this means.

>- Signals that require a handler have to wait until the mainthread is
>ready.  It may be advantageous/cleaner (this is a generalization of
>what you suggest for fork) to also wait for the mainthread to take
>default actions.

What does "mainthread is ready" mean?  You can't start the process until
a main thread is ready.

I'm sorry but I have no idea what you're talking about or why this has
anything to do with fork.

>P.S.: See also the Rationale at the bottom of
>http://www.opengroup.org/onlinepubs/009695399/

That's just the main page for the SUSv3.  I don't see how it applies.
