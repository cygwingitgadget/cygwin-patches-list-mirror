Return-Path: <cygwin-patches-return-2909-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17311 invoked by alias); 2 Sep 2002 06:10:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17295 invoked from network); 2 Sep 2002 06:10:19 -0000
Date: Sun, 01 Sep 2002 23:10:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <3260121239.20020902100735@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: [franck.leray@cheops.fr: tcsetattr timeout problem ?]
In-Reply-To: <20020831033855.GA18122@redhat.com>
References: <20020830145541.GB1402@redhat.com>
 <136198673817.20020830214611@logos-m.ru> <5199249725.20020830215547@logos-m.ru>
 <147200259187.20020830221236@logos-m.ru> <20020831033855.GA18122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00357.txt.bz2

Hi!

Saturday, 31 August, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Fri, Aug 30, 2002 at 10:12:36PM +0400, egor duda wrote:
>>ed> Actually, the patch is wrong :(. I'm looking into it and post a
>>ed> correct one asap.
>>
>>Forgot to include fhandler_tty.cc part.
>>
>>Please check it if possible and feel free to apply it, as i will be
>>away from computer for some time.

CF> I took a look at your patch but it didn't seem right to me.

CF> You were asking about circumventing the 'ready_for_read' code and,
CF> since fhandler_tty_slave::read has the ability to detect a signal,
CF> removal of fhandler_tty_slave::ready_for_read is the right way to
CF> go, AFAICT.

Absolutely. Silly me, i haven't noticed a FH_NOEINTR flag, which was
exactly what was needed. Thanks!

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
