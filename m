Return-Path: <cygwin-patches-return-2434-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20977 invoked by alias); 14 Jun 2002 22:54:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20961 invoked from network); 14 Jun 2002 22:54:24 -0000
Message-ID: <005801c213f6$ab0e2a30$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <003c01c213f3$2ed077f0$6132bc3e@BABEL>
Subject: Re: Mount interaction with /dev & /proc entries
Date: Fri, 14 Jun 2002 15:54:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00417.txt.bz2

Before anyone else gets there, I'll reply to my own message (what a
change).

The patch I just sent for path.cc breaks (at least) find(1) on
/proc/registry -- it doesn't descend into it at all. Sorry.

So I've got something wrong in my understanding of the cygwin/win32
stuff (which doesn't surprise me). It still seems that something like
this change should be made. One difference betwen /proc and /dev is
that the /dev fs doesn't contain any directories. I'll go look some
more.

Cheers,

// Conrad


