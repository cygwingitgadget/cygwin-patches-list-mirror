Return-Path: <cygwin-patches-return-5262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31174 invoked by alias); 20 Dec 2004 16:18:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30581 invoked from network); 20 Dec 2004 16:18:07 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 20 Dec 2004 16:18:07 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I913Y5-0000O9-AU
	for cygwin-patches@cygwin.com; Mon, 20 Dec 2004 11:18:05 -0500
Message-ID: <41C6FB3D.D9990C3F@phumblet.no-ip.org>
Date: Mon, 20 Dec 2004 16:18:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx> <41C6F57E.2D058229@phumblet.no-ip.org> <20041220161216.GH1175@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00263.txt.bz2



Christopher Faylor wrote:
> 
> On Mon, Dec 20, 2004 at 10:53:34AM -0500, Pierre A. Humblet wrote:
> >Stripping from the Posix path can't be done during normalize_
> >because it would apply to all paths (not only disk).
> 
> Why can't we just strip the dots from the path in
> path_conv::set_normalized path?

You can, after checking the device. But why do it all
the time if it's only needed by chdir?

Pierre
