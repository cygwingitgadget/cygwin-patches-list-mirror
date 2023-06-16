Return-Path: <SRS0=+0A2=CE=gmail.com=philcerf@sourceware.org>
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by sourceware.org (Postfix) with ESMTPS id E1DEF3858D35
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 15:43:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E1DEF3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-54fd6aa3b0dso599470a12.2
        for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686930227; x=1689522227;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7al2QHpCmL1i3AFN7vNY+53njKf712nYKOr1AV8jYYY=;
        b=Iqafr0085zEhWAFTkNAyNNklkCAC4tNLhOY5BRpvPHnYC7qp8XerxiME0Myd+uXiMv
         mFlK64IBpdNmiNrzQ7tD+D125aCrR9EvP42/wXO98UQxcS8hj5C7blSzK5164M1JC/wv
         JshfzPaxIaspqqi4LpT1a1G6DcdCHQPQ+giRFODTXSX09O942IWhG/kjV4Q9jtDium7X
         YQtVoHMqlok9F2dm/gYOic5GWUMYoS5uU5a6H4d37pmy+RQwclwhkG+NljYVXaBk58yk
         gFOGlf6oQSd8Wk0tbKYlBJ5Dv/o86Mj9A1G7AKDc8XCi94l3BLXovXBEFZVq9yxwA4H0
         dFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686930227; x=1689522227;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7al2QHpCmL1i3AFN7vNY+53njKf712nYKOr1AV8jYYY=;
        b=MXMBJXuESxLwd++oEzN0DR5Z1QVLUveaw1WiRmi68WIzsj1pl/Pg1azHUi94MMaTC1
         Ng9/tWBihob0DozL1S42JBlf/fF6Gn6LRR8lELqoVClPus4Pcbgo3kLb0sS5jDJDJxXv
         Dj6iyfK7AivSvprY3CXWSIFxM/9li2sYxMvJlNHrW8fKI/a3/T5mgWvrrH/zp3PQJLZb
         yoJS6xOlDlhD1gTwaVJ+KSlK8dwAQzMCuueuR7+Umzefq0Mo8RE/cMPivSINRVEcC+hn
         5eRSyBP3J4BZUszA7Eoi0WfICprsOJdSzunJWcaQabNShdAvMO8BguTouB6PSn+VeuJ1
         7L8w==
X-Gm-Message-State: AC+VfDylS0N4fClBKw42i9IjK/MIbVUM8g/eN4lVGyxsInt9kh8hKlCK
	78gSZunihj/40VNpmN0UOBLNhWpv9i3yom9+Hc+XPNc8PBg=
X-Google-Smtp-Source: ACHHUZ5p5XTkWMpT4IQ1uRp1BFZM5mC15bbmcGPWLtluZ9j7kiwgXoLgjos5hWh4jL9Z9zt9T8P/hsLmND2dARgVPpM=
X-Received: by 2002:a17:90b:a4f:b0:25e:112c:c5e9 with SMTP id
 gw15-20020a17090b0a4f00b0025e112cc5e9mr1910567pjb.12.1686930226638; Fri, 16
 Jun 2023 08:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca> <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de> <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de> <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
 <ZIx55su+P5zInrqa@calimero.vinschen.de>
In-Reply-To: <ZIx55su+P5zInrqa@calimero.vinschen.de>
From: Philippe Cerfon <philcerf@gmail.com>
Date: Fri, 16 Jun 2023 17:43:35 +0200
Message-ID: <CAN+za=P4Ra6-4Hc6P1HVODT3B5JtrJvV7bFWt-PkOeiawr=4NQ@mail.gmail.com>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
To: cygwin-patches@cygwin.com, Philippe Cerfon <philcerf@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000eb8c3305fe410ca0"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000eb8c3305fe410ca0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey.

On Fri, Jun 16, 2023 at 5:04=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Oh well. Now that I see it in real life, my idea to use the entire
> expression inline wasn't that great, it seems...

^^


> I didn't want to keep MAX_EA_NAME_LEN because now that we have an
> official name for the value, having an unofficial name using a different
> naming convention is a bit weird.
>
> On the other hand, having a macro for the expression certainly looks
> much cleaner.  Also, only one place to change (should a change ever be
> necessary).

Does both make sense.


> Sorry about that.

No worries :-)


> What do you think about something like _XATTR_NAME_MAX_ONDISK_?

