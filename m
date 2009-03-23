Return-Path: <cygwin-patches-return-6453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3882 invoked by alias); 23 Mar 2009 08:46:05 -0000
Received: (qmail 3868 invoked by uid 22791); 23 Mar 2009 08:46:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 Mar 2009 08:45:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BF7006D54DB; Mon, 23 Mar 2009 09:45:42 +0100 (CET)
Date: Mon, 23 Mar 2009 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <sys/un.h> uses strlen from <string.h>
Message-ID: <20090323084542.GA30735@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49C70438.10403@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49C70438.10403@users.sourceforge.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00051.txt.bz2

On Mar 22 22:38, Yaakov S wrote:
>     * include/sys/un.h: #include <string.h> for strlen.

Patch applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
