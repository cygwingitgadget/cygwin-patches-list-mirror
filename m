Return-Path: <cygwin-patches-return-2336-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1413 invoked by alias); 6 Jun 2002 11:18:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1399 invoked from network); 6 Jun 2002 11:18:36 -0000
Date: Thu, 06 Jun 2002 04:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
Message-ID: <20020606131834.H30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00319.txt.bz2

On Wed, Jun 05, 2002 at 08:23:59PM -0400, Pierre A. Humblet wrote:
> I saw the changes in grp.cc and passwd.cc where you make default
> entries from the token. That's a good idea, very close to what I had 
> in mind for the "except" clause" in suggestion c) above.
> 
> At any rate this doesn't favor keeping lookup_name() and using it
> up only in alloc_sd(). So you could still apply my patches, even if
> you want to move from b) to the direction of c).

Ok, applied.

> >However, I think calling lookup_name in internal_getlogin() is 
> >somewhat useless.
> I agree. My patches remove it, but replace it with something similar.
> I will remove it later if you apply them.
> 
> By the way, your ChangeLog entry is missing "* passwd.cc " :) :) :) 

Thanks, I've fixed that.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
