Return-Path: <cygwin-patches-return-1749-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17630 invoked by alias); 18 Jan 2002 23:45:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17616 invoked from network); 18 Jan 2002 23:45:27 -0000
Message-ID: <0aa301c1a079$ed6068d0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A6F@cnmail> <20020119004311.O11608@cygbert.vinschen.de>
Subject: Re: roken strptime addition to cygwin
Date: Fri, 18 Jan 2002 15:45:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 18 Jan 2002 23:45:26.0295 (UTC) FILETIME=[340F3270:01C1A07A]
X-SW-Source: 2002-q1/txt/msg00106.txt.bz2


===
----- Original Message ----- 
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>

> So I would like to suggest that you move the function implementaton
> into newlib/libc/time/strftime.c, Mark.  The extern declaration in
> libc/include/time.h could be moved out of the `#ifdef __CYGWIN__'
> brackets and the cygwin.din patch would stay as it is.
> 
> Is that ok?

Makes sense to me. I put it in cygwin out of familiarity :].

Rob
