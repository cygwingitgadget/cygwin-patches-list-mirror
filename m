Return-Path: <cygwin-patches-return-5153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25887 invoked by alias); 20 Nov 2004 23:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25874 invoked from network); 20 Nov 2004 23:28:47 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Nov 2004 23:28:47 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 11C311B3E5; Sat, 20 Nov 2004 18:29:25 -0500 (EST)
Date: Sat, 20 Nov 2004 23:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] debug_printf edits
Message-ID: <20041120232925.GI2765@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041120142737.0081a430@incoming.verizon.net> <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net> <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net> <3.0.5.32.20041120142737.0081a430@incoming.verizon.net> <3.0.5.32.20041120145103.00833bf0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041120145103.00833bf0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00154.txt.bz2

On Sat, Nov 20, 2004 at 02:51:03PM -0500, Pierre A. Humblet wrote:
>Strictly speaking the syscall_printf in fhandler_pipe::create should be
>removed, and reintroduced in both pipe and _pipe, but I thought this
>would be going overboard.

Ok.  Thanks for the clarification.  Go ahead and check this in.

It's funny that you should be doing this because I've been thinking
about sending email to cygwin-developers musing about cleaning up and
regularizing strace output.

cgf
