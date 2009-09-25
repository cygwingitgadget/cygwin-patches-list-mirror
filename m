Return-Path: <cygwin-patches-return-6643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9024 invoked by alias); 25 Sep 2009 10:06:23 -0000
Received: (qmail 8871 invoked by uid 22791); 25 Sep 2009 10:06:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 10:06:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6ED8C6D5598; Fri, 25 Sep 2009 12:06:00 +0200 (CEST)
Date: Fri, 25 Sep 2009 10:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Support for CJK Character Sets
Message-ID: <20090925100600.GA29048@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090403173212.51916.qmail@web4102.mail.ogk.yahoo.co.jp> <20090406110457.GA4134@calimero.vinschen.de> <4ABC3CBC.7000502@byu.net> <20090925083658.GD26348@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090925083658.GD26348@calimero.vinschen.de>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00097.txt.bz2

On Sep 25 10:36, Corinna Vinschen wrote:
> On Sep 24 21:45, Eric Blake wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > According to Corinna Vinschen on 4/6/2009 5:04 AM:
> > > Please note that eucJP does not work by default on Windows XP and
> > > earlier OSes!  At least not on the so-called "western languages"
> > > installations, US, French, Italian, whatever.  The reason is that the
> > > codepage 20932 is not installed by default.  You can easily install it,
> > > though, in the "Regional and Language Options" control panel -> Advanced
> > > -> Code page conversion tables.  Just click on codepage "20932 (JIS X
> > > 0208-1990 & 0212-1990)" and have your XP installation disk ready.
> > 
> > Let's document this.
> > 
> > 2009-09-24  Eric Blake  <ebb9@byu.net>
> > 
> > 	* setup2.sgml (setup-locale-problems): Document how to install
> > 	non-default charsets.
> 
> Shoot.

Btw., it's not only 20932/EUC-JP.  The full list is 932/SJIS,
936/EUC-KR, 949/GBK, 950/Big5, 20932/EUC-JP.  Probably it makes sense
to note all of them.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
