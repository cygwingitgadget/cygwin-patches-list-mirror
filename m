Return-Path: <SRS0=cL0F=JQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 2098243786B4
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 13:18:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2098243786B4
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2098243786B4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795785499; cv=none;
	b=fZxOVZkQqG3HFNcvqfMob0NXNMDhQsoStK+JDW1jEvlKh0HO9z4AsLj/C1y+k5k/MZmcluqvnJSUumFNm7/zlI8LzVR9IvY6ait+Y077SLwToEs2D6hDUNVLDSdKn6UYqafEcb4xzW/lbaO5UyBeQj56LF/zux/4gDDAxEUcqv0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795785499; c=relaxed/simple;
	bh=V/+AvXLT9ruiaqlBK+JIus7jve2l/C2YQ69VqLdP9oQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=OVkHMBmK/ovdzsDqP/+PCj1zKI3X+ruYK9UPUYjUjM60plg8/fLGvwm4SHbziFr+6WnndQObcSOjTn7PVqU4BAfN99j5JBTQEP2yqa0eXpf269MDP1S4MX63TV+GYlJzXqp2etPaSlmfj9wb3/KEVtVvT7a6YVZ1zkWFAUbAXpo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=TsObGWIH
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2098243786B4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=TsObGWIH
DKIM2-Signature:  i=1; m=1; t=1795785497;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGN5Z3dpbi1wYXRjaGVzQGN5Z3dpbi5jb20+;
 d=gmx.de;
 s=s31663417:rsa-sha256:FF2VorwmnWiQyX4DHJ6nWcxapyHJ
   tRuaVAEvAEoEXAckc5Dolv3trTqcDkd9Dg04G7A11ru+aByIXrPVorbiHlle9FnpaMhy2kvVhyx
   HXUTLfmwyUSF3TXFqVcd5RSs7RWw8ogUsIjyoipJlWyV51Uzr2L5m+AsbKuX7Pnu9IFERTAQGDS
   aIk2kuoE0OttcUSImc1g27Z83fvdt2CfibZ8MLbOMe4gfr/AHSonZSRu4zsz6FXWdK3Nsx+4P3n
   RH98VSJQcZPawYNn/kSVIFMbByNIt/BPbEp0RhCld4TTqHnR/JqKBIhTueDyA0XXW/wbraGQoJ3
   2VfVMPKEx1qfIg==;
Message-Instance:  m=1;
 h=sha256:
   +C/cseESI7Bnzt9tOlDYGDKatwQGlOjIY1ZDJgKPGzQ=:
   V/+AvXLT9ruiaqlBK+JIus7jve2l/C2YQ69VqLdP9oQ=,
  sha512:
   3b9wh38tbeKaIvb7xHgV1PVmled6M46LOpUSj3EwDDCLZbK34c4X4k1gwLfN3k5QCXcMV+kOmSToSGU/jakvBw==:
   /sjETkl7zBiyYkW66cq0Oz4OOkYNkqvv3nmVgrc0XamYyBpptFPJe6tKpvMcfwuNq5R+oO9thclKJuext5dhcQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795785497; x=1796390297;
	i=johannes.schindelin@gmx.de;
	bh=ZiikEsT/qqORSZA4JXsQAkXXoC2vYY9qsbFKkEzBz/Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TsObGWIH42EccCVq+bQ2BZIWFD/yy/YTqdZG2Bzj2cPet9/Zgi1FiALL3enREjlJ
	 LpvH7UMEPXXGQqO6GI/TcEY1FL++xNrN8dBfnTrgOBBPguKAE3ANAaTKSOMA2FQZr
	 XEr4+YqoAxV436Jdb1PbzjmpdTv4ofPWv07yKNwpxjHLJFmm3RFERejBiIc2CUg3y
	 O3wCX9dgs+UEZFT/c9/XWjM4U4eyKb+AFyh6nxCB1k8iBDGWbP4vnEEv8rSY8o+UC
	 buqjCQM9oLiwBAl5IcKZ1E7BJqwoFrPQqiqK6/9fO1QMvbjJ+6nS4BBrSAB+v+vLK
	 rMG4FEqrNgYmM619lA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1yWlZW2eDj-00wQKE; Fri, 27
 Nov 2026 14:18:13 +0100
Date: Fri, 27 Nov 2026 14:18:11 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not use terminfo to determine the terminal
 capability
In-Reply-To: <20261030141034.11993-1-takashi.yano@nifty.ne.jp>
Message-ID: <c91b3be9-3f14-8baf-7fd6-825a2cbce1be@gmx.de>
References: <20261030141034.11993-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:xnSfgpALFVBUpiF1OxNiY7lGub94ZuYgrQ2DaTH0JcqIh9RuRmK
 NZInGzbTaievOePfhzHnjHF4eNnZN7kn4Yrh1mrqfxfyQfTJegIi63YEACBAkklcqhErh9V
 I4ip1razBe1659VkmCeX0aNW+3IK6Btuzypaqx5iPwlLJAsHw53rPvH5NUd+eB0/J+6pRvz
 jW1i3gwATKf/sS61Yn7/g==
UI-OutboundReport: notjunk:1;M01:P0:UBk6sLt5h4A=;IbC+ww2cL+iEiYl5LaeBno9CtR1
 +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
 PkM2RBcDAgfA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 30 Oct 2026, Takashi Yano wrote:

> Currently, pty checks whether the terminal has ANSI escape sequences
> support which is needed by pseudo console using terminfo. If not, pty
> does not start psuedo console. However, it does not seem natural for a

