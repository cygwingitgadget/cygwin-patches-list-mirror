Return-Path: <cygwin-patches-return-5060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29096 invoked by alias); 15 Oct 2004 13:58:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29075 invoked from network); 15 Oct 2004 13:58:32 -0000
Date: Fri, 15 Oct 2004 13:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
Message-ID: <20041015135904.GD29569@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00061.txt.bz2

On Fri, Oct 15, 2004 at 02:03:24PM +0200, Bas van Gompel wrote:
>ChangeLog-entry:
>
>2004-10-15  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (pretty_id): Don't exit, return. Correct layout.

Thanks.  I've checked in a variation of this patch.

I don't see any reason to guard against n being zero or to negate
sz repeatedly inside of a loop.

cgf
