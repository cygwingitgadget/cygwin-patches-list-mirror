Return-Path: <cygwin-patches-return-5226-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31968 invoked by alias); 17 Dec 2004 02:55:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31825 invoked from network); 17 Dec 2004 02:54:58 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 02:54:58 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 293B81B401; Thu, 16 Dec 2004 21:56:07 -0500 (EST)
Date: Fri, 17 Dec 2004 02:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
Message-ID: <20041217025607.GE26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00227.txt.bz2

On Fri, Dec 17, 2004 at 03:51:47AM +0100, Bas van Gompel wrote:
>Op Thu, 16 Dec 2004 21:02:05 -0500 schreef Christopher Faylor
>in <20041217020205.GA26712@trixie.casa.cgf.cx>:
>:  On Fri, Dec 17, 2004 at 02:04:40AM +0100, Buzz wrote:
>: > Here is another attempt at making eprintf a usable/used function in
>: > cygcheck. It this time just flushes stdout and stderr before/after
>: > output on stderr, when both (stdout and stderr) are ttys.
>
>[...]
>
>:  I'm still not sure what you're hoping to accomplish with this.  I haven't
>:  seen any problems with flushing in cygcheck and I wouldn't expect any
>:  since the flushing should be automatic if stdout is a "tty".
>
>I seem to be making a mess here... The point is to have the error-messages
>appear at about the appropriate point in the output, not bunched together
>near the beginning or end. Here is another attempt. This time, do the
>flushing when both are ttys or neither are.

I still don't see the point.  There is no need to do explicit flushes if
both stdout and stderr are ttys.  In the case of stdout the flush should
occur every time there's a newline.  In the case of stderr, the flush
should happen after every write.

cgf
