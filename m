Return-Path: <cygwin-patches-return-5276-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24801 invoked by alias); 23 Dec 2004 19:32:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24738 invoked from network); 23 Dec 2004 19:32:33 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 23 Dec 2004 19:32:33 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 279CE1B401; Thu, 23 Dec 2004 14:34:05 -0500 (EST)
Date: Thu, 23 Dec 2004 19:32:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still stripping
Message-ID: <20041223193405.GJ13179@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41CAF567.365C09F7@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CAF567.365C09F7@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00277.txt.bz2

On Thu, Dec 23, 2004 at 11:42:15AM -0500, Pierre A. Humblet wrote:
>In a case such as "abc..exe", the posix_path "abc." should not be
>stripped. The patch below only strips the posix path if the win32
>path was stripped. I don't think that the posix path can be empty
>in that case.
>
>2004-12-23  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.h (path_conv::set_normalized_path): Add second argument.
>	* path.cc (path_conv::check): Declare, set and use "strip_tail".
>	(path_conv::set_normalized_path): Add and use second argument,
>	replacing all tail stripping tests.
>

I'm not sure that your assumption of dot stripping is true in the first
case of set_normalized_path in build_fh_dev in dtable.cc.  I do like the
idea of letting the previously derived path_conv tail stripping test
control whether set_normalized_path does stripping or not, though.

I have grown to dislike default parameters in c++.  I'm not sure why because
I used to think they were pretty nifty.  So, I'll check in your patch minus
the default and keeping the original while loop in set_normalized_path
more or less intact.

cgf
