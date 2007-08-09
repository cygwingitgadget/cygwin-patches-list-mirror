Return-Path: <cygwin-patches-return-6132-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24661 invoked by alias); 9 Aug 2007 17:36:51 -0000
Received: (qmail 24617 invoked by uid 22791); 9 Aug 2007 17:36:50 -0000
X-Spam-Check-By: sourceware.org
Received: from nat1.steeleye.com (HELO exgate.steeleye.com) (71.30.118.249)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 09 Aug 2007 17:36:46 +0000
Received: from steelpo.steeleye.com ([172.17.4.222]) by exgate.steeleye.com with Microsoft SMTPSVC(5.0.2195.6713); 	 Thu, 9 Aug 2007 13:36:41 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Signal handler not executed
Date: Thu, 09 Aug 2007 17:36:00 -0000
Message-ID: <76087731258D2545B1016BB958F00ADA123A4F@STEELPO.steeleye.com>
In-Reply-To: <20070809171911.GA9596@ednor.casa.cgf.cx>
From: "Ernie Coskrey" <Ernie.Coskrey@steeleye.com>
To: <cygwin-patches@cygwin.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00007.txt.bz2

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com=20
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of=20
> Christopher Faylor
> Sent: Thursday, August 09, 2007 1:19 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: Signal handler not executed
>=20
> On Thu, Aug 09, 2007 at 01:09:48PM -0400, Ernie Coskrey wrote:
> >There's a very small window of vulnerability in _sigbe,=20
> which can lead=20
> >to signal handlers not being executed.  In _sigbe, the=20
> _cygtls lock is=20
> >released before incyg is decremented.  If setup_handler acquires the=20
> >lock just after _sigbe releases it, but before incyg is decremented,=20
> >setup_handler will mistakenly believe that the thread is in Cygwin=20
> >code, and will set up the interrupt using the tls stack.
> >=20
> >_sigbe should decrement incyg before releasing the lock.
>=20
> I'll apply this but are you saying that this actually fixes=20
> your problem or that you think it fixes your problem?
>=20
> Thanks for the patch.
>=20
> cgf
>=20

It's hard to say definitively that it fixes the problem, since the
problem is so hard to reproduce.  I've been running stress scripts for
three days on six different systems, and haven't seen it occur.  But I
feel pretty sure that this fixes it - it certainly matches the symptoms
we see when we do happen to encounter the problem.

Ernie