s/psuedo/pseudo/

> POSIX emulation layer to refer to terminfo. This patch disables terminfo
> lookups and relying solely on checking the CSI6n responce with a
> timeout.
>=20
> Fixes: 4e08fe42c9f3 ("Cygwin: pty: Disable pseudo console if TERM does n=
ot have CSI6n.")

Thank you for working on this!

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
>=20
> ---
>  winsup/cygwin/fhandler/pty.cc | 76 +----------------------------------
>  1 file changed, 2 insertions(+), 74 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 6d0183f5d..39525bd08 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -4274,75 +4274,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *tty=
p, DWORD force_switch_to)
>      }
>  }
> =20
> -static bool
> -has_ansi_escape_sequences (const WCHAR *env)
> -{
> -  /* Retrieve TERM name */
> -  const char *term =3D NULL;
> -  char term_str[260];
> -  if (env)
> -    {
> -    for (const WCHAR *p =3D env; *p !=3D L'\0'; p +=3D wcslen (p) + 1)
> -      if (swscanf (p, L"TERM=3D%236s", term_str) =3D=3D 1)
> -	{
> -	  term =3D term_str;
> -	  break;
> -	}
> -    }
> -  else
> -    term =3D getenv ("TERM");
> -
> -  if (!term)
> -    return false;

So if `TERM` was unset (and I assume, with terminfo installed, also with
`TERM=3Ddumb`) this returned `false`, which...

> -
> -  /* If cursor_home is not "\033[H", terminal is not supposed to
> -     support ANSI escape sequences. */
> -  char tinfo[260];
> -  __small_sprintf (tinfo, "/usr/share/terminfo/%02x/%s", term[0], term)=
;
> -  path_conv path (tinfo);
> -  WCHAR wtinfo[260];
> -  path.get_wide_win32_path (wtinfo);
> -  HANDLE h;
> -  h =3D CreateFileW (wtinfo, GENERIC_READ, FILE_SHARE_READ,
> -		   NULL, OPEN_EXISTING, 0, NULL);
> -  if (h =3D=3D NULL)
> -    return false;
> -  char terminfo[4096];
> -  DWORD n;
> -  ReadFile (h, terminfo, sizeof (terminfo), &n, 0);
> -  CloseHandle (h);
> -
> -  int num_size =3D 2;
> -  if (*(int16_t *)terminfo =3D=3D 01036 /* MAGIC2 */)
> -    num_size =3D 4;
> -  const int name_pos =3D 12; /* Position of terminal name */
> -  const int name_size =3D *(int16_t *) (terminfo + 2);
> -  const int bool_count =3D *(int16_t *) (terminfo + 4);
> -  const int num_count =3D *(int16_t *) (terminfo + 6);
> -  const int str_count =3D *(int16_t *) (terminfo + 8);
> -  const int str_size =3D *(int16_t *) (terminfo + 10);
> -  const int cursor_home =3D 12; /* cursor_home entry index */
> -  if (cursor_home >=3D str_count)
> -    return false;
> -  int str_idx_pos =3D name_pos + name_size + bool_count + num_size * nu=
m_count;
> -  if (str_idx_pos & 1)
> -    str_idx_pos ++;
> -  const int16_t *str_idx =3D (int16_t *) (terminfo + str_idx_pos);
> -  const char *str_table =3D (const char *) (str_idx + str_count);
> -  if (str_idx + cursor_home >=3D (int16_t *) (terminfo + n))
> -    return false;
> -  if (str_idx[cursor_home] =3D=3D -1)
> -    return false;
> -  const char *cursor_home_str =3D str_table + str_idx[cursor_home];
> -  if (cursor_home_str >=3D str_table + str_size)
> -    return false;
> -  if (cursor_home_str >=3D terminfo + n)
> -    return false;
> -  if (strcmp (cursor_home_str, "\033[H") !=3D 0)
> -    return false;
> -  return true;
> -}
> -
>  bool
>  fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
>  {
> @@ -4355,10 +4286,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHA=
R *env)
>    int len;
>    int wait_cnt =3D 0;
> =20
> -  /* Check if terminal has ANSI escape sequence. */
> -  if (!has_ansi_escape_sequences (env))
> -    goto maybe_dumb;
> -

... immediately skipped the ANSI escape sequence handling. But now we no
longer do that, trying to handle ANSI escape sequences even for `TERM`
being unset, empty or `dumb`.

But I think we still want the ANSI sequences to be withheld for those
quite common scenarios, and not send them and then fix them up via
Backspaces.

Besides:

>    /* Check if terminal has CSI6n */
>    WaitForSingleObject (input_mutex, mutex_timeout);
>    /* Set pcon_activated and pcon_start so that the response
> @@ -4410,7 +4337,8 @@ not_has_csi6n:
>    get_ttyp ()->pcon_start =3D false;
>    get_ttyp ()->pcon_activated =3D false;
>    ReleaseMutex (input_mutex);
> -maybe_dumb:
> +  for (int i =3D 0; i < 4; i++)
> +    WriteFile (get_output_handle (), "\b \b", 3, &n, NULL);

In the failure path, this now _always_ sends backspaces, even if the ANSI
sequences were processed by the terminal?

Another writer can print legitimate text that this cleanup code would then
erase.

Ciao,
Johannes

>    get_ttyp ()->pcon_cap_checked =3D true;
>    return false;
>  }
> --=20
> 2.51.0
>=20
>=20
