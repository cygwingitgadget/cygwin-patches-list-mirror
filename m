Return-Path: <cygwin-patches-return-5024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26718 invoked by alias); 6 Oct 2004 14:58:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26590 invoked from network); 6 Oct 2004 14:58:04 -0000
Date: Wed, 06 Oct 2004 14:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041006145805.GB29289@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00025.txt.bz2

On Wed, Oct 06, 2004 at 10:49:09AM +0200, Bas van Gompel wrote:
>Op Tue, 5 Oct 2004 16:46:49 +0200 schreef Corinna Vinschen
>in <20041005144649.GB30752@cygbert.vinschen.de>:
>
>[Empty path-components resolving to current dir.]
>
>:  Oh, interesting.  I never even thought about using an empty path.
>
>Nor I. Thw described behaviour makes the warning even more useful (when
>cygcheck is run from a command/cmd prompt).
>
>Are you applying the patch?
>
>(Maybe the message could get a ``-v'' addition like: ``This will
>resolve to the current directory when in cygwin''.)

I see that Corinna has checked this in but I really don't see the need
for a warning for a perfectly acceptable use of an empty PATH component.

Why are we bothering with this?

cgf
