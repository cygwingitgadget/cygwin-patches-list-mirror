Return-Path: <cygwin-patches-return-3918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25229 invoked by alias); 27 May 2003 09:07:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18962 invoked from network); 27 May 2003 09:04:04 -0000
Date: Tue, 27 May 2003 09:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: [corinna-cygwin@cygwin.com: Re: ENOTSOCK errors with cygwin dll 1.3.21 and 1.3.22]
Message-ID: <20030527090403.GU875@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030527080142.GB19957@cygbert.vinschen.de> <Pine.WNT.4.44.0305271006230.1364-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0305271006230.1364-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00145.txt.bz2

On Tue, May 27, 2003 at 10:19:53AM +0200, Thomas Pfaff wrote:
> > > +        CloseHandle (ev[0]);
> >            ^^^^^^^^^^^
> > 	   ...shouldn't that be a WSACloseEvent?
> >
> Of course you are right. I have fixed this.
> 
> In reality this shouldn't make any difference since WSACreateEvent will use
> CreateEvent and the handles are therefore compatible.

Yes, I guessed so.  It's all a handle after all.  It's just cleaner to
use the expected function, though, I'm not that sure when it comes to
closesocket()...

So, that's ok to check in with a minor change in connect:

> +  if (res && !is_nonblocking () && !is_connect_pending () &&
>        WSAGetLastError () == WSAEWOULDBLOCK)

It's not your fault, it was already this way in the unpatched code
but I thought while you're at it it doesn't hurt.  Could you please
apply this as

     if (res && !is_nonblocking () && !is_connect_pending ()
         && WSAGetLastError () == WSAEWOULDBLOCK)

?  Just move the && to the beginning of the next line, that would be nice.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
