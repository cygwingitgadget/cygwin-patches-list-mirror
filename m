Return-Path: <cygwin-patches-return-1715-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7039 invoked by alias); 16 Jan 2002 22:45:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7012 invoked from network); 16 Jan 2002 22:45:39 -0000
Message-ID: <17b401c19edf$7ef33c10$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <178f01c19edd$27fce250$0200a8c0@lifelesswks> <20020116224233.GB1804@redhat.com>
Subject: Re: fnmatch
Date: Wed, 16 Jan 2002 14:45:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Jan 2002 22:45:37.0938 (UTC) FILETIME=[8467DF20:01C19EDF]
X-SW-Source: 2002-q1/txt/msg00072.txt.bz2


===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, January 17, 2002 9:42 AM
Subject: Re: fnmatch


> On Thu, Jan 17, 2002 at 09:28:43AM +1100, Robert Collins wrote:
> >Hopefully this is self-explanatory.
>
> I appreciate the work but I have the same reservations as my previous
> comments.  Isn't there an existing version of this function that we
> could grab?

Possibly, but I dont' have BSD library source handy.

My implementation is complete barring the [] functionality, and it
passes the four tests used by AC_FUNC_FNMATCH.

Rob
