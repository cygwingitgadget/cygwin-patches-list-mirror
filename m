Return-Path: <cygwin-patches-return-1714-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5876 invoked by alias); 16 Jan 2002 22:42:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5838 invoked from network); 16 Jan 2002 22:42:33 -0000
Message-ID: <17ae01c19edf$0ecac570$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <177e01c19edc$88d9bf90$0200a8c0@lifelesswks> <20020116224107.GA1804@redhat.com>
Subject: Re: strptime
Date: Wed, 16 Jan 2002 14:42:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Jan 2002 22:42:29.0309 (UTC) FILETIME=[13F95ED0:01C19EDF]
X-SW-Source: 2002-q1/txt/msg00071.txt.bz2


===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <newlib-patches@sources.redhat.com>; <cygwin-patches@cygwin.com>
> I'm not wild about some of the changes that indent made to times.cc.
> A lot of the changes are nice but some of the formatting doesn't
> seem right to me.

I ran indent to get my code right... and got a big surprise :].

> Can I ask where this strptime came from?  Is this a new work?  If
> so maybe we want to just incorporate a strptime from FreeBSD.  An
> in-use strptime would have a known track record and should have
> most bugs shaken out of it.

From scratch. I needed it for patchutils. I'm happy for someone to grab
an existing BSD licenced one instead.

Rob
