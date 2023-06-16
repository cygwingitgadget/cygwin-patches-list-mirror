Return-Path: <SRS0=+0A2=CE=gmail.com=philcerf@sourceware.org>
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by sourceware.org (Postfix) with ESMTPS id 39E543858C1F
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 14:09:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39E543858C1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54fcef0204aso592500a12.2
        for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686924559; x=1689516559;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJLgrliepcMkB/KYgm88xjgjcjtSJPRuf7kBFDlvp3s=;
        b=cyuzwTUpS/s8a5HUO8OKO/qu7H+4Q77LRs3k2jADw+rCJjk5FuyBedWqs0P5JmF+cQ
         wcyAFiZhuIcpEadklvTvEY+EpBmX8uiF8ynuLVNF/kNlWuIIaCQX1UAoJMWbBSHsMRKJ
         CTR+8sMJ31ScdSkVEBQy+gMpoAKETtbAhH6WRn6wOwWg7OPIhJrc1QqRtN2R5TYy65wX
         xpq3zWHGops4O66G0HT6yLotQkHXV0LBfwqd4P8N0DPm57L6YZ+iB1Tj2RZFphuqVC+p
         7o63N/UGjML0H5yNdWyGEH/WzQNDgz9aA9wyUUfXV0vZGo0T1UASEJdZ5N+XZFRHyUU+
         NGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924559; x=1689516559;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJLgrliepcMkB/KYgm88xjgjcjtSJPRuf7kBFDlvp3s=;
        b=OJOGT/aQjPY874Nc1U2o8xIkvfPBnwouSYE0g0uI+9qc6IuevLWHgJVYgIrP3YeTVL
         NVA6CYK5D919tmd94MkjquZX+7J7vQNj+aaJ1Nu/lS4Alr6odJ9aUWO8eC2SF+xxofGf
         DMOdlViaNCjaVgMRQNy0ZHn4XJPVX5mkFGe+Drw3SLFZOaHS7FecJpBEK8XmqlPePezc
         gn+4CmNhHcdjl7hb4Hoh/h/mDr46jUdrLqKNdAVDMyO8i9o+qGtTaGbFW6vsWWJiCsIa
         2IO+FqqdDERJBRw73+uM4Rtd0s2jRz0A5RQnWm2GU3UteUMLmf8OkErmdHLZfsO6Zip6
         TUWA==
X-Gm-Message-State: AC+VfDzqXKk0pW/HjJfs6e6RyMbNxzkwul44bDxg1SyL/FRCcrbVjVuc
	AJEI3+4/rb6YGekqOjejA7XEBanQjGauHCBsDU+CCGl7
X-Google-Smtp-Source: ACHHUZ6/27YeY+1YFKnBCdzs0E/1Kwo/SpBL7edsMh+RL8o0LX89tabcCw9dY2vabFFhXc9wrodOhVqLgPBFQrPFv3o=
X-Received: by 2002:a17:90a:f2d2:b0:25e:86ab:f4d7 with SMTP id
 gt18-20020a17090af2d200b0025e86abf4d7mr1757937pjb.22.1686924559299; Fri, 16
 Jun 2023 07:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca> <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de> <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
In-Reply-To: <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
From: Philippe Cerfon <philcerf@gmail.com>
Date: Fri, 16 Jun 2023 16:09:08 +0200
Message-ID: <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="0000000000001ed43b05fe3fbbc0"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000001ed43b05fe3fbbc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Corinna.

On Wed, Jun 7, 2023 at 12:06=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hmm, the comparisons would have to check for XATTR_NAME_MAX anyway,
> so maybe inlining is cleaner in this case.

Please have a look at the updated and attached patches.

Thanks,
Philippe.

--0000000000001ed43b05fe3fbbc0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-export-XATTR_-NAME-SIZE-LIST-_MAX.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_liynb50a0>
X-Attachment-Id: f_liynb50a0

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
--0000000000001ed43b05fe3fbbc0
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Disposition: attachment; 
	filename="0002-Cygwin-use-new-XATTR_-NAME-SIZE-_MAX-instead-of-MAX_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_liynb50j1>
X-Attachment-Id: f_liynb50j1

