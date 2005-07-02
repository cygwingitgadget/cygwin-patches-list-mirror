Return-Path: <cygwin-patches-return-5550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2468 invoked by alias); 2 Jul 2005 08:53:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2432 invoked by uid 22791); 2 Jul 2005 08:53:18 -0000
Received: from p549412f4.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.18.244)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 02 Jul 2005 08:53:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EA9686D4235; Sat,  2 Jul 2005 10:53:26 +0200 (CEST)
Date: Sat, 02 Jul 2005 08:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: cygwin_internal
Message-ID: <20050702085326.GQ21074@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com> <20050701185405.GP21074@calimero.vinschen.de> <20050701191146.GB15927@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701191146.GB15927@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00005.txt.bz2

On Jul  1 15:11, Christopher Faylor wrote:
> On Fri, Jul 01, 2005 at 08:54:05PM +0200, Corinna Vinschen wrote:
> >On Jul  1 09:58, Pierre A. Humblet wrote:
> >>The situation is that exim has the concept that some groups are
> >>privileged and can have write access to the configuration file.  They
> >>are normally initialized to hard values set at compile time.
> >>
> >>The Cygwin port of exim fakes things up so that the gid of Admins
> >>(obtained from cygwin_internal) is put in the list of exim's privileged
> >>groups.  The problem is that the gid obtained by cygwin_internal (from
> >>the Admins sid) may not match the gid reported by stat, which is
> >>obtained by cygpsid::get_id () from the same Admins sid.
> >
> >Ok, that makes sense.  It seems that cygserver can stumble over the
> >same problem.
> >
> >Chris, is removing cygwin_regname ok with you?
> 
> Yep.

Please check in, Pierre.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
