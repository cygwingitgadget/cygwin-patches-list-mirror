Return-Path: <cygwin-patches-return-4535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29757 invoked by alias); 23 Jan 2004 16:09:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29683 invoked from network); 23 Jan 2004 16:09:38 -0000
Date: Fri, 23 Jan 2004 16:09:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: secret event
Message-ID: <20040123160938.GB6773@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040122183313.00839860@incoming.verizon.net> <20040123095952.GC12512@cygbert.vinschen.de> <20040123151621.GC10708@redhat.com> <401145F5.5ECCA8DF@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401145F5.5ECCA8DF@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00025.txt.bz2

On Fri, Jan 23, 2004 at 11:04:05AM -0500, Pierre A. Humblet wrote:
>
>Christopher Faylor wrote:
>> 
>> 
>> I agree, with one nit.  Was there a reason for getting rid of the handle
>> protection in this patch?  We are apparently stumbling over a problem with
>> handle corruption in the current CVS so removing a chance for protection
>> seems like we're going backwards.
>
>The previous code was assuming that a handle would never change from
>inheritable to non-inheritable (or conversely) and was protecting it
>accordingly.
>That's not true anymore and I don't know how to protect in that situation.

Ah, of course.  I should have realized that.  I make similar tradeoffs in
the tty stuff for similar reasons.

Well, Volker's problem is confirmed as some strange handle corruption.
I always seem to be poised at the uncertain cusp of thinking that the
handle protection code is stupid and should be removed, and thinking
that it is useful and should be augmented...

cgf
