Return-Path: <cygwin-patches-return-4935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5284 invoked by alias); 8 Sep 2004 11:01:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5260 invoked from network); 8 Sep 2004 11:01:57 -0000
Date: Wed, 08 Sep 2004 11:01:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: RTLD_DEFAULT & RTLD_NEXT
Message-ID: <20040908101120.GH17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <u65704sup.fsf@gnu.org> <20040830143832.GE17670@cygbert.vinschen.de> <uisb018x4.fsf@gnu.org> <20040831083258.GA7517@cygbert.vinschen.de> <u1xhn1gaz.fsf@gnu.org> <20040831190826.GV17670@cygbert.vinschen.de> <uoekrxfqx.fsf@gnu.org> <20040901094429.GY17670@cygbert.vinschen.de> <uoekhx0m9.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uoekhx0m9.fsf@gnu.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00087.txt.bz2

On Sep  7 16:52, Sam Steingold wrote:
> the (C) assignment is in the mail.

Cool.  I'm looking forward to getting the ok from our HQ.

> Index: src/winsup/cygwin/autoload.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
> retrieving revision 1.87
> diff -u -w -r1.87 autoload.cc
> --- src/winsup/cygwin/autoload.cc	3 Sep 2004 01:32:02 -0000	1.87
> +++ src/winsup/cygwin/autoload.cc	7 Sep 2004 20:47:33 -0000
> @@ -309,6 +309,7 @@
>  LoadDLLfunc (DeregisterEventSource, 4, advapi32)
>  LoadDLLfunc (DuplicateToken, 12, advapi32)
>  LoadDLLfuncEx (DuplicateTokenEx, 24, advapi32, 1)
> +LoadDLLfuncEx (EnumProcessModules, 16, psapi, 1)

That's not quite the right place to add this line ;-)
Hint:  The autoload list is sorted by libraries...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
