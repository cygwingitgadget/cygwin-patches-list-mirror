Return-Path: <cygwin-patches-return-1954-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11701 invoked by alias); 7 Mar 2002 01:19:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11603 invoked from network); 7 Mar 2002 01:19:15 -0000
Message-ID: <02df01c1c576$4a534af0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <012301c1c570$8af537e0$0100a8c0@advent02> <20020307004423.GA24387@redhat.com>
Subject: Re: Patch for cd .../. bug
Date: Wed, 06 Mar 2002 17:40:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 07 Mar 2002 01:19:13.0849 (UTC) FILETIME=[17C20A90:01C1C576]
X-SW-Source: 2002-q1/txt/msg00311.txt.bz2


===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, March 07, 2002 11:44 AM
Subject: Re: Patch for cd .../. bug


> On Thu, Mar 07, 2002 at 12:39:28AM -0000, Chris January wrote:
> >This patch fixes the bug that allows cd .../. to succeed.
>
> This isn't a bug.  It's how Windows works.

Windows (NT) has trouble with this too.. see vuln-dev recently. One can
convince CMD that it is actually in C:\.. - which is somewhere in the NT
device tree IIRC.

Anyway, it seems reasonable to me to use unix behaviour for cygwin with
this.

Rob
