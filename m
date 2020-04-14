Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 850EA385DC1C
 for <cygwin-patches@cygwin.com>; Tue, 14 Apr 2020 10:37:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 850EA385DC1C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M26iv-1jQEtB3hQf-002Taq for <cygwin-patches@cygwin.com>; Tue, 14 Apr 2020
 12:37:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5A667A826F8; Tue, 14 Apr 2020 12:37:48 +0200 (CEST)
Date: Tue, 14 Apr 2020 12:37:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] proc_cpuinfo: Add PPIN support for AMD
Message-ID: <20200414103748.GB3943@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200411043527.6881-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20200411043527.6881-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:mqMeScdmDWf+/yO4GfKqH39ZNVXJQivKRwNLAvqAjedSkcXe5Zw
 7jP01zmyxL+wArzv5jn9jidk2uWudNU3LRFxHvPWFUl3vIro5Af8Hg7VUMhPFjppU904sP5
 da79y5332xk5gPvHEqQXYPgc/8IvYBEj6znPo388f6pKKz2dTiIRSK8715ljsEVIdM/A+UB
 7sYfO0Aw83kBoY1BMSRbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lPouaiwWQMM=:3IJBvrbeBp3IlLaubR9Jgq
 KxQkF83Q3SUOJncCfq8otP06fskXt7dM9yjFLeDjbnoe4jCpIiDmoT1kIgPZCk/waKNEuQyIe
 mFJUUDjU3YSnVwIuZ7bs3s7zJrXo8oTb8vop57bD/hXyUFdNdkW3Zpjxkksh6K1dRLJ1qUPtF
 B44EkgnfOoPsHQT624c5HjVG+0X+WQTE56SWy7Ade8snaxlKSBPYU0P818MfzAFT5Go+n4UcB
 VFTp7LgsgcQ4yHUJAUbUlVS5zjWoderaHVrhUyWwMA0B6KXwRQE0QeFhBmAy4SYw1slIk0d5u
 b1ZIqlKH/LtChSM3mGyYyVeYwLe1wqF4YwoSM5sx2/4rUnLHwnS+BRBZRgbYDFpeN25Iw7ynA
 ZoC7SjMwz1wYNtTHFjXUs+VahFHHZBcO8qdPQTZQWZ9xtLh/MvZN2FY1aSKZcSduWPbUfgRwg
 QK7WeSV+iMJv/8DvYzs/nJzabw2jDv1JrgYmx62CiQ6aomlaW7PUlolvrkqZpXGpaAf0z2vTg
 Ud6VHVC4zqm43T/ymyj2wxEOK6o6nk4PDBvgDmKQ3WBJaVHS/R2sHaeAJldRmx8Jy+HHKFhS7
 jdUwSQGvJ+ZT82RJlKfrYMi5ne+wRDVDpjqr3MNhKXRvSEb3X7YhQg9p6O0u4mMSGN8k63U0o
 3Fl+y09q4zA7xxH014/PF23y+Fz0Kr6XJzRLRhlP/gX+Ogb704FCESWHehEcTxaw1BBuJKvvO
 QW15xZBJRaLWqhc89yuWgsu5jouKuyMnL9EanmXpVP3wL0bW78GcXo1/0KnmmhgF2+58zEjNb
 VDAmQj3BFSN8iKFpJlYTdNmji67h1eZV+KY8jj7ywaBG2HHqppenhJ+/yiTS5AiNGN6RtYu
X-Spam-Status: No, score=-107.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 14 Apr 2020 10:37:54 -0000


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 10 22:35, Brian Inglis wrote:
> Newer AMD CPUs support a feature called protected processor
> identification number (PPIN). This feature can be detected via
> CPUID_Fn80000008_EBX[23].
> ---
>  winsup/cygwin/fhandler_proc.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
=2Ecc
> index 605a8443f0..5c5f4bd9ef 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1262,6 +1262,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  /*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec=
 */
>  /*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
>  /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on =
*/
> +	  ftcprint (features1, 23, "amd_ppin");     /* protected proc id no */
>  /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
>  	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
>  /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware =
*/
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl6VknwACgkQ9TYGna5E
T6DpGxAAlKRK/JpOxq2NQGhD2vyP9og7F/OSnKneDi3o/1wi9CSWNmI9NV5MwKQJ
Kll6MNaN6cqnvmwgCb7nM0EgWQ7deCnpTOIPdzn8JarBlFoDYhh6DZ39N4qRWiYj
lxX+WqDNk0wlh/BvCB2EBfMYBW6M3G7o922kFywr2ayICQzHqWL6cB2TpgGG7Nwi
MYAsel4QCEG0fQKhdGqCcYNfg1Dt4a0YldiHjBU3qKsNERLa14fWiUDhtKGMqb7W
ki+P9wSkW1QFiIaZPB5osHN1gNK2hMslsFzARCf6WCPw1L7FabayVVUg+juymHLl
YPjxwqiubcunlt2kz1/VcseNmfBTC/tdLNgfFqM6ULcQKxiqQ7S77GzFSR8mdIvc
sNGx4DAnb9h16qtyzDLJPGMVcvF8tc/BRt2L5pURm+xu9LNUfYOBIppdCi8AN/RJ
VccQzmnJq13wmRa+/gHetRHZJGVJisXc17RdA5oVzIVseGALtg5cwueFUEil5fkJ
4Z2Jb7hneAcR8vbNStseiEknCCh/TjoIKXFvNIu3Q+8tuf5x/CqxcRZ8/bCacsKk
b2qkr04xWX6CbGZHVYy1HkEJ1Uk6R6BvD61Hr9jPsbsQb7DVywSohhgH2C11GVwj
B9KwBqU7xYrP3QTbAARyVCfXiIR3qW1S4Kxq76q2Sn29iHIbV0w=
=Hdi1
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
