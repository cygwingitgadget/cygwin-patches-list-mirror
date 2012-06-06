Return-Path: <cygwin-patches-return-7671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3578 invoked by alias); 6 Jun 2012 02:29:29 -0000
Received: (qmail 3563 invoked by uid 22791); 6 Jun 2012 02:29:27 -0000
X-SWARE-Spam-Status: No, hits=-5.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_CP,TW_TM
X-Spam-Check-By: sourceware.org
Received: from mail-gg0-f171.google.com (HELO mail-gg0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 06 Jun 2012 02:29:13 +0000
Received: by ggmi1 with SMTP id i1so4813265ggm.2        for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2012 19:29:12 -0700 (PDT)
Received: by 10.50.154.233 with SMTP id vr9mr5221485igb.9.1338949751861;        Tue, 05 Jun 2012 19:29:11 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id nh8sm1638768igc.1.2012.06.05.19.29.10        (version=TLSv1/SSLv3 cipher=OTHER);        Tue, 05 Jun 2012 19:29:10 -0700 (PDT)
Message-ID: <4FCEC079.2090802@users.sourceforge.net>
Date: Wed, 06 Jun 2012 02:29:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de>
In-Reply-To: <20120605124209.GB23381@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------050509060109020303090601"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00040.txt.bz2

This is a multi-part message in MIME format.
--------------050509060109020303090601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2433

On 2012-06-05 07:42, Corinna Vinschen wrote:
>> +extern "C" struct mntent *
>> +getmntent_r (FILE *, struct mntent *mntbuf, char *buf, int buflen)
>> +{
>> +  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
>> +  char *tmpbuf;
>> +  int len = 0, maxlen;
>> +
>> +  if (!mnt)
>> +    {
>> +      mntbuf = NULL;
>
> This doesn't make sense since mntbuf is a local varibale.  Changing
> its value won't be propagated by the calling function anyway.

Further testing of glibc shows that buf and mntbuf are indeed left 
untouched when returning NULL.

>> +  maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
>> +           + strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 30;
>> +  tmpbuf = (char *) alloca (maxlen);
>> +  memset (tmpbuf, '\0', maxlen);
>> +
>> +  len += __small_sprintf (tmpbuf, "%s", mnt->mnt_fsname) + 1;
>> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_dir) + 1;
>> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_type) + 1;
>> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_opts) + 1;
>
> This you can have simpler.
>
>> +  len += __small_sprintf (tmpbuf + len, "%d %d", mnt->mnt_freq, mnt->mnt_passno);
>
> and this I don't grok at all.  Why don't you just copy over the
> numbers from mnt to mntbuf?

The string returned into buf is in the following format:

mnt_fsname\0mnt_dir\0mnt_type\0mnt_opts\0mnt_freq" "mnt_passno\0

In the test program, only 5 iterations of the for loop are necessary to 
display the entire string; the sixth only checks that no garbage is 
found beyond that (hence the memset call).

>> +  memcpy (buf, tmpbuf, buflen);
>
> So the function returns success even if the incoming buffer space
> is insufficient?

glibc makes no attempt to verify buf or mntbuf; if either of them are 
not initialized or too small, you're in "undefined behaviour" territory 
(aka SEGV :-).

> This doesn't do what you want.  mntbuf is just a copy of mnt, so the
> mntbuf members won't point to buf, but they will point to the internal
> storage.  While you have made a copy of the internal strings, they won't
> be used.  Also, assuming you first store the strings in tmpbuf and then
> memcpy them over to buf,
>
>> +  return mnt;
>
> And this returns the internal mntent entry anyway, so even mntbuf is
> kind of moot.

Further testing of glibc shows that the returned pointer is indeed &mntent.

Revised patch and testcase attached.


Yaakov

--------------050509060109020303090601
Content-Type: application/x-itunes-itlp;
 name="cygwin-getmntent_r.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin-getmntent_r.patch"
Content-length: 5917

