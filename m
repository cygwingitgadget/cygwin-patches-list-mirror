Return-Path: <cygwin-patches-return-3701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 522 invoked by alias); 13 Mar 2003 05:49:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 402 invoked from network); 13 Mar 2003 05:49:28 -0000
Message-ID: <001801c2e924$13180170$0400a8c0@robertcollins.net>
Reply-To: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
From: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
References: <Pine.WNT.4.44.0302271115543.285-201000@algeria.intern.net>
Subject: Re: [PATCH] Implement pthread_rwlocks
Date: Thu, 13 Mar 2003 05:49:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2003-q1/txt/msg00350.txt.bz2

This work looks pretty nice :}.

You are using the thunk approach here - the same one another patch of
yours removes.... is that deliberate? I'd rather not introduce more of
that approach.

Approval to commit is granted.

Rob


