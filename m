Return-Path: <cygwin-patches-return-5039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17929 invoked by alias); 9 Oct 2004 23:18:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17909 invoked from network); 9 Oct 2004 23:18:00 -0000
Date: Sat, 09 Oct 2004 23:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041009231813.GD11984@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag> <20041008001755.GK17593@trixie.casa.cgf.cx> <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck9k3i.3vvefmv.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00040.txt.bz2

On Sun, Oct 10, 2004 at 12:41:20AM +0200, Bas van Gompel wrote:
>Op Thu, 7 Oct 2004 20:17:55 -0400 schreef Christopher Faylor
>:  Of course, if someone can use cygcheck to diagnose their own problems
>:  then, that's great.  I don't see any reason to alarm someone with a
>:  warning about a minor issue like an empty path component when it
>:  is not an uncommon idiom, though.
>
>I see what you mean. I got the idea for the patch when reviewing a
>cygcheck.out which I first thought had 2 empty lines after the path.
>Further examination revealed the first of these held a TAB.
>
>I thought that was unclear. One might miss the fact there was an empty
>component.

So that should be replaced by a '.' then, not a warning.

>: > What are you planning to do? Will you revert this patch, reject the
>: > next patch and leave things as they are, or consider it when it's
>: > submitted?
>:
>:   I'm leaning to reverting the patch unless you can point me to a
>:  preponderance of email messages in the cygwin list which illustrate
>:  that this has been a common problem crying out for a warning.  Maybe
>:  I just missed something.
>
>You know there is no such thing. Would you anyhow consider the
>following patch, which just displays "." instead of the warning?

Heh.  Should have kept reading.  Yes, I like that better. I agree
that an empty line is unclear.

>:  If you are interested in adding real improvements to cygcheck, I'd
>:  suggest something to ensure that the permissions on system directories
>:  and files are sane, and maybe even a method to correct problems in that
>:  area.  That seems to be one of the biggest complaints in the mailing
>:  list.
>
>I'll see what I can do. I however doubt if this can be accomplished
>with a trivial patch. (I do have some more trivia in store...)

When I was at Red Hat, I tended to be slightly more lenient about
assignment obligations for things in the utils directory.

Corinna, do you think you could ask you-know-who if we could get a
waiver for cygcheck changes?  It doesn't seem like cygcheck provides
any core cygwin functionality.

We might even consider changing the license if Red Hat is amenable.

>(Would not corrections be misplaced in cygcheck?
>Is ensuring correct permissions not something better handled in setup?)

It should probably done in both places.  It's easy enough to screw up
permissions after setup.exe has been run and it seems like it is hard
for setup to set permissions correctly since it is not a cygwin program.

>ChangeLog-entry:
>
>2004-10-10  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (dump_sysinfo): Don't warn about empty path-
>	components, just display ``.''.

Checked in.  Thanks for the patch and special thanks for keeping the
dialog going about your patch.  Your persistence is appreciated.

cgf
