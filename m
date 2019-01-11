Return-Path: <cygwin-patches-return-9195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26750 invoked by alias); 11 Jan 2019 09:19:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26736 invoked by uid 89); 11 Jan 2019 09:19:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-125.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 11 Jan 2019 09:19:06 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MrxfX-1h5PMI2hnx-00o0Rc for <cygwin-patches@cygwin.com>; Fri, 11 Jan 2019 10:19:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4E9F9A8075A; Fri, 11 Jan 2019 10:19:03 +0100 (CET)
Date: Fri, 11 Jan 2019 09:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Message-ID: <20190111091903.GU593@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190110175635.16940-1-kbrown@cornell.edu> <20190110180253.GO593@calimero.vinschen.de> <3f1d89ac-a91a-e8c5-7fc2-61a8a30ecb3e@cornell.edu> <20190110201657.GP593@calimero.vinschen.de> <bb133df2-d836-387e-6cd1-cbe6b6749e43@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Content-Disposition: inline
In-Reply-To: <bb133df2-d836-387e-6cd1-cbe6b6749e43@cornell.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00005.txt.bz2


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2404

On Jan 10 23:20, Ken Brown wrote:
> On 1/10/2019 3:16 PM, Corinna Vinschen wrote:
> > On Jan 10 18:36, Ken Brown wrote:
> >> On 1/10/2019 1:02 PM, Corinna Vinschen wrote:
> >>> On Jan 10 17:56, Ken Brown wrote:
> >>>> Also fix a typo.
> >>>> ---
> >>>>    winsup/cygwin/fhandler.h | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> >>>> index d02b9a913..7e460701c 100644
> >>>> --- a/winsup/cygwin/fhandler.h
> >>>> +++ b/winsup/cygwin/fhandler.h
> >>>> @@ -832,9 +832,10 @@ class fhandler_socket_local: public fhandler_so=
cket_wsock
> >>>>    /* Sharable spinlock with low CPU profile.  These locks are NOT r=
ecursive! */
> >>>>    class af_unix_spinlock_t
> >>>>    {
> >>>> -  LONG  locked;          /* 0 oder 1 */
> >>>> +  LONG  locked;          /* 0 or 1 */
> >>>
> >>> Huh.
> >>>
> >>>>    public:
> >>>> +  af_unix_spinlock_t () : locked (0) {}
> >>>
> >>> Why do we need that?  The spinlock is created as part of a shared mem
> >>> region which gets initialized to all zero, no?  Or do you plan to use=
 it
> >>> outside of this scenario?
> >>
> >> At the moment I'm using it in the new FIFO code, and I'm not sure yet =
whether it
> >> will eventually be in shared memory.  (Until I get things working, I'm
> >> postponing thinking about whether I need shared memory.)
> >>
> >> Would it be better to use some other kind of spinlock until I know for=
 sure that
> >> I need shared memory?  My only reason for choosing af_unix_spinlock_t =
is that I
> >> was copying code from fhandler_socket_unix, and this saved me the trou=
ble of
> >> learning about other kinds of spinlocks.
> >=20
> > The above patch shouldn't hurt in the least since it's not used anyway
> > when allocating the shared mem region used by the AF_UNIX socket code.
> > If it helps you, I can push it, no problem.
> >=20
> > Just make sure this spinlock is the right thing for you.  The idea here
> > was to have a fast, sharable(*) lock without context switching, only
> > guarding small code blocks which don't hang due to resource starving.
> >=20
> > If you have to guard more complex code chunks, it might be better to
> > use a kernel locking object like mutex or semaphore.
> >=20
> >=20
> > So, push or no push?
>=20
> Please push.  Thanks.
>=20
> Ken

Done.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlw4X4cACgkQ9TYGna5E
T6CbeQ//WrQAsFSzKlX2X74sCDkKemoY2J9nkxFGzvnerHNjuGj04gXZfnja+GFt
QUfx07en+2MGWVmsU/1qjxhJ5zkWOYOxLx87ac0kT4qsqLlBatwp9qMzcz9yQN6u
vxIWt9AY5bDRguX+cuW2os0AwozzllZoAWIE3K8n16exdIygiSQCH1+xzNY82UR8
3OS+PC16sklh1NCPNDhe052fuGMX2iBMuIx7W5wlKs5+pM5jIkXWGLf34svrgU6o
Fed/fpdwI2vmtRCbJdev406Ufez/EC8EKUvQM0ArgqG8ciPiRuSQ81Rl1uczitJD
k2Fr3YlU621LMNr+MXfczw4Vppm7A+Q/gbYT1fVHuRzx1jeOxUv87UaWBluAxq4w
E97EeY5p5UlQFCymbN40z33HGugUlrNckBOfA62RG/Q9BMewx6ddezCzJzwK7b7B
yXXS2PmQV+C0gRUQWf7nj5qfjkvFbt4woiuR9HnAx2k9fw1bLGUA46iLZKc3yA9p
Bd7OFPoXxy0fQOiZZN3KmjNUsrZ1+SVCwcVCv1Pg5tCB56ihSuv5eNh/Xcuj52FU
/R6Rk9Ud5xnjf4ODYGZDX0bCDrhMeVLa/sV9dffW5cC++8nBjNIRd3gBzhg3hEnn
ugJCiO00x3n66+ihC7j2ol+NQ0V5M2JoGfbnexeMeCaDgbJF0I8=
=tDRU
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
