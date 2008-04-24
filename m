Return-Path: <cygwin-patches-return-6332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31679 invoked by alias); 24 Apr 2008 08:51:25 -0000
Received: (qmail 31662 invoked by uid 22791); 24 Apr 2008 08:51:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 24 Apr 2008 08:51:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A33006D4312; Thu, 24 Apr 2008 10:51:04 +0200 (CEST)
Date: Thu, 24 Apr 2008 08:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: wait.h
Message-ID: <20080424085104.GW23852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <480F8B7D.5080908@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480F8B7D.5080908@users.sourceforge.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q2/txt/msg00003.txt.bz2

On Apr 23 14:18, Yaakov (Cygwin Ports) wrote:
> glibc ships a <wait.h> which contains only one line:
>
> #include <sys/wait.h>
>
> I know of at least three packages that #include <wait.h> instead of
> <sys/wait.h>.  Could such a header please be added to Cygwin (preferably
> to both branches)?
>
> Patch attached; I presume this is trivial enough to not require a
> copyright assignment.

Thanks, applied.  I won't apply it to the 1.5 branch, though.  Only
really important bugfixes should go there.  1.5 DLLs are a dying species.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
