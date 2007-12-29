Return-Path: <cygwin-patches-return-6213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25562 invoked by alias); 29 Dec 2007 17:04:19 -0000
Received: (qmail 25552 invoked by uid 22791); 29 Dec 2007 17:04:19 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 17:04:15 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 393032B352; Sat, 29 Dec 2007 12:04:13 -0500 (EST)
Date: Sat, 29 Dec 2007 17:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Export fast *rint* functions
Message-ID: <20071229170412.GA24999@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx> <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00065.txt.bz2

On Sat, Dec 29, 2007 at 11:26:45AM -0000, Dave Korn wrote:
>
>  One quick Christmas break later.... hope everyone's had a nice week...
>
>
>On 21 December 2007 23:41, Christopher Faylor wrote:
>
>> Unless I don't know something about these functions, I don't think there
>> is any reason to add a foo and a _foo.  We haven't been doing that in
>> cygwin.din for years.
>
>  Righto, I didn't know that; I just copied the existing pattern.  Revised patch
>attached.
>
>2007-12-29  Dave Korn  <dave.korn@artimi.com>
>
>	* cygwin.din (_f_llrint, _f_llrintf, _f_llrintl, _f_lrint, _f_lrintf,
>	_f_lrintl, _f_rint, _f_rintf, _f_rintl):  Export fast *rint* functions.
>	(lrint, lrintf, rint, rintf):  Redirect exports to alias _f_ versions.
>	(llrint, llrintf, llrintl, lrintl, rintl):  Add exports aliasing _f_*
>	versions likewise.

I assume that the above comment about aliasing needs to know right?  Otherwise,
this is fine.

cgf
