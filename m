Return-Path: <cygwin-patches-return-1499-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 24370 invoked by alias); 15 Nov 2001 12:20:02 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 24329 invoked from network); 15 Nov 2001 12:20:01 -0000
Message-ID: <030601c16dd0$1a48ac40$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
References:  <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F28E@itdomain002.itdomain.net.au> <92602986318.20011109105819@logos-m.ru> <17285934467.20011115142602@logos-m.ru>
Subject: Re: PTHREAD_COND_INITIALIZER support
Date: Thu, 11 Oct 2001 13:56:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 15 Nov 2001 12:19:59.0877 (UTC) FILETIME=[D85DD350:01C16DCF]
X-SW-Source: 2001-q4/txt/msg00031.txt.bz2

----- Original Message -----
From: "egor duda" <deo@logos-m.ru>
..
> ed> yes. i'm going to add a bunch of pthread tests after this checkin.
>
> done too.
>
> Robert, can you please take a look at winsup.api/pthread/condvar3_1.c
> test? it looks like when condition variable is signalled, two threads
> wake on it instead of one. it's quite stable effect, so i don't think
> we have a race here.

Ok, it's probably the wakeup code. Do you have a sinlge or dual machine?

Rob
