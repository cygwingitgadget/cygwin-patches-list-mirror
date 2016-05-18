Return-Path: <cygwin-patches-return-8559-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117846 invoked by alias); 18 May 2016 19:23:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117797 invoked by uid 89); 18 May 2016 19:23:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=mailed, mouse, hood, frustrated
X-HELO: calimero.vinschen.de
Received: from ipbcc04766.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.71.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 May 2016 19:23:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 77094A803E7; Wed, 18 May 2016 21:23:10 +0200 (CEST)
Date: Wed, 18 May 2016 19:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
Message-ID: <20160518192310.GB5252@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org> <56EADD32.4010802@redhat.com> <56EDD62E.3040309@glup.org> <20160320150034.GE24954@calimero.vinschen.de> <20160329124939.GB3793@calimero.vinschen.de> <b45c2cb3-4c76-7213-cfc7-de4e2af79eb4@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <b45c2cb3-4c76-7213-cfc7-de4e2af79eb4@glup.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00034.txt.bz2


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2370

Hi John,

On May  8 16:43, john hood wrote:
> On 3/29/16 8:49 AM, Corinna Vinschen wrote:
> > John, ping?
>=20
> Sorry it took so long to reply, but I finally got around to cleaning up
> the patchset, I've mailed it separately.

I don't see the patchset anywhere.  Did I miss your mail or did it
fail to make it to this list?!?

> I was pretty frustrated at my
> slow Windows machine and the friction in dealing with the project,

What friction?  Was there anything I or others did to alienate you?
If there's some problem, please also feel free to discuss on the
#cygwin-developers IRC channel @Freenode.  You're apparently lurking
anyway.

> also sick for a while.

My sympathy.

And no worries if anything takes longer than anticipated.  We're not
on some tight schedule here :)

> > On Mar 20 16:00, Corinna Vinschen wrote:
> >> Does it really make sense to build up and break down a timer per each
> >> call to select_stuff::wait?  This function is called in a loop.  What
> >> about creating the timer in the caller and only arm and disarm it in t=
he
> >> wait call?
>=20
> Not fixed.  Managing the resource gets more complicated if you hoist it
> up to the caller with its various exit conditions.  Plus, doing that
> doesn't make the minimum or typical cost of select any less, it only
> makes the handling of events that select ignores slightly more
> efficient.  As I see it, ignored mouse events on the console are the
> only case where we're likely to see many ignored events, correct me if
> I'm wrong.

I don't know ATM.  I'll have another look when I review the patch but
actually we can also just keep it in mind for some later optimization,
*iff* it makes sense.

> >> Why?  It's a lot of additional debug output.  Was that only required f=
or
> >> developing or does it serve a real purpose for debugging user bug repo=
rts
> >> in future?  If so, I wouldn't mind to have a bit of additional descrip=
tion
> >> in the git log to explain the debug statements...
>=20
> Split out into a separate patch, apply or discard as you please.  I
> think it's useful for user bugs (when select is breaking, it really
> helps to see what's going on inside) but I don't feel strongly about it.

Ok.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPMEeAAoJEPU2Bp2uRE+gkPQP/2Hpv0YPJt3PGB4Zpq81uEE1
6kcojUhOQSk/g+2lexpnV/o2koaFOnm7G1YWRWdMoXxzOirT7VuKgHsHCjWjMTgr
GJFG6jGQ9YnVgFbOeqyQU/matSQRFrm7VrBGzYw7JWOhtW0VrW0HTXn49dn7p+gV
CHNFBlz0jl8UHB5nRst9eBR65pGzoVPPaPPPkyowiyS/K5TZCzF0JZ1vxF8RWfyP
83s81TGXxtOZOtfXa6+v6ee+7wq/7TS/PPWh37PTD5cINk3bIoXsK6rYWxdlOhTt
zppSDc0XNMDGiKNhutSwwZVzRc7PpmmkKvce/1mJiGESRvN/xRyAqgcJ8GuNhimz
lhk/0+E+B29Y0Xh8G23IzxDEeaQ9O56GZQfF4jG4wf7BxZYlkOa64efcbVQ3z1wl
AQ7UMqPWo9Q1PQqspFw2Xj+gY89JEmjwZ7ypCm5YGdfvAsIXQQli6WebTu6tcrb6
WSPEoVyK22sAkrKVN+Y7KXTt4IkcXENIqIN7YpkpbyPPE+VZQpAZBfYd0E7jy4zW
GvtGmjrPXqLzrVJ4I/MJQ+EIaUJDA29Dhae25j8Bgr8d25IRfAH2V5cGyAknDiR/
6Ssi6RFPHYFffdpR4YyA+WLXuwz+7dbXYwJuwfqhCRdFq8k0mSamiow6M2Q0C4ax
sjJbyV6gnuqOg56NEUVK
=Gyn7
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
