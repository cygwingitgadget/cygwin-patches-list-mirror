Return-Path: <cygwin-patches-return-4950-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9218 invoked by alias); 11 Sep 2004 05:10:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9209 invoked from network); 11 Sep 2004 05:10:34 -0000
Date: Sat, 11 Sep 2004 05:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040911051157.GB17449@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040910231337.007e0100@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net> <3.0.5.32.20040910231337.007e0100@incoming.verizon.net> <3.0.5.32.20040911002926.007e2810@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040911002926.007e2810@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00102.txt.bz2

On Sat, Sep 11, 2004 at 12:29:26AM -0400, Pierre A. Humblet wrote:
>For example, that would also prevent a process from being killed while
>exec'ing, while the baby is still suspended.  Of course an exec stub
>should still handle the signal, somehow, although you expressed other
>ideas earlier in this thread.

This part, at least, I can comment on.

You really can't turn off signals while exec'ing because you don't know
if you need to be hanging around as a stub waiting for a non-cygwin
process to terminate.

cgf
