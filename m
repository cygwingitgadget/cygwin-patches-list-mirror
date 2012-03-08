Return-Path: <cygwin-patches-return-7617-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7021 invoked by alias); 8 Mar 2012 14:57:16 -0000
Received: (qmail 6953 invoked by uid 22791); 8 Mar 2012 14:56:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 08 Mar 2012 14:56:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B6E582C006E; Thu,  8 Mar 2012 15:56:34 +0100 (CET)
Date: Thu, 08 Mar 2012 14:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: avoid calling strlen() twice in readlink()
Message-ID: <20120308145634.GA31783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>
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
X-SW-Source: 2012-q1/txt/msg00040.txt.bz2

On Mar  8 14:37, VÃ¡clav Zeman wrote:
> Hi.
> 
> Here is a tiny patch to avoid calling strlen() twice in readlink().
> 
> ChangeLog:
> 
> 2012-03-08  VÃ¡clav Zeman  <...>
> 
>         * path.cc (readlink): Avoid calling strlen() twice.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
