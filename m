Return-Path: <cygwin-patches-return-5333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11682 invoked by alias); 7 Feb 2005 15:45:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11641 invoked from network); 7 Feb 2005 15:45:10 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.111.154)
  by sourceware.org with SMTP; 7 Feb 2005 15:45:10 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 2DEA257D77; Mon,  7 Feb 2005 16:45:09 +0100 (CET)
Date: Mon, 07 Feb 2005 15:45:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: gethostbyname() problem?
Message-ID: <20050207154509.GE19096@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200502051240.j15CevQ32345@webmail.web-mania.com> <4205D6D1.70D38D40@dessent.net> <20050206110530.GR19096@cygbert.vinschen.de> <20050206230129.GA3512@efn.org> <20050206234458.GA2425@trixie.casa.cgf.cx> <20050207055347.GA2248@efn.org> <20050207061313.GA7852@trixie.casa.cgf.cx> <20050207093823.GV19096@cygbert.vinschen.de> <20050207153739.GA8035@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207153739.GA8035@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00036.txt.bz2

On Feb  7 10:37, Christopher Faylor wrote:
> On Mon, Feb 07, 2005 at 10:38:23AM +0100, Corinna Vinschen wrote:
> >On Feb  7 01:13, Christopher Faylor wrote:
> >> On Sun, Feb 06, 2005 at 09:53:48PM -0800, Yitzchak Scott-Thoennes wrote:
> >> >Reentrancy isn't actually required, but no reason not to do it.  I have
> >> >compiled net.cc but not done any other testing.  Did I mention that
> >> >dup_ent is really neat?
> >> 
> >> Thank you.  That solved a few problems when I implemented it.
> >> 
> >> You'd think it would have occurred to me that you could use it in this
> >> context.
> >> 
> >> This is fine with me, if it is ok with Corinna.
> >
> >I like it, but it's a bit over the border for a trivial patch.  I'd be
> >willing to let slip this through, though.  Yitzchak, any plans to send
> >a copyright assignment form to Red Hat?  That would be nice and would
> >keep me from further ticking off. ;-)
> >
> >However, CVS seems to be broken somehow.  I can't check it in.  Stay
> >tuned.
> 
> I wanted to find out what was wrong with CVS, so I just tried checking this
> in.  I had no problems fortunately (or unfortunately, depending on how you
> look at it).

Weird.  No it works again.  When I tried it this morning, I got strange
messages (which I neither saved nor recall unfortunately).  I was unable
to access you latest patches and I was unable to checkout a fresh copy
of winsup.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
