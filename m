Return-Path: <cygwin-patches-return-3142-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11693 invoked by alias); 9 Nov 2002 01:01:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11683 invoked from network); 9 Nov 2002 01:01:36 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: [list] Re: New ioctls for hard disks
Date: Fri, 08 Nov 2002 17:01:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHIEIKDAAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20021107152441.A24497@cygbert.vinschen.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-SW-Source: 2002-q4/txt/msg00093.txt.bz2

> > This patch implements some new ioctls for hard disks. This
> means you can run
> > fdisk under Cygwin.
>
> Nice patch!  Applied.
>
> Caution, broad hint follows:  Are you planning to maintain a fdisk port to
> Cygwin?

Not unless I was 100% sure it worked. Even then I'd give it second thoughts.
I only did this so I could fix a broken partition table on my zip disk :)

Chris
