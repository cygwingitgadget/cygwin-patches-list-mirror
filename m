Return-Path: <cygwin-patches-return-7395-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10162 invoked by alias); 24 May 2011 10:09:53 -0000
Received: (qmail 10056 invoked by uid 22791); 24 May 2011 10:09:32 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 24 May 2011 10:09:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A38F82CB9E4; Tue, 24 May 2011 12:09:16 +0200 (CEST)
Date: Tue, 24 May 2011 10:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix perror POSIX compliance
Message-ID: <20110524100916.GA5509@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DDAEDA4.9030005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DDAEDA4.9030005@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00161.txt.bz2

On May 23 17:28, Eric Blake wrote:
> This depends on the newlib patch:
> http://sourceware.org/ml/newlib/2011/msg00215.html
> 
> In fact, if that patch goes in, then this one is required to avoid a
> link failure; this one can probably go in first but makes no difference
> to perror without the newlib patch.

You can apply this together with the newlib patch.  But please
make sure that you also tested the newlib-only implementation.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
