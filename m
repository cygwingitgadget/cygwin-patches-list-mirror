Return-Path: <cygwin-patches-return-4006-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9749 invoked by alias); 12 Jul 2003 14:58:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9625 invoked from network); 12 Jul 2003 14:58:24 -0000
Message-Id: <3.0.5.32.20030712093737.00812900@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sat, 12 Jul 2003 14:58:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Problems on accessing Windows network resources
In-Reply-To: <20030712083102.GI12368@cygbert.vinschen.de>
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
 <3.0.5.32.20030711200253.00807190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00022.txt.bz2

At 10:31 AM 7/12/2003 +0200, Corinna Vinschen wrote:

>thanks for the patch but it has a problem.  You're comparing tokens against
>NULL while the correct "NULL" value for tokens is INVALID_HANDLE_VALUE. 

Corinna,

That's by design, using of Chris' astute observations. As he once
pointed out, INVALID_HANDLE_VALUE is the value returned in case of error
but NULL is not a legal handle value either, as implied by CreateFile
itself. Microsoft is using NULL handle values all the time. For the 
specific case of a NULL token handle, see SetThreadToken.

So I do like Microsoft and I use NULL to denote the legitimate absence 
of a token. I also use INVALID_HANDLE_VALUE in the error case.

Pierre
