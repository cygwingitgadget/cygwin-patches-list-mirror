Return-Path: <cygwin-patches-return-1529-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 8664 invoked by alias); 27 Nov 2001 18:49:49 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 8636 invoked from network); 27 Nov 2001 18:49:49 -0000
Message-ID: <002601c17773$53f23090$02af6080@cc.telcordia.com>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@sourceware.cygnus.com>
References: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com> <20011127193031.Q14975@cygbert.vinschen.de>
Subject: Re: shutdown sockets on exit patch
Date: Thu, 18 Oct 2001 16:07:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-SW-Source: 2001-q4/txt/msg00061.txt.bz2

> I tried it.  Rexecd, rshd, sshd (and scp) seem to work fine but the
> following new errors occur now:
>
> - Calling `dir' in an ftp connection to the Windows box works but
>   after finishing the connection is closed and the message
>   "421 Service not available, remote server has closed connection."
>   is printed.
>
> - Connecting from the Windows box to a host using ssh with X11
>   forwarding activated fails with error
>   "Write failed: errno ESHUTDOWN triggered"
>
> This is probably due to the child processes calling shutdown on the
> socket on exit.
>

You're right, child process shuts down parent's socket... I'll try to find
some other solution.

Sergey Okhapkin
Piscataway, NJ

