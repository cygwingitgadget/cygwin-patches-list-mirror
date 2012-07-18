Return-Path: <cygwin-patches-return-7681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12051 invoked by alias); 18 Jul 2012 10:21:39 -0000
Received: (qmail 12040 invoked by uid 22791); 18 Jul 2012 10:21:38 -0000
X-SWARE-Spam-Status: No, hits=-5.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_TM
X-Spam-Check-By: sourceware.org
Received: from mail-gg0-f171.google.com (HELO mail-gg0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Jul 2012 10:21:23 +0000
Received: by ggmi1 with SMTP id i1so1438202ggm.2        for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2012 03:21:22 -0700 (PDT)
Received: by 10.42.132.193 with SMTP id e1mr1397574ict.54.1342606882547;        Wed, 18 Jul 2012 03:21:22 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id dw5sm13994062igc.6.2012.07.18.03.21.19        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 18 Jul 2012 03:21:21 -0700 (PDT)
Message-ID: <50068E29.6060302@users.sourceforge.net>
Date: Wed, 18 Jul 2012 10:21:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <4FCEC079.2090802@users.sourceforge.net> <20120606073305.GA18246@calimero.vinschen.de>
In-Reply-To: <20120606073305.GA18246@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------020801080102000304090302"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------020801080102000304090302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1630

Somehow this one fell through the cracks.  Picking up where we left off:

On 2012-06-06 02:33, Corinna Vinschen wrote:
> On Jun  5 21:29, Yaakov (Cygwin/X) wrote:
>> The string returned into buf is in the following format:
>>
>> mnt_fsname\0mnt_dir\0mnt_type\0mnt_opts\0mnt_freq" "mnt_passno\0
>
> Yes, but this is not something inherent to the functionality of
> getmntent_r, it's just residue from the way getmntent_r works.  It reads
> a line from /etc/fstab or /etc/mtab into the buffer via fgets:
>
>    mnt_fsname\tmnt_dir\tmnt_type\tmnt_opts\tmnt_freq\n
>
> and then creates the content of mntbuf from there, replacing the \t with
> \0 as it goes along.  So it starts with mnt_opts and mnt_freq strings in
> buf, but only to sscanf them into their respective mntbuf->mnt_opts and
> mntbuf->mnt_freq members.

Since glibc is getting this information from the kernel, that makes sense.

> In case of Cygwin this is not needed since we don't read from the file
> but from the internal datastructure.  There's no reason to create
> garbage in buf just because this is by chance the layout the buffer gets
> when operating under Linux.
>
> The *important* thing is that buf contains the strings the members of
> mntbuf points to.

OK, revised patch attached.

>> glibc makes no attempt to verify buf or mntbuf; if either of them
>> are not initialized or too small, you're in "undefined behaviour"
>> territory (aka SEGV :-).
>
> You're basically right.  But it won't SEGV if buf is too small.

By "too small", I meant sizeof(buf) < buflen, or sizeof(mntbuf) < 
sizeof(struct mntent); then glibc definitely does SEGV.


Yaakov


--------------020801080102000304090302
Content-Type: application/x-itunes-itlp;
 name="cygwin-getmntent_r.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin-getmntent_r.patch"
Content-length: 6239

MjAxMi0wNy0xOCAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogY3lnd2luLmRpbiAoZ2V0bW50ZW50X3IpOiBFeHBvcnQuCgkqIG1v
dW50LmNjIChnZXRtbnRlbnRfcik6IE5ldyBmdW5jdGlvbi4KCSogcG9zaXgu
c2dtbCAoc3RkLWdudSk6IEFkZCBnZXRtbnRlbnRfci4KCSogaW5jbHVkZS9t
bnRlbnQuaCAoZ2V0bW50ZW50X3IpOiBEZWNsYXJlLgoJKiBpbmNsdWRlL2N5
Z3dpbi92ZXJzaW9uLmggKENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUik6IEJ1
bXAuCgpJbmRleDogY3lnd2luLmRpbgo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9jeWd3aW4u
ZGluLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjI1NQpkaWZmIC11IC1wIC1y
MS4yNTUgY3lnd2luLmRpbgotLS0gY3lnd2luLmRpbgkxMCBNYXkgMjAxMiAw
ODozNToyMiAtMDAwMAkxLjI1NQorKysgY3lnd2luLmRpbgkxOCBKdWwgMjAx
MiAxMDoxMzowMyAtMDAwMApAQCAtNzM4LDYgKzczOCw3IEBAIF9nZXRsb2dp
biA9IGdldGxvZ2luIE5PU0lHRkUKIGdldGxvZ2luX3IgTk9TSUdGRQogZ2V0
bW50ZW50IFNJR0ZFCiBfZ2V0bW50ZW50ID0gZ2V0bW50ZW50IFNJR0ZFCitn
ZXRtbnRlbnRfciBTSUdGRQogZ2V0bW9kZSBTSUdGRQogX2dldG1vZGUgPSBn
ZXRtb2RlIFNJR0ZFCiBnZXRuYW1laW5mbyA9IGN5Z3dpbl9nZXRuYW1laW5m
byBTSUdGRQpJbmRleDogcG9zaXguc2dtbAo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9wb3Np
eC5zZ21sLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjc4CmRpZmYgLXUgLXAg
LXIxLjc4IHBvc2l4LnNnbWwKLS0tIHBvc2l4LnNnbWwJMTAgTWF5IDIwMTIg
MDg6MzU6MjIgLTAwMDAJMS43OAorKysgcG9zaXguc2dtbAkxOCBKdWwgMjAx
MiAxMDoxMzowMyAtMDAwMApAQCAtMTExNSw2ICsxMTE1LDcgQEAgYWxzbyBJ
RUVFIFN0ZCAxMDAzLjEtMjAwOCAoUE9TSVguMS0yMDA4KQogICAgIGdldF9w
aHlzX3BhZ2VzCiAgICAgZ2V0X25wcm9jcwogICAgIGdldF9ucHJvY3NfY29u
ZgorICAgIGdldG1udGVudF9yCiAgICAgZ2V0b3B0X2xvbmcKICAgICBnZXRv
cHRfbG9uZ19vbmx5CiAgICAgZ2V0cHQKSW5kZXg6IG1vdW50LmNjCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5z
dXAvY3lnd2luL21vdW50LmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjkx
CmRpZmYgLXUgLXAgLXIxLjkxIG1vdW50LmNjCi0tLSBtb3VudC5jYwkyIEp1
bCAyMDEyIDE5OjQyOjM0IC0wMDAwCTEuOTEKKysrIG1vdW50LmNjCTE4IEp1
bCAyMDEyIDEwOjEzOjAzIC0wMDAwCkBAIC0xODk5LDYgKzE4OTksMzggQEAg
Z2V0bW50ZW50IChGSUxFICopCiAgIHJldHVybiBtb3VudF90YWJsZS0+Z2V0
bW50ZW50IChfbXlfdGxzLmxvY2Fscy5pdGVyYXRpb24rKyk7CiB9CiAKK2V4
dGVybiAiQyIgc3RydWN0IG1udGVudCAqCitnZXRtbnRlbnRfciAoRklMRSAq
LCBzdHJ1Y3QgbW50ZW50ICptbnRidWYsIGNoYXIgKmJ1ZiwgaW50IGJ1Zmxl
bikKK3sKKyAgc3RydWN0IG1udGVudCAqbW50ID0gbW91bnRfdGFibGUtPmdl
dG1udGVudCAoX215X3Rscy5sb2NhbHMuaXRlcmF0aW9uKyspOworICBpbnQg
ZnNuYW1lX2xlbiwgZGlyX2xlbiwgdHlwZV9sZW4sIG9wdHNfbGVuLCB0bXBs
ZW4gPSBidWZsZW47CisKKyAgaWYgKCFtbnQpCisgICAgcmV0dXJuIE5VTEw7
CisKKyAgZnNuYW1lX2xlbiA9IHN0cmxlbiAobW50LT5tbnRfZnNuYW1lKSAr
IDE7CisgIGRpcl9sZW4gPSBzdHJsZW4gKG1udC0+bW50X2RpcikgKyAxOwor
ICB0eXBlX2xlbiA9IHN0cmxlbiAobW50LT5tbnRfdHlwZSkgKyAxOworICBv
cHRzX2xlbiA9IHN0cmxlbiAobW50LT5tbnRfb3B0cykgKyAxOworCisgIHNu
cHJpbnRmIChidWYsIGJ1ZmxlbiwgIiVzJWMlcyVjJXMlYyVzJWMlZCAlZCVj
IiwgbW50LT5tbnRfZnNuYW1lLCAnXDAnLAorCSAgICBtbnQtPm1udF9kaXIs
ICdcMCcsIG1udC0+bW50X3R5cGUsICdcMCcsIG1udC0+bW50X29wdHMsICdc
MCcsCisJICAgIG1udC0+bW50X2ZyZXEsIG1udC0+bW50X3Bhc3NubywgJ1ww
Jyk7CisKKyAgbW50YnVmLT5tbnRfZnNuYW1lID0gYnVmOworICB0bXBsZW4g
LT0gZnNuYW1lX2xlbjsKKyAgbW50YnVmLT5tbnRfZGlyID0gdG1wbGVuID4g
MCA/IGJ1ZiArIGZzbmFtZV9sZW4gOiAoY2hhciAqKSIiOworICB0bXBsZW4g
LT0gZGlyX2xlbjsKKyAgbW50YnVmLT5tbnRfdHlwZSA9IHRtcGxlbiA+IDAg
PyBidWYgKyBmc25hbWVfbGVuICsgZGlyX2xlbiA6IChjaGFyICopIiI7Cisg
IHRtcGxlbiAtPSB0eXBlX2xlbjsKKyAgbW50YnVmLT5tbnRfb3B0cyA9IHRt
cGxlbiA+IDAgPyBidWYgKyBmc25hbWVfbGVuICsgZGlyX2xlbiArIHR5cGVf
bGVuIDogKGNoYXIgKikiIjsKKyAgdG1wbGVuIC09IG9wdHNfbGVuOworICBt
bnRidWYtPm1udF9mcmVxID0gdG1wbGVuID4gMCA/IG1udC0+bW50X2ZyZXEg
OiAwOworICB0bXBsZW4gLT0gMjsKKyAgbW50YnVmLT5tbnRfcGFzc25vID0g
dG1wbGVuID4gMCA/IG1udC0+bW50X3Bhc3NubyA6IDA7CisgIHJldHVybiBt
bnRidWY7Cit9CisKIGV4dGVybiAiQyIgaW50CiBlbmRtbnRlbnQgKEZJTEUg
KikKIHsKSW5kZXg6IGluY2x1ZGUvbW50ZW50LmgKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4v
aW5jbHVkZS9tbnRlbnQuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42CmRp
ZmYgLXUgLXAgLXIxLjYgbW50ZW50LmgKLS0tIGluY2x1ZGUvbW50ZW50LmgJ
MiBGZWIgMjAxMCAxMToxNzo1NCAtMDAwMAkxLjYKKysrIGluY2x1ZGUvbW50
ZW50LmgJMTggSnVsIDIwMTIgMTA6MTM6MDMgLTAwMDAKQEAgLTMxLDYgKzMx
LDcgQEAgc3RydWN0IG1udGVudAogI2luY2x1ZGUgPHN0ZGlvLmg+CiBGSUxF
ICpzZXRtbnRlbnQgKGNvbnN0IGNoYXIgKl9fZmlsZXAsIGNvbnN0IGNoYXIg
Kl9fdHlwZSk7CiBzdHJ1Y3QgbW50ZW50ICpnZXRtbnRlbnQgKEZJTEUgKl9f
ZmlsZXApOworc3RydWN0IG1udGVudCAqZ2V0bW50ZW50X3IgKEZJTEUgKiwg
c3RydWN0IG1udGVudCAqLCBjaGFyICosIGludCk7CiBpbnQgZW5kbW50ZW50
IChGSUxFICpfX2ZpbGVwKTsKICNlbmRpZgogCkluZGV4OiBpbmNsdWRlL2N5
Z3dpbi92ZXJzaW9uLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4v
dmVyc2lvbi5oLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjM3MApkaWZmIC11
IC1wIC1yMS4zNzAgdmVyc2lvbi5oCi0tLSBpbmNsdWRlL2N5Z3dpbi92ZXJz
aW9uLmgJMTAgTWF5IDIwMTIgMDg6MzU6MjIgLTAwMDAJMS4zNzAKKysrIGlu
Y2x1ZGUvY3lnd2luL3ZlcnNpb24uaAkxOCBKdWwgMjAxMiAxMDoxMzowMyAt
MDAwMApAQCAtNDMwLDEyICs0MzAsMTMgQEAgZGV0YWlscy4gKi8KICAgICAg
IDI1OTogRXhwb3J0IHB0aHJlYWRfc2lncXVldWUuCiAgICAgICAyNjA6IEV4
cG9ydCBzY2FuZGlyYXQuCiAgICAgICAyNjE6IEV4cG9ydCBtZW1yY2hyLgor
ICAgICAgMjYyOiBFeHBvcnQgZ2V0bW50ZW50X3IuCiAgICAgICovCiAKICAg
ICAgLyogTm90ZSB0aGF0IHdlIGZvcmdvdCB0byBidW1wIHRoZSBhcGkgZm9y
IHVhbGFybSwgc3RydG9sbCwgc3RydG91bGwgKi8KIAogI2RlZmluZSBDWUdX
SU5fVkVSU0lPTl9BUElfTUFKT1IgMAotI2RlZmluZSBDWUdXSU5fVkVSU0lP
Tl9BUElfTUlOT1IgMjYxCisjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9N
SU5PUiAyNjIKIAogICAgICAvKiBUaGVyZSBpcyBhbHNvIGEgY29tcGF0aWJp
dHkgdmVyc2lvbiBudW1iZXIgYXNzb2NpYXRlZCB3aXRoIHRoZQogCXNoYXJl
ZCBtZW1vcnkgcmVnaW9ucy4gIEl0IGlzIGluY3JlbWVudGVkIHdoZW4gaW5j
b21wYXRpYmxlCkluZGV4OiByZWxlYXNlLzEuNy4xNgo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dp
bi9yZWxlYXNlLzEuNy4xNix2CnJldHJpZXZpbmcgcmV2aXNpb24gMS44CmRp
ZmYgLXUgLXAgLXIxLjggMS43LjE2Ci0tLSByZWxlYXNlLzEuNy4xNgkzIEp1
biAyMDEyIDE2OjQ3OjU3IC0wMDAwCTEuOAorKysgcmVsZWFzZS8xLjcuMTYJ
MTggSnVsIDIwMTIgMTA6MTM6MDMgLTAwMDAKQEAgLTEsNyArMSw3IEBACiBX
aGF0J3MgbmV3OgogLS0tLS0tLS0tLS0KIAotLSBOZXcgQVBJOiBtZW1yY2hy
LgorLSBOZXcgQVBJOiBnZXRtbnRlbnRfciwgbWVtcmNoci4KIAogLSBTdXBw
b3J0IFJlRlMuCiAK

--------------020801080102000304090302--
