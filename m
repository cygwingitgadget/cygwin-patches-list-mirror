Return-Path: <cygwin-patches-return-1555-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 3822 invoked by alias); 28 Nov 2001 23:18:07 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 3803 invoked from network); 28 Nov 2001 23:18:06 -0000
Message-ID: <038f01c17862$b64afb60$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Alexander Gottwald" <Alexander.Gottwald@informatik.tu-chemnitz.de>
Cc: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.21.0111282007530.1783-100000@lupus.ago.vpn>
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Thu, 01 Nov 2001 02:41:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Nov 2001 23:17:54.0225 (UTC) FILETIME=[E8481210:01C17862]
X-SW-Source: 2001-q4/txt/msg00087.txt.bz2

----- Original Message -----
From: "Alexander Gottwald"
<Alexander.Gottwald@informatik.tu-chemnitz.de>
> I was once told that NULL might not be equal to 0 on all platforms. So
...
> This is - afair - defined for C.

Thus my comment re: NULL usage on C. I'm religious there - I always use
NULL.

> For C++ I have no clues.

Nuff said :]. Seriously though for C++ NULL == '0'.

Rob
