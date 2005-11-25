Return-Path: <cygwin-patches-return-5679-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30651 invoked by alias); 25 Nov 2005 01:26:25 -0000
Received: (qmail 30642 invoked by uid 22791); 25 Nov 2005 01:26:25 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 25 Nov 2005 01:26:23 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 200EE13D354; Thu, 24 Nov 2005 20:26:22 -0500 (EST)
Date: Fri, 25 Nov 2005 01:26:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
Message-ID: <20051125012622.GA12798@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43863896.4080203@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43863896.4080203@t-online.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00021.txt.bz2

On Thu, Nov 24, 2005 at 11:03:02PM +0100, Christian Franke wrote:
>unlike Linux & friends, Cygwin cannot send a SIGQUIT via keyboard.  The
>SIGQUIT key simulated in termios does only work if app reads from
>console.  Both console events ^C and ^BREAK are mapped to SIGINT.
>
>Suggest to add some option to send SIGQUIT via ^BREAK.
>
>A simple patch is attached.
>
>It sends SIGQUIT on ^BREAK if both VINTR and VQUIT are set to ^C.  As a
>positive side effect, this disables any other SIGQUIT key in termios.

Sorry but the precedent of sending SIGINT when pressing CTRL-BREAK is
long-standing behavior that I am not comfortable changing.

Thank you for the patch, though.

cgf
