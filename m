Return-Path: <cygwin-patches-return-5199-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12340 invoked by alias); 13 Dec 2004 20:24:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12085 invoked from network); 13 Dec 2004 20:24:07 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 13 Dec 2004 20:24:07 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 2D67D1B401; Mon, 13 Dec 2004 15:25:05 -0500 (EST)
Date: Mon, 13 Dec 2004 20:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041213202505.GB27768@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041205010020.GA20101@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00200.txt.bz2

With the current CVS, I am seeing the same (suboptimal) behavior on
Windows Me that I do in 1.5.12.

If I type a bunch of "sleep 60&" at the command line, then "bash" won't
exit until the last sleep 60 has terminated.  I can't explain why this
is.  It doesn't work that way on XP, of course.

While "bash" is waiting, I see no sign of it in the process table so
it's odd behavior.

The current CVS should work better with exim now, though.

cgf
