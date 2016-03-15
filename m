Return-Path: <cygwin-patches-return-8408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106394 invoked by alias); 15 Mar 2016 13:47:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106378 invoked by uid 89); 15 Mar 2016 13:47:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-87.4 required=5.0 tests=BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=separated, H*R:U*cygwin-patches, HX-Envelope-From:sk:corinna, work
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 13:46:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3C6EFA80685; Tue, 15 Mar 2016 14:46:55 +0100 (CET)
Date: Tue, 15 Mar 2016 13:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console requested =?utf-8?Q?reports_?= =?utf-8?B?4oCT?= Re: [ANNOUNCEMENT] TEST RELEASE: Cygwin 2.5.0-0.6
Message-ID: <20160315134655.GC4177@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de> <56E80B4B.5040106@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <56E80B4B.5040106@towo.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00114.txt.bz2


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 5539

Hi Thomas,


Thanks for the patch.  I have a few comments, though.

On Mar 15 14:16, Thomas Wolff wrote:
> On 13.03.2016, Corinna Vinschen wrote:
> >- Make buffered console characters visible to select().
> >   Addresses: https://cygwin.com/ml/cygwin/2014-12/msg00118.html
> Triggered by this change, I thought I'd revisit an old problem
> (https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html),
> and in fact =E2=80=93 requested console reports now work!
> This makes the following ESC sequences work:
> ESC[c sends primary device attributes
> ESC[>c sends secondary device attributes
> ESC[6n sends cursor position report
>=20
> Changelog (old format):

Just drop this line from the comment, please.  If you send the mail
via git format-patch/git send-email I can simply apply it with git am
including the entire text in the git log.

> 2016-03-15  Thomas Wolff  <towo@towo.net>
>=20
>     * fhandler.h (class dev_console): Add console read-ahead buffer.
>     (class fhandler_console): Add peek function for it (for select).
>     * fhandler_console.cc (fhandler_console::setup): Init buffer.
>     (fhandler_console::read): Check console read-aheader buffer.
>     (fhandler_console::char_command): Put responses to terminal
>     requests (device status and cursor position reports) into
>     common console buffer (shared between CONOUT/CONIN)
>     instead of fhandler buffer (separated).
>     * select.cc (peek_console): Check console read-ahead buffer.
>=20
> Thomas

> diff -rup winsup/cygwin/orig/fhandler.h winsup/cygwin/fhandler.h
> --- winsup/cygwin/orig/fhandler.h	2016-03-10 17:30:40.000000000 +0000
> +++ winsup/cygwin/fhandler.h	2016-03-14 13:08:14.545958400 +0000
> @@ -1352,6 +1352,8 @@ class dev_console
>    bool ext_mouse_mode15;
>    bool use_focus;
>    bool raw_win32_keyboard_mode;
> +  char cons_rabuf[40];

Why 40?  Where does this number come from?  Do we have a define for this
which makes sense?  Shouldn't we introduce one if it doesn't exist?

> +  char * cons_rapoi;
          ^^^
          Drop the space, please.
>=20=20
>    inline UINT get_console_cp ();
>    DWORD con_to_str (char *d, int dlen, WCHAR w);
> @@ -1449,6 +1451,7 @@ private:
>    int init (HANDLE, DWORD, mode_t);
>    bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
>    bool focus_aware () {return shared_console_info->con.use_focus;}
> +  bool get_cons_readahead_valid () { return shared_console_info->con.con=
s_rapoi !=3D 0; }

Can you please reformat this to fit into 80 columns?

Also, s/0/NULL/

>    select_record *select_read (select_stuff *);
>    select_record *select_write (select_stuff *);
> diff -rup winsup/cygwin/orig/fhandler_console.cc winsup/cygwin/fhandler_c=
onsole.cc
> --- winsup/cygwin/orig/fhandler_console.cc	2016-01-12 14:39:52.000000000 =
+0000
> +++ winsup/cygwin/fhandler_console.cc	2016-03-15 13:12:29.273612200 +0000
> @@ -196,6 +196,7 @@ fhandler_console::setup ()
>  	  con.meta_mask |=3D RIGHT_ALT_PRESSED;
>  	con.set_default_attr ();
>  	con.backspace_keycode =3D CERASE;
> +	con.cons_rapoi =3D 0;

NULL, please.

>  	shared_console_info->tty_min_state.is_console =3D true;
>        }
>  }
> @@ -310,6 +311,14 @@ fhandler_console::read (void *pv, size_t
>    int ch;
>    set_input_state ();
>=20=20
> +  /* Check console read-ahead buffer filled from terminal requests */
> +  if (con.cons_rapoi && * con.cons_rapoi)
                           ^^^
                           Drop the space, please.

> +    {
> +      * buf =3D * con.cons_rapoi ++;
         ^^^     ^^^
         Drop the spaces, please.

> +      buflen =3D 1;
> +      return;
> +    }
> +
>    int copied_chars =3D get_readahead_into_buffer (buf, buflen);
>=20=20
>    if (copied_chars)
> @@ -1899,8 +1908,12 @@ fhandler_console::char_command (char c)
>  	strcpy (buf, "\033[?6c");
>        /* The generated report needs to be injected for read-ahead into t=
he
>  	 fhandler_console object associated with standard input.
> -	 The current call does not work. */
> -      puts_readahead (buf);
> +	 So puts_readahead does not work. */
> +      //puts_readahead (buf);

Just remove this line entirely.

> +      /* Use a common console read-ahead buffer instead. */
> +      con.cons_rapoi =3D 0;
> +      strcpy (con.cons_rabuf, buf);
> +      con.cons_rapoi =3D con.cons_rabuf;
>        break;
>      case 'n':
>        switch (con.args[0])
> @@ -1910,7 +1923,10 @@ fhandler_console::char_command (char c)
>  	  y -=3D con.b.srWindow.Top;
>  	  /* x -=3D con.b.srWindow.Left;		// not available yet */
>  	  __small_sprintf (buf, "\033[%d;%dR", y + 1, x + 1);
> -	  puts_readahead (buf);
> +	  //puts_readahead (buf);

Ditto.

> +	  con.cons_rapoi =3D 0;
> +	  strcpy (con.cons_rabuf, buf);
> +	  con.cons_rapoi =3D con.cons_rabuf;
>  	  break;
>        default:
>  	  goto bad_escape;
> diff -rup winsup/cygwin/orig/select.cc winsup/cygwin/select.cc
> --- winsup/cygwin/orig/select.cc	2016-02-18 13:10:46.000000000 +0000
> +++ winsup/cygwin/select.cc	2016-03-14 13:09:07.661269400 +0000
> @@ -845,6 +845,12 @@ peek_console (select_record *me, bool)
>    if (!me->read_selected)
>      return me->write_ready;
>=20=20
> +  if (fh->get_cons_readahead_valid ())
> +    {
> +      select_printf ("cons_readahead");
> +      return me->read_ready =3D true;
> +    }
> +
>    if (fh->get_readahead_valid ())
>      {
>        select_printf ("readahead");

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6BJPAAoJEPU2Bp2uRE+gQIgP/jS2PSQGuHJhZj5k/ZGl54yG
zTHgU7oA9Rkw0mSmTeU+L/aK7999hppffbH7w9uhEvIR8Grs5DdM/GiF2UTGafkr
QkApAVweoa2f1zGyrf8h7IwjVCu/sGn3JhnpVmDoluSAZKI0NWA4V/bs7I83Kyi+
Xr/Iyf3AqD4ptRxuuyBj3GWeHmWv3tu6pa8+cl7dEj4/F2FPa0SZ9StpatJKGdJv
BHLwbfIyCAPkUaeNS2K6jr2WiNPwvXLc+P0k7uqQzvLgTod42eXSf+JAgebStES0
KNMtH654jLD5S1oL5mY/U1q+RXyvYMKDP6pOpx1mAdmjjA08wlnTgV4tYyIO42Kf
1ZcCkkSp/tDrIKMkhKa2oVX60F5819mR2aVVxoGyL1CILVkIabANmmfW34RJXglv
AaOrSKyBZEfOX0WafcYoE9AEWkZu+xLH687MoPC77ovN918p0QX7UklveftLCoeT
nEvoTR8ivxVWCIWlBAi9sS3ji5J60jcjoAKwdiXSHWiQ/fwcFmwoDcERLTuMwz92
Py5jncO1A2bk3MDhxcsv9IeFzs7eoWN025K1v4t9OTfC3SqlWTk3c8MbSJCGofD/
Js0zbzfiLywr+Ol2T2OpXVqfxLqC0Qle8eK0xXXiY5IBw2iK5Jir4GMjmGxxq7HT
MACR27f1bviKMC9tKmrh
=wzct
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
