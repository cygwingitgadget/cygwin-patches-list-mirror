Return-Path: <cygwin-patches-return-5331-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20039 invoked by alias); 7 Feb 2005 09:38:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19925 invoked from network); 7 Feb 2005 09:38:24 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.111.154)
  by sourceware.org with SMTP; 7 Feb 2005 09:38:24 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 7303357D77; Mon,  7 Feb 2005 10:38:23 +0100 (CET)
Date: Mon, 07 Feb 2005 09:38:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: gethostbyname() problem?
Message-ID: <20050207093823.GV19096@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200502051240.j15CevQ32345@webmail.web-mania.com> <4205D6D1.70D38D40@dessent.net> <20050206110530.GR19096@cygbert.vinschen.de> <20050206230129.GA3512@efn.org> <20050206234458.GA2425@trixie.casa.cgf.cx> <20050207055347.GA2248@efn.org> <20050207061313.GA7852@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207061313.GA7852@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00034.txt.bz2

On Feb  7 01:13, Christopher Faylor wrote:
> On Sun, Feb 06, 2005 at 09:53:48PM -0800, Yitzchak Scott-Thoennes wrote:
> >Reentrancy isn't actually required, but no reason not to do it.  I have
> >compiled net.cc but not done any other testing.  Did I mention that
> >dup_ent is really neat?
> 
> Thank you.  That solved a few problems when I implemented it.
> 
> You'd think it would have occurred to me that you could use it in this
> context.
> 
> This is fine with me, if it is ok with Corinna.

I like it, but it's a bit over the border for a trivial patch.  I'd be
willing to let slip this through, though.  Yitzchak, any plans to send
a copyright assignment form to Red Hat?  That would be nice and would
keep me from further ticking off. ;-)

However, CVS seems to be broken somehow.  I can't check it in.  Stay
tuned.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
