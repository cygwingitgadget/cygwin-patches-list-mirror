Return-Path: <cygwin-patches-return-2582-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31170 invoked by alias); 2 Jul 2002 17:25:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31153 invoked from network); 2 Jul 2002 17:25:00 -0000
Date: Tue, 02 Jul 2002 10:25:00 -0000
From: David E Euresti <davie@MIT.EDU>
To: <cygwin-patches@cygwin.com>
Subject: Re: Patch to pass file descriptors
Message-ID: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00030.txt.bz2


That I can tell shm doesn't work if the cygserver isn't running.  Why is
it demanded that passing file descriptors work without the cygserver?  I
mean currently you can't pass file descriptors so even having one optional
solution is better than no solution.

David

>I have objections.  This is neither fully discussed nor is it clear
>how to incorporate the call together with the cygserver-less descriptor
>passing code into fhandler_socket.cc so far.
>
>Corinna


