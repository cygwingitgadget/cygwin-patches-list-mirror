Return-Path: <cygwin-patches-return-6991-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12115 invoked by alias); 26 Feb 2010 16:05:05 -0000
Received: (qmail 11997 invoked by uid 22791); 26 Feb 2010 16:05:04 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_FAIL
X-Spam-Check-By: sourceware.org
Received: from qmta14.emeryville.ca.mail.comcast.net (HELO qmta14.emeryville.ca.mail.comcast.net) (76.96.27.212)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 16:04:59 +0000
Received: from omta03.emeryville.ca.mail.comcast.net ([76.96.30.27]) 	by qmta14.emeryville.ca.mail.comcast.net with comcast 	id meL21d0060b6N64AEg4yV0; Fri, 26 Feb 2010 16:04:59 +0000
Received: from [192.168.0.5] ([24.10.247.83]) 	by omta03.emeryville.ca.mail.comcast.net with comcast 	id mg4m1d00A1ohlF48Pg4waS; Fri, 26 Feb 2010 16:04:58 +0000
Message-ID: <4B87F118.6050307@redhat.com>
Date: Fri, 26 Feb 2010 16:05:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>  <4B876413.8040800@users.sourceforge.net>  <20100226092035.GB8489@calimero.vinschen.de>  <4B8796E6.5010202@users.sourceforge.net>  <20100226100417.GY5683@calimero.vinschen.de>  <4B87A77B.2010704@users.sourceforge.net> <20100226155249.GA5683@calimero.vinschen.de>
In-Reply-To: <20100226155249.GA5683@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enigF569C9619E48D678DC46FEE1"
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
X-SW-Source: 2010-q1/txt/msg00107.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF569C9619E48D678DC46FEE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 804

According to Corinna Vinschen on 2/26/2010 8:52 AM:
> Btw., I fixed the copyright date and a minor formatting issue in
> strsig.cc.  The copyright date is one of those pesky things you almost
> never think of in time.

Unless you use emacs, in which case you can install a hook that remembers
on your behalf with this chunk in ~/.emacs:

(require 'copyright)
;; the next line is if you use GPLv3 more than GPLv2
(setq copyright-current-gpl-version "3")
(defun my-copyright-update (&optional arg)
  "My improvements to `copyright-update'."
  (interactive "*P")
  (and (not (eq major-mode 'fundamental-mode))
       (copyright-update arg))
  nil)
(add-hook 'before-save-hook 'my-copyright-update)


--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigF569C9619E48D678DC46FEE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 320

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkuH8R0ACgkQ84KuGfSFAYCciACgvzTX1wF/E9Vj1hlKNEu+aRVV
lCEAoIgjw+9k7uixv57Ub7AfxUr1wdxt
=sAPB
-----END PGP SIGNATURE-----

--------------enigF569C9619E48D678DC46FEE1--