MjAxMi0wNi0wNSAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
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
ODozNToyMiAtMDAwMAkxLjI1NQorKysgY3lnd2luLmRpbgk2IEp1biAyMDEy
IDAyOjI0OjA2IC0wMDAwCkBAIC03MzgsNiArNzM4LDcgQEAgX2dldGxvZ2lu
ID0gZ2V0bG9naW4gTk9TSUdGRQogZ2V0bG9naW5fciBOT1NJR0ZFCiBnZXRt
bnRlbnQgU0lHRkUKIF9nZXRtbnRlbnQgPSBnZXRtbnRlbnQgU0lHRkUKK2dl
dG1udGVudF9yIFNJR0ZFCiBnZXRtb2RlIFNJR0ZFCiBfZ2V0bW9kZSA9IGdl
dG1vZGUgU0lHRkUKIGdldG5hbWVpbmZvID0gY3lnd2luX2dldG5hbWVpbmZv
IFNJR0ZFCkluZGV4OiBtb3VudC5jYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9tb3VudC5j
Yyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45MApkaWZmIC11IC1wIC1yMS45
MCBtb3VudC5jYwotLS0gbW91bnQuY2MJMyBKdW4gMjAxMiAxNjo0Njo1MyAt
MDAwMAkxLjkwCisrKyBtb3VudC5jYwk2IEp1biAyMDEyIDAyOjI0OjA2IC0w
MDAwCkBAIC0xOTAwLDYgKzE5MDAsMzIgQEAgZ2V0bW50ZW50IChGSUxFICop
CiAgIHJldHVybiBtb3VudF90YWJsZS0+Z2V0bW50ZW50IChfbXlfdGxzLmxv
Y2Fscy5pdGVyYXRpb24rKyk7CiB9CiAKK2V4dGVybiAiQyIgc3RydWN0IG1u
dGVudCAqCitnZXRtbnRlbnRfciAoRklMRSAqLCBzdHJ1Y3QgbW50ZW50ICpt
bnRidWYsIGNoYXIgKmJ1ZiwgaW50IGJ1ZmxlbikKK3sKKyAgc3RydWN0IG1u
dGVudCAqbW50ID0gbW91bnRfdGFibGUtPmdldG1udGVudCAoX215X3Rscy5s
b2NhbHMuaXRlcmF0aW9uKyspOworICBjaGFyICp0bXBidWY7CisgIGludCBs
ZW4gPSAwLCBtYXhsZW47CisKKyAgaWYgKCFtbnQpCisgICAgcmV0dXJuIE5V
TEw7CisKKyAgbWF4bGVuID0gc3RybGVuIChtbnQtPm1udF9mc25hbWUpICsg
c3RybGVuIChtbnQtPm1udF9kaXIpCisgICAgICAgICAgICsgc3RybGVuICht
bnQtPm1udF90eXBlKSArIHN0cmxlbiAobW50LT5tbnRfb3B0cykgKyAzMDsK
KyAgdG1wYnVmID0gKGNoYXIgKikgYWxsb2NhIChtYXhsZW4pOworICBtZW1z
ZXQgKHRtcGJ1ZiwgJ1wwJywgbWF4bGVuKTsKKworICBsZW4gKz0gX19zbWFs
bF9zcHJpbnRmICh0bXBidWYsICIlcyIsIG1udC0+bW50X2ZzbmFtZSkgKyAx
OworICBsZW4gKz0gX19zbWFsbF9zcHJpbnRmICh0bXBidWYgKyBsZW4sICIl
cyIsIG1udC0+bW50X2RpcikgKyAxOworICBsZW4gKz0gX19zbWFsbF9zcHJp
bnRmICh0bXBidWYgKyBsZW4sICIlcyIsIG1udC0+bW50X3R5cGUpICsgMTsK
KyAgbGVuICs9IF9fc21hbGxfc3ByaW50ZiAodG1wYnVmICsgbGVuLCAiJXMi
LCBtbnQtPm1udF9vcHRzKSArIDE7CisgIGxlbiArPSBfX3NtYWxsX3Nwcmlu
dGYgKHRtcGJ1ZiArIGxlbiwgIiVkICVkIiwgbW50LT5tbnRfZnJlcSwgbW50
LT5tbnRfcGFzc25vKTsKKworICBtZW1jcHkgKGJ1ZiwgdG1wYnVmLCBidWZs
ZW4pOworICBtZW1jcHkgKG1udGJ1ZiwgbW50LCBzaXplb2YgKHN0cnVjdCBt
bnRlbnQpKTsKKyAgcmV0dXJuIG1udGJ1ZjsKK30KKwogZXh0ZXJuICJDIiBp
bnQKIGVuZG1udGVudCAoRklMRSAqKQogewpJbmRleDogcG9zaXguc2dtbAo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMv
d2luc3VwL2N5Z3dpbi9wb3NpeC5zZ21sLHYKcmV0cmlldmluZyByZXZpc2lv
biAxLjc4CmRpZmYgLXUgLXAgLXIxLjc4IHBvc2l4LnNnbWwKLS0tIHBvc2l4
LnNnbWwJMTAgTWF5IDIwMTIgMDg6MzU6MjIgLTAwMDAJMS43OAorKysgcG9z
aXguc2dtbAk2IEp1biAyMDEyIDAyOjI0OjA2IC0wMDAwCkBAIC0xMTE1LDYg
KzExMTUsNyBAQCBhbHNvIElFRUUgU3RkIDEwMDMuMS0yMDA4IChQT1NJWC4x
LTIwMDgpCiAgICAgZ2V0X3BoeXNfcGFnZXMKICAgICBnZXRfbnByb2NzCiAg
ICAgZ2V0X25wcm9jc19jb25mCisgICAgZ2V0bW50ZW50X3IKICAgICBnZXRv
cHRfbG9uZwogICAgIGdldG9wdF9sb25nX29ubHkKICAgICBnZXRwdApJbmRl
eDogaW5jbHVkZS9tbnRlbnQuaAo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21u
dGVudC5oLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjYKZGlmZiAtdSAtcCAt
cjEuNiBtbnRlbnQuaAotLS0gaW5jbHVkZS9tbnRlbnQuaAkyIEZlYiAyMDEw
IDExOjE3OjU0IC0wMDAwCTEuNgorKysgaW5jbHVkZS9tbnRlbnQuaAk2IEp1
biAyMDEyIDAyOjI0OjA2IC0wMDAwCkBAIC0zMSw2ICszMSw3IEBAIHN0cnVj
dCBtbnRlbnQKICNpbmNsdWRlIDxzdGRpby5oPgogRklMRSAqc2V0bW50ZW50
IChjb25zdCBjaGFyICpfX2ZpbGVwLCBjb25zdCBjaGFyICpfX3R5cGUpOwog
c3RydWN0IG1udGVudCAqZ2V0bW50ZW50IChGSUxFICpfX2ZpbGVwKTsKK3N0
cnVjdCBtbnRlbnQgKmdldG1udGVudF9yIChGSUxFICosIHN0cnVjdCBtbnRl
bnQgKiwgY2hhciAqLCBpbnQpOwogaW50IGVuZG1udGVudCAoRklMRSAqX19m
aWxlcCk7CiAjZW5kaWYKIApJbmRleDogaW5jbHVkZS9jeWd3aW4vdmVyc2lv
bi5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3Jj
L3NyYy93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaCx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zNzAKZGlmZiAtdSAtcCAtcjEuMzcw
IHZlcnNpb24uaAotLS0gaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCTEwIE1h
eSAyMDEyIDA4OjM1OjIyIC0wMDAwCTEuMzcwCisrKyBpbmNsdWRlL2N5Z3dp
bi92ZXJzaW9uLmgJNiBKdW4gMjAxMiAwMjoyNDowNyAtMDAwMApAQCAtNDMw
LDEyICs0MzAsMTMgQEAgZGV0YWlscy4gKi8KICAgICAgIDI1OTogRXhwb3J0
IHB0aHJlYWRfc2lncXVldWUuCiAgICAgICAyNjA6IEV4cG9ydCBzY2FuZGly
YXQuCiAgICAgICAyNjE6IEV4cG9ydCBtZW1yY2hyLgorICAgICAgMjYyOiBF
eHBvcnQgZ2V0bW50ZW50X3IuCiAgICAgICovCiAKICAgICAgLyogTm90ZSB0
aGF0IHdlIGZvcmdvdCB0byBidW1wIHRoZSBhcGkgZm9yIHVhbGFybSwgc3Ry
dG9sbCwgc3RydG91bGwgKi8KIAogI2RlZmluZSBDWUdXSU5fVkVSU0lPTl9B
UElfTUFKT1IgMAotI2RlZmluZSBDWUdXSU5fVkVSU0lPTl9BUElfTUlOT1Ig
MjYxCisjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUiAyNjIKIAog
ICAgICAvKiBUaGVyZSBpcyBhbHNvIGEgY29tcGF0aWJpdHkgdmVyc2lvbiBu
dW1iZXIgYXNzb2NpYXRlZCB3aXRoIHRoZQogCXNoYXJlZCBtZW1vcnkgcmVn
aW9ucy4gIEl0IGlzIGluY3JlbWVudGVkIHdoZW4gaW5jb21wYXRpYmxlCklu
ZGV4OiByZWxlYXNlLzEuNy4xNgo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzEu
Ny4xNix2CnJldHJpZXZpbmcgcmV2aXNpb24gMS44CmRpZmYgLXUgLXAgLXIx
LjggMS43LjE2Ci0tLSByZWxlYXNlLzEuNy4xNgkzIEp1biAyMDEyIDE2OjQ3
OjU3IC0wMDAwCTEuOAorKysgcmVsZWFzZS8xLjcuMTYJNiBKdW4gMjAxMiAw
MjoyNDowNyAtMDAwMApAQCAtMSw3ICsxLDcgQEAKIFdoYXQncyBuZXc6CiAt
LS0tLS0tLS0tLQogCi0tIE5ldyBBUEk6IG1lbXJjaHIuCistIE5ldyBBUEk6
IGdldG1udGVudF9yLCBtZW1yY2hyLgogCiAtIFN1cHBvcnQgUmVGUy4KIAo=

