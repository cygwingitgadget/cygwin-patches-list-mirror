Return-Path: <cygwin-patches-return-3043-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9531 invoked by alias); 24 Sep 2002 16:17:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9517 invoked from network); 24 Sep 2002 16:17:51 -0000
Date: Tue, 24 Sep 2002 09:17:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <16288646311.20020924201427@logos-m.ru>
To: Steve O <bub@io.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty doecho change
In-Reply-To: <20020924105431.A3758@fnord.io.com>
References: <20020924015053.A21742@eris.io.com>
 <20020924092143.J29920@cygbert.vinschen.de> <20020924143723.GB918@redhat.com>
 <20020924105431.A3758@fnord.io.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00491.txt.bz2

Hi!

Tuesday, 24 September, 2002 Steve O bub@io.com wrote:

SO> I was thinking about the deadlock problem some more last night,
SO> and it occured to me that if termios processing were done on 
SO> the slave side, some of the buffering and tricky bits of 
SO> flushing the write buffer would go away (maybe).  And you wouldn't
SO> need this patch.

What do you mean exactly by "termios processing"?

And did you take into account the possibility that process which owns
slave side of tty forks and child gets handle to slave too. Then child
does some "termios processing". Will parent use old or new termios
settings?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
