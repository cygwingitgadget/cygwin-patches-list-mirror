Return-Path: <cygwin-patches-return-5261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22464 invoked by alias); 20 Dec 2004 16:11:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22363 invoked from network); 20 Dec 2004 16:11:04 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Dec 2004 16:11:04 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4B41E1B401; Mon, 20 Dec 2004 11:12:16 -0500 (EST)
Date: Mon, 20 Dec 2004 16:11:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041220161216.GH1175@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de> <20041220151716.GA1175@trixie.casa.cgf.cx> <41C6F57E.2D058229@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C6F57E.2D058229@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00262.txt.bz2

On Mon, Dec 20, 2004 at 10:53:34AM -0500, Pierre A. Humblet wrote:
>Stripping from the Posix path can't be done during normalize_
>because it would apply to all paths (not only disk).

Why can't we just strip the dots from the path in
path_conv::set_normalized path?

cgf
