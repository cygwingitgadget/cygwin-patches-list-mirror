Return-Path: <cygwin-patches-return-2313-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20480 invoked by alias); 5 Jun 2002 13:12:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20466 invoked from network); 5 Jun 2002 13:12:45 -0000
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] minor pthread fixes
Date: Wed, 05 Jun 2002 06:12:00 -0000
Message-ID: <016901c20c92$b4288c70$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020605150912.X30892@cygbert.vinschen.de>
X-OriginalArrivalTime: 05 Jun 2002 13:12:43.0919 (UTC) FILETIME=[ADB9D1F0:01C20C92]
X-SW-Source: 2002-q2/txt/msg00296.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Corinna Vinschen
> Sent: Wednesday, 5 June 2002 11:09 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] minor pthread fixes
> 
> 
> On Wed, Jun 05, 2002 at 10:44:54PM +1000, Robert Collins wrote:
> > Ok, Chris, whats the guideline in nuber-of-line before we need an
> > assignment? Do I need to back out this patch (it's very few 
> lines, just
> > spread over a few functions).
> 
> I'm not Chris, sorry

That's ok, you being a RedHat employee and all :}.

> , but the answer is basically something below
> 10 changed lines is treated as "nonsignificant".  There's no hard
> rule, though.  Basically, if a change is not only fixing a bug but
> introduces new functionality, it's a "significant" patch, even if
> it's changing less than 10 lines.

Hmm. I'll look carefully at the remaining patches to see if there is new
functionality or just bugfixes. The current one should be fine though
IMO.

Rob
