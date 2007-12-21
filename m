Return-Path: <cygwin-patches-return-6208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11954 invoked by alias); 21 Dec 2007 23:41:16 -0000
Received: (qmail 11944 invoked by uid 22791); 21 Dec 2007 23:41:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 23:41:04 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 809EA13C312; Fri, 21 Dec 2007 18:41:02 -0500 (EST)
Date: Fri, 21 Dec 2007 23:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: Cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: Export fast *rint* functions
Message-ID: <20071221234102.GA23118@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin patches <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00060.txt.bz2

On Fri, Dec 21, 2007 at 06:46:06PM -0000, Dave Korn wrote:
>
>    Hi gang,
> 
>  This patch exports all the new _f_*rint* functions from newlib, adds aliases for
>the non-_f_* names, and redirects the exports for the existing functions
>(rint/rintf/lrint/lrintf) away from the current slow soft float implementation and
>toward the _f_ versions.  The slow soft float implementation is still linked
>internally in the dll against some functions such as nearbyint(), pow(), powf(), and
>a few others.
>
>  As far as I can see, there's no reason not to get rid of the old slow soft-float
>implementations altogether, and that will be the subject of a follow-on patch to
>newlib, but it'll have to wait for Jeff to get back from holiday now.
>
>  Oh, and Happy Christmas! to the MPlayer and ffmpeg teams :)
>
>winsup/cygwin/ChangeLog
>
>2007-12-21  Dave Korn  <dave.korn@artimi.com>
>
>	* cygwin.din (_f_lrint, __f_lrint, _f_lrintf, __f_lrintf, _f_lrintl,
>	__f_lrintl, _f_llrint, __f_llrint, _f_llrintf, __f_llrintf,
>	_f_llrintl, __f_llrintl, _f_rint, __f_rint, _f_rintf, __f_rintf,
>	_f_rintl, __f_rintl):  Export fast *rint* functions.
>	(lrint, lrintf, rint, _rint, rintf, _rintf):  Redirect exports to
>	alias _f_ versions.
>	(_lrint, _lrintf):  Added for consistency at the same time.
>	(lrintl, _lrintl, llrint, _llrint, llrintf, _llrintf, llrintl,
>	_llrintl, rintl, _rintl):  Add exports aliasing _f_ versions likewise.

Unless I don't know something about these functions, I don't think there
is any reason to add a foo and a _foo.  We haven't been doing that in
cygwin.din for years.

cgf
