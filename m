Return-Path: <cygwin-patches-return-5388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26281 invoked by alias); 27 Mar 2005 23:59:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26260 invoked from network); 27 Mar 2005 23:58:59 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 27 Mar 2005 23:58:59 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 30AE313C2E5; Sun, 27 Mar 2005 18:58:59 -0500 (EST)
Date: Sun, 27 Mar 2005 23:59:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] hires.h
Message-ID: <20050327235859.GB2887@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050327145927.00b60730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050327145927.00b60730@incoming.verizon.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00091.txt.bz2

On Sun, Mar 27, 2005 at 02:59:27PM -0500, Pierre A. Humblet wrote:
>        * timer.cc (nanosleep): Treat tv_sec < 0 as invalid.
>
>Should be in signal.cc. But then I thought I had covered that case way
>back. Turns out the root cause is in hires.h. With this patch, the nanosleep
>patch can be reverted.
>
>2005-03-27  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* hires.h: Add parentheses to HIRES_DELAY_MAX.

Applied.

Thanks.

cgf
