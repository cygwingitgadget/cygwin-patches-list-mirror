Return-Path: <cygwin-patches-return-5044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29317 invoked by alias); 10 Oct 2004 17:13:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29306 invoked from network); 10 Oct 2004 17:13:07 -0000
Date: Sun, 10 Oct 2004 17:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041010171323.GD14377@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag> <20041009231813.GD11984@trixie.casa.cgf.cx> <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckaqe1.3vva6e9.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00045.txt.bz2

On Sun, Oct 10, 2004 at 08:36:38AM +0200, Bas van Gompel wrote:
>Op Sat, 9 Oct 2004 19:18:13 -0400 schreef Christopher Faylor
>So cygcheck will have the same problem...

Right, but cygcheck can rely on the fact that cygwin1.dll is around, at
least, if necessary.  I guess a goal could be to come up with a generic
library which did sanity checking and corrections on cygwin permissions.

>How about doing it from a (postinstall-)script?

A post-install script doesn't help if someone copied all of their stuff
to a CD-ROM and then to a new system.

We really should improve setup, too, but I still think we need this in
two places.

Maybe we could get by with just having a sanity shell script that could
be run but it still seems like it should be tied into cygcheck somehow.

Or, maybe we need a "cygfix"...

>[ChangeLog-entry]
>
>:  Checked in.  Thanks for the patch and special thanks for keeping the
>:  dialog going about your patch.  Your persistence is appreciated.
>
>Thank /you/. I was afraid you'd think I was a PITA!

Not at all.

cgf
