Return-Path: <cygwin-patches-return-6287-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13177 invoked by alias); 11 Mar 2008 18:32:03 -0000
Received: (qmail 13166 invoked by uid 22791); 11 Mar 2008 18:32:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Mar 2008 18:31:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D20386D430A; Tue, 11 Mar 2008 19:31:39 +0100 (CET)
Date: Tue, 11 Mar 2008 18:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080311183139.GK18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D6A6E1.F8C89DFF@dessent.net> <20080311160116.GH18407@calimero.vinschen.de> <47D6BC47.75284EB7@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D6BC47.75284EB7@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00061.txt.bz2

On Mar 11 10:07, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Btw., you don't need to make the buffers MAX_PATH + 1.  MAX_PATH is
> > defined including the trailing NUL.  Existing code shows a lot of
> > irritation about this...
> 
> Oh, I wasn't even thinking of that... the reason I used MAX_PATH + 1 was
> because earlier I had written
> 
> +      static char tmp[SYMLINK_MAX + 1];
> 
> so that the following sizes would not need to be SYMLINK_MAX - 1, 
> 
> +      if (!readlink (fh, tmp, SYMLINK_MAX))
> 
> +	  strncpy (tmp, cygpath (papp, NULL), SYMLINK_MAX);
> 
> +	  strncpy (lastsep+1, ptr, SYMLINK_MAX - (lastsep-tmp));
> 
> 
> I.e. pure lazyness of wanting to type the least necessary.  But now that
> you mention it, it makes more sense to have the "- 1" than the "+ 1"
> form, so I'll change that.

Urgh.  MAX_PATH is defined with trailing 0, SYMLINK_MAX is defined
without trailing 0 (like NAME_MAX).  You should better change the
SYMLINK_MAX stuff back, afaics...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
