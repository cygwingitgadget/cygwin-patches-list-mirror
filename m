Return-Path: <SRS0=fQ4V=GO=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by sourceware.org (Postfix) with ESMTPS id 5AA814BA543C
	for <cygwin-patches@cygwin.com>; Fri, 21 Aug 2026 15:20:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5AA814BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5AA814BA543C
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::52f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1787325648; cv=pass;
	b=Wi9zUt0dyXhlWyL9xUVWeWDBPm/EifY9OSiqjTZt1KbetcNfOKYp/o6YFlijev2HbUZHSXgj+bVGu07RWSp9xzuTjrFvrE9LGejpe378Nv9ow0hVyvQCyrDX1j4D/Ptt6D68h9vOP24hy4RPaHMJFNny4bolOwLfEE2KsdWcG0g=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787325648; c=relaxed/simple;
	bh=ob+vvOl5vRgoOY1yVN2WFOxcnEPDjZUOeJKaHFnRGyo=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=bsQsnh0oKMn6JrXUQOTtHW2QIIFrzW75TS/UIR6XdplKVEBhWuJNu3CjRV/IltrgJwPxPO4mCxJaiaDPQy6PlJbqx0q+O34GikXmRuv4BzKwHjOjhfMfwJJuDsGE5GjW0j9/nY8fKNOlL4l3kMkiQJVPLPzoSpM5OLFVqyOnpgI=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DzojN+Pm
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5AA814BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DzojN+Pm
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6a17211b9ecso3206301a12.2
        for <cygwin-patches@cygwin.com>; Fri, 21 Aug 2026 08:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787325647; cv=none;
        d=google.com; s=arc-20260327;
        b=b0aTs3aCcgbBwOiCG2UNKm3ssKBQ5tdgceB4yiPLBRV7Pdhu0dQdq9uDl/E9Lcs4S6
         puFSlVZiaBl1JK3fTn7ZVVXIjsGIEj7XUhTTlof2YPUTLP3+riWcCM140ZAuWrKBrTIC
         rhy8ulaf27fNK4NhNujc0W95nCduO9ZHxGkqEEKK9zy10UK+SYGEfeB/RZamKQH/AjHh
         xsrcVEJ4B9x06eq4T9UJUt0ZOqInFMKVi03IOV4Ukiif6u38OIIa9+XPTMGbLU6dGBhJ
         YGYE6tpNME0jdTZyalqJ/JeUFIkp50sPZgeqbtIpOa7VOSVCWBorr7Hnk0TdceCPi+1/
         4hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=sck+mobgSk9IWwq4bRqjqykDIdSggNr5oMxPE+CRki8=;
        fh=LDuCfoqTHLfBJJnUY9ekX7myLl4cc7+1mDvALRdt/Ts=;
        b=ekT/TxAPwsZBalitIrRv8mWs9wwTpE52PzkxKSzREtNeRKQThOvw7tRNuUz4QJqwp2
         gU8FWgvTnc6TDV478iceZmS/xz2mwy059tXcTv52X6knugtIFPAzr5N8wrSCYbkBegiI
         gQrzlTn7AyvqLYWHblUaBnylpKMJI4bKIXSB+jGSixaCnNHFwFuCRBaY7cWuN48rdtT8
         kuddpn5EBJTB1gOyWydAizcgSxrOkqjZWEpgeE9fz4R2BVpSaGfKu4F2ZldWPFLS58sT
         c2wtnDIMevASyrmW0R+Nf90Yt/jE2O51eW4T/LPGca4/jtfYSzIvsV1f3UV9hTA1u9mA
         pnkw==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787325647; x=1787930447; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sck+mobgSk9IWwq4bRqjqykDIdSggNr5oMxPE+CRki8=;
        b=DzojN+Pm5QDfT/QQDw3tjWWJYUS5zB5lfokwffQwXOUCSDjKf+kNc477Qfk/pM6vAH
         g/9o4wWpzqglNdfJjKyF8VBc4jdwAqdiXq8nck4LeDApYbE/HxIX6pEcbmXLlggDvFUW
         pvGpPJ2SGjMlrVzD/Ye8AeP5ycoDbW/I5R0EIcLct/JOrejhEKmUyLxY/jtt8sJgzbJQ
         3BH9cmWTBsXnDqUaLcdItbEEMePVeBS0NDrGGY7cNjgEhXjSkwVg/BCq+BcH3pEKgvUx
         sGwBd6daxYUUNXow4jfOWrOheJa+F1rXE/t4toX6+x+DwOXBdeedcFMw+2j2bTdZFWeb
         50dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325647; x=1787930447;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sck+mobgSk9IWwq4bRqjqykDIdSggNr5oMxPE+CRki8=;
        b=nGQKP5H5OCWpIdEJG+8k02hHCJKzLRIbxA6lU1PxGJvWQFHqhdKByHDyab33KdxruA
         QcgYIkmNbOrKNVki6Qc6GivFghbPLHfuh8ikjx+YNtsHolFnkYuZu+ndnDGmksWaRiDr
         9vXMlJf0fVtuKQK3QaeJrE9b0L6gLFq9aNJUUzJgyOffrpGpu26o++mmvdKxJj7bF4pV
         X4oRDApmu7QPMn6Rp2kWfMJs0+fx4V+LEfajBSTzeA+KFnRVUDddFuIAwJTBeevAheV+
         Se9ek/5SQTn/kbIRRo/m+bROr4kW9uxA9ApiUC2lCTLLfV3bFNOKhEA5IUb9E5jm6x1Q
         ZoiQ==
