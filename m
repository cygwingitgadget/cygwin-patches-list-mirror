Return-Path: <cygwin-patches-return-8760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38080 invoked by alias); 24 Apr 2017 12:19:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38016 invoked by uid 89); 24 Apr 2017 12:19:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=wondering
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Apr 2017 12:19:25 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 53EB6721E281A;	Mon, 24 Apr 2017 14:19:23 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AE6C05E0416;	Mon, 24 Apr 2017 14:19:22 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9237CA8038E; Mon, 24 Apr 2017 14:19:22 +0200 (CEST)
Date: Mon, 24 Apr 2017 12:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
Message-ID: <20170424121922.GA5622@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Santos <daniel.santos@pobox.com>
References: <20170424093754.536-1-daniel.santos@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20170424093754.536-1-daniel.santos@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00031.txt.bz2


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3650

Hi Daniel,

On Apr 24 04:37, Daniel Santos wrote:
> The root cause of problem with strace causing long delays when any
> process enumerates the process database appears to be calling
> myself.thisproc () from child_info_spawn::handle_spawn() when we've
> dynamically loaded cygwin1.dll.  It definately fixes the problem, but I
> don't konw what other processes dynamically load cygwin1.dll and, thus,
> what other side-effects that this may have.  Please verify correctness.
>=20
> Please see discussion here: https://cygwin.com/ml/cygwin/2017-04/msg00240=
.html
>=20
> Daniel
>=20
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---

I was just looking into this myself, but I was looking into the weird
Sleep loop itself and was wondering if that makes any sense at all.

Assuming pinfo::init is called from process enumeration (winpids::add)
then there's no good reason to handle this procinfo block at all.  It
doesn't resolve into an existing "real" Cygwin process.  And that's
exactly the case that hangs.

So my curent fix would have been this:

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index e43082d..090fcb9 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -314,12 +314,18 @@ pinfo::init (pid_t n, DWORD flag, HANDLE h0)
       /* Detect situation where a transitional memory block is being retri=
eved.
 	 If the block has been allocated with PINFO_REDIR_SIZE but not yet
 	 updated with a PID_EXECED state then we'll retry.  */
-      if (!created && !(flag & PID_NEW))
-	/* If not populated, wait 2 seconds for procinfo to become populated.
-	   Would like to wait with finer granularity but that is not easily
-	   doable.  */
-	for (int i =3D 0; i < 200 && !procinfo->ppid; i++)
-	  Sleep (10);
+      if (!created && !(flag & PID_NEW) && !procinfo->ppid)
+	{
+	  /* We're fetching process info for /proc or ps so we can just
+	     ignore this procinfo. */
+	  if (flag & PID_NOREDIR)
+	    break;
+	  /* If not populated, wait 2 seconds for procinfo to become populated.
+	     Would like to wait with finer granularity but that is not easily
+	     doable.  */
+	  for (int i =3D 0; i < 200 && !procinfo->ppid; i++)
+	    Sleep (10);
+	}
=20
       if (!created && createit && (procinfo->process_state & PID_REAPED))
 	{

>  winsup/cygwin/dcrt0.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index ea6adcbbd..bbab08725 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -664,7 +664,8 @@ child_info_spawn::handle_spawn ()
>    my_wr_proc_pipe =3D wr_proc_pipe;
>    rd_proc_pipe =3D wr_proc_pipe =3D NULL;
>=20=20
> -  myself.thisproc (h);
> +  if (!dynamically_loaded)
> +    myself.thisproc (h);
>    __argc =3D moreinfo->argc;
>    __argv =3D moreinfo->argv;
>    envp =3D moreinfo->envp;
> --=20
> 2.11.0

Your patch looks simple and elegant.  I'm just not sure about the side
effects it may have if a process is missing its procinfo.  No problem
for strace and ldd, apparently, but other processes...?

We could try it for a while.  I'm off all of May anyway and I could
create a test build for that time...

Btw., would you mind to send a BSD waiver per
https://cygwin.com/contrib.html and
https://cygwin.com/git/?p=3Dnewlib-cygwin.git;f=3Dwinsup/CONTRIBUTORS;hb=3D=
HEAD
Your patches are covered by the "trivial patch" rule yet, but if you
look into providing more patches you don't have to care anymore.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/e1KAAoJEPU2Bp2uRE+gh0sP/2xFrveTnxgALXmjlnJKzZAX
aTEUKtd2yUzTppVkaQY5frQrMVfuPU4kr/lA4tqou7mkcfdhunaUREjnY5XbewMW
Ds7zxCKwxBi/No3ddtCYSXLjYk48xcjyErolnkrcNK3a71yKjMcfUL7kRuQe0iBL
cQ6JZSANVf7UHDgNkiSvFIi5cjrUjrGMcFoXVoz7aJWGnvACSc/q4Yg3faClRb6A
2SAkYE8Xojnl0LOfk9zMeu5x7ptQNmwf+dT/Zkx0pRt/3lXMH1AAn/2Y5lfdi2nG
amvwdHMy1sC0p8UIT3Tt8HNXzLTjiHGRcTMQ1fQlJCrrZnVk9hQpBfxSlZN7xoie
KL0y44tvgejTRIGjX5+SPlDw2tpcrh3/1CY1nlhM0f0UI1s5yGgf0nkf5Qt1Lxby
pQae6qDCa3bwX7j/5W6eGajnklnhtccNsjA1Bw4xL4M5T4It1I6pE3waIQh6l4ey
jAwzjryHMccmpQRZwIOBm4NpNMLEMXjGRkiNueJa10/cdZ2jIFqf4HuGGQq1OEv/
5tpuGjVkS2AIoKr8glCJgwVhrfW2ZIXs3BlzM9MPliJ1PC5C71Le34d80hrRVO/M
Grxz3nPMmIzMLgJbINUuokDfalnrmZgF4Dwse6duyK7I/7nT0p8Zazj865hvaq0i
xeyh3imbJ25G6rgutOJp
=I4t8
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
