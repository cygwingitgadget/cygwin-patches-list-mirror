Return-Path: <cygwin-patches-return-5142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15494 invoked by alias); 18 Nov 2004 15:21:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15424 invoked from network); 18 Nov 2004 15:21:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Nov 2004 15:21:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id BA6771B3E5; Thu, 18 Nov 2004 10:22:06 -0500 (EST)
Date: Thu, 18 Nov 2004 15:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do more.
Message-ID: <20041118152206.GD10795@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00143.txt.bz2

On Thu, Nov 18, 2004 at 09:52:04AM +0100, Bas van Gompel wrote:
>Hi,
>
>This patch enables eprintf. It also causes stdout and stderr to be
>synchronzied (using fflush) when they refer to the same file-descriptor.
>
>Also, when stdout and stderr have a different number, and stdout is not
>a tty, the error-message is copied to stdout, allowing it to be easily
>captured in a cygcheck.out.
>
>(I'm aware that generally it is a bad idea to do things like this, but
>cygcheck being what it is, I think this ought to be an exception.)

I think the generally bad idea is a bad idea for a reason.

If we are going to redirect stuff like this, why not just forego the use
of stderr entirely and use stdout for all messages?

Also, rather than explicitly flushing, why not just set setbuf (stdout, NULL)
setbuf (stderr, NULL) in main()?

cgf
