Return-Path: <cygwin-patches-return-8012-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4741 invoked by alias); 4 Aug 2014 19:28:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4729 invoked by uid 89); 4 Aug 2014 19:28:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 04 Aug 2014 19:28:30 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s74JSSSx022879	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 4 Aug 2014 15:28:28 -0400
Received: from [10.3.113.131] (ovpn-113-131.phx2.redhat.com [10.3.113.131])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s74JSS3G019620	for <cygwin-patches@cygwin.com>; Mon, 4 Aug 2014 15:28:28 -0400
Message-ID: <53DFDEDC.1000305@redhat.com>
Date: Mon, 04 Aug 2014 19:28:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: docs: improve package maintainer instructions
References: <53DCE738.3090406@redhat.com> <1407117639.2942.3.camel@yselkowitz.redhat.com> <20140804091439.GE2578@calimero.vinschen.de>
In-Reply-To: <20140804091439.GE2578@calimero.vinschen.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="NTFWN9suMWaLfphPaX6MvfHlBND9BP9nS"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00007.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NTFWN9suMWaLfphPaX6MvfHlBND9BP9nS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1639

On 08/04/2014 03:14 AM, Corinna Vinschen wrote:

> I'm fine with the changes, barring Yaakov's nits.

I fixed those.

>=20
> However, while we're at it shouldn't we change from "cygport is the
> accepted way to make Cygwin packages" to "cygport is the required way to
> make new Cygwin packages and the (strongly) recommended way for package
> updates"?  I for one think it's time to switch to a single packaging
> method.  After all, you don't have rpm packages in Debian or apt
> packages in Fedora.  This will also greatly simplify to set up an
> automated build system for Cygwin packages at one point.

Agreed; so here's what I added in before pushing my patch:

@@ -283,9 +288,12 @@ etc...
   <li>Ensure that your package handles being installed on binary and
text mounts correctly. </li>
 </ul>

-<p>While you could make a package satisfying these requirements by
hand, the
-accepted way to make Cygwin packages is using the cygport tool, which
-automatically handles most of the above issues for you.</p>
+<p>While older packages exist which satisfy these requirements by hand, the
+only accepted way to make a new Cygwin package is using the cygport
tool, which
+automatically handles most of the above issues for you.  It is also
+strongly recommended to convert existing packages to cygport when
+updating them; ask on the <tt>cygwin-apps</tt> list if you need help
+converting an existing package to use cygport.</p>

 <h2><a id=3D"making_srcpackage" name=3D"making_srcpackage">Making a package
with cygport</a></h2>



--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--NTFWN9suMWaLfphPaX6MvfHlBND9BP9nS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 539

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg

iQEcBAEBCAAGBQJT397cAAoJEKeha0olJ0Nq1nwH/if2BeNpXjc68fwBX+oS4f1H
0eDsmM683/NVbPLJ33x42C+q2/SRqaR2yQ5kFflWc2HYHD3z4HHuU2VF6ehr52cx
mB1ttkcs//bVlvSwIJovRUe5kFYaQy9Yd57Mn7PWe1se5SAAvODLEwEPXC2FhqES
WlDtfwRi/zEO4DxkqLUPr8HBEnKv5tZAtJrAenboB8DPwJNFb4AJFAi2Ec57D8b8
EIpnWYxJjcFn+K9y4+/5JTQ4et3NgastQ7HTsjfJPQzec5pz16N7ktqFxGEIdMRr
FyJ4QNtnWsZR1DMrQyLfRB5+t2ll5xvimXMCNQuA31q+LXvGWFxpgka30PS2f8o=
=szVX
-----END PGP SIGNATURE-----

--NTFWN9suMWaLfphPaX6MvfHlBND9BP9nS--
