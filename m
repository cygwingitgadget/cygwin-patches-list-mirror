Return-Path: <cygwin-patches-return-2167-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31490 invoked by alias); 8 May 2002 14:43:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31471 invoked from network); 8 May 2002 14:43:34 -0000
Message-ID: <3CD93A75.58F7C244@ieee.org>
Date: Wed, 08 May 2002 07:43:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Security patches
References: <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net> <20020314133309.Q29574@cygbert.vinschen.de> <3C90B0D7.EB06F222@ieee.org> <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020507223050.007b2550@mail.attbi.com> <20020508131529.D9238@cygbert.vinschen.de> <3CD92ECC.2377927E@ieee.org> <20020508162312.J9238@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00151.txt.bz2

Corinna Vinschen wrote:

> You can retrieve the value of `orig_psid' by calling the method
> `orig_sid()' now.

Excellent. I will use that instead and send you a new diff soon.

Pierre
