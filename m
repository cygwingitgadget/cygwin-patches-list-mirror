Return-Path: <cygwin-patches-return-3001-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13272 invoked by alias); 19 Sep 2002 08:31:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13257 invoked from network); 19 Sep 2002 08:31:08 -0000
Message-ID: <00ed01c25fb7$1f9f6970$0100a8c0@wdg.uk.ibm.com>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020918220225.00810100@mail.attbi.com> <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com>
Subject: Re: More changes about open on Win95 directories.
Date: Thu, 19 Sep 2002 01:31:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2002-q3/txt/msg00449.txt.bz2

Pierre A. Humblet wrote:
> Is '!' invalid? It can easily be confused with '|'.

Maybe ':' ?

> I am bothered that the code uses 0 as an illegal
> handle value. Is that really the case?

No.
/usr/include/w32api/winbase.h:232:#define INVALID_HANDLE_VALUE (HANDLE)(-1)

Max.