Really with trailing/leading underscores? If you try to keep it out of
the "official namespace", then I'd would perhaps make more sense to
mark this as being cygwin specific like CYGWIN_XATTR_NAME_MAX_ONDISK
or so?
Also - may be nitpicking - but storage is not really guaranteed to be
a disk anymore. Maybe ONSTORAGE instead? But admittedly ONDISK sounds
more common ("on disk format", etc.).

> I can also just push the patches and we discuss this further afterwards,
> your call.

Well you know the naming convention used in your code much better than I do=
.

Attached patches use _XATTR_NAME_MAX_ONDISK_ as you proposed.

Just pick whichever name you like best, and either tell me and I
provide a new patch, or just sed 's/_XATTR_NAME_MAX_ONDISK_/foobar/g'
(+ maybe align text wrapping of comments if necessary).


Thanks,
Philippe

--000000000000eb8c3305fe410ca0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_liyqoyy30>
X-Attachment-Id: f_liyqoyy30

RnJvbSA4MmUyZmY2ZjUyZDc0MDEyMTAyNDdhZTM5NmNlM2YxZjExNWQ5M2YwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCAzMCBNYXkgMjAyMyAxMzoxNjoxOCArMDIwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBDeWd3aW46IGV4cG9ydCBYQVRUUl97TkFNRSxTSVpFLExJU1R9X01BWAoKVGhlc2UgYXJlIHVz
ZWQgZm9yIGV4YW1wbGUgYnkgQ1B5dGhvbi4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZv
biA8cGhpbGNlcmZAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBDb3Jpbm5hIFZpbnNjaGVuIDxj
b3Jpbm5hQHZpbnNjaGVuLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vbGlt
aXRzLmggfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oIGIvd2luc3VwL2N5
Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMuaAppbmRleCBhZWZjN2M3YmQuLmVhM2UyODM2YSAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMuaAorKysgYi93
aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oCkBAIC01Niw0ICs1NiwxMSBAQCBk
ZXRhaWxzLiAqLwogI2RlZmluZSBfX1BBVEhfTUFYIDQwOTYKICNkZWZpbmUgX19QSVBFX0JVRiA0
MDk2CiAKKy8qIFhBVFRSX05BTUVfTUFYIGlzIHRoZSBtYXhpbXVtIFhBVFRSIG5hbWUgbGVuZ3Ro
IGV4Y2x1ZGluZyB0aGUgbnVsbAorICogdGVybWluYXRvci4gU2luY2Ugb25seSBYQVRUUnMgaW4g
dGhlIGB1c2VyJyBuYW1lc3BhY2UgYXJlIGFsbG93ZWQgYW5kIHRoZQorICogYHVzZXIuJyBwcmVm
aXggaXMgbm90IHN0b3JlZCwgdGhlIG1heGltdW0gaXMgaW5jcmVhc2VkIGJ5IDUuICovCisjZGVm
aW5lIFhBVFRSX05BTUVfTUFYIDI2MAorI2RlZmluZSBYQVRUUl9TSVpFX01BWCA2NTUzNgorI2Rl
ZmluZSBYQVRUUl9MSVNUX01BWCA2NTUzNgorCiAjZW5kaWYgLyogX0NZR1dJTl9MSU1JVFNfSF9f
ICovCi0tIAoyLjQwLjEKCg==
--000000000000eb8c3305fe410ca0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Disposition: attachment; 
	filename="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_liyqoyyc1>
X-Attachment-Id: f_liyqoyyc1

