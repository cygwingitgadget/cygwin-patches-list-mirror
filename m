Return-Path: <cygwin-patches-return-2049-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24395 invoked by alias); 10 Apr 2002 21:55:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24377 invoked from network); 10 Apr 2002 21:55:01 -0000
Message-ID: <024501c1e0da$37df54c0$d900a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Pavel Tsekov" <ptsekov@gmx.net>
Cc: <cygwin-patches@cygwin.com>
References: <018801c1e0b8$fc496fc0$d900a8c0@mchasecompaq> <2528830.20020410220133@gmx.net>
Subject: Re: [PATCH]setup.exe: delete called for NULL pointer
Date: Wed, 10 Apr 2002 14:55:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00033.txt.bz2

I don't know, but many other places where it is called, it's protected by
   if (var)
      delete[] var;
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.
----- Original Message -----
From: "Pavel Tsekov" <ptsekov@gmx.net>
To: "Michael A Chase" <mchase@ix.netcom.com>
Cc: <cygwin-patches@cygwin.com>
Sent: Wednesday, April 10, 2002 13:01
Subject: Re: [PATCH]setup.exe: delete called for NULL pointer


> Wednesday, April 10, 2002, 7:20:30 PM, you wrote:
>
> MAC> I don't know if this delete call is a problem, but every other place
I found
> MAC> delete called in the setup.exe source, the variable was either
confirmed not
> MAC> NULL or the variable was certain to not be NULL.  In this case, the
variable
> MAC> either must be NULL or the buffer is too small.
>
> Isn't the 'delete' operator NULL aware ?

