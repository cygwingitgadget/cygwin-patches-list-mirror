Return-Path: <cygwin-patches-return-2129-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30491 invoked by alias); 1 May 2002 01:57:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30445 invoked from network); 1 May 2002 01:57:45 -0000
Message-Id: <3.0.5.32.20020430215517.007f13e0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 30 Apr 2002 18:57:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: SSH -R problem
In-Reply-To: <3CCEA638.E357EFE2@ieee.org>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
 <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
 <3.0.5.32.20020430073223.007e3e00@mail.attbi.com>
 <20020430142039.D1214@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00113.txt.bz2

At 10:12 AM 4/30/2002 -0400, Pierre A. Humblet wrote:
>Now I have never observed this myself, and don't have a strong opinion.
>Do we have a reproducible case to understand exactly what's going on?

I found the nice example by Jonathan Kammen, using socketpair()
http://cygwin.com/ml/cygwin/2001-07/msg00758.html
The weird thing is that I can't get it to misbehave on Win98/ME,
even with a Cygwin dll without the linger hack. I will try on NT.
If it's confirmed that there is no such problem on Win98/ME, then
the ssh -R issue could be solved without risk by using linger only 
on NT and making the socket blocking with no linger only on Win95...

>So an ideal fix would detect "end of life" situations. Here is a brain 
>storming idea: on a Cygwin close(), do a shutdown(.,2), free the Cygwin
Oops, absolutely no shutdown().

Pierre