RnJvbSAzNGEyZTIxMDA4MmRkYmY4N2QyYzk1NjliNmIxNDc3NWE2Y2M1Yjk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXBwZSBDZXJmb24gPHBoaWxjZXJmQGdtYWlsLmNvbT4K
RGF0ZTogVHVlLCA2IEp1biAyMDIzIDAyOjUyOjQ5ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IEN5Z3dpbjogdXNlIG5ldyBYQVRUUl97TkFNRSxTSVpFfV9NQVggaW5zdGVhZCBvZgogTUFYX0VB
X3tOQU1FLFZBTFVFfV9MRU4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIENlcmZvbiA8cGhpbGNl
cmZAZ21haWwuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vbnRlYS5jYyB8IDE5ICsrKysrKysrKy0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbnRlYS5jYyBiL3dpbnN1cC9jeWd3aW4vbnRl
YS5jYwppbmRleCBhNDAwZmNiMmIuLmVmMWZkZjRjYyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dp
bi9udGVhLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbnRlYS5jYwpAQCAtMTcsOSArMTcsNyBAQCBk
ZXRhaWxzLiAqLwogI2luY2x1ZGUgInRsc19wYnVmLmgiCiAjaW5jbHVkZSA8c3RkbGliLmg+CiAj
aW5jbHVkZSA8YXR0ci94YXR0ci5oPgotCi0jZGVmaW5lIE1BWF9FQV9OQU1FX0xFTiAgICAyNTYK
LSNkZWZpbmUgTUFYX0VBX1ZBTFVFX0xFTiA2NTUzNgorI2luY2x1ZGUgPGN5Z3dpbi9saW1pdHMu
aD4KIAogLyogQXQgbGVhc3Qgb25lIG1heGltdW0gc2l6ZWQgZW50cnkgZml0cy4KICAgIENWIDIw
MTQtMDQtMDQ6IE50UXVlcnlFYUZpbGUgZnVuY3Rpb24gY2hva2VzIG9uIGJ1ZmZlcnMgYmlnZ2Vy
IHRoYW4gNjRLCkBAIC0yNywxMyArMjUsMTQgQEAgZGV0YWlscy4gKi8KIAkJICBvbiBhIHJlbW90
ZSBzaGFyZSwgYXQgbGVhc3Qgb24gV2luZG93cyA3IGFuZCBsYXRlci4KIAkJICBJbiB0aGVvcnkg
dGhlIGJ1ZmZlciBzaG91bGQgaGF2ZSBhIHNpemUgb2YKIAotCQkgICAgc2l6ZW9mIChGSUxFX0ZV
TExfRUFfSU5GT1JNQVRJT04pICsgTUFYX0VBX05BTUVfTEVOCi0JCSAgICArIE1BWF9FQV9WQUxV
RV9MRU4KKwkJICAgIHNpemVvZiAoRklMRV9GVUxMX0VBX0lORk9STUFUSU9OKQorCQkgICAgKyAo
WEFUVFJfTkFNRV9NQVggKyAxIC0gc3RybGVuKCJ1c2VyLiIpKQorCQkgICAgKyBYQVRUUl9TSVpF
X01BWAogCiAJCSAgKDY1ODA0IGJ5dGVzKSwgYnV0IHdlJ3JlIG9wdGluZyBmb3Igc2ltcGxpY2l0
eSBoZXJlLCBhbmQKIAkJICBhIDY0SyBidWZmZXIgaGFzIHRoZSBhZHZhbnRhZ2UgdGhhdCB3ZSBj
YW4gdXNlIGEgdG1wX3BhdGhidWYKIAkJICBidWZmZXIsIHJhdGhlciB0aGFuIGhhdmluZyB0byBh
bGxvY2EgNjRLIGZyb20gc3RhY2suICovCi0jZGVmaW5lIEVBX0JVRlNJWiBNQVhfRUFfVkFMVUVf
TEVOCisjZGVmaW5lIEVBX0JVRlNJWiBYQVRUUl9TSVpFX01BWAogCiAjZGVmaW5lIE5FWFRfRkVB
KHApICgoUEZJTEVfRlVMTF9FQV9JTkZPUk1BVElPTikgKHAtPk5leHRFbnRyeU9mZnNldCBcCiAJ
CSAgICAgPyAoY2hhciAqKSBwICsgcC0+TmV4dEVudHJ5T2Zmc2V0IDogTlVMTCkpCkBAIC01NSw3
ICs1NCw3IEBAIHJlYWRfZWEgKEhBTkRMRSBoZGwsIHBhdGhfY29udiAmcGMsIGNvbnN0IGNoYXIg
Km5hbWUsIGNoYXIgKnZhbHVlLCBzaXplX3Qgc2l6ZSkKICAgICAgcmV0dXJucyB0aGUgbGFzdCBF
QSBlbnRyeSBvZiB0aGUgZmlsZSBpbmZpbml0ZWx5LiAgRXZlbiB1dGlsaXppbmcgdGhlCiAgICAg
IG9wdGlvbmFsIEVhSW5kZXggb25seSBoZWxwcyBtYXJnaW5hbGx5LiAgSWYgeW91IHVzZSB0aGF0
LCB0aGUgbGFzdAogICAgICBFQSBpbiB0aGUgZmlsZSBpcyByZXR1cm5lZCB0d2ljZS4gKi8KLSAg
Y2hhciBsYXN0bmFtZVtNQVhfRUFfTkFNRV9MRU5dOworICBjaGFyIGxhc3RuYW1lWyhYQVRUUl9O
QU1FX01BWCArIDEgLSBzdHJsZW4oInVzZXIuIikpXTsKIAogICBfX3RyeQogICAgIHsKQEAgLTk1
LDcgKzk0LDcgQEAgcmVhZF9lYSAoSEFORExFIGhkbCwgcGF0aF9jb252ICZwYywgY29uc3QgY2hh
ciAqbmFtZSwgY2hhciAqdmFsdWUsIHNpemVfdCBzaXplKQogCSAgICAgIF9fbGVhdmU7CiAJICAg
IH0KIAotCSAgaWYgKChubGVuID0gc3RybGVuIChuYW1lKSkgPj0gTUFYX0VBX05BTUVfTEVOKQor
CSAgaWYgKChubGVuID0gc3RybGVuIChuYW1lKSkgPj0gKFhBVFRSX05BTUVfTUFYICsgMSAtIHN0
cmxlbigidXNlci4iKSkpCiAJICAgIHsKIAkgICAgICBzZXRfZXJybm8gKEVJTlZBTCk7CiAJICAg
ICAgX19sZWF2ZTsKQEAgLTE5Nyw3ICsxOTYsNyBAQCByZWFkX2VhIChIQU5ETEUgaGRsLCBwYXRo
X2NvbnYgJnBjLCBjb25zdCBjaGFyICpuYW1lLCBjaGFyICp2YWx1ZSwgc2l6ZV90IHNpemUpCiAJ
CSAgLyogRm9yIGNvbXBhdGliaWxpdHkgd2l0aCBMaW51eCwgd2UgYWx3YXlzIHByZXBlbmQgInVz
ZXIuIiB0bwogCQkgICAgIHRoZSBhdHRyaWJ1dGUgbmFtZSwgc28gZWZmZWN0aXZlbHkgd2Ugb25s
eSBzdXBwb3J0IHVzZXIKIAkJICAgICBhdHRyaWJ1dGVzIGZyb20gYSBhcHBsaWNhdGlvbiBwb2lu
dCBvZiB2aWV3LiAqLwotCQkgIGNoYXIgdG1wYnVmW01BWF9FQV9OQU1FX0xFTiAqIDJdOworCQkg
IGNoYXIgdG1wYnVmWyhYQVRUUl9OQU1FX01BWCArIDEgLSBzdHJsZW4oInVzZXIuIikpICogMl07
CiAJCSAgY2hhciAqdHAgPSBzdHBjcHkgKHRtcGJ1ZiwgInVzZXIuIik7CiAJCSAgc3RwY3B5ICh0
cCwgZmVhLT5FYU5hbWUpOwogCQkgIC8qIE5URlMgc3RvcmVzIGFsbCBFQSBuYW1lcyBpbiB1cHBl
cmNhc2UgdW5mb3J0dW5hdGVseS4gIFRvCkBAIC0yOTcsNyArMjk2LDcgQEAgd3JpdGVfZWEgKEhB
TkRMRSBoZGwsIHBhdGhfY29udiAmcGMsIGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnZh
bHVlLAogICAgICAgLyogU2tpcCAidXNlci4iIHByZWZpeC4gKi8KICAgICAgIG5hbWUgKz0gNTsK
IAotICAgICAgaWYgKChubGVuID0gc3RybGVuIChuYW1lKSkgPj0gTUFYX0VBX05BTUVfTEVOKQor
ICAgICAgaWYgKChubGVuID0gc3RybGVuIChuYW1lKSkgPj0gKFhBVFRSX05BTUVfTUFYICsgMSAt
IHN0cmxlbigidXNlci4iKSkpCiAJewogCSAgc2V0X2Vycm5vIChFSU5WQUwpOwogCSAgX19sZWF2
ZTsKLS0gCjIuNDAuMQoK
--0000000000001ed43b05fe3fbbc0--
