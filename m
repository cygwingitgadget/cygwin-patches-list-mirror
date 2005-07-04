Return-Path: <cygwin-patches-return-5552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2860 invoked by alias); 4 Jul 2005 08:44:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2688 invoked by uid 22791); 4 Jul 2005 08:44:15 -0000
Received: from p54941b94.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.27.148)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 04 Jul 2005 08:44:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4F9E2544122; Mon,  4 Jul 2005 10:44:24 +0200 (CEST)
Date: Mon, 04 Jul 2005 08:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: cygwin_internal
Message-ID: <20050704084424.GW21074@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com> <20050701185405.GP21074@calimero.vinschen.de> <20050701191146.GB15927@trixie.casa.cgf.cx> <20050702085326.GQ21074@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702085326.GQ21074@calimero.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00007.txt.bz2

On Jul  2 10:53, Corinna Vinschen wrote:
> On Jul  1 15:11, Christopher Faylor wrote:
> > On Fri, Jul 01, 2005 at 08:54:05PM +0200, Corinna Vinschen wrote:
> > >On Jul  1 09:58, Pierre A. Humblet wrote:
> > >>The situation is that exim has the concept that some groups are
> > >>privileged and can have write access to the configuration file.  They
> > >>are normally initialized to hard values set at compile time.
> > >>
> > >>The Cygwin port of exim fakes things up so that the gid of Admins
> > >>(obtained from cygwin_internal) is put in the list of exim's privileged
> > >>groups.  The problem is that the gid obtained by cygwin_internal (from
> > >>the Admins sid) may not match the gid reported by stat, which is
> > >>obtained by cygpsid::get_id () from the same Admins sid.
> > >
> > >Ok, that makes sense.  It seems that cygserver can stumble over the
> > >same problem.
> > >
> > >Chris, is removing cygwin_regname ok with you?
> > 
> > Yep.
> 
> Please check in, Pierre.

I've checked in now.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
