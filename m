Return-Path: <cygwin-patches-return-2985-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22016 invoked by alias); 17 Sep 2002 08:48:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21994 invoked from network); 17 Sep 2002 08:48:48 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 17 Sep 2002 01:48:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork Part 1
In-Reply-To: <1032176687.17674.131.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209161541580.90-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="268295-25500-1032252522=:277"
X-SW-Source: 2002-q3/txt/msg00433.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--268295-25500-1032252522=:277
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1066



On Mon, 16 Sep 2002, Robert Collins wrote:

> On Sat, 2002-08-17 at 06:18, Thomas Pfaff wrote:
> >
> > Rob suggested to break the pthread_fork patch into smaller chunks. Ths is
> > part 1 providing a fork save key value handling.
> > The patch will add a linked list of keys to< MTinterface and a fork buffer
> > in pthread_key where the key values are passed between parent and child.
>
> In general, I liked this patch.
> I've made some essentially stylistic alterations, to make the resulting
> code a little easier to read. I realise you followed my lead on some of
> the layout - I need to fix up my existing code too :].
>
> Here's a snapshot of HEAD with your patch after my changes.
>
> I'd love it if you sent me the source for the test case you used when
> developing this.
>

I have attached a small source file for testing.

My main goal was to get a working threaded perl, so this was the reference
source for the final testing. With all patches applied (and the changed
mutex implementation) i was able to build and run it without problems.

Thomas


--268295-25500-1032252522=:277
Content-Type: TEXT/plain; name="fork.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0209171048420.277@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="fork.c"
Content-length: 647

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1
ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CgppbnQgbWFp
bih2b2lkKQp7CiAgcHRocmVhZF9rZXlfdCBwX2tleTsKCiAgcHRocmVhZF9r
ZXlfY3JlYXRlICgmcF9rZXksTlVMTCk7CiAgcHRocmVhZF9zZXRzcGVjaWZp
YyAocF9rZXksICh2b2lkKikgMHgxMCk7CgogIHN3aXRjaCAoZm9yaygpKQog
ICAgewogICAgY2FzZSAtMToKICAgICAgcmV0dXJuIDA7CiAgICBjYXNlIDA6
CiAgICAgIHByaW50ZiAoImNoaWxkOiAgJXAgJXBcbiIsIHB0aHJlYWRfc2Vs
ZigpLCBwdGhyZWFkX2dldHNwZWNpZmljIChwX2tleSkpOwogICAgICBicmVh
azsKICAgIGRlZmF1bHQ6CiAgICAgIHByaW50ZiAoInBhcmVudDogJXAgJXBc
biIsIHB0aHJlYWRfc2VsZigpLCBwdGhyZWFkX2dldHNwZWNpZmljIChwX2tl
eSkpOwogICAgfQoKICByZXR1cm4gMDsKfQo=

--268295-25500-1032252522=:277--
