Return-Path: <SRS0=2ccK=GE=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by sourceware.org (Postfix) with ESMTPS id 394F14BA79A6
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 21:06:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 394F14BA79A6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 394F14BA79A6
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::530
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1786482370; cv=pass;
	b=X38yDC1sY4eZdQ1WJ8TTaTSed7aN7JdT9hqP2VB8628Vla4yyUc0dg+da5YVb/rm5Dlvw8/vGvYgiF+5rDBx6O8cwoJqls+LFzhHdW6uffyRHHhz8eKJCsItk2JjRetYmR0CPrYm8ZQTlIVjuTAi0z5Jx+YnuA8dcoE1qDYVrpE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786482370; c=relaxed/simple;
	bh=aURvcjjDN7eHWmeXTtfky7hItpojHzG64K66MMTXEbg=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=XHmY6Ewo1aK5CkdujabgVUyPCtdpeq1HXIz17SnbrjzXd+6CUj8Bu7yBEFVas5+BxqgRB1dPEIPSHk++ca3jZD4/LssvkRlTJtCnQk+I8L1c1XFoa0akidvGJMduzZMVFE2FNNSyEzH79ovf4zq76vGblFR0laeoqx/tLg+pj0I=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZJten3KE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 394F14BA79A6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZJten3KE
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6a10b20634fso505794a12.3
        for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 14:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786482369; cv=none;
        d=google.com; s=arc-20260327;
        b=DrsRV3KJePjRoUdDrEaJZnMIIVfgE+1rQcofEhyTVsNgr8/wcakKv+17do81KNeA0z
         +05yVcK60aVZMu5iVK5nJa4WnDrNwaFvp/1B1Ur8wYlMDc2dsOkViVEN3pPOSdlt60tS
         wll3QJivgMp9O2iYdZEWRjQKZThIZFFmZ9mDgxzF2UrjSt89B5yP7kzMpAoqYD/GOZDi
         vLDfpXzPwyJA/sfA93T3iGyZmIv4BCf4/iKO8Ape/DX+2edj1KJyXLctZu9sITD+StXz
         o12hwDo0W3S9iw9gnCkfIFQwK8MPUXO3GM0oY72oY0Pi8KV5FNv2QzkENfsfxEhhgpij
         DMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2VjxSBKiqI+AGrNvxARMAaofMOX1bh5RAy6Hbxcz7MI=;
        fh=TGfz9IGWS1Bu2lRfKs6RyjTeHHTS/YPw7wAB5YPVafk=;
        b=FhESert3FLc554YamCZAWi1SB2ChS1vLLmsfsTkjmgLCCef49++4LKcvxqbSpdnBEx
         GC3jWM5PU/jtxAhgFKgjVW+XppGMTTyETOIhZVQHyoTVYxyLLD2DueCKTneq7rJ5SxnF
         09yYbq5e9FZsuJ0wX9A8ZDrdBbvN5QaRGm4SlvPP/ZE6W2bsE0jmTJyBcm/rIs4vxfde
         8FnLh1BQIqGQdpXiQSetEkLI4QS6oLNM4nT6g+y6PdXAUf1lp3soIkRWs8rDdZ8zt0RH
         +aUM14NIlQZDiXNkBoU6wPu7XOq+qUTMBUq7+3+m1cZCBvbEuFj4LiSoLonH2nT2/lAH
         FJzQ==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786482369; x=1787087169; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2VjxSBKiqI+AGrNvxARMAaofMOX1bh5RAy6Hbxcz7MI=;
        b=ZJten3KE3g6oiUpls+yF9cV6uCK99WlNpTJ9DA9WcPAjrjGXpY9JPSzzQmB+dz4LwM
         5HSjybTjb8md+/6IcIE6JLLmfwEufa3DJfh1Olfz9zZV8KaEMyNri/KtmAhYuSSg7Fmz
         2WXBeIDgwAd4VmqCOTqmCLinAqhue4zpa+H0wYk40YZ2td+O6SKoSxRYvDxjKZ3a0KZr
         GJs3UsbiT79iB5N4j15TEiukkEZ9/qnNsm0H2rxU22yQXc4zfgQjg60oNpvZ7CWNL1yL
         pkToSkCW2M1UVOCG2wSjDBePkq+m5JVgTl0aOXz8VkCQz//RLS1W2TfFdSPRtnW/Ab2y
         UHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786482369; x=1787087169;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2VjxSBKiqI+AGrNvxARMAaofMOX1bh5RAy6Hbxcz7MI=;
        b=fq8rP8w1HsTMLSep0nCzknkgwiEIbcx9egva7u9xecCzb1KcbAE8vreHiIuh0szEio
         wPRNiXAZcmP7ZrAIEyjx/twT9j2YbyBnFdJea2DDabwxXeV04dUgHYzNdWKT2sfZ3zvc
         OiZPomq0S8BtoBF7SM8gTWpolsCpCsOvO2Lon3qgxTlUhsGCXrCPIZMmDNINfigd3N4O
         gmOjACHhcLHW4Jg/RPZ4IErNvT8rUvu9uLLwzbjkFl7VxWzNR4EupGGli9W9Zf75JcCF
         giglkVDD7eSw58IZ/yhZhrBrNhdO/uncO1dMSltu0TT9kvv7d/cxDSv0C4uX0KmZIfjp
         Tb0g==
