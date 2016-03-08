Return-Path: <cygwin-patches-return-8379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81779 invoked by alias); 8 Mar 2016 12:54:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81765 invoked by uid 89); 8 Mar 2016 12:54:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=dash, Vinschen, vinschen, Maintainer
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 08 Mar 2016 12:54:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DDD70A80600; Tue,  8 Mar 2016 13:54:08 +0100 (CET)
Date: Tue, 08 Mar 2016 12:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] faq: Sort BLODA list and update advice on fixing fork failures
Message-ID: <20160308125408.GA27123@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1457435653-8152-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1457435653-8152-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00085.txt.bz2


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 819

Hi Jon,

On Mar  8 11:14, Jon Turney wrote:
> 	* faq-using.xml(bloda): Alphabetically sort BLODA list for ease of
> 	finding things in it.  (fixing-fork-failures) Update to suggest
> 	rebase-trigger rather than running rebaseall via dash yourself.
> 	Mention detect_bloda CYGWIN token.

Can you clean up formatting of this log entry before applying?

In theory the patch itself is ok.  I'm just wondering for a while now if
the detect_bloda option should be removed.  I don't remember any useful
BLODA report as a result of using it.  But my memory could be wrong
here, do you have a different experience?  If so, feel free to check in
your patch as is.


Thanks.
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3stwAAoJEPU2Bp2uRE+gow8P/Awx+qizpLleSMoYlMSRcE0n
gwcDuGgR9ZVsUNMniaNVPx+TTOr3QkjWVKakNFaZgAvQSrc2LQMwdheW2Z1eUgUt
j8744ep7IgiF9IMwZKHFh1F+wWhTDtTnz0jdN6JXuc4JGJJkvl6jJA+IEqQTyZDU
FS63fHZW9Wb7WqQLTsAXfv7m/lPM0kOXZ6+0h+49wRLiHqaojxHmIiqn7TggcMKN
QJQnSn9hgZEQrFo7gM5XOecgRyZ8wNUKgbkwGS6WuW1TJotlXaWmjeO/cy9OTSR1
cvX3f7tWXLnbBDJqiptQS7dE8PsWOaAbT05u29i/9a+K7QkUQz8tiMY9xbO4z3YE
cFkZp5sdFXTxgFxV9Nc64ABseUW5sI1MFXp+iKdMP4aWA1TD6TDxCjJY0WkP4dC4
E1YhliJugyrNWrt3qBCM8XrmiAOIK2Vf1c/cjNBgHGQhq7AEkmP5KIdDYksAEvR7
oD3/ldZMLnqgk4nDyvCWhDWm3escSX7sHFHuk9bVVLimm55pPLAq8f2A8c/1f3ur
wkKaMHejWXOhgvRPVzCtHVwYR9f0FnzZHMcsNS+MwjxBZa2H5HDQa7x7kO049m9h
DydgW8bFSbLonazAJ7FWyo/yad02zR16w5BBUR0VV4Lh2WuVNVa24TEcdOwX5lWJ
rnmvLX9w0kzSgWu7nHEG
=eQ/r
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
