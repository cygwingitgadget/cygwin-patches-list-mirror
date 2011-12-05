Return-Path: <cygwin-patches-return-7552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14557 invoked by alias); 5 Dec 2011 01:57:11 -0000
Received: (qmail 14045 invoked by uid 22791); 5 Dec 2011 01:57:10 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_MK
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Dec 2011 01:56:55 +0000
Received: by ywt34 with SMTP id 34so4665777ywt.2        for <cygwin-patches@cygwin.com>; Sun, 04 Dec 2011 17:56:54 -0800 (PST)
Received: by 10.236.180.101 with SMTP id i65mr8827800yhm.21.1323050214877;        Sun, 04 Dec 2011 17:56:54 -0800 (PST)
Received: from [192.168.1.52] (c-24-18-179-193.hsd1.wa.comcast.net. [24.18.179.193])        by mx.google.com with ESMTPS id l16sm22457ane.2.2011.12.04.17.56.52        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 04 Dec 2011 17:56:53 -0800 (PST)
Message-ID: <4EDC24E0.5060609@gmail.com>
Date: Mon, 05 Dec 2011 01:57:00 -0000
From: Daniel Colascione <dan.colascione@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com> <CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com>
In-Reply-To: <CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig8C216186E6F38EC3287B8C58"
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
X-SW-Source: 2011-q4/txt/msg00042.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C216186E6F38EC3287B8C58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 3635

On 12/4/11 12:17 PM, Andy Koppe wrote:
> On 4 December 2011 07:07, Russell Davis wrote:
>> This was discussed before here:
>> http://cygwin.com/ml/cygwin/2008-03/msg00277.html
>>
>> These were the reasons given for not using native symlinks to create
>> cygwin symlinks, along with my responses:
>>
>> - By default, only administrators have the right to create native
>>   symlinks.  Admins running with restricted permissions under UAC don't
>>   have this right.
>>
>> This is true, however the feature can be made optional through the
>> CYGWIN environment variable (just like winsymlinks). For users that
>> can add the permission or disable UAC, the use of native symlinks is a
>> huge step towards making cygwin more unified with the rest of Windows.
>>
>> - When creating a native symlink, you have to define if this symlink
>>   points to a file or a directory.  This makes no sense given that
>>   symlinks often are created before the target they point to.
>>
>> Also true. However, the type only matters for Windows' usage of the
>> symlink -- cygwin already treats both the types the same. For example,
>> if a native symlink of type `file` actually points to a directory, it
>> will still work fine inside cygwin. It won't work for Win32 programs
>> that try to access it, but that's still no worse than the status quo
>> -- Win32 programs already can't use cygwin symlinks.
>>
>> Since cygwin already supports reading of native symlinks, I was able
>> to add support for this with a fairly small change. Some edge cases
>> probably still need to be handled (disabling for older versions of
>> windows and unsupported file systems), but I wanted to get this out
>> there for review. The patch is attached.
>=20
> Those aren't all the issues with using native symlinks as Cygwin
> symlinks. POSIX symlinks of course are supposed to point to POSIX
> paths, whereas native links point to Windows paths, with the following
> consequences:
>=20
> - Native links can't point to special Cygwin paths such as /proc and
> /dev, although I guess that could be fudged.
> - If the meaning of the POSIX path changes due to Cygwin mount point
> changes, native symlinks won't reflect that and point to the wrong
> thing.
> - Native relative links can't cross drive boundaries, whereas relative
> POSIX paths can reach the whole filesystem.

In addition, Windows systems ignore symlinks to remote volumes by default,
ostensibly for security reasons. (This behavior can be changed by using the
in-box fsutil program.) I agree that using Windows symlinks to implement
symlink(2) is a bad idea.

> I think the better approach here is to have an ln-like utility that
> creates Windows symlinks, as proposed by Daniel Colascione at
> http://cygwin.com/ml/cygwin/2011-04/msg00059.html. Perhaps it could be
> added to cygutils if it was knocked into appropriate shape. (The main
> advantage over using Windows facilities, in particular cmd.exe's
> mklink builtin, would be an ln-like interface and Cygwin charset
> support.)

I've sent an updated version of the program to the main Cygwin mailing list=
. Is
the new version suitable?

By the way: could we add an option to _not_ support shortcut-style symlinks?
("neverwinsymlinks"?) To support winsymlinks-created symlinks, we open an e=
xtra
two files for every open(2) call, even when winsymlinks isn't present in CY=
GWIN.

That is, when we open /foo/bar/qux, we actually try opening /foo/bar/qux.ln=
k,
/foo/bar/qux, /foo/bar/qux.exe.lnk, and /foo/bar/qux.exe. Skipping two of t=
hese
would benefit performance, and *I* know for certain that on my system, I do=
n't
use .lnk-style links.


--------------enig8C216186E6F38EC3287B8C58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 235

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAk7cJOAACgkQ17c2LVA10VtkYQCg5ua4WMnvN+VUI1WY9O5Fh9On
Fg0AnA9bnlTW1NT4XVpT2y1iymU0Bo67
=Xhly
-----END PGP SIGNATURE-----

--------------enig8C216186E6F38EC3287B8C58--
