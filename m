Return-Path: <cygwin-patches-return-1885-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19858 invoked by alias); 25 Feb 2002 01:19:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19767 invoked from network); 25 Feb 2002 01:19:15 -0000
Message-ID: <04ba01c1bd9a$926c7840$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <m31yfhdpkf.fsf@appel.lilypond.org><009201c1b9f9$99575fc0$0200a8c0@lifelesswks> <m3r8ng0wex.fsf@appel.lilypond.org> <018a01c1ba55$ff233b10$0200a8c0@lifelesswks> <02db01c1ba65$936be6f0$f400a8c0@mchasecompaq> <014001c1bd20$45424a60$0200a8c0@lifelesswks> <004d01c1bd8d$c0fcdcc0$5c00a8c0@mchasecompaq>
Subject: Re: [Patch]setup.exe type prefixes for io_stream::mkpath_p and io_stream:open paths
Date: Sun, 24 Feb 2002 18:03:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 25 Feb 2002 01:19:14.0009 (UTC) FILETIME=[6FB8F490:01C1BD9A]
X-SW-Source: 2002-q1/txt/msg00242.txt.bz2

Thanks Michael - I've applied a slight variation (cygfile:// is the
appropriate prefix for the io_stream_cygfile links) to the setup200202
branch. For HEAD we should actually start using io_streams in desktop.cc
which will remove the need for cygpath usage. Rather than renaming
cygpath (which is consistent with cygwin's innards, and the cygpath
commandline util) I'd like to finish getting everything to use
io_stream's cygfile:// syntax.

Rob
