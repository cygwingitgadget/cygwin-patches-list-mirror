Return-Path: <cygwin-patches-return-1737-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32567 invoked by alias); 18 Jan 2002 02:30:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32552 invoked from network); 18 Jan 2002 02:30:12 -0000
Message-ID: <067101c19fc7$c5860ed0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>,
	<cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A64@cnmail>
Subject: Re: strptime addition to cygwin
Date: Thu, 17 Jan 2002 18:30:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 18 Jan 2002 02:30:10.0627 (UTC) FILETIME=[0D2AD130:01C19FC8]
X-SW-Source: 2002-q1/txt/msg00094.txt.bz2


===
----- Original Message -----
From: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>

> Rinse, lather, repeat.  Same thing.  Since this is the first time I've
tried
> to add new functionality to cygwin1.dll I'd guess I'm missing
something
> obvious.  Can I get a push in the right direction?  Am I making the
dll
> wrong, or is there something else I'm missing?

copy libcygwin.a (the import library) to /usr/lib.

Rob