X-Gm-Message-State: AOJu0YyveKShfKGsqZSc4CWOm+eg2tJ3qVFA43DWuxtMnoQWdMkWcUaC
	N+C5+XqydnKou1NAm8giIzhRkB69nsMz79HfGg9JpDh5dGGt2MwhXZDMmL6c1jcTg95DiG/7EKk
	qBgdcIlihPpderozpixMGtswELMFdIYWzv2ba
X-Gm-Gg: AR+sD11F/YCDmQS/LfPCHjJNVHyBVgQBAd2c7LJqbpn2ga4YsiN983yGEj6ao22BJew
	49KXbVSBYKeVFZllKbjQmI7HoCIGyPyyEShiu+z9QFyfaYEFuhG0xzntPf13MtosYewJpxeVK4r
	Mw0wVkpeB9HN18I0fBrAA8zHS9d8oB3QqmZ8zeTHSKj+gma/3h2aTsAD6s7Ug0ufguUdC/AD2V1
	vZ2jSj0dXaTBFYDR7wFx7KVrOSlPZP1JsGH9We7KjimydYEXiFIm5jeLkkQjgVr8Qss1y5XtfmR
	RA7x52HOaTnIIROQyZjCp0Ayb6U02HlSUs7m57BuKCCZLQ==
X-Received: by 2002:a05:6938:a094:10b0:c20:d4bf:6547 with SMTP id
 a640c23a62f3a-c20f3103d69mr6351166b.32.1786482368660; Tue, 11 Aug 2026
 14:06:08 -0700 (PDT)
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 11 Aug 2026 23:05:31 +0200
X-Gm-Features: AUfX_mzXZEgAkHJChugSPmHI6uT6kw8XyRCwNzQddMwwKCAwHhBkLwLnQ3LYOfs
Message-ID: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
Subject: Patch to fix uid/gid lookup for NFSv4 filesystems
To: cygwin-patches@cygwin.com
Cc: ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="000000000000fb85840658cbd64a"
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000fb85840658cbd64a
Content-Type: text/plain; charset="UTF-8"

I've attached a patch
(cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
ms-nfs41-client project) that resolves an issue with uid/gid lookups
on Windows NFSv4 filesystems.

Currently, Cygwin assumes that all Windows NFS clients operate
similarly to the Windows NFSv3 client. It expects that account names
and numeric uid/gid values are identical on both the client and server
sides, with LDAP acting as the sole authority for these numeric
values.

However, the NFSv4 protocol fundamentally changes this paradigm. As
defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
protocol representation in favor of string-based identifiers (e.g.,
user@domain and group@domain).

