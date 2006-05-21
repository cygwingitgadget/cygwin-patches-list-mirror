Return-Path: <cygwin-patches-return-5861-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8418 invoked by alias); 21 May 2006 21:06:13 -0000
Received: (qmail 6381 invoked by uid 22791); 21 May 2006 21:05:57 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 21:04:45 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 3499A13C01F; Sun, 21 May 2006 17:04:44 -0400 (EDT)
Date: Sun, 21 May 2006 21:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Getting the pipe guard
Message-ID: <20060521210444.GA25110@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com> <20060521052641.GA17087@trixie.casa.cgf.cx> <ba40711f0605210754s7a10f603k79d883f4b1b6748d@mail.gmail.com> <ba40711f0605210756l74ecdd59qc0c6eff214b54fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605210756l74ecdd59qc0c6eff214b54fb4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00049.txt.bz2

On Sun, May 21, 2006 at 10:56:53AM -0400, Lev Bishop wrote:
>>On 5/21/06, Christopher Faylor wrote:
>>
>>> I've checked in a variation of the above plus some modifications to
>>> pipe.cc which prevent some handle stomping and may make things work
>>> better.
>
>Did you actually check in a change to select.cc? I'm not seeing it.
>(But I'm not all that good with cvs so maybe it's my fault)

Oops.  No.  I've checked this in along with some more changes which deal
with handle inheritance.  I decided that the way I dealt with
inheritance originally was probably best.

cgf
