Return-Path: <cygwin-patches-return-5021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5976 invoked by alias); 6 Oct 2004 09:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5967 invoked from network); 6 Oct 2004 09:48:34 -0000
Date: Wed, 06 Oct 2004 09:48:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041006094939.GS6702@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com> <20041005143458.GB13719@trixie.casa.cgf.cx> <20041005144649.GB30752@cygbert.vinschen.de> <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ck0h06.3vvequf.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00022.txt.bz2

On Oct  6 10:49, Bas van Gompel wrote:
> Op Tue, 5 Oct 2004 16:46:49 +0200 schreef Corinna Vinschen
> in <20041005144649.GB30752@cygbert.vinschen.de>:
> 
> [Empty path-components resolving to current dir.]
> 
> :  Oh, interesting.  I never even thought about using an empty path.
> 
> Nor I. Thw described behaviour makes the warning even more useful (when
> cygcheck is run from a command/cmd prompt).
> 
> Are you applying the patch?

I did, but I'm wondering if a check for relative paths wouldn't be
more useful.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
