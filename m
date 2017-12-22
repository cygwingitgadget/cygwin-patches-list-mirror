Return-Path: <cygwin-patches-return-8988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130710 invoked by alias); 22 Dec 2017 15:17:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130678 invoked by uid 89); 22 Dec 2017 15:17:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Dec 2017 15:16:59 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 1AB00721E280D	for <cygwin-patches@cygwin.com>; Fri, 22 Dec 2017 16:16:55 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 4F4715E03A7	for <cygwin-patches@cygwin.com>; Fri, 22 Dec 2017 16:16:54 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3AD51A8049F; Fri, 22 Dec 2017 16:16:54 +0100 (CET)
Date: Fri, 22 Dec 2017 15:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
Message-ID: <20171222151654.GA4063@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171220080832.2328-1-mark@maxrnd.com> <20171220115122.GF19986@calimero.vinschen.de> <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net> <20171221102502.GJ19986@calimero.vinschen.de> <Pine.BSF.4.63.1712220116310.32087@m0.truegem.net> <d2e7e624-8f52-d1b8-518f-d26108158bbb@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <d2e7e624-8f52-d1b8-518f-d26108158bbb@dronecode.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00118.txt.bz2


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1908

On Dec 22 13:30, Jon Turney wrote:
> On 22/12/2017 09:48, Mark Geisert wrote:
> >=20
> > I'd still like to get a vote of acceptance for what I've called the
> > "courtesy" code in cygthread.cc, cygthread::name method.=C2=A0 The meth=
od is
> > called with a Windows tid and that tid is looked up in the table of
> > cygthreads.=C2=A0 If found, you immediately have the thread's name.=C2=
=A0 I added
> > code on the failure path for the case where tid represents a pthread.
> > If it does, the pthread's name is retrieved into the result buffer.
> >=20
> > This would be useful in straces of any application whose pthreads issue
> > Cygwin syscalls: It means the strace log has messages referring to
> > pthreads by their names and not by "unknown 0x###" as at present.=C2=A0=
 It
> > was a help while debugging my "aio library built in userspace using
> > pthreads" that shall never be mentioned again ;-).=C2=A0 But somebody e=
lse
> > coding or debugging their own multi-threaded app will run into this need
> > eventually.
>=20
> Yeah, there's definitely a piece missing if pthread names aren't being
> reported correctly in strace output.
>=20
> I'd suggest it might be a bit cleaner to have a utility function used by
> strace::vsprntf() to get the thread name, which tries cygthread::name() or
> pthread_getname_np(), rather than having cygthread::name() be the only pa=
rt
> of cygthread which knows about pthreads...
>=20
> Other uses of cygthread::name() need inspecting to see if they need to
> change or not.  Given [1], I think CW_GETTHREADNAME should stay as it is.
>=20
> [1] https://cygwin.com/ml/cygwin/2009-05/msg00263.html

Full ACK.  Something like dbg_get_thread_name() or some such would
make sense for the new function.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlo9IeYACgkQ9TYGna5E
T6CbDQ//dZhSRXiVtb88LEPQ7nvi13xzYWh1M3BA+S+eFylw4VKk/33QAhM2YZ74
o7HG8Y9pIlreiVKdjAOLyWGWpUVSoC97buzKbA36O6Vzc5/1ecr1wa853fytI5UP
dyd3xeqDqDi7OjzbGILS0rE5SwFfSksKYL7BQYyyaDhUqMMEc3zZdQnqIy5YChyV
I2YVtUIbXwBIc/GDoi77naC4Poc0Ghr8I7oZYcsvgdd37dB6H7Nsq3vcqFA1tsEb
qARlGjZkqnAaZ+VgZYUUPABuRV1Uwu/6TRLNloDwEpT9Q4AGW9pm/B+n7bCF9wU/
shH6qlRXHU4ZNFFRo95faADg0kTgcRi3zhm+O/BC7lq0ylMsrOtcKiCj5VlL5RKu
x3gquGtxvwxYbKbLsPxFvi9f/7uvfe2aMoBw5+BHFnjloci8rbo6IUxQTBhGwA49
632CD137r/r3PDo49lDJ3HzxdQhC1JkFmFxqKQEbfXZqRdcEq43mHsj+qABpSu2W
ukHmr/dYp+c0yy8JClomFB8QGG/5AFxY2WONI4vQVwB/svcNIwpDJxQVT+qBkJAF
in4gaFPALuTK5/wSlJQh3fiGQvhTkIpXPd47n+aPNLmsDP8aJF+nVUG2dJ1bsOwu
Yt1v3wojJ9D7BSO0fFBtpAyupyFq3XsGFPDUKWoVGsLRpBLejv4=
=8LPg
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
