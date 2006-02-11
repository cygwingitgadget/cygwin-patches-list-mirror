Return-Path: <cygwin-patches-return-5742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5482 invoked by alias); 11 Feb 2006 00:09:13 -0000
Received: (qmail 5472 invoked by uid 22791); 11 Feb 2006 00:09:12 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 11 Feb 2006 00:09:12 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id DC06313C0F8; Fri, 10 Feb 2006 19:09:10 -0500 (EST)
Date: Sat, 11 Feb 2006 00:09:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: clock_[get|set]time timespec conversions
Message-ID: <20060211000910.GA17732@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0602101743300.1780@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0602101743300.1780@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00051.txt.bz2

On Fri, Feb 10, 2006 at 05:53:45PM -0600, Brian Ford wrote:
>2006-02-10  Brian Ford  <Brian.Ford@FlightSafety.com>
>
>	* times.cc (clock_gettime): Properly convert ms period to struct
>	timespec.
>	(clock_settime): Likewise reverse convert.
>

Applied.  I changed the ChangeLog entery to be, IMO, slightly more
informative, however.

cgf