RnJvbSA0Yzk0ZjgwZmM4MTdiZWUwZTU5ZGEzOTM5NzM5MWNmMjQwOWNmMDI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA2IEp1biAyMDIzIDAyOjUyOjQ5ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IEN5Z3dpbjogdXNlIG5ldyBYQVRUUl97TkFNRSxTSVpFfV9NQVggaW5zdGVhZCBvZgogTUFYX0VB
X3tOQU1FLFZBTFVFfV9MRU4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZvbiA8cGhpbGNl
cmZAZ21haWwuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vbnRlYS5jYyB8IDIwICsrKysrKysrKysr
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL250ZWEuY2MgYi93aW5zdXAvY3lnd2luL250
ZWEuY2MKaW5kZXggYTQwMGZjYjJiLi43MDgxNTY0OWMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3
aW4vbnRlYS5jYworKysgYi93aW5zdXAvY3lnd2luL250ZWEuY2MKQEAgLTE3LDkgKzE3LDExIEBA
IGRldGFpbHMuICovCiAjaW5jbHVkZSAidGxzX3BidWYuaCIKICNpbmNsdWRlIDxzdGRsaWIuaD4K
ICNpbmNsdWRlIDxhdHRyL3hhdHRyLmg+CisjaW5jbHVkZSA8Y3lnd2luL2xpbWl0cy5oPgogCi0j
ZGVmaW5lIE1BWF9FQV9OQU1FX0xFTiAgICAyNTYKLSNkZWZpbmUgTUFYX0VBX1ZBTFVFX0xFTiA2
NTUzNgorLyogT24gc3RvcmFnZSB0aGUgYHVzZXIuYCBwcmVmaXggaXMgbm90IGluY2x1ZGVkIGJ1
dCB0aGUgdGVybWluYXRpbmcgbnVsbCBieXRlCisgICBpcyBuZWVkZWQuKi8KKyNkZWZpbmUgX1hB
VFRSX05BTUVfTUFYX09ORElTS18gKFhBVFRSX05BTUVfTUFYIC0gc3RybGVuKCJ1c2VyLiIpICsg
MSkKIAogLyogQXQgbGVhc3Qgb25lIG1heGltdW0gc2l6ZWQgZW50cnkgZml0cy4KICAgIENWIDIw
MTQtMDQtMDQ6IE50UXVlcnlFYUZpbGUgZnVuY3Rpb24gY2hva2VzIG9uIGJ1ZmZlcnMgYmlnZ2Vy
IHRoYW4gNjRLCkBAIC0yNywxMyArMjksMTMgQEAgZGV0YWlscy4gKi8KIAkJICBvbiBhIHJlbW90
ZSBzaGFyZSwgYXQgbGVhc3Qgb24gV2luZG93cyA3IGFuZCBsYXRlci4KIAkJICBJbiB0aGVvcnkg
dGhlIGJ1ZmZlciBzaG91bGQgaGF2ZSBhIHNpemUgb2YKIAotCQkgICAgc2l6ZW9mIChGSUxFX0ZV
TExfRUFfSU5GT1JNQVRJT04pICsgTUFYX0VBX05BTUVfTEVOCi0JCSAgICArIE1BWF9FQV9WQUxV
RV9MRU4KKwkJICAgIHNpemVvZiAoRklMRV9GVUxMX0VBX0lORk9STUFUSU9OKSArIF9YQVRUUl9O
QU1FX01BWF9PTkRJU0tfCisJCSAgICArIFhBVFRSX1NJWkVfTUFYCiAKIAkJICAoNjU4MDQgYnl0
ZXMpLCBidXQgd2UncmUgb3B0aW5nIGZvciBzaW1wbGljaXR5IGhlcmUsIGFuZAogCQkgIGEgNjRL
IGJ1ZmZlciBoYXMgdGhlIGFkdmFudGFnZSB0aGF0IHdlIGNhbiB1c2UgYSB0bXBfcGF0aGJ1Zgog
CQkgIGJ1ZmZlciwgcmF0aGVyIHRoYW4gaGF2aW5nIHRvIGFsbG9jYSA2NEsgZnJvbSBzdGFjay4g
Ki8KLSNkZWZpbmUgRUFfQlVGU0laIE1BWF9FQV9WQUxVRV9MRU4KKyNkZWZpbmUgRUFfQlVGU0la
IFhBVFRSX1NJWkVfTUFYCiAKICNkZWZpbmUgTkVYVF9GRUEocCkgKChQRklMRV9GVUxMX0VBX0lO
Rk9STUFUSU9OKSAocC0+TmV4dEVudHJ5T2Zmc2V0IFwKIAkJICAgICA/IChjaGFyICopIHAgKyBw
LT5OZXh0RW50cnlPZmZzZXQgOiBOVUxMKSkKQEAgLTU1LDcgKzU3LDcgQEAgcmVhZF9lYSAoSEFO
RExFIGhkbCwgcGF0aF9jb252ICZwYywgY29uc3QgY2hhciAqbmFtZSwgY2hhciAqdmFsdWUsIHNp
emVfdCBzaXplKQogICAgICByZXR1cm5zIHRoZSBsYXN0IEVBIGVudHJ5IG9mIHRoZSBmaWxlIGlu
ZmluaXRlbHkuICBFdmVuIHV0aWxpemluZyB0aGUKICAgICAgb3B0aW9uYWwgRWFJbmRleCBvbmx5
IGhlbHBzIG1hcmdpbmFsbHkuICBJZiB5b3UgdXNlIHRoYXQsIHRoZSBsYXN0CiAgICAgIEVBIGlu
IHRoZSBmaWxlIGlzIHJldHVybmVkIHR3aWNlLiAqLwotICBjaGFyIGxhc3RuYW1lW01BWF9FQV9O
QU1FX0xFTl07CisgIGNoYXIgbGFzdG5hbWVbX1hBVFRSX05BTUVfTUFYX09ORElTS19dOwogCiAg
IF9fdHJ5CiAgICAgewpAQCAtOTUsNyArOTcsNyBAQCByZWFkX2VhIChIQU5ETEUgaGRsLCBwYXRo
X2NvbnYgJnBjLCBjb25zdCBjaGFyICpuYW1lLCBjaGFyICp2YWx1ZSwgc2l6ZV90IHNpemUpCiAJ
ICAgICAgX19sZWF2ZTsKIAkgICAgfQogCi0JICBpZiAoKG5sZW4gPSBzdHJsZW4gKG5hbWUpKSA+
PSBNQVhfRUFfTkFNRV9MRU4pCisJICBpZiAoKG5sZW4gPSBzdHJsZW4gKG5hbWUpKSA+PSBfWEFU
VFJfTkFNRV9NQVhfT05ESVNLXykKIAkgICAgewogCSAgICAgIHNldF9lcnJubyAoRUlOVkFMKTsK
IAkgICAgICBfX2xlYXZlOwpAQCAtMTk3LDcgKzE5OSw3IEBAIHJlYWRfZWEgKEhBTkRMRSBoZGws
IHBhdGhfY29udiAmcGMsIGNvbnN0IGNoYXIgKm5hbWUsIGNoYXIgKnZhbHVlLCBzaXplX3Qgc2l6
ZSkKIAkJICAvKiBGb3IgY29tcGF0aWJpbGl0eSB3aXRoIExpbnV4LCB3ZSBhbHdheXMgcHJlcGVu
ZCAidXNlci4iIHRvCiAJCSAgICAgdGhlIGF0dHJpYnV0ZSBuYW1lLCBzbyBlZmZlY3RpdmVseSB3
ZSBvbmx5IHN1cHBvcnQgdXNlcgogCQkgICAgIGF0dHJpYnV0ZXMgZnJvbSBhIGFwcGxpY2F0aW9u
IHBvaW50IG9mIHZpZXcuICovCi0JCSAgY2hhciB0bXBidWZbTUFYX0VBX05BTUVfTEVOICogMl07
CisJCSAgY2hhciB0bXBidWZbX1hBVFRSX05BTUVfTUFYX09ORElTS18gKiAyXTsKIAkJICBjaGFy
ICp0cCA9IHN0cGNweSAodG1wYnVmLCAidXNlci4iKTsKIAkJICBzdHBjcHkgKHRwLCBmZWEtPkVh
TmFtZSk7CiAJCSAgLyogTlRGUyBzdG9yZXMgYWxsIEVBIG5hbWVzIGluIHVwcGVyY2FzZSB1bmZv
cnR1bmF0ZWx5LiAgVG8KQEAgLTI5Nyw3ICsyOTksNyBAQCB3cml0ZV9lYSAoSEFORExFIGhkbCwg
cGF0aF9jb252ICZwYywgY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqdmFsdWUsCiAgICAg
ICAvKiBTa2lwICJ1c2VyLiIgcHJlZml4LiAqLwogICAgICAgbmFtZSArPSA1OwogCi0gICAgICBp
ZiAoKG5sZW4gPSBzdHJsZW4gKG5hbWUpKSA+PSBNQVhfRUFfTkFNRV9MRU4pCisgICAgICBpZiAo
KG5sZW4gPSBzdHJsZW4gKG5hbWUpKSA+PSBfWEFUVFJfTkFNRV9NQVhfT05ESVNLXykKIAl7CiAJ
ICBzZXRfZXJybm8gKEVJTlZBTCk7CiAJICBfX2xlYXZlOwotLSAKMi40MC4xCgo=
--000000000000eb8c3305fe410ca0--
