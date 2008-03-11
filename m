Return-Path: <cygwin-patches-return-6288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16270 invoked by alias); 11 Mar 2008 18:44:13 -0000
Received: (qmail 16258 invoked by uid 22791); 11 Mar 2008 18:44:13 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Mar 2008 18:43:53 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZ9S3-0007fc-AY 	for cygwin-patches@cygwin.com; Tue, 11 Mar 2008 18:43:51 +0000
Message-ID: <47D6D2E9.7A570153@dessent.net>
Date: Tue, 11 Mar 2008 18:44:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D6A6E1.F8C89DFF@dessent.net> <20080311160116.GH18407@calimero.vinschen.de> <47D6BC47.75284EB7@dessent.net> <20080311183139.GK18407@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00062.txt.bz2

Corinna Vinschen wrote:

> Urgh.  MAX_PATH is defined with trailing 0, SYMLINK_MAX is defined
> without trailing 0 (like NAME_MAX).  You should better change the
> SYMLINK_MAX stuff back, afaics...

D'oh!  'Kay.
