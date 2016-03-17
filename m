Return-Path: <cygwin-patches-return-8414-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1286 invoked by alias); 17 Mar 2016 07:59:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1249 invoked by uid 89); 17 Mar 2016 07:59:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-87.4 required=5.0 tests=BAYES_50,GARBLED_SUBJECT,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=schrieb, separated, Wolff, wolff
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Mar 2016 07:59:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AE0FBA806B3; Thu, 17 Mar 2016 08:59:53 +0100 (CET)
Date: Thu, 17 Mar 2016 07:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console requested =?utf-8?Q?reports_?= =?utf-8?B?4oCT?= Re: [ANNOUNCEMENT] TEST RELEASE: Cygwin 2.5.0-0.6
Message-ID: <20160317075953.GB14874@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <announce.20160312232737.GA25791@calimero.vinschen.de> <56E80B4B.5040106@towo.net> <20160315134655.GC4177@calimero.vinschen.de> <56E88137.9020307@towo.net> <20160316092816.GB28452@calimero.vinschen.de> <56E9D974.4030804@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <56E9D974.4030804@towo.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00120.txt.bz2


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1868

On Mar 16 23:08, Thomas Wolff wrote:
> Am 16.03.2016 um 10:28 schrieb Corinna Vinschen:
> >On Mar 15 22:40, Thomas Wolff wrote:
> >>Hi Corinna,
> >>here is my updated patch.
> >>>Changelog (old format):
> >>>Just drop this line from the comment, please.  If you send the mail
> >>>via git format-patch/git send-email I can simply apply it with git am
> >>>including the entire text in the git log.
> >>I hope the comment format is OK now, I cannot currently use git format-=
patch
> >>due to missing setup.
> >>
> >>Make requested console reports work, cf https://cygwin.com/ml/cygwin-pa=
tches/2012-q3/msg00019.html
> >>
> >>This enables the following ESC sequences:
> >>ESC[c sends primary device attributes
> >>ESC[>c sends secondary device attributes
> >>ESC[6n sends cursor position report
> >>
> >>     * fhandler.h (class dev_console): Add console read-ahead buffer.
> >>     (class fhandler_console): Add peek function for it (for select).
> >>     * fhandler_console.cc (fhandler_console::setup): Init buffer.
> >>     (fhandler_console::read): Check console read-aheader buffer.
> >>     (fhandler_console::char_command): Put responses to terminal
> >>     requests (device status and cursor position reports) into
> >>     common console buffer (shared between CONOUT/CONIN)
> >>     instead of fhandler buffer (separated).
> >>     * select.cc (peek_console): Check console read-ahead buffer.
> >Patch applied.  Do you have a short text for the release message?
> - Enabled console reports requested by escape sequences:
>   Requesting primary and secondary device attributes,
>   requesting cursor position report;
>   see https://cygwin.com/ml/cygwin-patches/2012-q3/msg00019.html

Added.


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

iQIcBAEBCAAGBQJW6mP5AAoJEPU2Bp2uRE+gYLIP/jSXGPnkH+rLpQR2S6TorNrU
wOxxSNtYQnMuJF1f10USiGQ+bfQr1E67HBYwKva7Tq/mJuW9sYpg4p5QyUUMBvFV
4Ha0wAqr5KSC9bl89DKiSgHGPB2UFGTBzvDwJKg4nfwwavEcM+Zyll5yYRiuNrrF
1jH1rbmLQ98X1nRg+MaLmml1MujtVWGcWQwCOQoN6BmeBldOu2trDK+rtlrzR2MW
ND4RQrRZQ2AoCqJTYnVyCq5UZKYk4Sdqbj/+27h/DjAZ8PLvf7Ac4RL37F/KtsPV
bcDS8rhoYozWFmsRBlMk0uyzSQHk4yr6E9+o1GWgX1PB2mQZb/H+diF/kS3CmqUt
T+t4jX65M3oc6f/fqjSwf/fjIIlTdueF51PWw2t9VMgrRcOBd8yGp+IjQwezQYNd
IT5Y/V0wKgUBFg/1WV+2KEg7m2pXwi5SXJ2rmbpNw3Jhuw1JX+jsuLTiRmo/T9xR
ljWF3+NI3Zq1GVxPDlmQ80MwZ+vHPT0JQsfd7JdS9ZFsMZv+A/Qje3cc77fxda0V
DVm2R/cMUvCKXUrFCKbGrn3BVgEka1tYArejoZghW18UhthQ9XgBxT+MJWPUbxZt
rog+BakBtYF0q49IyAopgLpGvC88TkpFA8UQr9ZyIjVBg3d9xsQVZ0HIbG0K5vPJ
0xC/phbSyJ9xILakhCAo
=TbVI
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
