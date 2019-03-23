Return-Path: <cygwin-patches-return-9223-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109400 invoked by alias); 23 Mar 2019 20:46:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109344 invoked by uid 89); 23 Mar 2019 20:46:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 20:46:32 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MzhWp-1glzKV2nL7-00vjiD; Sat, 23 Mar 2019 21:46:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3A2CAA80751; Sat, 23 Mar 2019 21:46:25 +0100 (CET)
Date: Sat, 23 Mar 2019 20:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
Message-ID: <20190323204625.GD3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,	cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de> <8e8f788c-83c8-1260-011f-055b19001c44@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <8e8f788c-83c8-1260-011f-055b19001c44@SystematicSw.ab.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00033.txt.bz2


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 602

On Mar 23 14:32, Brian Inglis wrote:
> On 2019-03-23 12:36, Corinna Vinschen wrote:
> > On Mar 23 18:17, Achim Gratz wrote:
> >> replacing one lie with another that is less easy to spot doesn't sound
> >> the right thing to do.  How about ps if reported "N/A" or something to
> >> that effect instead?
> > 1 Jan 1970 may also be a good hint...
>=20
> Except it's shifted to local time so always inconsistent unless we fudged=
 with
> _TM_GMTOFF and string shuffling or format %b %Y?

Just stick to your orignal idea, we go with that for now.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyWmyEACgkQ9TYGna5E
T6DyHw//bS5QbetZq1GBVcI4axLTYFPlsfo9Wnk0sjgQ9YQzYIJjZMhjx0Qawvux
D91Y5+4tBtVmO+6USMSCySG4fdzWrU726M4gbgYaV4sygnbAS3GR5eQf49KTZSnL
N0pm+LqBkN2lpAlAoG9IoOjyTVGEe0wJyfl/OZteZUl5FLAuYlLyvp25jmUHKNAt
pnlJy6GWw47LTQhyEzA8DhhSdHhPczOlRvGsEKmuBhFLnnJbXo3vmBK7HaSjRAqo
6RD9G9YjlMHqD5y468pEZhIgI9zgy6rS+L7supjT0FQTCItQSYbgWNFCFgodC9Wf
wEHE9wTCzSzKxvuWPnRIJyLPluJ70GWDwNkSIRnWV+Lb7gQkTwWRD5S9Vho9CGyV
iEdtCcoc8YwEsBaS00+N3/n0s/kvg9Ox86PZMbmIleKZxVoHngJkFl+AoylvhKvs
2HZrfhcEEnA9yoiX+fWJVhX/Lkeq5fr9h/1nHURMhZw4dXmtFdoJpire97VZ/3Li
VrdOKIMqUL4dzr9GtN3EC7HX18e0FgCyDsyOQ0Ev4fpxxmpcZznpM9hHnQFuB3mM
s5vw2Afgg6k/xNmtDymgaj0PtbFeohOuZE3vSv8iw39DwB2DVC82oiQ9HCShoNrg
lTVBJVjl63sVIJ/QNyKjc3KhF2yPRvQLXy88NCKVih0LEeoKqak=
=jGmm
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
