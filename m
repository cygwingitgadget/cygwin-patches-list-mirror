Return-Path: <cygwin-patches-return-2130-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26677 invoked by alias); 1 May 2002 09:35:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26634 invoked from network); 1 May 2002 09:35:06 -0000
Message-ID: <006601c1f0f3$6f7df750$42a18c09@wdg.uk.ibm.com>
From: "Max Bowsher" <maxb@ukf.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>,
	<cygwin@cygwin.com>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de> <3.0.5.32.20020430215517.007f13e0@mail.attbi.com>
Subject: Why no shutdown? (was: Re: SSH -R problem)
Date: Wed, 01 May 2002 02:35:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 01 May 2002 09:34:48.0133 (UTC) FILETIME=[6F7DF750:01C1F0F3]
X-SW-Source: 2002-q2/txt/msg00114.txt.bz2

On cygwin-patches@, Pierre A. Humblet wrote:
> >So an ideal fix would detect "end of life" situations. Here is a brain
> >storming idea: on a Cygwin close(), do a shutdown(.,2), free the Cygwin
> Oops, absolutely no shutdown().
>
> Pierre

Why no shutdown? (I am aware that this is dangerously off-topic for
cygwin-patches. I am cross posting there only for continuities sake. Please
reply only to cygwin@)

Max.
