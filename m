Return-Path: <cygwin-patches-return-1518-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 7177 invoked by alias); 26 Nov 2001 14:13:11 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 7131 invoked from network); 26 Nov 2001 14:13:04 -0000
Message-ID: <00eb01c17684$78718230$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Pavel Tsekov" <ptsekov@syntrex.com>,
	<cygwin-patches@cygwin.com>
References: <3BFE8631.AFC9AEF6@syntrex.com> <08ae01c17454$ef204970$0200a8c0@lifelesswks> <3C02323E.ACFEECF0@syntrex.com>
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class
Date: Mon, 15 Oct 2001 19:29:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 26 Nov 2001 14:13:02.0734 (UTC) FILETIME=[75CEEAE0:01C17684]
X-SW-Source: 2001-q4/txt/msg00050.txt.bz2

RFC 2616 and 2617 are the current HTTP specs.

However, the format of a URI is defined elsewhere :|. Uhmm, see the
begining of rfc 2616 for a pointer to the correct URI defining RFC>

Rob
===
----- Original Message -----
From: "Pavel Tsekov" <ptsekov@syntrex.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, November 26, 2001 11:14 PM
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class


> Robert Collins wrote:
> >
> >
> > A few points ...
>
> [ snip ]
>
> > auth may be needed. Also something is needed to pass through a ftp
url
> > via http proxy request .. something like
> >
http://proxyusername:proxypassword@proxyaddress:port/ftp://ftpuser:ftppa
> > ss@ftpsite.com/bar is a minor variation from the HTTP RFC and should
be
> > easily parseable. The http code will need to understand what urls'
if
> > can proxy  - as you'd expect :].
>
> Where do you read this from ? rfc2068 ? Can you point me to the right
> docu.
>
