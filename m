Return-Path: <cygwin-patches-return-6928-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9953 invoked by alias); 18 Jan 2010 09:16:27 -0000
Received: (qmail 9942 invoked by uid 22791); 18 Jan 2010 09:16:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 18 Jan 2010 09:16:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3AE396D4DA2; Mon, 18 Jan 2010 10:16:09 +0100 (CET)
Date: Mon, 18 Jan 2010 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100118091609.GN4977@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>  <20100114160953.GB26286@calimero.vinschen.de>  <20100115154203.GA5885@calimero.vinschen.de>  <036301ca961d$f1898520$870410ac@wirelessworld.airvananet.com>  <20100115202247.GG4977@calimero.vinschen.de>  <20100115203427.GH4977@calimero.vinschen.de>  <039001ca962a$5eaf9ac0$870410ac@wirelessworld.airvananet.com>  <20100115220315.GJ4977@calimero.vinschen.de>  <03ad01ca9635$788f70e0$870410ac@wirelessworld.airvananet.com>  <0KWF00L0JBBIWK15@vms173003.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0KWF00L0JBBIWK15@vms173003.mailsrvcs.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00044.txt.bz2

On Jan 17 22:35, Pierre A. Humblet wrote:
> At 05:52 PM 1/15/2010, Pierre A. Humblet wrote:
> 
> >The scenario you describe (one packet only, with a long delay between accept
> >and WSAEventSelect) could easily be tested to settle the matter.
> >Put a sleep before fdsock !
> 
> To close the matter, I have done just that, putting a 60 s sleep in
> :accept4 between the call to Windows accept and fdsock. Packet
> doesn't get lost :)
> Server:
> 2010_1_17.22:31:41 Listening
> 2010_1_17.22:32:43 Accepted
> 2010_1_17.22:32:43 Read 6 hello
> Client:
> 2010_1_17.22:31:43 Connecting to localhost
> 2010_1_17.22:31:43 Connected to localhost
> 2010_1_17.22:31:43 Written 6 hello
> 2010_1_17.22:32:58 Exiting

Cool, thank you!  So we can settle down with the Linux-behaviour in
terms of O_ASYNC.  In theory I'd like to make the base accept(2)
function behave like on Linux as well in terms of O_NONBLOCK, but
since that potentially breaks packages which erroneously expect BSD
semantics, it might be a bad idea...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
