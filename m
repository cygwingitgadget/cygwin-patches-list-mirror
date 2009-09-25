Return-Path: <cygwin-patches-return-6647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30005 invoked by alias); 25 Sep 2009 16:27:40 -0000
Received: (qmail 29991 invoked by uid 22791); 25 Sep 2009 16:27:39 -0000
X-SWARE-Spam-Status: No, hits=-3.1 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (217.115.75.233)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 16:27:34 +0000
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56]) 	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id n8PGRVog006118 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Fri, 25 Sep 2009 18:27:31 +0200
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id n8PGRT48008959 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Fri, 25 Sep 2009 18:27:31 +0200
Message-ID: <4ABCEF71.7070302@computer.org>
Date: Fri, 25 Sep 2009 16:27:00 -0000
From: Thomas Wolff <towo@computer.org>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Support for CJK Character Sets
References: <20090403173212.51916.qmail@web4102.mail.ogk.yahoo.co.jp> <20090406110457.GA4134@calimero.vinschen.de> <4ABC3CBC.7000502@byu.net> <20090925083658.GD26348@calimero.vinschen.de> <20090925100600.GA29048@calimero.vinschen.de>
In-Reply-To: <20090925100600.GA29048@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00101.txt.bz2


> Btw., it's not only 20932/EUC-JP.  The full list is 932/SJIS,
> 936/EUC-KR, 949/GBK, 950/Big5, 20932/EUC-JP.  Probably it makes sense
> to note all of them.
>   
I think, looking at other information, two have been interchanged here:
936 should be GBK
949 should be EUC-KR
