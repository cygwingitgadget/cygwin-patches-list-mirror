Return-Path: <cygwin-patches-return-8665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115610 invoked by alias); 9 Jan 2017 14:58:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115488 invoked by uid 89); 9 Jan 2017 14:58:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=UD:n, curly, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 14:58:21 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 8D617721E280D	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:58:14 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id DDBAA5E0210	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:58:13 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C17D3A8041E; Mon,  9 Jan 2017 15:58:13 +0100 (CET)
Date: Mon, 09 Jan 2017 14:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and others.
Message-ID: <20170109145813.GC13527@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170105173929.65728-3-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20170105173929.65728-3-erik.m.bray@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00006.txt.bz2


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3194

On Jan  5 18:39, Erik M. Bray wrote:
> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> index 1ce6809..a3e376c 100644
> --- a/winsup/cygwin/pinfo.cc
> +++ b/winsup/cygwin/pinfo.cc
> @@ -653,8 +653,29 @@ commune_process (void *arg)
>  	else if (!WritePipeOverlapped (tothem, path, n, &nr, 1000L))
>  	  sigproc_printf ("WritePipeOverlapped fd failed, %E");
>  	break;
> -      }
> -    }
> +	  }
> +	case PICOM_ENVIRON:
> +	  {
> +	sigproc_printf ("processing PICOM_ENVIRON");
> +	unsigned n =3D 0;
> +    char **env =3D cur_environ ();
> +    for (char **e =3D env; *e; e++)
> +        n +=3D strlen (*e) + 1;
> +	if (!WritePipeOverlapped (tothem, &n, sizeof n, &nr, 1000L))
> +	  {
> +	    sigproc_printf ("WritePipeOverlapped sizeof argv failed, %E");
> +	  }

          No curlies here, please, just as in sibling cases.

> +	else
> +	  for (char **e =3D env; *e; e++)
> +	    if (!WritePipeOverlapped (tothem, *e, strlen (*e) + 1, &nr, 1000L))
> +	      {
> +	        sigproc_printf ("WritePipeOverlapped arg %d failed, %E",
> +	                        e - env);
> +		break;
> +	      }
> +	break;
> +	  }
> +	}

Please have another look into the PICOM_ENVIRON case.  Indentation is
completely broken in this code snippet, as if it has been moved around
a bit and then left at the wrong spot.

>  }
>=20=20
> +
> +char *
> +_pinfo::environ (size_t& n)
> +{
> +  char **env =3D NULL;
> +  if (!this || !pid)
> +    return NULL;
> +  if (ISSTATE (this, PID_NOTCYGWIN))
> +    {
> +      RTL_USER_PROCESS_PARAMETERS rupp;
> +      HANDLE proc =3D open_commune_proc_parms (dwProcessId, &rupp);
> +
> +      n =3D 0;
> +      if (!proc)
> +        return NULL;
> +
> +	  MEMORY_BASIC_INFORMATION mbi;

Whoops, broken indentation again.

> +      SIZE_T envsize;
> +      PWCHAR envblock;
> +	  if (!VirtualQueryEx (proc, rupp.Environment, &mbi, sizeof(mbi)))

And here

> +        {
> +          NtClose (proc);
> +          return NULL;
> +        }
> +
> +      SIZE_T read;
> +      envsize =3D mbi.RegionSize - ((char*) rupp.Environment - (char*) m=
bi.BaseAddress);

Stick to max 80 chars per line, please, i.e.

  +      envsize =3D mbi.RegionSize
                   - ((char*) rupp.Environment - (char*) mbi.BaseAddress);

It might also be prudent to use another cast here, like, say, ptrdiff_t,
since this is for pointer arithmetic only anyway.

> +      envblock =3D (PWCHAR) cmalloc_abort (HEAP_COMMUNE, envsize);
> +
> +      if (ReadProcessMemory (proc, rupp.Environment, envblock, envsize, =
&read))
> +        {
> +          env =3D win32env_to_cygenv (envblock, false);
> +        }

Your function, your choice, but I'd get rid of the curly braces for
oneliners here.

> +
> +      NtClose (proc);
> +    }
> +  else if (pid !=3D myself->pid)
> +    {
> +      commune_result cr =3D commune_request (PICOM_ENVIRON);
> +      n =3D cr.n;
> +      return cr.s;
> +    }
> +  else
> +    {
> +      env =3D cur_environ ();
> +    }

Same here.

> +
> +  if (env =3D=3D NULL)
> +      return NULL;

Just as here.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYc6UFAAoJEPU2Bp2uRE+gqtUQAIvJuzRssOv2+/eE0Kb5PzdT
xWHwDRaxGNdQkgKQsLnvWNSEgATu/wgDy0BW7lyHpj4iCYZh07Q+SBSIyNCLq9DG
ABc0+n2kMGZsJRuZs8vmBMq+8z0glqvIiT5wSeUDWjxHgEIgUzVDELczE8xFJ4Fs
GveoxCpqOVxnBr1ev822W4xsz4LDJ3lyhQark35hV3uFN97rWKvZAppevf2slH+q
qwYcvVbGoCql9tKiKRlu2j5nZ62deNnnl+68KgcgZba8yECZq+C4vOYLkIrPI/eE
Q40DZ9Q2sxlwZQNIlV9yoknSh/69zbVH2/qjG1x+luG9QsV/cSI5M8R/uJJl8MDg
f4UoDfGCA8onytaTHm47DeqDxLLOzfCbYn1drCaX9QghW0Td1r5t0WQVPGKt+KG+
tana96T9Rll5SMWM5HPYY40ixvTtHpueJT8XP/a1bnTIS9I4oniSzpbmMLL4gRW2
WZwuO6cYICe5HF1xfh1YewR+kPu2O8dHeWs+xKiRPLxbB4dt0tgbDvQRrC5OTyOW
eZGBEdcZ53nmdHHE/Njc+Oi4EAvu/OluPhO1ltEROLD5wnl8QUWzFLGNqt/XQRAH
NQacUQRuQwigRuP8lHICbogtTQguyzZIx6OEYw2Pht7lWkj2+5FSeG6+t8qxHGds
WDDoS7d+MZ+ieib/SaPC
=5SUv
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
