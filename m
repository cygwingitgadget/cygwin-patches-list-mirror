Return-Path: <cygwin-patches-return-5068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10902 invoked by alias); 18 Oct 2004 10:25:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10889 invoked from network); 18 Oct 2004 10:25:53 -0000
Date: Mon, 18 Oct 2004 10:25:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
Message-ID: <20041018102659.GA26101@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag> <20041015135904.GD29569@trixie.casa.cgf.cx> <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag> <20041017233423.GA8780@trixie.casa.cgf.cx> <n2m-g.ckvd9l.3vvapnt.1@buzzy-box.bavag> <20041018014629.GO29569@trixie.casa.cgf.cx> <n2m-g.ckvk3d.3vvamo1.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckvk3d.3vvamo1.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00069.txt.bz2

On Oct 18 07:13, Bas van Gompel wrote:
> 2004-10-18  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
> 
> 	* cygcheck.cc (pretty_id): Don't let i become negative. Fix
> 	printf-format.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
