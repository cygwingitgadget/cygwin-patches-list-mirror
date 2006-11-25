Return-Path: <cygwin-patches-return-6001-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13227 invoked by alias); 25 Nov 2006 15:47:24 -0000
Received: (qmail 13216 invoked by uid 22791); 25 Nov 2006 15:47:22 -0000
X-Spam-Check-By: sourceware.org
Received: from service2.sh.cvut.cz (HELO service2.sh.cvut.cz) (147.32.127.218)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 25 Nov 2006 15:47:14 +0000
Received: from localhost (localhost [127.0.0.1]) 	by service2.sh.cvut.cz (Postfix) with ESMTP id 3138E137838; 	Sat, 25 Nov 2006 16:47:12 +0100 (CET)
Received: from service2.sh.cvut.cz ([127.0.0.1]) 	by localhost (service2.sh.cvut.cz [127.0.0.1]) (amavisd-new, port 10024) 	with ESMTP id 28192-05; Sat, 25 Nov 2006 16:47:04 +0100 (CET)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	by service2.sh.cvut.cz (Postfix) with ESMTP id 115F2137797; 	Sat, 25 Nov 2006 16:47:04 +0100 (CET)
Received: from [192.168.1.2] (localhost [127.0.0.1]) 	by logout.sh.cvut.cz (Postfix) with ESMTP id 2921861C29; 	Sat, 25 Nov 2006 16:46:47 +0100 (CET)
Message-ID: <4568655E.6030403@sh.cvut.cz>
Date: Sat, 25 Nov 2006 15:47:00 -0000
From: =?UTF-8?B?VsOhY2xhdiBIYWlzbWFu?= <V.Haisman@sh.cvut.cz>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [RFC][patch] cygwin/singal.h is not compatible with -std=c89 or -std=c99
OpenPGP: id=733031B4
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enig8D16040D272B54A8F32C6293"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00019.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D16040D272B54A8F32C6293
Content-Type: multipart/mixed;
 boundary="------------060108090604080909070506"

This is a multi-part message in MIME format.
--------------060108090604080909070506
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 2223

Hi,
I've tried to compile following test case with -std=3Dc99 and later with
-std=3Dc89 flags and it fails to compile.

#include <signal.h>

void
sigchld_handler (int s)
{ }

int
main (void)
{
  struct sigaction sa;

  sa.sa_handler =3D sigchld_handler;
}

The problem is that the declaration of struct sigaction uses GCC extension
that is turned off by the -std=3Dc99 or -std=3Dc89 flag. The declaration lo=
oks
like this. (I stripped the comment that was there to make the line shorter.=
):

struct sigaction
{
  union
  {
    _sig_func_ptr sa_handler;
    void  (*sa_sigaction) ( int, siginfo_t *, void * );
  };
  sigset_t sa_mask;
  int sa_flags;
};

Notice the anonymous unnamed union. This extension is used few more times in
other parts of the same header. I can see two approaches to fixing this.

1. Use GCC's __extension__ keyword before the union (which the attached pat=
ch
does);
2. or use a little bit of macro magic like FreeBSD's sys/signal.h header do=
es.

The first approach uses another GCC extension to cover up use a GCC
extension. Pros are that it does not uglify the code much and the change is
very localized. Also the use of this __extension__ on architecture that
probably will never use anything but GCC does not seem that bad. Cons are
that it can be done in without the extension.

The second approach uses C89 and C99 conforming code but it makes the code a
little bit ugly. The following is what FreeBSD does:

struct sigaction {
        union {
                void    (*__sa_handler)(int);
                void    (*__sa_sigaction)(int, struct __siginfo *, void *);
        } __sigaction_u;                /* signal handler */
        int     sa_flags;               /* see signal options below */
        sigset_t sa_mask;               /* signal mask to apply */
};

#define sa_handler      __sigaction_u.__sa_handler

So, the attached patch is the minimal patch I used locally to compile my
programme. I think the header (and probably other headers) should be fixed
(either way) to allow to be compiled with stricter C standard conformance
flags like the two mentioned. The question is which way does Cygwin want to
go, use extensions in headers or do without them?

--
Vaclav Haisman

--------------060108090604080909070506
Content-Type: text/plain;
 name="signal.h.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signal.h.diff"
Content-length: 700

KioqIHNpZ25hbC5oLn4xLjE0Ln4JU2F0IE5vdiAyNSAxNjowNToxMiAyMDA2
Ci0tLSBzaWduYWwuaAlTYXQgTm92IDI1IDE2OjEzOjU5IDIwMDYKKioqKioq
KioqKioqKioqCioqKiAxOTQsMjAwICoqKioKICAKICBzdHJ1Y3Qgc2lnYWN0
aW9uCiAgewohICAgdW5pb24KICAgIHsKICAgICAgX3NpZ19mdW5jX3B0ciBz
YV9oYW5kbGVyOyAgCQkvKiBTSUdfREZMLCBTSUdfSUdOLCBvciBwb2ludGVy
IHRvIGEgZnVuY3Rpb24gKi8KICAgICAgdm9pZCAgKCpzYV9zaWdhY3Rpb24p
ICggaW50LCBzaWdpbmZvX3QgKiwgdm9pZCAqICk7Ci0tLSAxOTQsMjAwIC0t
LS0KICAKICBzdHJ1Y3Qgc2lnYWN0aW9uCiAgewohICAgX19leHRlbnNpb25f
XyB1bmlvbgogICAgewogICAgICBfc2lnX2Z1bmNfcHRyIHNhX2hhbmRsZXI7
ICAJCS8qIFNJR19ERkwsIFNJR19JR04sIG9yIHBvaW50ZXIgdG8gYSBmdW5j
dGlvbiAqLwogICAgICB2b2lkICAoKnNhX3NpZ2FjdGlvbikgKCBpbnQsIHNp
Z2luZm9fdCAqLCB2b2lkICogKTsK

--------------060108090604080909070506--

--------------enig8D16040D272B54A8F32C6293
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 542

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQEVAwUBRWhlZkNOZDESBK8FAQIihAgAhkfuoGXk9WB+EIR1Y7A79DPz+sqRJqsL
wIkwltwlOj/rOXUt2kGsOY6O+cwjHVDrhG3KMyPv6zWt6kqAgE7D2XQ1rmkX/ZKH
hmsZ9HPoHSe8w8aIlLmd68PBwsZKsIi7sQbcXmN5/XP5cZkJK6xZePX+tTLs/Q/W
exKydXqgY+SjWNPrrEwX4SgjpNIUjlESpMWn3Ds0arw/o+E4dWoe0hUJRcKArMuA
EDd7eQ6nDIEDGox1WcrextrHGuok4x30VT2QRd+KZ2ciK8s2EbVgFWhZOW56deSD
dyNRLvNvvH3e4K8vN+bwLDuT4DFImoEPpvB16OFbtlCEaud2KdsF3Q==
=UwsR
-----END PGP SIGNATURE-----

--------------enig8D16040D272B54A8F32C6293--
