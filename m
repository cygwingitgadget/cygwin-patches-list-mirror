Return-Path: <cygwin-patches-return-2051-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28939 invoked by alias); 10 Apr 2002 23:47:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28925 invoked from network); 10 Apr 2002 23:47:15 -0000
Message-ID: <029101c1e0e9$e2e90b90$d900a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	"Pavel Tsekov" <ptsekov@gmx.net>
Cc: <cygwin-patches@cygwin.com>
References: <FC169E059D1A0442A04C40F86D9BA7600C5DF0@itdomain003.itdomain.net.au>
Subject: Re: [PATCH]setup.exe: delete called for NULL pointer
Date: Wed, 10 Apr 2002 16:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00035.txt.bz2

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; "Pavel Tsekov"
<ptsekov@gmx.net>
Cc: <cygwin-patches@cygwin.com>
Sent: Wednesday, April 10, 2002 16:03
Subject: RE: [PATCH]setup.exe: delete called for NULL pointer

> From: Michael A Chase [mailto:mchase@ix.netcom.com]
> Sent: Thursday, April 11, 2002 7:51 AM
> To: Pavel Tsekov
> Cc: cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe: delete called for NULL pointer
>
> I don't know, but many other places where it is called, it's
> protected by
>    if (var)
>       delete[] var;

That was before I had read up on certain aspects of the C++ spec.


OK.  Then ignore the patch.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.
