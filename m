Return-Path: <cygwin-patches-return-7121-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31524 invoked by alias); 6 Oct 2010 07:02:05 -0000
Received: (qmail 31514 invoked by uid 22791); 6 Oct 2010 07:02:03 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,TW_CF,TW_NH,TW_OJ,TW_XP,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from nm2.bullet.mail.ukl.yahoo.com (HELO nm2.bullet.mail.ukl.yahoo.com) (217.146.183.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 06 Oct 2010 07:01:59 +0000
Received: from [217.146.183.214] by nm2.bullet.mail.ukl.yahoo.com with NNFMP; 06 Oct 2010 07:01:56 -0000
Received: from [217.146.183.177] by tm7.bullet.mail.ukl.yahoo.com with NNFMP; 06 Oct 2010 07:01:55 -0000
Received: from [127.0.0.1] by omp1018.mail.ukl.yahoo.com with NNFMP; 06 Oct 2010 07:01:55 -0000
Received: (qmail 82132 invoked by uid 60001); 6 Oct 2010 07:01:55 -0000
Message-ID: <915699.82111.qm@web25505.mail.ukl.yahoo.com>
Received: from [93.33.98.225] by web25505.mail.ukl.yahoo.com via HTTP; Wed, 06 Oct 2010 08:01:54 BST
Date: Wed, 06 Oct 2010 07:02:00 -0000
From: Marco Atzeri <marco_atzeri@yahoo.it>
Subject: patch to add C99 complex
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1216153723-1286348514=:82111"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00000.txt.bz2


--0-1216153723-1286348514=:82111
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1242

here is the cygwin follow up of the patch=20
sent to newlib mailing list.

Marco


--- Mer 6/10/10, Marco Atzeri  ha scritto:

> The attached patch add C99 Complex to
> newlib
> using all NETBSD source except "long double" ones.
>=20
> Tested on cygwin:
>=20
> a =3D 1.000000+1.000000I
> b =3D 3.141590+1.200000I
> a+b =3D 4.141590+2.200000I
> a*b =3D 1.941590+4.341590I
> 1/c =3D 0.500000-0.500000I
> -a =3D -1.000000-1.000000I
> abs(a) =3D 1.414214+0.000000I
> cacos(a) =3D 0.904557-1.061275I
> casin(a) =3D 0.666239+1.061275I
> catan(a) =3D 1.017222+0.402359I
> ccos(a) =3D 0.833730-0.988898I
> csin(a) =3D 1.298458+0.634964I
> ctan(a) =3D 0.271753+1.083923I
> cacosh(a) =3D 1.061275+0.904557I
> casinh(a) =3D 1.061275+0.666239I
> catanh(a) =3D 0.402359+1.017222I
> ccosh(a) =3D 0.833730+0.988898I
> csinh(a) =3D 0.634964+1.298458I
> ctanh(a) =3D 1.083923+0.271753I
> cexp(a) =3D 1.468694+2.287355I
> clog(a) =3D 0.346574+0.785398I
> cpow(a,b) =3D -1.119157+0.295690I
> csqrt(a) =3D 1.098684+0.455090I
> carg(a) =3D 0.785398+0.000000I
> cimag(a) =3D 1.000000+0.000000I
> conj(a) =3D 1.000000-1.000000I
> cproj(a) =3D 1.000000+1.000000I
> creal(a) =3D 1.000000+0.000000I
>=20
> Regards
> Marco
>=20
>=20
> =A0 =A0 =A0


=20=20=20=20=20=20=

--0-1216153723-1286348514=:82111
Content-Type: text/x-diff; name="cygwin_complex.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin_complex.patch"
Content-length: 3726

ZGlmZiAtdU5yIC14IE1ha2VmaWxlLmluIC14ICcqficgLXggJyoubTQnIC14
IGF1dG9tNHRlLmNhY2hlIC14IGNvbmZpZ3VyZSBzcmNfY2xvbmVfb3JpZy93
aW5zdXAvY3lnd2luL0NoYW5nZUxvZyBzcmNfY2xvbmUvd2luc3VwL2N5Z3dp
bi9DaGFuZ2VMb2cKLS0tIHNyY19jbG9uZV9vcmlnL3dpbnN1cC9jeWd3aW4v
Q2hhbmdlTG9nCTIwMTAtMTAtMDUgMDU6MzY6MjUuODQzNzUwMDAwICswMjAw
CisrKyBzcmNfY2xvbmUvd2luc3VwL2N5Z3dpbi9DaGFuZ2VMb2cJMjAxMC0x
MC0wNSAyMzoyNTozOS45Njg3NTAwMDAgKzAyMDAKQEAgLTEsMyArMSwxMiBA
QAorMjAxMC0xMC0wNSAgTWFyY28gQXR6ZXJpICA8bWFyY29fYXR6ZXJpQHlh
aG9vLml0PgorCisgICAgICAgICogY3lnd2luLmRpbiAoIGNhY29zIGNhY29z
ZiBjYWNvc2ggY2Fjb3NoZiBjYXJnIGNhcmdmIAorCSAgIGNhc2luIGNhc2lu
ZiBjYXNpbmggY2FzaW5oZiBjYXRhbiBjYXRhbmYgY2F0YW5oIGNhdGFuaGYK
KwkgICBjY29zIGNjb3NmIGNjb3NoIGNjb3NoZiBjZXhwIGNleHBmIGNpbWFn
IGNpbWFnZiBjbG9nIGNsb2dmIAorCSAgIGNvbmogY29uamYgY3BvdyBjcG93
ZiBjcHJvaiBjcHJvamYgY3JlYWwgY3JlYWxmIAorCSAgIGNzaW4gY3NpbmYg
Y3NpbmggY3NpbmhmIGNzcXJ0IGNzcXJ0ZiAKKwkgICBjdGFuIGN0YW5mIGN0
YW5oIGN0YW5oZik6IEV4cG9ydCBuZXcgY29tcGxleCBtYXRoIGZ1bmN0aW9u
cyAKKwogMjAxMC0wOS0wMiAgQ29yaW5uYSBWaW5zY2hlbiAgPGNvcmlubmFA
dmluc2NoZW4uZGU+CiAKIAkqIGZoYW5kbGVyX3Byb2NzeXMuY2MgKGZoYW5k
bGVyX3Byb2NzeXM6OmV4aXN0cyk6IFJldHVybiB2aXJ0X25vbmUKZGlmZiAt
dU5yIC14IE1ha2VmaWxlLmluIC14ICcqficgLXggJyoubTQnIC14IGF1dG9t
NHRlLmNhY2hlIC14IGNvbmZpZ3VyZSBzcmNfY2xvbmVfb3JpZy93aW5zdXAv
Y3lnd2luL2N5Z3dpbi5kaW4gc3JjX2Nsb25lL3dpbnN1cC9jeWd3aW4vY3ln
d2luLmRpbgotLS0gc3JjX2Nsb25lX29yaWcvd2luc3VwL2N5Z3dpbi9jeWd3
aW4uZGluCTIwMTAtMTAtMDUgMDU6MzY6MjguNDY4NzUwMDAwICswMjAwCisr
KyBzcmNfY2xvbmUvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluCTIwMTAtMTAt
MDQgMTc6MzQ6MzIuNzg3NTEwMDAwICswMjAwCkBAIC0xNjQsMTcgKzE2NCwz
NyBAQAogX2NhYnMgPSBjYWJzIE5PU0lHRkUKIGNhYnNmIE5PU0lHRkUKIF9j
YWJzZiA9IGNhYnNmIE5PU0lHRkUKK2NhY29zIE5PU0lHRkUKK2NhY29zZiBO
T1NJR0ZFCitjYWNvc2ggTk9TSUdGRQorY2Fjb3NoZiBOT1NJR0ZFCiBjYWxs
b2MgU0lHRkUKIF9jYWxsb2MgPSBjYWxsb2MgU0lHRkUKIGNhbm9uaWNhbGl6
ZV9maWxlX25hbWUgU0lHRkUKK2NhcmcgTk9TSUdGRQorY2FyZ2YgTk9TSUdG
RQorY2FzaW4gTk9TSUdGRQorY2FzaW5mIE5PU0lHRkUKK2Nhc2luaCBOT1NJ
R0ZFCitjYXNpbmhmIE5PU0lHRkUKK2NhdGFuIE5PU0lHRkUKK2NhdGFuZiBO
T1NJR0ZFCitjYXRhbmggTk9TSUdGRQorY2F0YW5oZiBOT1NJR0ZFCiBjYnJ0
IE5PU0lHRkUKIF9jYnJ0ID0gY2JydCBOT1NJR0ZFCiBjYnJ0ZiBOT1NJR0ZF
CiBfY2JydGYgPSBjYnJ0ZiBOT1NJR0ZFCitjY29zIE5PU0lHRkUKK2Njb3Nm
IE5PU0lHRkUKK2Njb3NoIE5PU0lHRkUKK2Njb3NoZiBOT1NJR0ZFCiBjZWls
IE5PU0lHRkUKIF9jZWlsID0gY2VpbCBOT1NJR0ZFCiBjZWlsZiBOT1NJR0ZF
CiBfY2VpbGYgPSBjZWlsZiBOT1NJR0ZFCitjZXhwIE5PU0lHRkUKK2NleHBm
IE5PU0lHRkUKIGNmZ2V0aXNwZWVkIE5PU0lHRkUKIGNmZ2V0b3NwZWVkIE5P
U0lHRkUKIGNmbWFrZXJhdyBOT1NJR0ZFCkBAIC0xODksNiArMjA5LDggQEAK
IF9jaG93bjMyID0gY2hvd24zMiBTSUdGRQogY2hyb290IFNJR0ZFCiBfY2hy
b290ID0gY2hyb290IFNJR0ZFCitjaW1hZyBOT1NJR0ZFCitjaW1hZ2YgTk9T
SUdGRQogY2xlYW51cF9nbHVlIE5PU0lHRkUKIGNsZWFyZXJyIFNJR0ZFCiBf
Y2xlYXJlcnIgPSBjbGVhcmVyciBTSUdGRQpAQCAtMTk3LDEyICsyMTksMTYg
QEAKIGNsb2NrX2dldHJlcyBTSUdGRQogY2xvY2tfZ2V0dGltZSBTSUdGRQog
Y2xvY2tfc2V0cmVzIFNJR0ZFCitjbG9nIE5PU0lHRkUKK2Nsb2dmIE5PU0lH
RkUKIGNsb3NlIFNJR0ZFCiBfY2xvc2UgPSBjbG9zZSBTSUdGRQogY2xvc2Vk
aXIgU0lHRkUKIF9jbG9zZWRpciA9IGNsb3NlZGlyIFNJR0ZFCiBjbG9zZWxv
ZyBTSUdGRQogY29uZnN0ciBOT1NJR0ZFCitjb25qIE5PU0lHRkUKK2Nvbmpm
IE5PU0lHRkUKIGNvbm5lY3QgPSBjeWd3aW5fY29ubmVjdCBTSUdGRQogY29w
eXNpZ24gTk9TSUdGRQogX2NvcHlzaWduID0gY29weXNpZ24gTk9TSUdGRQpA
QCAtMjE2LDggKzI0MiwyNCBAQAogX2Nvc2ggPSBjb3NoIE5PU0lHRkUKIGNv
c2hmIE5PU0lHRkUKIF9jb3NoZiA9IGNvc2hmIE5PU0lHRkUKK2Nwb3cgTk9T
SUdGRQorY3Bvd2YgTk9TSUdGRQorY3Byb2ogTk9TSUdGRQorY3Byb2pmIE5P
U0lHRkUKK2NyZWFsIE5PU0lHRkUKK2NyZWFsZiBOT1NJR0ZFCiBjcmVhdCBT
SUdGRQogX2NyZWF0ID0gY3JlYXQgU0lHRkUKK2NzaW4gTk9TSUdGRQorY3Np
bmYgTk9TSUdGRQorY3NpbmggTk9TSUdGRQorY3NpbmhmIE5PU0lHRkUKK2Nz
cXJ0IE5PU0lHRkUKK2NzcXJ0ZiBOT1NJR0ZFCitjdGFuIE5PU0lHRkUKK2N0
YW5mIE5PU0lHRkUKK2N0YW5oIE5PU0lHRkUKK2N0YW5oZiBOT1NJR0ZFCiBj
dGVybWlkIFNJR0ZFCiBjdGltZSBTSUdGRQogX2N0aW1lID0gY3RpbWUgU0lH
RkUK

--0-1216153723-1286348514=:82111--