X-Gm-Message-State: AFuF++l/d0a6FZxABk2EQzGbJ1wnAsPnQthxGlg5GxjBfC8TP5YqwxIZ
	fdZxQGiAmTj7HrbqhCX6Z+6kZ9zXF1My0RWZAJGOswlgZkxFRVXFx+6z5TH4noIco4onInIekIV
	fDH9Yzs4Cw9TpigOGzOSgV4lx3PRdllHdBGOG
X-Gm-Gg: AR+sD12RZyeCqQgiEJ9PvZEI90oPK4vXc8u415nFgzwRcudCZSoDbYql6558H+l+rms
	abetGM0TGwOlAGEXGbvLbycJUhuumBS3KFlcWHhzeXMOlfZIlCBUAxOlNczUGNUqno/U0kPxNzL
	PoM+TLhx4XKwdCZh3hr2AqniFjZlCGTYRy2cDf/NfbLD4/lLD5T/vtVVHC7gXbq6rUkhKZQKrwn
	GL0nR8fsOFCEWManBpus9JBNxGWtdLK6O0ILFRHtj24jHp8blt8sNcb2uyNUqGGKRxB2IRWY9xN
	x7kGdn0lajOAriSeKwKfBrwTUgbhtJz1lJaRfpN4GPMLp7Y9jvV3Nzw=
X-Received: by 2002:a17:907:97c1:b0:c1c:64d4:5ba3 with SMTP id
 a640c23a62f3a-c246a651d39mr725034666b.20.1787325647031; Fri, 21 Aug 2026
 08:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
In-Reply-To: <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Fri, 21 Aug 2026 17:20:10 +0200
X-Gm-Features: AcwNN1UkHJdAY1YMkXG1OutC0cIa0tabGzOqueQYzlkJ9LEn8SgYQpdMPgq552g
Message-ID: <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] Patch to fix uid/gid lookup for NFSv4 filesystems
To: cygwin-patches@cygwin.com, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="0000000000004a6b700659902e28"
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000004a6b700659902e28
Content-Type: text/plain; charset="UTF-8"

On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> wrote:
>
> Repost with proper [PATCH/RFC] tag.
>
> I've attached a patch
> (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
> ms-nfs41-client project) that resolves an issue with uid/gid lookups
> on Windows NFSv4 filesystems.
>
> Currently, Cygwin assumes that all Windows NFS clients operate
> similarly to the Windows NFSv3 client. It expects that account names
> and numeric uid/gid values are identical on both the client and server
> sides, with LDAP acting as the sole authority for these numeric
> values.
>
> However, the NFSv4 protocol fundamentally changes this paradigm. As
> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
> protocol representation in favor of string-based identifiers (e.g.,
> user@domain and group@domain).
>
> To handle this, all NFSv4 clients implement a local "idmapper"
> component that translates these string-based identities from the
> network side into local account data (in the case of Windows, mapping
> user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
> clients manage their own uid/gid translation locally, Cygwin's
> reliance on raw LDAP data fails in these environments and results in
> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> owner/group output in Cygwin ls -l.
>
> The attached patch addresses this by detecting whether the underlying
> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
> performs a direct pass-through of the uid/gid values supplied by the
> NFSv4 client's idmapper.
>
> I have successfully tested this fix against several major clients, including:
> - Exceed NFSv4 client
> - OpenText NFSv4 client
> - ms-nfs41-client
> - ms-nfs42-client
> - Windows NFSv3 client (no change, it continues to use LDAP raw data)
>
> Please let me know if you have any questions or require modifications
> to the patch.

?

Lionel

--0000000000004a6b700659902e28
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
--0000000000004a6b700659902e28--
