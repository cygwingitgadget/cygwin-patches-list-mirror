Return-Path: <cygwin-patches-return-2759-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19094 invoked by alias); 31 Jul 2002 13:20:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19060 invoked from network); 31 Jul 2002 13:20:39 -0000
Date: Wed, 31 Jul 2002 06:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Performance: fhandler_socket and ready_for_read()
Message-ID: <20020731152036.L3921@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07f001c2381e$43118070$6132bc3e@BABEL> <20020731002910.GD17985@redhat.com> <086701c2382f$2c6b19b0$6132bc3e@BABEL> <20020731012133.GB21134@redhat.com> <08e301c23833$d05627f0$6132bc3e@BABEL> <20020731020213.GC21291@redhat.com> <20020731115336.F3921@cygbert.vinschen.de> <09e301c2388d$c90be7a0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e301c2388d$c90be7a0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00207.txt.bz2

On Wed, Jul 31, 2002 at 01:28:32PM +0100, Conrad Scott wrote:
> "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > I agree.  Just setting the flag is cleaner than overriding the
> method
> > while the flag is still set to a wrong value, isn't it?
> 
> It is, especially now that I look at this in the, umm, early
> afternoon light after a good, umm, night's sleep (tho' no coffee
> or breakfast yet, so no guarantees).
> 
> Summarising last night's twisty little thread, this patch just
> sets the NOEINTR flag for sockets if winsock2 is available, which
> should keep us all happy.  And it makes the get_r_no_interrupt
> method non-virtual again too.  Just in case :-)

Cool.  Applied.  Sorry but reviewing your other patch will take
a little bit longer.  I'd especially like to have Egor's comment
on the security stuff.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
