Return-Path: <cygwin-patches-return-3702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3292 invoked by alias); 13 Mar 2003 05:54:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3197 invoked from network); 13 Mar 2003 05:54:44 -0000
Message-ID: <003201c2e924$e6077ca0$0400a8c0@robertcollins.net>
Reply-To: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
From: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
References: <Pine.WNT.4.44.0302271028080.285-201000@algeria.intern.net>
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
Date: Thu, 13 Mar 2003 05:54:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2003-q1/txt/msg00351.txt.bz2

This:

   if (1 == InterlockedIncrement ((long *)&lock_counter))

is not safe. You can only check for equal to 0, less than 0, and greater
than 0 with InterlockedIncrement | Decrement.

Secondly, IIRC lock_counter should be long, so the (long *) typecasting
isn't needed.

Rob

