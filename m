Return-Path: <cygwin-patches-return-5230-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25217 invoked by alias); 17 Dec 2004 03:26:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25128 invoked from network); 17 Dec 2004 03:26:12 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 03:26:12 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 6AE701B401; Thu, 16 Dec 2004 22:27:21 -0500 (EST)
Date: Fri, 17 Dec 2004 03:26:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041217032721.GA28985@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217032627.GF26712@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00231.txt.bz2

On Thu, Dec 16, 2004 at 10:26:27PM -0500, Christopher Faylor wrote:
>I don't see how it could be correct for the slash checking code not to
>be "in the loop".  Won't this cause a problem if you've done

Ah, nevermind.  I see that your patch handles that.

cgf
