Return-Path: <cygwin-patches-return-1817-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14525 invoked by alias); 29 Jan 2002 06:05:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14497 invoked from network); 29 Jan 2002 06:05:10 -0000
Message-ID: <066001c1a88a$ed36f680$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <000a01c1a879$90fddcf0$0d00a8c0@mchasecompaq>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 22:05:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 06:05:09.0785 (UTC) FILETIME=[E8356090:01C1A88A]
X-SW-Source: 2002-q1/txt/msg00174.txt.bz2

Ok, I've looked at the patch.

Most of the methods are stubs that should warn when used. Some aren't,
and I'll try and merge those changes in by hand tonight. Don't bother
reissuing the patch - I'm about to cause everyone heartache by removing
much of the char * usage (I got sick of memleaks) for a
quick-and-dirtyish String class. Sigh, still no STL.

Rob
