Return-Path: <cygwin-patches-return-3212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26302 invoked by alias); 20 Nov 2002 17:10:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26292 invoked from network); 20 Nov 2002 17:10:35 -0000
Date: Wed, 20 Nov 2002 09:10:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch #4: passwd and group
Message-ID: <20021120181034.N24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de> <3.0.5.32.20021117224418.0083ac70@mail.attbi.com> <20021120114009.E24928@cygbert.vinschen.de> <3DDBA495.C5A801A2@ieee.org> <20021120163542.L24928@cygbert.vinschen.de> <3DDBB854.3A5841EB@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDBB854.3A5841EB@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00163.txt.bz2

On Wed, Nov 20, 2002 at 11:29:08AM -0500, Pierre A. Humblet wrote:
> > How would you like to remove LookupAccountSidA?  Just remove it and
> > debug_printf ("Failed to get primary group name.") ?
> 
> OK, the debug printf can be removed too, the result will be visible in the
> other debug_printf below.
> A more ambitious way is to see if the sid is local or not. If it is local we
> can safely call LookupAccountSidA.

I chose the less ambitious way for now.

> > Rewriting the external funcs and creating and using the internal funcs
> > is ok for another patch.
> 
> Glad we talk! The external non multithread functions are already OK (i.e. POSIX), 
> as long as we have the new internal functions.
> In other words, if the internal functions don't reread the files, then there
> is no need for new static buffers. The existing buffers can only be wiped out
> on the next external call, which is OK.

You're correct, sure.  Somehow I was already fixed on the "static buffer
track".

Applied with changes.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
