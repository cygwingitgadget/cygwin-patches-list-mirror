Return-Path: <cygwin-patches-return-5033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8779 invoked by alias); 7 Oct 2004 02:15:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8717 invoked from network); 7 Oct 2004 02:15:54 -0000
Date: Thu, 07 Oct 2004 02:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041007021558.GL2722@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00034.txt.bz2

On Thu, Oct 07, 2004 at 04:05:14AM +0200, Bas van Gompel wrote:
>Op Wed, 6 Oct 2004 10:58:05 -0400 schreef Christopher Faylor
>in <20041006145805.GB29289@trixie.casa.cgf.cx>:
>:  On Wed, Oct 06, 2004 at 10:49:09AM +0200, Bas van Gompel wrote:
>
>[Empty path-components resolving to current dir.]
>
>: > (Maybe the message could get a ``-v'' addition like: ``This will
>: > resolve to the current directory when in cygwin''.)
>
>s/-v/-h/. (I'm waiting for the other (trailing slash) patch to be
>applied or rejected, before submitting this.)

I missed the part about the warning before but I *really* don't think we
need to warn the user about standard UNIX behavior in cygcheck.  That is
really not what's for.

>:  I see that Corinna has checked this in but I really don't see the need
>:  for a warning for a perfectly acceptable use of an empty PATH component.
>:
>:  Why are we bothering with this?
>
>If I may attempt to answer this one... Many people may not know of
>this usage, yet may have their windows path ending on a ';'.

I'm sure the same thing is true on UNIX and yet it has survived for
years without a unicheck program informing people of this fact.

cgf
