Return-Path: <cygwin-patches-return-1549-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 30976 invoked by alias); 28 Nov 2001 12:05:44 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 30931 invoked from network); 28 Nov 2001 12:05:42 -0000
Message-ID: <00b801c17804$cd3c06b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKOEJNCHAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Sat, 27 Oct 2001 04:05:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Nov 2001 12:05:40.0970 (UTC) FILETIME=[FFC9C4A0:01C17804]
X-SW-Source: 2001-q4/txt/msg00081.txt.bz2

Commited. Thanks Gary and Pavel.

Rob
===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Wednesday, November 28, 2001 6:36 PM
Subject: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating
entire stream as a header


> Ok, with a bit of help from Mr. Tsekov et al, this ought to do it:
>
>
> 2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>
.
