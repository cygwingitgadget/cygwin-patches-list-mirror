Return-Path: <SRS0=cVhV=PK=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 6DD533858D39
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 18:31:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DD533858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DD533858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1723401117; cv=none;
	b=JfdgZe2u34Hpnp3eTPhzifjbHrC3tE8D7fWDUozym1SUvMY5W5tO8xOCNi0t0blaa744fo6aEjIAwzxSML608IIy0LOd1R6FRSQGu9CBQMreThyq1E3IRr8EdbwlTmdaAYs1qlGDOLuyyYE9zUdHW3GwqNRKKhqQxQSoR8tDO80=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1723401117; c=relaxed/simple;
	bh=7VfnykEpyPkWa7nGBU0pAdLT+xAtaGiLGX7WIe5uXVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=fod6ohiR2jOjNOS4DOSHO9AJ2mPgiX1midzBF0+w4nhKlwdNiARyV0Ys0jpAlgDiWpd5/cutyJi6NAyCobmBnFliDLbh4UpV5zoVn8WfO0JkJIxBblygjkHmK3tFZUBKYjZ5A3tVtsltKQHGF+yYJeKTLC2htZ08z4kqMNcAUek=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CC44E819E7
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 18:31:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 5593C20025
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 18:31:53 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------l0fcsQkzuCAkt069c0847SlU"
Message-ID: <659ca957-c6bd-481d-99ef-2516e902be31@SystematicSW.ab.ca>
Date: Sun, 11 Aug 2024 12:31:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of
 socket ioctls
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-6-jon.turney@dronecode.org.uk>
 <ZrCn00PXmRT77OKj@calimero.vinschen.de>
 <4deb7dbe-1ac0-478c-bd36-76d3937864cc@dronecode.org.uk>
 <ZrN_YlBeD31PpxN7@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <ZrN_YlBeD31PpxN7@calimero.vinschen.de>
X-Stat-Signature: 9kiis644begrkghqfqf7k31g5n9p6owa
X-Rspamd-Server: rspamout05
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 5593C20025
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/a7qdCdIjRwtQC4sI0SA09cclv6jRHCEI=
X-HE-Tag: 1723401113-452978
X-HE-Meta: U2FsdGVkX18gvin5p6xHkKMDEGLIaolWF6/HvNKpWAJesu4iq4NMTlLZSkYiA00Pp4+mIm/fWLkaXAqG38y07Q0E96y4ytcxugrhx1OUNFHRDoMQJTZUQUVHfdRgMV1UyYQ4MFFdXsa8z+vM/rapQl4TXv2kLHz4jXnVttgoABcgHd3bY2Y/REGQgTCLq0a7rwOyjtvnuvsezY774mvGd7Uahp0lk1za4EYtrYIrZjx3bWrdiq/RLinYeDh7jtdR+/oqBxzACoVHaSg1fHuFVBdoMXTh+Yq3Fk7vj7RbxkkPS7zLlwHHbFQKJeTf32fBdGHUKSb5LR8E1pyom6IRfpu1fpivTY6OnjepExPByynM4uPw8+Xgjcz5i5pJ9ISHBf6UTWVVCtxsLPHQvepKoJSevxmcUw4s
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------l0fcsQkzuCAkt069c0847SlU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-07 08:06, Corinna Vinschen wrote:
> On Aug  6 19:58, Jon Turney wrote:
>> On 05/08/2024 11:22, Corinna Vinschen wrote:
>>> On Aug  4 22:48, Jon Turney wrote:
>>>> Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
>>>> when used as case labels, e.g:
>>>> [...]
>>> The only caller, fhandler_socket::ioctl, passes an unsigned int
>>> value to get_ifconf. Given how the value is defined, it would be
>>> more straightforward to convert get_ifconf to
>>>
>>>     get_ifconf (struct ifconf *ifc, unsigned int what);
>>>
>>> wouldn't it?
>>
>> Yeah, I'm not sure why I didn't do that.  I think I got confused about where
>> this is used from.

> LGTM.  I will additionally push a patch dropping the useless casts.

Hi folks,

Trying to rebuild got a couple of issues with gcc12 and likely recent updates to 
main, as my previous rebuild for /proc/cpuinfo with gcc11 was fine:

- picky g++

   CXX      net.o
In file included from 
/usr/src/newlib-cygwin/winsup/cygwin/include/cygwin/socket.h:47,
                  from /usr/src/newlib-cygwin/winsup/cygwin/include/cygwin/if.h:17,
                  from /usr/src/newlib-cygwin/winsup/cygwin/include/ifaddrs.h:42,
                  from /usr/src/newlib-cygwin/winsup/cygwin/net.cc:26:
