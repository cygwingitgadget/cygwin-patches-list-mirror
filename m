Return-Path: <cygwin-patches-return-5831-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23242 invoked by alias); 21 Apr 2006 17:23:32 -0000
Received: (qmail 23230 invoked by uid 22791); 21 Apr 2006 17:23:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 21 Apr 2006 17:23:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 262A26D42B2; Fri, 21 Apr 2006 19:23:28 +0200 (CEST)
Date: Fri, 21 Apr 2006 17:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is initialized
Message-ID: <20060421172328.GD7685@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00019.txt.bz2

On Apr  6 12:35, Pierre A. Humblet wrote:
>        * environ.cc (getearly): New function.
>           (getenv) : Call getearly if needed.

Thanks for the patch and sorry for the loooong delay.  I've applied a
slightly tweaked version of your patch, which uses a function pointer in
getenv, instead of adding a conditional.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
