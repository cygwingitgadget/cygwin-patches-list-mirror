Return-Path: <cygwin-patches-return-4323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29716 invoked by alias); 29 Oct 2003 09:36:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29491 invoked from network); 29 Oct 2003 09:35:41 -0000
Date: Wed, 29 Oct 2003 09:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
Message-ID: <20031029093534.GB22720@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	cygwin-patches@sources.redhat.com
References: <3F9F1C5B.2050501@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9F1C5B.2050501@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00042.txt.bz2

On Tue, Oct 28, 2003 at 08:48:11PM -0500, Nicholas Wourms wrote:
> I'm not sure how this would be taken... The only problem I see in doing 
> this is if we ever decided to start supporting ia64/x86_64.  However, at 
> that point we'd have to change a *ton* of other machine-dependant macros 
> as well, so it seems like a rather trivial addition.  These macros seem 
> to be fairly standard in both the linux and bsd worlds, so it would be 
> very beneficial if we went ahead and defined them.  The reason I would 
> like them is merely as a convienience factor in some socket work I'm 
> doing.  I'm assuming that the windows default page shift, 12[*], will be 
> an acceptable value that we can agree on?  This macro defines the base 
> value upon which the aother macros calculate their values.  Based on 
> that, I have attached a patch with those macros defined and some 
> whitespace/tab cleanup cause by my last patch.  Because I'm not sure 
> about my MUA, I've gzipped the patch to preserve formatting.
> 
> Cheers,
> Nicholas
> 
> * This is the same value used by Linux/ia32, *BSD/ia32, Wine, and the 
> Windows DDK in the cvs repo.

> 2003-10-28  Nicholas Wourms  <nwourms@netscape.net>
> 
>     * include/sys/param.h: Define some page counting macros.
>     (PAGE_SHIFT): Define.
>     (PAGE_SIZE): Define.
>     (PAGE_MASK): Define.
>     Tidy tab/whitespace formatting from last patch.

Sorry, but I have several problems with this patch:

- The formatting of the ChangeLog entry (no TABS).

- The ChangeLog and your above description are missing the fact, that
  you also added a NBPW definition.

- The definition of PAGE_MASK is... a problem.  Your definition is the
  BSD definition (PAGE_SIZE-1), while Linux defines it as the negation
  thereof, (~(PAGE_SIZE-1)).  I don't know what way to follow here.
  I guess it's all one, considering that we don't use it in Cygwin so
  far.  While we once decided that, if SUSv3 fails to lend us a hand,
  we would try to map the Linux behaviour, the sys/param.h file is
  a header for mostly BSD definitions.

- Neither BSD nor Linux define these highly machine dependent values
  in sys/param.h.  What about adding a asm/param.h file and include
  that in sys/param.h?

- Don't attach gzipped patches, please.  Mozilla doesn't scramble
  text attachments, AFAIK.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
