Return-Path: <cygwin-patches-return-1657-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 955 invoked by alias); 7 Jan 2002 13:46:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 909 invoked from network); 7 Jan 2002 13:46:19 -0000
Message-ID: <009d01c19781$ae8bfdf0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: =?iso-8859-1?Q?Schaible=2C_J=F6rg?= <Joerg.Schaible@gft.com>,
	<cygwin-patches@sourceware.cygnus.com>
References: <C2D7D58DBFE9D111B0480060086E96350689B60B@mail_server.gft.com>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Mon, 07 Jan 2002 05:46:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 07 Jan 2002 13:46:17.0581 (UTC) FILETIME=[AE6981D0:01C19781]
X-SW-Source: 2002-q1/txt/msg00014.txt.bz2

I'm sorry Jorg, but I don't have the standard to reference. Do you know
of an on-line copy? (Googling for "c++ standard 10.3.2" gave me lots of
useless hits :})

I got my info from the C++ FAQS second edition (Cline Lomow & Girou),
FAQ 33.09.

Rob
===
----- Original Message -----
From: "Schaible, Jörg" <Joerg.Schaible@gft.com>
>My understanding is that this is not 100% the case. Or more
>pedantically - in a class derived from a a class with virtual
>functions,
>those virtual functions wil get overriden, but if not declared virtual
>themselves, any further derivations will not. I believe that the
>technique of doing this to allow inlining of code calling references to
>an object is called 'final classes'.

Sorry, Gary is right. See 10.3.2 of the standard.

Regards,
Jörg

