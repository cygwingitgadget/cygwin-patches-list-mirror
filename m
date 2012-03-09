Return-Path: <cygwin-patches-return-7621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18137 invoked by alias); 9 Mar 2012 11:35:05 -0000
Received: (qmail 17931 invoked by uid 22791); 9 Mar 2012 11:35:03 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f43.google.com (HELO mail-pw0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Mar 2012 11:34:45 +0000
Received: by pbcwz12 with SMTP id wz12so2647586pbc.2        for <cygwin-patches@cygwin.com>; Fri, 09 Mar 2012 03:34:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.73.234 with SMTP id o10mr3757157pbv.90.1331292885238; Fri, 09 Mar 2012 03:34:45 -0800 (PST)
Received: by 10.68.74.71 with HTTP; Fri, 9 Mar 2012 03:34:45 -0800 (PST)
In-Reply-To: <4F58FEF6.2040004@t-online.de>
References: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>	<4F58D059.1090608@redhat.com>	<20120308155610.GA646@calimero.vinschen.de>	<4F58FEF6.2040004@t-online.de>
Date: Fri, 09 Mar 2012 11:35:00 -0000
Message-ID: <CAKw7uVijnw2cWzUHRsk4+eu=xZoc+fCA+t3dSoW0fbSTJZWNaw@mail.gmail.com>
Subject: Re: avoid calling strlen() twice in readlink()
From: =?UTF-8?Q?V=C3=A1clav_Zeman?= <vhaisman@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-SW-Source: 2012-q1/txt/msg00044.txt.bz2

On 8 March 2012 19:48, Christian Franke <Christian.Franke@t-online.de> wrot=
e:
> Corinna Vinschen wrote:
>>
>> On Mar =C2=A08 08:29, Eric Blake wrote:
>>>
>>> On 03/08/2012 06:37 AM, V=C3=A1clav Zeman wrote:
>>>>
>>>> Hi.
>>>>
>>>> Here is a tiny patch to avoid calling strlen() twice in readlink().
>>>>
>>>>
>>>> - =C2=A0ssize_t len =3D min (buflen, strlen (pathbuf.get_win32 ()));
>>>> + =C2=A0size_t pathbuf_len =3D strlen (pathbuf.get_win32 ());
>>>> + =C2=A0size_t len =3D MIN (buflen, pathbuf_len);
>>>> =C2=A0 =C2=A0memcpy (buf, pathbuf.get_win32 (), len);
>>>
>>> For that matter, is calling pathbuf.get_win32() twice worth factoring
>>> out?
>>
>> It's just a const char *pointer, and it's an inline method. =C2=A0I'm pr=
etty
>> sure the compiler will optimize this just fine.
>>
>>
>
> Yes - and it does ever more:
> strlen() is one of the compiler builtins declared with a const attribute
> internally. Then gcc optimizes duplicate calls away.
>
> Testcase:
>
> $ cat opt.cc
> #include <string.h>
>
> class X {
> =C2=A0const char * p;
> =C2=A0public:
> =C2=A0 =C2=A0X();
> =C2=A0 =C2=A0const char * get() { return p; }
> };
>
> int f(X & x)
> {
> =C2=A0int i =3D 0;
> =C2=A0i +=3D strlen(x.get());
> =C2=A0i +=3D strlen(x.get());
> =C2=A0i +=3D strlen(x.get());
> =C2=A0i +=3D strlen(x.get());
> =C2=A0i +=3D strlen(x.get());
> =C2=A0return i;
> }
>
> int g(X & x)
> {
> =C2=A0return 5 * strlen(x.get());
> }
>
>
> $ gcc -S -O2 -fomit-frame-pointer opt.cc
>
> $ cat opt.s | c++filt
> ...
> f(X&):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subl =C2=A0 =C2=A0$28, %esp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A032(%esp), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A0(%eax), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A0%eax, (%esp)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0call =C2=A0 =C2=A0_strlen
> =C2=A0 =C2=A0 =C2=A0 =C2=A0addl =C2=A0 =C2=A0$28, %esp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0leal =C2=A0 =C2=A0(%eax,%eax,4), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret
> ...
> g(X&):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subl =C2=A0 =C2=A0$28, %esp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A032(%esp), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A0(%eax), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0movl =C2=A0 =C2=A0%eax, (%esp)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0call =C2=A0 =C2=A0_strlen
> =C2=A0 =C2=A0 =C2=A0 =C2=A0addl =C2=A0 =C2=A0$28, %esp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0leal =C2=A0 =C2=A0(%eax,%eax,4), %eax
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret
>
> (interesting: With -O1 it uses an inline version of strlen, with -O2,3,...
> it doesn't)
>
>
> So this patch probably had no effect at all, sorry :-)
Heh, no problem. I really did not know GCC could do that these days.
The benefit seemed too obvious to let it pass :)

--=20
VZ
