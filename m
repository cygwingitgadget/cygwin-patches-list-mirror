Return-Path: <cygwin-patches-return-5006-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14581 invoked by alias); 5 Oct 2004 02:10:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14350 invoked from network); 5 Oct 2004 02:10:25 -0000
Date: Tue, 05 Oct 2004 02:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] pinfo.cc: second CreatePipe, not first.
Message-ID: <20041005021043.GA7897@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjt3mt.3vvcq0n.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cjt3mt.3vvcq0n.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00007.txt.bz2

On Tue, Oct 05, 2004 at 03:49:20AM +0200, Bas van Gompel wrote:
>Hi,
>
>Looking over pinfo.cc, I saw that the debugging-output on
>_pinfo::commune_send is awkward. This (trivial again, IMHO)
>patch changes that.
>
>
>Changelog-entry:
>
>2004-10-05  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* pinfo.cc (_pinfo::commune_send): Make debugging output less ambiguous.

I've applied this patch.  Thanks.

I used a slightly less ambiguous ChangeLog, though. :-)

cgf