/usr/src/newlib-cygwin/winsup/cygwin/net.cc: In function ‘int 
get_ifconf(ifconf*, int)’:
/usr/src/newlib-cygwin/winsup/cygwin/net.cc:1940:18: error: narrowing conversion 
of ‘2152756069’ from ‘long unsigned int’ to ‘int’ [-Wnarrowing]
  1940 |             case SIOCGIFFLAGS:
       |                  ^~~~~~~~~~~~
... and so on

50cf10dfa485 Cygwin: asm/socket.h: drop outdated casts

so change net.cc get_ifconf (struct ifconf *ifc, int what) to unsigned long, and 
where it is also declared in fhandler/socket.cc?

- __utoa (and __itoa) declared in stdlib.h inside #ifndef __CYGWIN__

   CC       libc/stdlib/libc_a-itoa.o
/usr/src/newlib-cygwin/newlib/libc/stdlib/itoa.c: In function ‘__itoa’:
/usr/src/newlib-cygwin/newlib/libc/stdlib/itoa.c:57:3: warning: implicit 
declaration of function ‘__utoa’; did you mean ‘__itoa’? 
[-Wimplicit-function-declaration]
    57 |   __utoa (uvalue, &str[i], base);
       |   ^~~~~~
       |   __itoa


31f7cd1e4332 Hide itoa, utoa, __itoa and __utoa in stdlib.h on Cygwin only

$ grep -C2 utoa ../../newlib/libc/include/stdlib.h
#ifndef __CYGWIN__
char *  __itoa (int, char *, int);
char *  __utoa (unsigned, char *, int);
# if __MISC_VISIBLE
char *  itoa (int, char *, int);
char *  utoa (unsigned, char *, int);
# endif
#endif

so should this be __INSIDE_CYGWIN__ instead or something else?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
--------------l0fcsQkzuCAkt069c0847SlU
Content-Type: text/plain; charset=UTF-8;
 name="newlib-cygwin-build64-gcc-12-issues.log"
Content-Disposition: attachment;
 filename="newlib-cygwin-build64-gcc-12-issues.log"
Content-Transfer-Encoding: base64

