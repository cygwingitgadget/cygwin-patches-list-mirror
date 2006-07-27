Return-Path: <cygwin-patches-return-5947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18502 invoked by alias); 27 Jul 2006 09:18:58 -0000
Received: (qmail 18469 invoked by uid 22791); 27 Jul 2006 09:18:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 27 Jul 2006 09:18:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2C9006D42F4; Thu, 27 Jul 2006 11:18:49 +0200 (CEST)
Date: Thu, 27 Jul 2006 09:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [send|recv]msg tidy
Message-ID: <20060727091849.GA24564@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607262142390.2228@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607262142390.2228@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00042.txt.bz2

On Jul 26 22:03, Brian Ford wrote:
> 	* fhandler_socket.cc (fhandler_socket::recvmsg): Remove unused tot
> 	argument.  All callers changed.
> 	(fhandler_socket::sendmsg): Likewise.
> 	* net.cc (cygwin_recvmsg): Likewise.
> 	(cygwin_sendmsg): Likewise, and prevent calling sendmsg whith an
> 	invalid iovec.
> 	* fhandler.h (fhandler_socket::recvmsg): Adjust prototype.
> 	(fhandler_socket::sendmsg): Likewise.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
