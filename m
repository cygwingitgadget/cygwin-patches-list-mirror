Return-Path: <cygwin-patches-return-3226-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23157 invoked by alias); 24 Nov 2002 16:28:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23147 invoked from network); 24 Nov 2002 16:28:22 -0000
Message-Id: <3.0.5.32.20021124112817.008279b0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 24 Nov 2002 08:28:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: More passwd/group patches
In-Reply-To: <20021124170805.B1398@cygbert.vinschen.de>
References: <3.0.5.32.20021124092120.00829650@mail.attbi.com>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3DDE3FB9.2AFAA199@ieee.org>
 <20021122154644.N1398@cygbert.vinschen.de>
 <3DDE4528.3BDCDCEF@ieee.org>
 <3.0.5.32.20021124092120.00829650@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00177.txt.bz2

At 05:08 PM 11/24/2002 +0100, Corinna Vinschen wrote:
>The appropriate changes to sec_acl.cc would collide with your patch
>so I'd like to ask you if you want me to make the necessary changes
>to comply with Solaris first and then to send a revised patch, or
>if you want to incorporate these changes into your patch, too?

Corinna,

Between the two proposals I prefer the first (you make the change first).
The don't like the second much, because there is a possibility of 
misunderstanding.
There is also a third possibility: apply the patch and then fix it to
match solaris. That may minimize the overall amount of work and 
reviewing.

I have been working on the home directory problem but can't reproduce 
it. 
I don't see anything wrong with his passwd file. Do you?

Pierre

 