MjAyNC0wOC0xMCAyMjowMTozNVoKMjAyNC0wOC0xMCAyMjowMTozNloKMjAyNC0wOC0xMCAy
MjowNDowMloKLi4uCm1ha2VbMl06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMvYnVp
bGQ2NC94ODZfNjQtcGMtY3lnd2luL25ld2xpYicKL3Vzci9iaW4vbWFrZSAiQ0NfRk9SX0JV
SUxEPWdjYyIgIkNGTEFHUz0tZyAtTzIiICJDQ0FTRkxBR1M9LWcgLU8yIiAiQ0ZMQUdTX0ZP
Ul9CVUlMRD0tZyAtTzIiICJDRkxBR1NfRk9SX1RBUkdFVD0tZyAtTzIiICJJTlNUQUxMPS91
c3IvYmluL2luc3RhbGwgLWMiICJMREZMQUdTPSIgIkxJQkNGTEFHUz0tZyAtTzIiICJMSUJD
RkxBR1NfRk9SX1RBUkdFVD0tZyAtTzIiICJNQUtFPS91c3IvYmluL21ha2UiICJNQUtFSU5G
Tz1tYWtlaW5mbyAtLXNwbGl0LXNpemU9NTAwMDAwMCAtLXNwbGl0LXNpemU9NTAwMDAwMCAi
ICJQSUNGTEFHPSIgIlBJQ0ZMQUdfRk9SX1RBUkdFVD0iICJTSEVMTD0vYmluL3NoIiAiRVhQ
RUNUPWV4cGVjdCIgIlJVTlRFU1Q9cnVudGVzdCIgIlJVTlRFU1RGTEFHUz0iICJleGVjX3By
ZWZpeD0vdXNyL3NyYy9pbnN0YWxsNjQvdXNyL2JpbiIgImluZm9kaXI9L3Vzci9zcmMvaW5z
dGFsbDY0L3Vzci9zaGFyZS9pbmZvIiAibGliZGlyPS91c3Ivc3JjL2luc3RhbGw2NC91c3Iv
YmluL2xpYiIgInByZWZpeD0vdXNyL3NyYy9pbnN0YWxsNjQvdXNyIiAidG9vbGRpcj0vdXNy
L3NyYy9pbnN0YWxsNjQvdXNyL2Jpbi94ODZfNjQtcGMtY3lnd2luIiAidG9wX3Rvb2xsaWJk
aXI9L3Vzci9zcmMvaW5zdGFsbDY0L3Vzci9iaW4veDg2XzY0LXBjLWN5Z3dpbi9saWIiICJB
Uj1hciAiICJBUz1hcyIgIkNDPWdjYyAtTC91c3Ivc3JjL2J1aWxkNjQveDg2XzY0LXBjLWN5
Z3dpbi93aW5zdXAvY3lnd2luIC1pc3lzdGVtIC91c3Ivc3JjL25ld2xpYi1jeWd3aW4vd2lu
c3VwL2N5Z3dpbi9pbmNsdWRlIC1CL3Vzci9zcmMvYnVpbGQ2NC94ODZfNjQtcGMtY3lnd2lu
L25ld2xpYi8gLWlzeXN0ZW0gL3Vzci9zcmMvYnVpbGQ2NC94ODZfNjQtcGMtY3lnd2luL25l
d2xpYi90YXJnLWluY2x1ZGUgLWlzeXN0ZW0gL3Vzci9zcmMvbmV3bGliLWN5Z3dpbi9uZXds
aWIvbGliYy9pbmNsdWRlICAgIC1JL3Vzci9zcmMvbmV3bGliLWN5Z3dpbi9uZXdsaWIvLi4v
d2luc3VwL2N5Z3dpbi9pbmNsdWRlIiAiTEQ9L3Vzci9saWIvZ2NjL3g4Nl82NC1wYy1jeWd3
aW4vMTIvLi4vLi4vLi4vLi4veDg2XzY0LXBjLWN5Z3dpbi9iaW4vbGQuZXhlIiAiTElCQ0ZM
QUdTPS1nIC1PMiIgIk5NPW5tIiAiUElDRkxBRz0iICJSQU5MSUI9cmFubGliICIgIkRFU1RE
SVI9L3Vzci9zcmMvaW5zdGFsbDY0IiBhbGwtYW0KbWFrZVszXTogRW50ZXJpbmcgZGlyZWN0
b3J5ICcvdXNyL3NyYy9idWlsZDY0L3g4Nl82NC1wYy1jeWd3aW4vbmV3bGliJwouLi4KICBD
QyAgICAgICBsaWJjL3N0ZGxpYi9saWJjX2EtaXRvYS5vCi91c3Ivc3JjL25ld2xpYi1jeWd3
aW4vbmV3bGliL2xpYmMvc3RkbGliL2l0b2EuYzogSW4gZnVuY3Rpb24g4oCYX19pdG9h4oCZ
OgovdXNyL3NyYy9uZXdsaWItY3lnd2luL25ld2xpYi9saWJjL3N0ZGxpYi9pdG9hLmM6NTc6
Mzogd2FybmluZzogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYX191dG9h
4oCZOyBkaWQgeW91IG1lYW4g4oCYX19pdG9h4oCZPyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1k
ZWNsYXJhdGlvbl0KICAgNTcgfCAgIF9fdXRvYSAodXZhbHVlLCAmc3RyW2ldLCBiYXNlKTsK
ICAgICAgfCAgIF5+fn5+fgogICAgICB8ICAgX19pdG9hCi4uLgptYWtlWzRdOiBMZWF2aW5n
IGRpcmVjdG9yeSAnL3Vzci9zcmMvYnVpbGQ2NC94ODZfNjQtcGMtY3lnd2luL25ld2xpYicK
bWFrZVszXTogTGVhdmluZyBkaXJlY3RvcnkgJy91c3Ivc3JjL2J1aWxkNjQveDg2XzY0LXBj
LWN5Z3dpbi9uZXdsaWInCm1ha2VbMl06IExlYXZpbmcgZGlyZWN0b3J5ICcvdXNyL3NyYy9i
dWlsZDY0L3g4Nl82NC1wYy1jeWd3aW4vbmV3bGliJwptYWtlWzJdOiBFbnRlcmluZyBkaXJl
Y3RvcnkgJy91c3Ivc3JjL2J1aWxkNjQveDg2XzY0LXBjLWN5Z3dpbi93aW5zdXAnCm1ha2Vb
M106IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMvYnVpbGQ2NC94ODZfNjQtcGMtY3ln
d2luL3dpbnN1cC9jeWd3aW4nCm1ha2VbNF06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9z
cmMvYnVpbGQ2NC94ODZfNjQtcGMtY3lnd2luL3dpbnN1cC9jeWd3aW4nCi4uLgogIENYWCAg
ICAgIG5ldC5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL3NyYy9uZXdsaWItY3lnd2lu
L3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vc29ja2V0Lmg6NDcsCiAgICAgICAgICAg
ICAgICAgZnJvbSAvdXNyL3NyYy9uZXdsaWItY3lnd2luL3dpbnN1cC9jeWd3aW4vaW5jbHVk
ZS9jeWd3aW4vaWYuaDoxNywKICAgICAgICAgICAgICAgICBmcm9tIC91c3Ivc3JjL25ld2xp
Yi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2lmYWRkcnMuaDo0MiwKICAgICAgICAg
ICAgICAgICBmcm9tIC91c3Ivc3JjL25ld2xpYi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQu
Y2M6MjY6Ci91c3Ivc3JjL25ld2xpYi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQuY2M6IElu
IGZ1bmN0aW9uIOKAmGludCBnZXRfaWZjb25mKGlmY29uZiosIGludCnigJk6Ci91c3Ivc3Jj
L25ld2xpYi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQuY2M6MTk0MDoxODogZXJyb3I6IG5h
cnJvd2luZyBjb252ZXJzaW9uIG9mIOKAmDIxNTI3NTYwNjnigJkgZnJvbSDigJhsb25nIHVu
c2lnbmVkIGludOKAmSB0byDigJhpbnTigJkgWy1XbmFycm93aW5nXQogMTk0MCB8ICAgICAg
ICAgICAgIGNhc2UgU0lPQ0dJRkZMQUdTOgogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+
fn5+fn5+fn5+Ci91c3Ivc3JjL25ld2xpYi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQuY2M6
MTk0MzoxODogZXJyb3I6IG5hcnJvd2luZyBjb252ZXJzaW9uIG9mIOKAmDIxNDg1NjE3NjTi
gJkgZnJvbSDigJhsb25nIHVuc2lnbmVkIGludOKAmSB0byDigJhpbnTigJkgWy1XbmFycm93
aW5nXQogMTk0MyB8ICAgICAgICAgICAgIGNhc2UgU0lPQ0dJRkNPTkY6CiAgICAgIHwgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fgovdXNyL3NyYy9uZXdsaWItY3lnd2luL3dpbnN1
cC9jeWd3aW4vbmV0LmNjOjE5NDQ6MTg6IGVycm9yOiBuYXJyb3dpbmcgY29udmVyc2lvbiBv
ZiDigJgyMTUyNzU2MDcw4oCZIGZyb20g4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgdG8g4oCY
aW504oCZIFstV25hcnJvd2luZ10KIDE5NDQgfCAgICAgICAgICAgICBjYXNlIFNJT0NHSUZB
RERSOgogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KL3Vzci9zcmMvbmV3
bGliLWN5Z3dpbi93aW5zdXAvY3lnd2luL25ldC5jYzoxOTQ4OjE4OiBlcnJvcjogbmFycm93
aW5nIGNvbnZlcnNpb24gb2Yg4oCYMjE1Mjc1NjA3MuKAmSBmcm9tIOKAmGxvbmcgdW5zaWdu
ZWQgaW504oCZIHRvIOKAmGludOKAmSBbLVduYXJyb3dpbmddCiAxOTQ4IHwgICAgICAgICAg
ICAgY2FzZSBTSU9DR0lGTkVUTUFTSzoKICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+Ci91c3Ivc3JjL25ld2xpYi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQuY2M6
MTk1MjoxODogZXJyb3I6IG5hcnJvd2luZyBjb252ZXJzaW9uIG9mIOKAmDIxNTI3NTYwNzji
gJkgZnJvbSDigJhsb25nIHVuc2lnbmVkIGludOKAmSB0byDigJhpbnTigJkgWy1XbmFycm93
aW5nXQogMTk1MiB8ICAgICAgICAgICAgIGNhc2UgU0lPQ0dJRkRTVEFERFI6CiAgICAgIHwg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fgovdXNyL3NyYy9uZXdsaWItY3lnd2lu
L3dpbnN1cC9jeWd3aW4vbmV0LmNjOjE5NTk6MTg6IGVycm9yOiBuYXJyb3dpbmcgY29udmVy
c2lvbiBvZiDigJgyMTUyNzU2MDcx4oCZIGZyb20g4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkg
dG8g4oCYaW504oCZIFstV25hcnJvd2luZ10KIDE5NTkgfCAgICAgICAgICAgICBjYXNlIFNJ
T0NHSUZCUkRBRERSOgogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4K
L3Vzci9zcmMvbmV3bGliLWN5Z3dpbi93aW5zdXAvY3lnd2luL25ldC5jYzoxOTcwOjE4OiBl
cnJvcjogbmFycm93aW5nIGNvbnZlcnNpb24gb2Yg4oCYMjE1Mjc1NjA3M+KAmSBmcm9tIOKA
mGxvbmcgdW5zaWduZWQgaW504oCZIHRvIOKAmGludOKAmSBbLVduYXJyb3dpbmddCiAxOTcw
IHwgICAgICAgICAgICAgY2FzZSBTSU9DR0lGSFdBRERSOgogICAgICB8ICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fgovdXNyL3NyYy9uZXdsaWItY3lnd2luL3dpbnN1cC9jeWd3
aW4vbmV0LmNjOjE5NzQ6MTg6IGVycm9yOiBuYXJyb3dpbmcgY29udmVyc2lvbiBvZiDigJgy
MTUyNzU2MDc04oCZIGZyb20g4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgdG8g4oCYaW504oCZ
IFstV25hcnJvd2luZ10KIDE5NzQgfCAgICAgICAgICAgICBjYXNlIFNJT0NHSUZNRVRSSUM6
CiAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+Ci91c3Ivc3JjL25ld2xp
Yi1jeWd3aW4vd2luc3VwL2N5Z3dpbi9uZXQuY2M6MTk3NzoxODogZXJyb3I6IG5hcnJvd2lu
ZyBjb252ZXJzaW9uIG9mIOKAmDIxNTI3NTYwNzXigJkgZnJvbSDigJhsb25nIHVuc2lnbmVk
IGludOKAmSB0byDigJhpbnTigJkgWy1XbmFycm93aW5nXQogMTk3NyB8ICAgICAgICAgICAg
IGNhc2UgU0lPQ0dJRk1UVToKICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn4K
L3Vzci9zcmMvbmV3bGliLWN5Z3dpbi93aW5zdXAvY3lnd2luL25ldC5jYzoxOTgwOjE4OiBl
cnJvcjogbmFycm93aW5nIGNvbnZlcnNpb24gb2Yg4oCYMjE1Mjc1NjA3NuKAmSBmcm9tIOKA
mGxvbmcgdW5zaWduZWQgaW504oCZIHRvIOKAmGludOKAmSBbLVduYXJyb3dpbmddCiAxOTgw
IHwgICAgICAgICAgICAgY2FzZSBTSU9DR0lGSU5ERVg6CiAgICAgIHwgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn4KL3Vzci9zcmMvbmV3bGliLWN5Z3dpbi93aW5zdXAvY3lnd2lu
L25ldC5jYzoxOTgzOjE4OiBlcnJvcjogbmFycm93aW5nIGNvbnZlcnNpb24gb2Yg4oCYMjE1
Mjc1NjA3N+KAmSBmcm9tIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIHRvIOKAmGludOKAmSBb
LVduYXJyb3dpbmddCiAxOTgzIHwgICAgICAgICAgICAgY2FzZSBTSU9DR0lGRlJORExZTkFN
OgogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fgptYWtlWzRdOiAq
KiogW01ha2VmaWxlOjIwNzY6IG5ldC5vXSBFcnJvciAxCm1ha2VbNF06IExlYXZpbmcgZGly
ZWN0b3J5ICcvdXNyL3NyYy9idWlsZDY0L3g4Nl82NC1wYy1jeWd3aW4vd2luc3VwL2N5Z3dp
bicKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTg2OiBhbGxdIEVycm9yIDIKbWFrZVszXTog
TGVhdmluZyBkaXJlY3RvcnkgJy91c3Ivc3JjL2J1aWxkNjQveDg2XzY0LXBjLWN5Z3dpbi93
aW5zdXAvY3lnd2luJwptYWtlWzJdOiAqKiogW01ha2VmaWxlOjM5NTogYWxsLXJlY3Vyc2l2
ZV0gRXJyb3IgMQptYWtlWzJdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMvYnVpbGQ2
NC94ODZfNjQtcGMtY3lnd2luL3dpbnN1cCcKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo5NDY0
OiBhbGwtdGFyZ2V0LXdpbnN1cF0gRXJyb3IgMgptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9y
eSAnL3Vzci9zcmMvYnVpbGQ2NCcKbWFrZTogKioqIFtNYWtlZmlsZTo4ODM6IGFsbF0gRXJy
b3IgMgoyMDI0LTA4LTEwIDIyOjIzOjMxWgo=

--------------l0fcsQkzuCAkt069c0847SlU--
