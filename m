Return-Path: <cygwin-patches-return-5264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28850 invoked by alias); 20 Dec 2004 16:52:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28763 invoked from network); 20 Dec 2004 16:51:57 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 20 Dec 2004 16:51:57 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I915IK-0000RS-M5
	for cygwin-patches@cygwin.com; Mon, 20 Dec 2004 11:51:56 -0500
Message-ID: <41C7032C.A8C9DD37@phumblet.no-ip.org>
Date: Mon, 20 Dec 2004 16:52:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx> <41C6F57E.2D058229@phumblet.no-ip.org> <20041220161216.GH1175@trixie.casa.cgf.cx> <41C6FB3D.D9990C3F@phumblet.no-ip.org> <20041220163218.GJ1175@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00265.txt.bz2



Christopher Faylor wrote:
> 
> On Mon, Dec 20, 2004 at 11:18:05AM -0500, Pierre A. Humblet wrote:
> >
> >Christopher Faylor wrote:
> >>
> >> On Mon, Dec 20, 2004 at 10:53:34AM -0500, Pierre A. Humblet wrote:
> >> >Stripping from the Posix path can't be done during normalize_
> >> >because it would apply to all paths (not only disk).
> >>
> >> Why can't we just strip the dots from the path in
> >> path_conv::set_normalized path?
> >
> >You can, after checking the device. But why do it all
> >the time if it's only needed by chdir?
> 
> It just seems more consistent and safer to do the same thing to both the
> win32 and posix paths.  chroot probably needs it too.  After removing
> the code from normalize_posix_path, this is probably not a performance
> hit.

Good points. normalize_posix_path already finds the length, so the
performance hit will be really small.

Not sure what you mean by "removing the code from normalize_posix_path".
It's still important that normalize_{posix,win32}_path strip the final 
'.' in "xxxx/.", because :check looks for a final /
 
Pierre