To handle this, all NFSv4 clients implement a local "idmapper"
component that translates these string-based identities from the
network side into local account data (in the case of Windows, mapping
user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
clients manage their own uid/gid translation locally, Cygwin's
reliance on raw LDAP data fails in these environments and results in
the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
owner/group output in Cygwin ls -l.

The attached patch addresses this by detecting whether the underlying
filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
performs a direct pass-through of the uid/gid values supplied by the
NFSv4 client's idmapper.

I have successfully tested this fix against several major clients, including:
- Exceed NFSv4 client
- OpenText NFSv4 client
- ms-nfs41-client
- ms-nfs42-client
- Windows NFSv3 client (no change, it continues to use LDAP raw data)

Please let me know if you have any questions or require modifications
to the patch.

Lionel

--000000000000fb85840658cbd64a
Content-Type: text/plain; charset="US-ASCII"; 
	name="cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt"
Content-Disposition: attachment; 
	filename="cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_msp4xq6g0>
X-Attachment-Id: f_msp4xq6g0

IyBQcm90b3R5cGUgZml4IGZvciBDeWd3aW4gRExMIHRvIGhhbmRsZSB1aWRzL2dpZHMgY29ycmVj
dGx5IG9uCiMgTkZTdjQgZmlsZXN5c3RlbXMsIHdoaWNoIHVzdWFsbHkgdXNlIGFuIGlkbWFwcGVy
IHRvIG1hcAojIFdpbjMyIHVzZXImZ3JvdXAgbmFtZXMgdG8gTkZTIHNlcnZlciBhY2NvdW50IG5h
bWVzLgojIFdpdGhvdXQgTERBUCB0aGUgTkZTdjQgaWRtYXBwZXJzIHVzdWFsbHkgdXNlIEN5Z3dp
biBvciBVV0lOIHRvIG9idGFpbiB0aGUKIyB1aWQvZ2lkIGZvciBmaWxlcywgd2hpY2ggYnJlYWtz
IHRoZSBhc3N1bXB0aW9ucyBpbgojIHxmaGFuZGxlcl9iYXNlOjpmc3RhdF9ieV9uZnNfZWEoKXwg
YW5kIGNhdXNlcyBpdCB0byBtYXAgYWxsIHVpZC9naWQgdmFsdWVzCiMgaW50byB0aGUgVW5peF9V
c2VyKzx1aWQ+L1VuaXhfR3JvdXArPGdpZD4gU0lEIHJhbmdlCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyL2Rpc2tfZmlsZS5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGlz
a19maWxlLmNjCmluZGV4IGQ1NGQzNzQ3ZS4uYTI4MGVhOWM2IDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyL2Rpc2tfZmlsZS5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
L2Rpc2tfZmlsZS5jYwpAQCAtMjE0LDcgKzIxNCw3IEBAIGZoYW5kbGVyX2Jhc2U6OmZzdGF0X2J5
X25mc19lYSAoc3RydWN0IHN0YXQgKmJ1ZikKICAgICAgYWNjZXNzIHRocm91Z2ggYW5vdGhlciBo
YW5kbGUgaW52YWxpZGF0ZXMgdGhlIGNhY2hpbmcgd2l0aGluIHRoZQogICAgICBORlMgY2xpZW50
LiAgU2tpcCB0aGlzIGZvciBDeWd3aW4tY3JlYXRlZCBTeW1saW5rcyBwbGF5aW5nIEZJRk9zCiAg
ICAgICh0aGlzIHNldHMgdGhlIGZpbGxlcjEgbWVtYmVyIHRvIE5GM0ZJRk8pLiAqLwotICBpZiAo
Z2V0X2hhbmRsZSAoKSAmJiBuZnNfYXR0ci0+ZmlsbGVyMSAhPSBORjNGSUZPKQorICBpZiAoZ2V0
X2hhbmRsZSAoKSAmJiBwYy5mc19pc19uZnMzKCkgJiYgKG5mc19hdHRyLT5maWxsZXIxICE9IE5G
M0ZJRk8pKQogICAgIHsKICAgICAgIGlmIChnZXRfYWNjZXNzICgpICYgR0VORVJJQ19XUklURSkK
IAlGbHVzaEZpbGVCdWZmZXJzIChnZXRfaGFuZGxlICgpKTsKQEAgLTIzNiwxMSArMjM2LDE1IEBA
IGZoYW5kbGVyX2Jhc2U6OmZzdGF0X2J5X25mc19lYSAoc3RydWN0IHN0YXQgKmJ1ZikKIAl7CiAJ
ICB1aWRfdCBtYXBfdWlkID0gSUxMRUdBTF9VSUQ7CiAKLQkgIGRvbWFpbiA9IGN5Z2hlYXAtPmRv
bS5nZXRfcmZjMjMwN19kb21haW4gKCk7Ci0JICBpZiAoKGxkYXBfb3BlbiA9IChjbGRhcC5vcGVu
IChkb21haW4pID09IE5PX0VSUk9SKSkpCi0JICAgIG1hcF91aWQgPSBjbGRhcC5yZW1hcF91aWQg
KG5mc19hdHRyLT51aWQpOwotCSAgaWYgKG1hcF91aWQgPT0gSUxMRUdBTF9VSUQpCi0JICAgIG1h
cF91aWQgPSBNQVBfVU5JWF9UT19DWUdXSU5fSUQgKG5mc19hdHRyLT51aWQpOworICAgICAgICAg
IGlmIChwYy5mc19pc19uZnM0KCkpCisgICAgICAgICAgICBtYXBfdWlkID0gbmZzX2F0dHItPnVp
ZDsKKyAgICAgICAgICBlbHNlIHsKKwkgICAgZG9tYWluID0gY3lnaGVhcC0+ZG9tLmdldF9yZmMy
MzA3X2RvbWFpbiAoKTsKKwkgICAgaWYgKChsZGFwX29wZW4gPSAoY2xkYXAub3BlbiAoZG9tYWlu
KSA9PSBOT19FUlJPUikpKQorCSAgICAgIG1hcF91aWQgPSBjbGRhcC5yZW1hcF91aWQgKG5mc19h
dHRyLT51aWQpOworCSAgICBpZiAobWFwX3VpZCA9PSBJTExFR0FMX1VJRCkKKwkgICAgICBtYXBf
dWlkID0gTUFQX1VOSVhfVE9fQ1lHV0lOX0lEIChuZnNfYXR0ci0+dWlkKTsKKyAgICAgICAgICB9
CiAJICBjeWdoZWFwLT51Z2lkX2NhY2hlLmFkZF91aWQgKG5mc19hdHRyLT51aWQsIG1hcF91aWQp
OwogCSAgYnVmLT5zdF91aWQgPSBtYXBfdWlkOwogCX0KQEAgLTI1NSwxMSArMjU5LDE1IEBAIGZo
YW5kbGVyX2Jhc2U6OmZzdGF0X2J5X25mc19lYSAoc3RydWN0IHN0YXQgKmJ1ZikKIAl7CiAJICBn
aWRfdCBtYXBfZ2lkID0gSUxMRUdBTF9HSUQ7CiAKLQkgIGRvbWFpbiA9IGN5Z2hlYXAtPmRvbS5n
ZXRfcmZjMjMwN19kb21haW4gKCk7Ci0JICBpZiAoKGxkYXBfb3BlbiB8fCBjbGRhcC5vcGVuIChk
b21haW4pID09IE5PX0VSUk9SKSkKLQkgICAgbWFwX2dpZCA9IGNsZGFwLnJlbWFwX2dpZCAobmZz
X2F0dHItPmdpZCk7Ci0JICBpZiAobWFwX2dpZCA9PSBJTExFR0FMX0dJRCkKLQkgICAgbWFwX2dp
ZCA9IE1BUF9VTklYX1RPX0NZR1dJTl9JRCAobmZzX2F0dHItPmdpZCk7CisgICAgICAgICAgaWYg
KHBjLmZzX2lzX25mczQoKSkKKyAgICAgICAgICAgIG1hcF9naWQgPSBuZnNfYXR0ci0+Z2lkOwor
ICAgICAgICAgIGVsc2UgeworCSAgICBkb21haW4gPSBjeWdoZWFwLT5kb20uZ2V0X3JmYzIzMDdf
ZG9tYWluICgpOworCSAgICBpZiAoKGxkYXBfb3BlbiB8fCBjbGRhcC5vcGVuIChkb21haW4pID09
IE5PX0VSUk9SKSkKKwkgICAgICBtYXBfZ2lkID0gY2xkYXAucmVtYXBfZ2lkIChuZnNfYXR0ci0+
Z2lkKTsKKwkgICAgaWYgKG1hcF9naWQgPT0gSUxMRUdBTF9HSUQpCisJICAgICAgbWFwX2dpZCA9
IE1BUF9VTklYX1RPX0NZR1dJTl9JRCAobmZzX2F0dHItPmdpZCk7CisgICAgICAgICAgfQogCSAg
Y3lnaGVhcC0+dWdpZF9jYWNoZS5hZGRfZ2lkIChuZnNfYXR0ci0+Z2lkLCBtYXBfZ2lkKTsKIAkg
IGJ1Zi0+c3RfZ2lkID0gbWFwX2dpZDsKIAl9CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL3BhdGguaCBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcGF0aC5o
CmluZGV4IGFkMTQyZGRkMy4uYjg1NTBjMDVjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL3BhdGguaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3Bh
dGguaApAQCAtNDIzLDYgKzQyMyw4IEBAIGNsYXNzIHBhdGhfY29udgogICBib29sIGZzX2lzX3Jl
ZnMgKCkgY29uc3Qge3JldHVybiBmcy5pc19yZWZzICgpO30KICAgYm9vbCBmc19pc19zYW1iYSAo
KSBjb25zdCB7cmV0dXJuIGZzLmlzX3NhbWJhICgpO30KICAgYm9vbCBmc19pc19uZnMgKCkgY29u
c3Qge3JldHVybiBmcy5pc19uZnMgKCk7fQorICBib29sIGZzX2lzX25mczMgKCkgY29uc3Qge3Jl
dHVybiBmcy5pc19uZnMgKCkgJiYgIWZzLmhhc19hY2xzICgpO30KKyAgYm9vbCBmc19pc19uZnM0
ICgpIGNvbnN0IHtyZXR1cm4gZnMuaXNfbmZzICgpICYmIGZzLmhhc19hY2xzICgpO30KICAgYm9v
bCBmc19pc19uZXRhcHAgKCkgY29uc3Qge3JldHVybiBmcy5pc19uZXRhcHAgKCk7fQogICBib29s
IGZzX2lzX2Nkcm9tICgpIGNvbnN0IHtyZXR1cm4gZnMuaXNfY2Ryb20gKCk7fQogICBib29sIGZz
X2lzX212ZnMgKCkgY29uc3Qge3JldHVybiBmcy5pc19tdmZzICgpO30K
--000000000000fb85840658cbd64a--
