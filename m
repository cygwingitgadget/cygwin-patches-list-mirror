Return-Path: <cygwin-patches-return-5687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4309 invoked by alias); 8 Dec 2005 10:14:13 -0000
Received: (qmail 4291 invoked by uid 22791); 8 Dec 2005 10:14:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 08 Dec 2005 10:14:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 86051544005; Thu,  8 Dec 2005 11:14:04 +0100 (CET)
Date: Thu, 08 Dec 2005 10:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Handling non-winsock flags in fhandler_socket.cc
Message-ID: <20051208101404.GB25739@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <80fd4e750512071319r4ae0bc2fj9c0fb5b9e29c398f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fd4e750512071319r4ae0bc2fj9c0fb5b9e29c398f@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00029.txt.bz2

On Dec  7 23:19, Pekka Pessi wrote:
> Hello,
> 
>  I found a problem with sendmsg() failng when MSG_NOSIGNAL is used. It
> looks like MSG_WINMASK is used in sendto() but not in sendmsg().

Thanks for the patch.  Unfortunately it's missing a ChangeLog entry and
it didn't work OOTB since it was missing curly braces, but I took the
freedom to fix it up.  The change to fhandler_socket::recvfrom was not
necessary since flags is masked at the start of the function.  However,
maybe it comes handy to keep the original flags value at one point, so
I removed this masking at the function start.

Please note that I can take this patch only because it's relatively
small.  If you would like to send bigger patches or extensions to the
Cygwin functionality at one point, you'll have to sign a copyright
assignment form and send it to Red Hat.  Please read
http://cygwin.com/contrib.html for more details about contributing.

Other than that, patch applied with changes.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.
