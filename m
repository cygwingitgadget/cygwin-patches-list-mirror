Return-Path: <cygwin-patches-return-5290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11356 invoked by alias); 24 Dec 2004 15:39:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11326 invoked from network); 24 Dec 2004 15:39:25 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 24 Dec 2004 15:39:25 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3AC8A1B4C2; Fri, 24 Dec 2004 10:40:59 -0500 (EST)
Date: Fri, 24 Dec 2004 15:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041224154059.GD22966@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org> <41C9C088.9E9B16E3@phumblet.no-ip.org> <3.0.5.32.20041223182306.00824b60@incoming.verizon.net> <3.0.5.32.20041223215420.0082b790@incoming.verizon.net> <3.0.5.32.20041223230550.0081e100@incoming.verizon.net> <3.0.5.32.20041223235959.0081ba80@incoming.verizon.net> <3.0.5.32.20041224084029.00825100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041224084029.00825100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00291.txt.bz2

On Fri, Dec 24, 2004 at 08:40:29AM -0500, Pierre A. Humblet wrote:
>At 12:54 AM 12/24/2004 -0500, Pierre A. Humblet wrote:
>I think the way out is as follows:
>Toward the end of spawn_guts:
>
>ciresrv.sync (myself, INFINITE);   [always]
>
>if (wait_for_myself)
>   waitpid (myself->pid, &dummy, 0);
> [For clarity, these two lines should be brought down
>  inside the case _P_OVERLAY: ]

Yes, I thought of this last night as I was trying to sleep.  It also
dawned on me that I need to synchronize wr_proc_pipe any time it is
used.  Otherwise an exec followed by a quick SIGSTOP may not work.

I almost got up to make these changes but, instead, I just dreamed
about them all night and had a crappy night's sleep.

The change to pinfo::exit didn't occur to me but it is logical.  I
have made that change.

cgf
