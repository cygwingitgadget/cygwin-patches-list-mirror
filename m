Return-Path: <cygwin-patches-return-5215-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11385 invoked by alias); 16 Dec 2004 16:02:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10911 invoked from network); 16 Dec 2004 16:01:16 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.93)
  by sourceware.org with SMTP; 16 Dec 2004 16:01:16 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 0B4F8580C7; Thu, 16 Dec 2004 17:03:22 +0100 (CET)
Date: Thu, 16 Dec 2004 16:02:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216160322.GC16474@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216155707.GG23488@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00216.txt.bz2

On Dec 16 10:57, Christopher Faylor wrote:
> On Thu, Dec 16, 2004 at 04:53:39PM +0100, Corinna Vinschen wrote:
> >Since the mount code is called from path_conv anyway, wouldn't it be
> >better to pass the information "managed mount or not" up to path_conv?
> 
> How about just doing the pathname munging in `conv_to_win32_path' if/when
> it's needed?

Erm... I'm not quite sure, but didn't the "remove trailing dots and spaces"
code start there and has been moved to path_conv by Pierre to circumvent
some problem?  I recall only very vaguely right now.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
