Return-Path: <cygwin-patches-return-5326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28316 invoked by alias); 28 Jan 2005 15:18:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28279 invoked from network); 28 Jan 2005 15:18:16 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 28 Jan 2005 15:18:16 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id IB196E-0000K1-PC
	for cygwin-patches@cygwin.com; Fri, 28 Jan 2005 10:18:14 -0500
Message-ID: <41FA57B6.97EA62CB@phumblet.no-ip.org>
Date: Fri, 28 Jan 2005 15:18:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fs_info::update
References: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net> <20050128094524.GY31117@cygbert.vinschen.de> <41FA5600.FD6CE295@phumblet.no-ip.org> <20050128151453.GB10301@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q1/txt/msg00029.txt.bz2



Christopher Faylor wrote:
> 
> On Fri, Jan 28, 2005 at 10:10:56AM -0500, Pierre A. Humblet wrote:
> >Corinna Vinschen wrote:
> >>This looks pretty much like a band-aid.  I can see the use for checking
> >>the last error code, but shouldn't Cygwin opt for safety and not assume
> >>ACLs?  Also, if there's no right to read a remote drive, there might be
> >>a good reason for that, which doesn't necessarily mean the drive has
> >>acls.
> >>
> >>After all, the effect of chmod -r can be reverted with Windows own
> >>means.
> >
> >Background: I noticed all of that when testing the
> >SetCurrentDirectory("c:\\").  Took me a while to understand why chmod
> >stopped working.  On XP HOME there is no security gui, so I had to use
> >cacls.  Not nice.
> 
> Are you saying this is somehow a side-effect of
> SetCurrentDirectory("c:\\") in exit()?  I can't imagine how that change
> could cause this behavior.

No, no. I was checking that the rmdir bug would come back if I removed
access to c:\ (It did).

Pierre
