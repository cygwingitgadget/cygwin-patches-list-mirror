Return-Path: <cygwin-patches-return-8312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64358 invoked by alias); 12 Feb 2016 20:47:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64237 invoked by uid 89); 12 Feb 2016 20:47:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mail-wm0-f52.google.com
Received: from mail-wm0-f52.google.com (HELO mail-wm0-f52.google.com) (74.125.82.52) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 12 Feb 2016 20:47:11 +0000
Received: by mail-wm0-f52.google.com with SMTP id p63so34798608wmp.1        for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 12:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:subject:to:references:from:message-id:date         :user-agent:mime-version:in-reply-to:content-type;        bh=5CMlgtP7Mq7QLgwwfQfJ9ovc42Fg9Vi3P3tUZT4InNg=;        b=hzxQvqqIn1it1v0+8vHOSpIiOXsy3k/Js8W7+1DqcxW/ytmT419qMEr4DmRj5rifld         Gpf5q3zEKbLVH8/ykNK6eqJDczWV1sVYhVhlBawIZkiEJkT5A7OiPM8qrl8CmsQ+A7dH         nog7Ns1hXn9f0/IUUSdkL8+AFBoMAnPDYGCfVxxKNaMohyFLnOqwPnsgIMj8R1XE2hm3         zF0FM7S3N8kuL0aiqRIpaW72l7w6Lih/RlmjKmpx2L/nURbqRWpiRqVR9eDbb0mEpwDO         p2k0LmkhEUGIA2diLC8NS0jZ74/Q1iPLHpzE4pvL+4RyAcAMEnoEDd5Fyk377wzeKAzK         QRpA==
X-Gm-Message-State: AG10YOT72uQ0IqoDA0KwrK2Kwt9p7o24r6vOc1AUONwbM+mtlXDgXAp/HsvZvi+k+j0xXQ==
X-Received: by 10.28.127.5 with SMTP id a5mr6774717wmd.32.1455310028360;        Fri, 12 Feb 2016 12:47:08 -0800 (PST)
Received: from [10.0.0.1] (27.228.broadband3.iol.cz. [85.70.228.27])        by smtp.googlemail.com with ESMTPSA id i1sm13559195wjs.45.2016.02.12.12.47.07        (version=TLSv1/SSLv3 cipher=OTHER);        Fri, 12 Feb 2016 12:47:07 -0800 (PST)
Subject: Re: [PATCH] POSIX barrier implementation, take 2
To: cygwin-patches@cygwin.com
References: <56BDB206.9090101@gmail.com> <20160212142537.GD3415@calimero.vinschen.de>
From: =?UTF-8?Q?V=c3=a1clav_Haisman?= <vhaisman@gmail.com>
Message-ID: <56BE44B4.5080307@gmail.com>
Date: Fri, 12 Feb 2016 20:47:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160212142537.GD3415@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="IwUpJdO9eK2kxgr1wtHe0S5mUuocBU1EK"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00018.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IwUpJdO9eK2kxgr1wtHe0S5mUuocBU1EK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 2037

On 12.2.2016 15:25, Corinna Vinschen wrote:
> Hi V=C3=A1clav,
>=20
>=20
> the patch looks pretty good, I have just a few (minor) nits:
>=20
> On Feb 12 11:20, V=C3=A1clav Haisman wrote:
>> diff --git a/newlib/libc/include/sys/types.h b/newlib/libc/include/sys/t=
ypes.h
>> index 5dd6c75..bfe93fa 100644
>> --- a/newlib/libc/include/sys/types.h
>> +++ b/newlib/libc/include/sys/types.h
>> @@ -431,6 +431,7 @@ typedef struct {
>>=20=20
>>  /* POSIX Barrier Types */
>>=20=20
>> +#if !defined(__CYGWIN__)
>>  #if defined(_POSIX_BARRIERS)
>>  typedef __uint32_t pthread_barrier_t;        /* POSIX Barrier Object */
>>  typedef struct {
>> @@ -440,6 +441,7 @@ typedef struct {
>>  #endif
>>  } pthread_barrierattr_t;
>>  #endif /* defined(_POSIX_BARRIERS) */
>> +#endif /* __CYGWIN__ */
>=20
> Instead of adding YA `if !CYGWIN', I think it might be prudent to
> just move the `if !CYGWIN' up from the following _POSIX_SPIN_LOCKS
> block.

OK, will do.

>=20
>> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
>> index d7f4d24..18e010a 100644
>> --- a/winsup/cygwin/common.din
>> +++ b/winsup/cygwin/common.din
>> @@ -882,6 +882,13 @@ pthread_condattr_getpshared SIGFE
>>  pthread_condattr_init SIGFE
>>  pthread_condattr_setclock SIGFE
>>  pthread_condattr_setpshared SIGFE
>> +pthread_barrierattr_init SIGFE
>> +pthread_barrierattr_setpshared SIGFE
>> +pthread_barrierattr_getpshared SIGFE
>> +pthread_barrierattr_destroy SIGFE
>> +pthread_barrier_init SIGFE
>> +pthread_barrier_destroy SIGFE
>> +pthread_barrier_wait SIGFE
>>  pthread_continue SIGFE
>>  pthread_create SIGFE
>>  pthread_detach SIGFE
>=20
> These should be added in alphabetic order.

OK. I did not realize that.

>=20
>> +#define LIKELY(X) __builtin_expect (!!(X), 1)
>> +#define UNLIKELY(X) __builtin_expect (!!(X), 0)
>=20
> May I suggest to use lowercase "likely/unlikely" just as in the Linux
> kernel and to move the definitions into a header like winsup.h or
> miscfuncs.h?

I was not sure where to put these and then I forgot. Will fix.


--=20
VH


--IwUpJdO9eK2kxgr1wtHe0S5mUuocBU1EK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 213

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREKAAYFAla+RMMACgkQlv+b6dkC1za0RQEA8AoX6PR5xcqmPIa3FlnKvb2a
xQEwNHqYUa8acGGc2U8BAJa5MnH+XRkyMB2pcxR/wqdXRcHxiIi7KBO1SvCI6yIW
=f+Cy
-----END PGP SIGNATURE-----

--IwUpJdO9eK2kxgr1wtHe0S5mUuocBU1EK--
