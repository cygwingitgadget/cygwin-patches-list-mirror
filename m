Return-Path: <cygwin-patches-return-2591-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13396 invoked by alias); 3 Jul 2002 13:47:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13324 invoked from network); 3 Jul 2002 13:47:31 -0000
Message-ID: <005b01c22298$b7501f50$c9823bd5@dmitry>
From: "Dmitry Timoshkov" <dmitry@baikal.ru>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu> <005601c22280$e9e4f610$c9823bd5@dmitry> <20020703134115.V21857@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Wed, 03 Jul 2002 06:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q3/txt/msg00039.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:

> recvmsg is in another process.  The open handle is only valid in
> the source process.

Of course, you are right. Just refreshed my mind looking at that
old diff and revealed that what actually was getting passed is
a process id. Your further reasoning regarding privileges is
completely valid.

Sorry for the misleading info.

-- 
Dmitry.


