Return-Path: <cygwin-patches-return-1815-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18498 invoked by alias); 29 Jan 2002 05:37:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18484 invoked from network); 29 Jan 2002 05:37:55 -0000
Message-ID: <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 21:37:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 05:37:54.0296 (UTC) FILETIME=[19618F80:01C1A887]
X-SW-Source: 2002-q1/txt/msg00172.txt.bz2


===
----- Original Message -----
From: "Michael A Chase" <mchase@ix.netcom.com>

> If the intention of those messages is to highlight methods that should
have
> been overridden but aren't, then setup.log is the right place.

Essentially, yes thats why they are there: incomplete methods. When I
review your patch I'll be looking at the function status.

Rob
