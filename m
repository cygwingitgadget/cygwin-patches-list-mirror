Return-Path: <cygwin-patches-return-6687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6850 invoked by alias); 4 Oct 2009 19:57:41 -0000
Received: (qmail 6839 invoked by uid 22791); 4 Oct 2009 19:57:40 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 19:57:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E2A816D55B9; Sun,  4 Oct 2009 21:57:23 +0200 (CEST)
Date: Sun, 04 Oct 2009 19:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091004195723.GH4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC8F299.1020303@t-online.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00018.txt.bz2

On Oct  4 21:08, Christian Franke wrote:
> Hi Corinna,
>[...]
> Unfortunately this does not work for a typical use case: an admin process 
> creates a restricted token with standard user rights. The function 
> IsTokenRestricted() returns TRUE only if the token contains 'restricted 
> SIDs'.
> (http://msdn.microsoft.com/en-us/library/aa379137(VS.85).aspx)

Bummer.

> There is apparently no function to check whether a token is a result of 
> CreateRestrictedToken() or SaferComputeTokenFromLevel().
>
> Would'nt it be easier to add a new function 
> 'cygwin_set_restricted_token(token)' instead of the test of the token type?

The idea was to avoid another non-standard system call.  Maybe you're
right, but we should create another cygwin_internal call instead, like,
say,

  cygwin_internal (CW_SET_RESTRICTED_TOKEN, token_handle);

Since you have a copyright assignment in place anyway, would you like
to do that and change the seteuid32 call accordingly?  A bool value in
cygheap->user could store the fact that the current external token is 
a restricted token.  That would simplify the seteuid32 extension
enormously.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
