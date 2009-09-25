Return-Path: <cygwin-patches-return-6648-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6990 invoked by alias); 25 Sep 2009 16:43:12 -0000
Received: (qmail 6978 invoked by uid 22791); 25 Sep 2009 16:43:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 16:43:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 010396D5598; Fri, 25 Sep 2009 18:42:56 +0200 (CEST)
Date: Fri, 25 Sep 2009 16:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Support for CJK Character Sets
Message-ID: <20090925164256.GC32422@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090403173212.51916.qmail@web4102.mail.ogk.yahoo.co.jp> <20090406110457.GA4134@calimero.vinschen.de> <4ABC3CBC.7000502@byu.net> <20090925083658.GD26348@calimero.vinschen.de> <20090925100600.GA29048@calimero.vinschen.de> <4ABCEF71.7070302@computer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABCEF71.7070302@computer.org>
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
X-SW-Source: 2009-q3/txt/msg00102.txt.bz2

On Sep 25 18:27, Thomas Wolff wrote:
>
>> Btw., it's not only 20932/EUC-JP.  The full list is 932/SJIS,
>> 936/EUC-KR, 949/GBK, 950/Big5, 20932/EUC-JP.  Probably it makes sense
>> to note all of them.
>>   
> I think, looking at other information, two have been interchanged here:
> 936 should be GBK
> 949 should be EUC-KR

Right.  My bad.  I fixed that in CVS.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