--------------050509060109020303090601
Content-Type: text/plain; charset=windows-1252;
 name="mntent-test.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mntent-test.c"
Content-length: 1769

I2lmZGVmIENDT0QKI3ByYWdtYSBDQ09EOnNjcmlwdCBubwojZW5kaWYKCiNp
bmNsdWRlIDxtbnRlbnQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgoKI2lmZGVmIF9fQ1lH
V0lOX18KI2luY2x1ZGUgPGRsZmNuLmg+CiNpbmNsdWRlIDxjeWd3aW4vdmVy
c2lvbi5oPgojZW5kaWYKCmludAptYWluKHZvaWQpCnsKI2lmIGRlZmluZWQo
X19DWUdXSU5fXykgJiYgQ1lHV0lOX1ZFUlNJT05fQVBJX01JTk9SIDwgMjYy
CiAgdm9pZCAqbGliYyA9IGRsb3BlbiAoImN5Z3dpbjEuZGxsIiwgMCk7CiAg
c3RydWN0IG1udGVudCAqKCpnZXRtbnRlbnRfcikgKEZJTEUgKiwgc3RydWN0
IG1udGVudCAqLCBjaGFyICosIGludCkKICAgID0gZGxzeW0gKGxpYmMsICJn
ZXRtbnRlbnRfciIpOwojZW5kaWYKCiAgRklMRSAqbXRhYiA9IHNldG1udGVu
dCAoX1BBVEhfTU9VTlRFRCwgInIiKTsKICBpbnQgYnVmbGVuID0gMjU2Owog
IGNoYXIgKmJ1ZiA9IChjaGFyICopIG1hbGxvYyAoYnVmbGVuKTsKICBzdHJ1
Y3QgbW50ZW50IG1udGVudCwgKm1udHJldDsKICBpbnQgaSwgbGVuOwoKICB3
aGlsZSAoKChtbnRyZXQgPSBnZXRtbnRlbnRfciAobXRhYiwgJm1udGVudCwg
YnVmLCBidWZsZW4pKSAhPSBOVUxMKSkKICAgIHsKICAgICAgbGVuID0gMDsK
ICAgICAgZm9yIChpID0gMDsgaSA8IDY7IGkrKykKICAgICAgICBsZW4gKz0g
cHJpbnRmICgiJXMgIiwgYnVmICsgbGVuKTsKICAgICAgcHJpbnRmICgiXG4i
KTsKICAgICAgLyogY2hlY2sgdGhhdCB0aGVzZSBhcmUgaWRlbnRpY2FsIHdp
dGggdGhlIGFib3ZlICovCiAgICAgIHByaW50ZiAoIiVzICVzICVzICVzICVk
ICVkXG4iLCBtbnRlbnQubW50X2ZzbmFtZSwgbW50ZW50Lm1udF9kaXIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtbnRlbnQubW50
X3R5cGUsIG1udGVudC5tbnRfb3B0cywKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1udGVudC5tbnRfZnJlcSwgbW50ZW50Lm1udF9w
YXNzbm8pOwogICAgICAvKiBtbnRyZXQgPT0gJm1udGVudCAqLwogICAgICBw
cmludGYgKCIlcCAlcFxuIiwgJm1udGVudCwgbW50cmV0KTsKICAgIH0KICBt
bnRyZXQgPSBnZXRtbnRlbnRfciAobXRhYiwgJm1udGVudCwgYnVmLCBidWZs
ZW4pOwogIC8qIG1udGVudCBhbmQgYnVmIGFyZSB1bnRvdWNoZWQgd2hlbiBy
ZXR1cm5pbmcgTlVMTCAqLwogIHByaW50ZiAoIiVzICVzICVwXG4iLCBidWYs
IG1udGVudC5tbnRfZnNuYW1lLCBtbnRyZXQpOwoKICByZXR1cm4gMDsKfQo=

--------------050509060109020303090601--
