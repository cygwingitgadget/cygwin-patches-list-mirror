Return-Path: <cygwin-patches-return-2553-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21715 invoked by alias); 1 Jul 2002 09:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21700 invoked from network); 1 Jul 2002 09:19:38 -0000
Message-ID: <006a01c220e0$6735afd0$1800a8c0@LAPTOP>
From: "Robert Collins" <robert.collins@syncretize.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0206291214370.4768-100000@this> <20020701100414.B17641@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Mon, 01 Jul 2002 02:19:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00001.txt.bz2


----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, July 01, 2002 6:04 PM

> A change in the concept would eliminate that.  The sender process
> could start a thread and duplicate all file handlers/HANDLEs.  So
> the main thread in the sender isn't blocked.  The receiver is blocked
> anyway since it has to wait until all file handle information has
> been correctly transmitted/regenerated.

This is still incomplete, the parent now cannot exit(). I think that it is a
reasonable fall-back position for when the cygserver isn't running though.

Rob
