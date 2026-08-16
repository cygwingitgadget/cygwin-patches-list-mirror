Return-Path: <SRS0=ujlu=GJ=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by sourceware.org (Postfix) with ESMTPS id CDA2B4BA2E18
	for <cygwin-patches@cygwin.com>; Sun, 16 Aug 2026 17:36:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDA2B4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CDA2B4BA2E18
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::634
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1786901780; cv=pass;
	b=KGBXORLfYAUMzh24ygqkiPH2YYBeLjPK+bBREdCq6+O8XLv90JHsOhiwVGQxchAJ6TkkCZzl4B20v4Qy5V+EJjAGlP3qmcmVEEf+9f9nP5zW1aH/0uSXaGvJCxptW+Sf1f/b4MltdAbU3APGA5fSx724/iIHNWaEBDVgYr8r7z8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786901780; c=relaxed/simple;
	bh=iTHGaw9FLOJZEUJ6tmr8hSElaSzsnBvU6yKRuSpnzp4=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=TWdwFL5m5jABMV9FxGYH1vkdLzEqVQ2h+z6AXWbDKrGE8uf771Xcx9wj4fWpMZfGrQEmDyChaRlRCb6O6PBG5+U9I0ERDyQehZlckvnCtO8xEwdTzVoZig+dzS0NL4LHTj3ycGGtqdMh51v7G3vS/YxQtwgHw6Ai0pJ30uGANFE=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5lHmE1y
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDA2B4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5lHmE1y
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so272362466b.1
        for <cygwin-patches@cygwin.com>; Sun, 16 Aug 2026 10:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786901777; cv=none;
        d=google.com; s=arc-20260327;
        b=eG3UakqTLsbV+2jvfeaD3CwbTtuhC/VfyRi88Acm8mn34z3neeOiJVuSiyKPBsZ9Hh
         656+uUqQPp++zDDDFe/BTjFV8Ej4iYlWmMwE7f9MpQLu5H3/Be5Sm5tUY3WgoHXdTRca
         BEeTUf1S7vJ5a5J+ut46fB+dBj+dnPtmzrsmwrN4ySTeUYwprVQF55r59UgrD09dJReu
         bkdvrcoxmaldFjDSyd1RDo3H947DhgCKmuIVNLtzoqcPtoV9hR5K8kXVmzDlrI9viXFz
         8af/vJgeZpinOrsMpc5IYkB5WWhOZo4BxPbv4A8ScyIlzVkWuSK1m5tF9664qENFFVM9
         igXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=kGlJkH0HhZtC8pZsu4GKZe1hKFWjKBiZjkV8NAS8XHg=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=bJr9wpQln41cyb54NMwr3vp43c70HcRnfYo6gG9BBZ6KjvWCSwonwlBCCb5qUTkRWn
         rTsy4u/Zu5jo2VlxvDA2uVrv6bwH1xPGC9m+RLzqVTJt8FrOcBw+pyYwtJ6lAkNT0Lyp
         QsvAtKJCToE6SFGJaXXsnwH+iLXxi6Ln+dKmiQROeyBVCFeUawSy5kpUjSIey1yWxH57
         w0z9doke2Jy4ISgkUbuJIRavuc6p6XgdYNKTsYrTxWJVF7HyrTNu15Nh4WwBIuXufJZh
         ynYjVmR0MoBkW2rVcEM0iZU1ypyQaZgAQvtZGIaX909HJ757O0s6rSO3CvAozsv99nnl
         pPGw==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786901777; x=1787506577; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGlJkH0HhZtC8pZsu4GKZe1hKFWjKBiZjkV8NAS8XHg=;
        b=L5lHmE1ygz/tVPRkQF8Agcs4hots/gM7RwVwuH1t7aOlOIYb96QSrMe17eEpezgbnq
         x+vbmFOiprFBsx9FqhfIBlnJLfBij9wf8gFjeR9aLMZ2nayZ20sKFf+G00QFLNdg0BRt
         Ju6YeCKxEHQ18RZ7YBsyIdSq2p80FQ60yJFtIt/STERbexbcU61IW3myuskIirHv/SEa
         AaZG+x/lILbkrRgdHyWxhOI+/geF1W4H7TufpnXmdNWRD98jM0QY/r7HswZb/uOe3EiO
         qE0vsCF6bAjtp2zb2/ry4OK8oX1h24GgoOQLYTxCAuxqnp1Ifye6R/+666DIHuL+ZRaG
         KJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786901777; x=1787506577;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGlJkH0HhZtC8pZsu4GKZe1hKFWjKBiZjkV8NAS8XHg=;
        b=gb1nDujFY4A78oYDCbMf9Ui4+nZCo+T4naKnTae/LD94TQ9Ej4j71X6xr/g1ckcklO
         0F7cerEUpc9MJna2XyCHhlgtqOcwUiGCVMWCZ26sTjnxGHIiZi6cYjx9j+dyzHklsF49
         uW35FgWS8ePZXC0/+K7+vUZ81Zylqy0nUYMua+dXPnO5AQ85xU9wRkXqCYM4Xew2UHqj
         8o0LNOImf6eZjXpEbrXGbXHD6VEkMCFQmIvJjqNuWArzVi2H69pa6KCGjjD7Nl6q3fVB
         0j2M8oC4XhtJpmeBQANA1JhmKNqpSe7BKekSxO4lTlrTJ0cCm5Z9lCkjSd/9qDcepyHu
         mAog==
X-Gm-Message-State: AOJu0YxnMgl0QXmtaTwI9dMv0PgRCCWV7zx6gISgj24P1vWo+kFHF3ye
	e9KfEAdXF3P8/sbAYYjdEvkKFQT+1E+/ZsUA0yWEVxVr1iQREFOYCXFFyj7GRJazqnvwS8idM2Y
	3IR/v6o5NotRsg2n8fAnfsH8h3rG6UsSkfw==
X-Gm-Gg: AR+sD10YF5Z12Sc6xY2RR0yTtRcGI4F3a0xszVWYu1Mh22gfY21GQOhNeQvI1VnqGRv
	og24YAjDVoe0YuKVSZ4xU14WGywesLYBxCwVOhuzNk07H2lbf24j50WD9mlP5QyLnIE3g4c3lsc
	vhYxebCw9MHa9RG0nC5wMyXHQvNGrZSLOOuxEOh+znO3Sb+BJbywf/ZlA7i0RuXG+lVSLwwaBJY
	8miCOJ7ylU876Y7S13MjwRkII34dnfMeMRxwiLlgjojn/TbaJgq43uJJ01dDtRpXyrzn0qAVsVR
	PIDTj8ScwcigcYQoxu/NRNqMpLap+0XgvTZYNtDXBK/S
X-Received: by 2002:a17:907:1c81:b0:c1c:72b:e65a with SMTP id
 a640c23a62f3a-c212a262b3cmr835539366b.26.1786901777107; Sun, 16 Aug 2026
 10:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
In-Reply-To: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Sun, 16 Aug 2026 19:35:38 +0200
X-Gm-Features: AcwNN1UuKyf5FQtp2PoP7FRt-zBksymzvx6V7vmS4SAAJmR9-kxKllkcg4v5uCA
Message-ID: <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
Subject: [PATCH/RFC] Patch to fix uid/gid lookup for NFSv4 filesystems
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="000000000000ac84e806592d7d81"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000ac84e806592d7d81
Content-Type: text/plain; charset="UTF-8"

Repost with proper [PATCH/RFC] tag.

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

--000000000000ac84e806592d7d81
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
--000000000000ac84e806592d7d81--
