Return-Path: <cygwin-patches-return-1517-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 28051 invoked by alias); 26 Nov 2001 12:14:58 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 27998 invoked from network); 26 Nov 2001 12:14:56 -0000
Message-ID: <3C02323E.ACFEECF0@syntrex.com>
Date: Mon, 15 Oct 2001 19:29:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class
References: <3BFE8631.AFC9AEF6@syntrex.com> <08ae01c17454$ef204970$0200a8c0@lifelesswks>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00049.txt.bz2

Robert Collins wrote:
> 
> 
> A few points ...

[ snip ]

> auth may be needed. Also something is needed to pass through a ftp url
> via http proxy request .. something like
> http://proxyusername:proxypassword@proxyaddress:port/ftp://ftpuser:ftppa
> ss@ftpsite.com/bar is a minor variation from the HTTP RFC and should be
> easily parseable. The http code will need to understand what urls' if
> can proxy  - as you'd expect :].

Where do you read this from ? rfc2068 ? Can you point me to the right
docu.
