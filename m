Return-Path: <cygwin-patches-return-5035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26685 invoked by alias); 8 Oct 2004 00:18:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26649 invoked from network); 8 Oct 2004 00:17:57 -0000
Date: Fri, 08 Oct 2004 00:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041008001755.GK17593@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag> <20041006145805.GB29289@trixie.casa.cgf.cx> <n2m-g.ck2ctr.3vshr73.1@buzzy-box.bavag> <20041007021558.GL2722@trixie.casa.cgf.cx> <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck4jdl.3vsg21n.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00036.txt.bz2

On Fri, Oct 08, 2004 at 01:42:05AM +0200, Bas van Gompel wrote:
>: > :  Why are we bothering with this?
>: >
>: > If I may attempt to answer this one... Many people may not know of
>: > this usage, yet may have their windows path ending on a ';'.
>:
>:   I'm sure the same thing is true on UNIX and yet it has survived for
>:  years without a unicheck program informing people of this fact.
>
>There are no windows paths in UNIX, and there is no unicheck program
>for any purpose. Does this mean cygcheck should be removed?

We're talking about paths, not "Windows paths".

Cygcheck was invented as a bug reporting adjunct so that we wouldn't
have to keep asking people to send us the output of the mount command
and the which command and the env command, etc.  There are similar
programs on linux.  The name of the one that Red Hat uses escapes me
but, in Red Hat tech support, it was standard procedure to ask people to
include output from this program in their bug reports.

Of course, if someone can use cygcheck to diagnose their own problems
then, that's great.  I don't see any reason to alarm someone with a
warning about a minor issue like an empty path component when it
is not an uncommon idiom, though.

>What are you planning to do? Will you revert this patch, reject the
>next patch and leave things as they are, or consider it when it's
>submitted?

I'm leaning to reverting the patch unless you can point me to a
preponderance of email messages in the cygwin list which illustrate
that this has been a common problem crying out for a warning.  Maybe
I just missed something.

If you are interested in adding real improvements to cygcheck, I'd
suggest something to ensure that the permissions on system directories
and files are sane, and maybe even a method to correct problems in that
area.  That seems to be one of the biggest complaints in the mailing
list.

cgf
