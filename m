Return-Path: <cygwin-patches-return-4646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31391 invoked by alias); 31 Mar 2004 09:39:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31379 invoked from network); 31 Mar 2004 09:39:38 -0000
Date: Wed, 31 Mar 2004 09:39:00 -0000
Message-ID: <406309F90000C96E@mail-4.tiscali.it>
From: fabrizio.ge@tiscali.it
Subject: Support for SNDCTL_DSP_CHANNELS ioctl
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========/406309F90000C96E/mail-4.tiscali.it"
X-SW-Source: 2004-q1/txt/msg00136.txt.bz2


--========/406309F90000C96E/mail-4.tiscali.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 640

Hello.

This patch adds support for calling the SNDCTL_DSP_CHANNELS ioctl on /dev/d=
sp.
The changelog is

2004-03-31 Fabrizio Gennari (fabrizio.ge@tiscali.it)
- fhandler_dsp.cc(fhandler_dev_dsp::ioctl): add support for SNDCTL_DSP_CHAN=
NELS
ioctl

It is almost a copy-and-paste from SNDCTL_DSP_STEREO

Bye
Fabrizio

__________________________________________________________________
ADSL Senza Canone 640Kbps:
attivala entro il 31 marzo e avrai GRATIS il costo di adesione,
quello di attivazione e il modem per tutto il 2004.
E per i primi 3 mesi navighi a 1,5 euro l'ora! Affrettati!
http://point.tiscali.it/adsl/prodotti/senzacanone/




--========/406309F90000C96E/mail-4.tiscali.it
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dsp_patch.txt"
Content-length: 810

LS0tIGZoYW5kbGVyX2RzcF9vbGQuY2MJMjAwMy0xMS0yNiAwMzoxNTowNy4w
MDEwMDAwMDAgKzAxMDAKKysrIGZoYW5kbGVyX2RzcC5jYwkyMDA0LTAzLTEy
IDEwOjExOjUwLjgzMDE4NTYwMCArMDEwMApAQCAtNTkxLDYgKzU5MSwyNCBA
QAogICAgICAgfQogICAgICAgYnJlYWs7CiAKKyAgICAgIENBU0UgKFNORENU
TF9EU1BfQ0hBTk5FTFMpCisgICAgICB7CisJaW50IG5DaGFubmVscyA9ICpp
bnRwdHI7CisKKwlzX2F1ZGlvLT5jbG9zZSAoKTsKKwlpZiAoc19hdWRpby0+
b3BlbiAoYXVkaW9mcmVxXywgYXVkaW9iaXRzXywgbkNoYW5uZWxzKSA9PSB0
cnVlKQorCSAgeworCSAgICBhdWRpb2NoYW5uZWxzXyA9IG5DaGFubmVsczsK
KwkgICAgcmV0dXJuIDA7CisJICB9CisJZWxzZQorCSAgeworCSAgICBzX2F1
ZGlvLT5vcGVuIChhdWRpb2ZyZXFfLCBhdWRpb2JpdHNfLCBhdWRpb2NoYW5u
ZWxzXyk7CisJICAgIHJldHVybiAtMTsKKwkgIH0KKyAgICAgIH0KKyAgICAg
IGJyZWFrOworCiAgICAgICBDQVNFIChTTkRDVExfRFNQX0dFVE9TUEFDRSkK
ICAgICAgIHsKIAlhdWRpb19idWZfaW5mbyAqcCA9IChhdWRpb19idWZfaW5m
byAqKSBwdHI7Cg==

--========/406309F90000C96E/mail-4.tiscali.it--
