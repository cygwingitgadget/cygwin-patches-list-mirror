Return-Path: <cygwin-patches-return-2598-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6797 invoked by alias); 3 Jul 2002 16:36:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6712 invoked from network); 3 Jul 2002 16:36:46 -0000
X-WM-Posted-At: avacado.atomice.net; Wed, 3 Jul 02 17:36:47 +0100
Message-ID: <001a01c222af$d2d4fc70$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <011a01c2228f$f91fbe30$0100a8c0@advent02> <20020703155036.GG24177@redhat.com>
Subject: Re: UTF8 patch
Date: Wed, 03 Jul 2002 09:36:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00046.txt.bz2

> >This patch adds UTF8 support to Cygwin. It's a quick hack, so may not be
> >complete or perfect.
>
> Is there any way that this could be done with wrapper functions for things
> like CreateFile?  I would rather make this change as unintrusive as
possible.
yep, this sounds like a good idea. only problem is it adds a bit of overhead
if you call more than one wrapper from the same function because it would be
hard to store the converted value between calls and hence the conversion
would be done more than once.
Someone else suggested adding support for any arbitary codepage. I thought
about this and decided it wouldn't work, since the unicode->codepage
function would not necessarily be reversible. Hence some names would get
mangled, others would be inaccessible, etc. If I can solve this problem
somehow, however, then this would be a good idea.

Chris


