Return-Path: <cygwin-patches-return-5256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6466 invoked by alias); 20 Dec 2004 10:32:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6405 invoked from network); 20 Dec 2004 10:32:17 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.94)
  by sourceware.org with SMTP; 20 Dec 2004 10:32:17 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id EB5E95808F; Mon, 20 Dec 2004 11:32:16 +0100 (CET)
Date: Mon, 20 Dec 2004 10:32:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
Message-ID: <20041220103216.GM9277@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx> <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag> <20041217061932.GH26712@trixie.casa.cgf.cx> <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag> <20041217094301.GG9277@cygbert.vinschen.de> <n2m-g.cpvkqo.3vvegs9.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cpvkqo.3vvegs9.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00257.txt.bz2

On Dec 17 21:59, Bas van Gompel wrote:
> Op Fri, 17 Dec 2004 10:43:01 +0100 schreef Corinna Vinschen
> :  Hmm, if stderr is not unbuffered in mingw, then that should be fixed
> :  in mingw, shouldn't it?
> 
> I guess so...
> 
> I'll try and look into this, if noone else does.
> 
> What about the patch? It shouldn't hurt, and the flush of stderr can
> be removed, once this has been fixed in mingw.

I'd rather see a fix than a workaround, if that's possible.  You know
that the typical lifetime of a workaround is a multiple of the lifetime
of the actual problem ;-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
