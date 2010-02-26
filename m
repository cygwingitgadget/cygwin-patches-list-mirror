Return-Path: <cygwin-patches-return-6986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19779 invoked by alias); 26 Feb 2010 09:25:22 -0000
Received: (qmail 19764 invoked by uid 22791); 26 Feb 2010 09:25:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 26 Feb 2010 09:25:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CE03E6D42F5; Fri, 26 Feb 2010 10:25:15 +0100 (CET)
Date: Fri, 26 Feb 2010 09:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] check_access()
Message-ID: <20100226092515.GC8489@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KYF00GJLGK5PMO7@vms173005.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0KYF00GJLGK5PMO7@vms173005.mailsrvcs.net>
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
X-SW-Source: 2010-q1/txt/msg00102.txt.bz2

On Feb 25 21:36, Pierre A. Humblet wrote:
> This fixes problem # 3 in http://cygwin.com/ml/cygwin/2010-02/msg00330.html
> 
> Pierre
> 
> +       * security.cc (check_access): Use user.imp_token if appropriate.
> +        Set errno and return if DuplicateTokenEx fails .

Thanks for catching, please apply.

Btw., please send ChangeLog entries always as plain text, not as diff.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
