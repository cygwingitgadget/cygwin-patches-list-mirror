Return-Path: <cygwin-patches-return-4131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22993 invoked by alias); 20 Aug 2003 04:12:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22983 invoked from network); 20 Aug 2003 04:12:52 -0000
Date: Wed, 20 Aug 2003 04:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030820041252.GA26771@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F4288CE.C5133419@ieee.org> <3.0.5.32.20030819210645.00815bc0@incoming.verizon.net> <3.0.5.32.20030819223422.00815bc0@incoming.verizon.net> <20030820033132.GA26048@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030820033132.GA26048@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00147.txt.bz2

On Tue, Aug 19, 2003 at 11:31:32PM -0400, Christopher Faylor wrote:
>If you do something like:
>
>foo()
>{
>   sigframe thisframe;
>   sig_dispatch_pending ();
>}
>
>then the signal dispatch will happen when foo returns, not when
>sig_dispatch_pending returns.  The goal is that, in most cases, the
>function closest to the user should be the one that gets "interrupted".

Well, that is what I thought the goal was, but looking at the sigframe
code again it doesn't work that way.  If it did work that way then the
current call to call_signal_handler_now in sigreturn wouldn't be
necessary, although the stack pressue would be even greater.

So, I don't know why I put that explicit call in that function.  It's
probably superfluous, as you suspect.

My knees are getting really skinned...

cgf
