Return-Path: <cygwin-patches-return-2587-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19982 invoked by alias); 3 Jul 2002 10:57:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19941 invoked from network); 3 Jul 2002 10:57:15 -0000
Message-ID: <005601c22280$e9e4f610$c9823bd5@dmitry>
From: "Dmitry Timoshkov" <dmitry@baikal.ru>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu>
Subject: Re: Patch to pass file descriptors
Date: Wed, 03 Jul 2002 03:57:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q3/txt/msg00035.txt.bz2

Hello all.

Why not implement passing file descriptors in the following way:

Somewhere in the structure passed to sendmsg send a handle of
the calling process created with
OpenProcess(PROCESS_DUP_HANDLE, FALSE, GetCurrentProcessId());
OpenProcess will always succed, since the caller is current process.

recvmsg implementation will just use that process handle
for the DuplicateHandle call.

That approach worked for me year ago in the experimental (now dead)
Cygwin port of my application.

-- 
Dmitry.


