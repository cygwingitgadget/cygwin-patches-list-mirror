Return-Path: <cygwin-patches-return-5144-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2693 invoked by alias); 18 Nov 2004 18:37:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2519 invoked from network); 18 Nov 2004 18:37:33 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Nov 2004 18:37:33 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 61DE11B3E5; Thu, 18 Nov 2004 13:38:03 -0500 (EST)
Date: Thu, 18 Nov 2004 18:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do more.
Message-ID: <20041118183803.GK10795@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag> <m33bz7w0hn.fsf@seneca.benny.turtle-trading.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33bz7w0hn.fsf@seneca.benny.turtle-trading.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00145.txt.bz2

On Thu, Nov 18, 2004 at 06:06:12PM +0100, Benjamin Riefenstahl wrote:
>Bas van Gompel writes:
>>+ if (fileno (stdout) != fileno (stderr) [...]
>
>I thought that fileno(stdout) is *always* 1 and fileno(stderr) is
>*always* 2.  Isn't that true?

Heh.  Yes.  I missed that.

cgf
