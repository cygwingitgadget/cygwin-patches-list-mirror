Return-Path: <cygwin-patches-return-1662-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31727 invoked by alias); 7 Jan 2002 22:11:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31708 invoked from network); 7 Jan 2002 22:11:02 -0000
Message-ID: <01dc01c197c8$314603d0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <013601c19784$1f95c1f0$0200a8c0@lifelesswks> <20020107164140.GA4029@redhat.com>
Subject: Re: getsem cleanup
Date: Mon, 07 Jan 2002 14:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 07 Jan 2002 22:11:01.0095 (UTC) FILETIME=[30CB0770:01C197C8]
X-SW-Source: 2002-q1/txt/msg00019.txt.bz2


===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>

> If I'm reading the patch correctly, it changes the behavior of cygwin
so
> that cygwin will output an error in the case of a failing
OpenSemaphore.
> That's not right.  The current behavior is correct.  The only time you
> should see an error is when the process is creating a semaphore for
> itself.  It should always be able to do that.
>
> I'll clean up the code in getsem a little to make this more obvious.

Ok. I thought there was a bug because the error line has
p ? "open" : "create" :}

Te error line only goes to strace in any event...

ROb
