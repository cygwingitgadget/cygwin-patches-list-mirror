Return-Path: <cygwin-patches-return-5227-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8248 invoked by alias); 17 Dec 2004 03:07:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7512 invoked from network); 17 Dec 2004 03:07:08 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 03:07:08 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 589271B4C4; Thu, 16 Dec 2004 22:08:16 -0500 (EST)
Date: Fri, 17 Dec 2004 03:07:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: Another attempt to patch path.cc for trailing dots
Message-ID: <20041217030816.GA28805@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <0I8U00B7YA5G0E@pmismtp02.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0I8U00B7YA5G0E@pmismtp02.mcilink.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00228.txt.bz2

On Thu, Dec 16, 2004 at 04:48:52PM -0700, Mark Paulus wrote:
>	* path.cc (path_conv::check): retain trailing dots and spaces
>	* path.cc (mount_item::build_win32):  strip trailing dots and spaces for 
>	unmanaged filesystems

Thanks for the effort.  You're working on some of the most complicated code
in cygwin.

However, I'd prefer not to add extra loops at this point, if I can help
it, or add extra burden to the common case of non-managed mode for the
the uncommon case of managed mode.

I have things set up in my sandbox so that the tail information is
passed to the appropriate routine which will recreate trailing dots
if needed.  I'm just running cygwin through the test suite to make
sure I didn't make any egregious mistakes.

cgf
