Return-Path: <cygwin-patches-return-5681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19852 invoked by alias); 25 Nov 2005 16:41:42 -0000
Received: (qmail 19837 invoked by uid 22791); 25 Nov 2005 16:41:42 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 25 Nov 2005 16:41:40 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 398BD13D354; Fri, 25 Nov 2005 11:41:39 -0500 (EST)
Date: Fri, 25 Nov 2005 16:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
Message-ID: <20051125164139.GD8670@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43863896.4080203@t-online.de> <20051125012622.GA12798@trixie.casa.cgf.cx> <1EfYLi-05iS2a0@fwd29.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1EfYLi-05iS2a0@fwd29.aul.t-online.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00023.txt.bz2

On Fri, Nov 25, 2005 at 08:50:26AM +0100, Christian Franke wrote:
>Christopher Faylor wrote:
>>>[...]
>>>Suggest to add some option to send SIGQUIT via ^BREAK.
>>>
>>>A simple patch is attached.
>>>
>>>It sends SIGQUIT on ^BREAK if both VINTR and VQUIT are set to ^C.  As
>a
>>>positive side effect, this disables any other SIGQUIT key in termios.
>>
>>Sorry but the precedent of sending SIGINT when pressing CTRL-BREAK is
>>long-standing behavior that I am not comfortable changing.
>
>Agree.
>
>But the patch won't change this long standing-behavior unless the user
>opts-in via "stty quit ^C" (see testcase).
>
>So the patch shouldn't BREAK anything ;-)
>
>As an alternative, a new CYGWIN environment setting could be used.
>But using some termios setting for such an option is IMO the right thing
>to do.
>
>I missed the SIGQUIT via keyboard during the first port of smartd to
>Cygwin last year. In smartd's debug mode, SIGINT is used to reload
>configuration file, SIGQUIT to exit. This worked on every supported
>platform except Cygwin.

It is (or should be, since I haven't checked it recently) supported if you
set CYGWIN=tty, though.  There is a lot of functionality that isn't available
with the normal windows console that is available with CYGWIN=tty.  Since
the only precedent for the behavior of CTRL-BREAK is MSVCRT, I am very
reluctant to change it.

cgf
