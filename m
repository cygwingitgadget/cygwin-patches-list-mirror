Return-Path: <cygwin-patches-return-5387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25985 invoked by alias); 27 Mar 2005 23:58:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25965 invoked from network); 27 Mar 2005 23:58:45 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 27 Mar 2005 23:58:45 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id E38DA13C2E4; Sun, 27 Mar 2005 18:58:44 -0500 (EST)
Date: Sun, 27 Mar 2005 23:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: hires_ms::usecs
Message-ID: <20050327235844.GA2887@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050327151900.00b60730@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050327151900.00b60730@incoming.verizon.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00090.txt.bz2

On Sun, Mar 27, 2005 at 03:19:00PM -0500, Pierre A. Humblet wrote:
>The old test below will only detect the wraparound when "now" is
>in the interval [0, inittime_ms), so it's likely to miss if
>inittime_ms is very small (e.g. daemon starting at reboot).
>
>With the new test, the wraparound will be detected if the function
>is called at any time between the 25th and 49th day after startup.
>
>2005-03-27  Pierre Humblet <pierre.humblet@ieee.org>
>
>	*times.cc (hires_ms::usecs): Compare the difference.

Applied.

Thanks.

cgf
