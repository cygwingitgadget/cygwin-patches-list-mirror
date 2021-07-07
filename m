Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 219513857C44
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 09:43:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 219513857C44
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo.net
Received: from [192.168.178.51] ([91.65.247.112]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MStKq-1lcDQU2KTe-00UGNm for <cygwin-patches@cygwin.com>; Wed, 07 Jul 2021
 11:43:44 +0200
Subject: [PATCH] Re: propagate font zoom via SIGWINCH
To: cygwin-patches@cygwin.com
References: <9191991e-4c52-43f1-cd9e-6eaac9013f24@towo.net>
 <YORkHm5mUk1jfMtm@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <b0dba327-4e00-f681-fcbf-db0da3890b89@towo.net>
Date: Wed, 7 Jul 2021 11:43:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YORkHm5mUk1jfMtm@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------DD4DA668A337340072F33162"
X-Provags-ID: V03:K1:lFeGkgRxciHN/4qs/qg8SJOeXSUgBWZwZyF1LOTuq0p8zMJYI3t
 1qgh1mctxATjr9+D6EwAV2lZJyWA2UFlSOqswu7xHIPbITH+YxwYsR0tnMseqdvtRPafp6+
 dmKLBnWyjJGDaRMuO2NGXq12RCSwe7sgEYguDfdp63NcT+nnmvXFLT/ST/LR9y/M7r/Va6v
 sAcsXpopXLCiuFqF6Iuug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjgFuciCc0E=:2D8CvE/NlqeXM+nG/+mw+e
 TlAG305QouBlWhi69NU0AGXOUfR2+T0kKHdDe4EWObiY2tmLkpk7usmefqLgQSFdLYT5/mpAp
 28GcAhcvPjhAfmzDoWsNC/VJmxao3YkWKa/4lfpCJ1ZRlXtVDSOCCLO8G7IfIV6xN5GOy+KEt
 ILy/5lOKVfW1rVPN69d/zs/8Ww8Sw5vCwMJlpk/4p8N7SaQhlsPIrKJVg/YKxHWj64l36gIR1
 w8hevmzP1boUhCD+ti8VM8gSesZQfAfu1IZSsUQiZC56jqk+2qhs8SPN1+UZ2GjCHtr/L2Dvw
 vFBAhsD/uVvVdX2eIxA+HpQGJG9JyF1HOR8ukNaSfh+Ef0eKHRo6t/Vy+QgwxoXI91AC1yxSb
 VjMWe7K0IUKtCyK1XDR85dmTHARbyA7CJzpuQ1OiveNugl2azKX2MgRuLzoe4mB6VqX5S1tdV
 DxNSKMeF1/2xYNs1dpWhgm3sS3hIAc25HQTZ+OUJ6ycrRWGURoTd30OEGIop/WvQxQoP5k7E4
 N6H7CwhsTSjq5Vjf/nODK+IgoXfEmIbpRug/zuAbePjdHTTUmRs3vHg6yuST9r5u+1QTsCatz
 /tX5sjhAgdsOR+2O7S/xrANDzBb++ieEH3IWslHOUVqqBBUI8tkDVaQP0uGTKNFrwS9hByPK3
 v4ZoVDHXexy5qc5n5yvNmx4Mh22hW271cZgLc3DlxfGj2kVIimrsG/ZBwUj+YZOmWx1M2ndwU
 89SBpi6Xxq6G8Dby80739Bd+BGKM+gCWteXpduwliv2tE26ekj+b1F9OmRXihiPwM33YGg0OV
 96tDt41JDXLFI8wvJ0Fn96fWu846VlM4I9q3bWTeo7+D7cwCG13Q7zEVT4j8gDGc0Rn0ct9
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 07 Jul 2021 09:43:47 -0000

This is a multi-part message in MIME format.
--------------DD4DA668A337340072F33162
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Update with more elaborate commit comment, hopefully formatted properly.

Am 06.07.2021 um 16:09 schrieb Corinna Vinschen:
> Hi Thomas,
>
> On Jul  3 18:19, Thomas Wolff wrote:
>> xterm 368 and mintty 3.5.1 implement a new feature to support notification
>> of terminal scaling via font zooming also if the terminal text dimensions
>> (rows/columns) stay unchanged, using ioctl(TIOCSWINSZ), raising SIGWINCH.
>> This does not work in cygwin currently. The attached patch fixes that.
>> Thomas
> Can you please put the describing text into the commit message?
>
>
> Thanks,
> Corinna


--------------DD4DA668A337340072F33162
Content-Type: text/plain; charset=UTF-8;
 name="0001-tty-pty-support-TIOCSWINSZ-pixel-size-only-change-no.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-tty-pty-support-TIOCSWINSZ-pixel-size-only-change-no.pa";
 filename*1="tch"

RnJvbSBiOTc5NWVkNmVjMzk3OWY2ODE3M2U1NGQwMWU2ODEyNzFlZWE0YTlhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgV29sZmYgPG1pbmVkQHVzZXJzLm5vcmVw
bHkuZ2l0aHViLmNvbT4KRGF0ZTogU2F0LCAzIEp1bCAyMDIxIDAwOjAwOjAwICswMjAwClN1
YmplY3Q6IFtQQVRDSF0gdHR5L3B0eTogc3VwcG9ydCBUSU9DU1dJTlNaIHBpeGVsLXNpemUt
b25seSBjaGFuZ2UKIG5vdGlmaWNhdGlvbgoKeHRlcm0gMzY4IGFuZCBtaW50dHkgMy41LjEg
aW1wbGVtZW50IGEgbmV3IGZlYXR1cmUgdG8gc3VwcG9ydCAKbm90aWZpY2F0aW9uIG9mIHRl
cm1pbmFsIHNjYWxpbmcgdmlhIGZvbnQgem9vbWluZyBhbHNvIGlmIHRoZSB0ZXJtaW5hbCAK
dGV4dCBkaW1lbnNpb25zIChyb3dzL2NvbHVtbnMpIHN0YXkgdW5jaGFuZ2VkLCB1c2luZyAK
aW9jdGwoVElPQ1NXSU5TWiksIHJhaXNpbmcgU0lHV0lOQ0g7CnRoaXMgcGF0Y2hlcyBjeWd3
aW4gdG8gc3VwcG9ydCB0aGF0IHNjZW5hcmlvCgotLS0KIHdpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfdHR5LmNjIHwgMTAgKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3R0eS5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjCmluZGV4IDFlZDQx
ZDNiMi4uZjJhYzI2ODkyIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0
eS5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYwpAQCAtMTY4Nyw3ICsx
Njg3LDEwIEBAIGZoYW5kbGVyX3B0eV9zbGF2ZTo6aW9jdGwgKHVuc2lnbmVkIGludCBjbWQs
IHZvaWQgKmFyZykKICAgICAgIGJyZWFrOwogICAgIGNhc2UgVElPQ1NXSU5TWjoKICAgICAg
IGlmIChnZXRfdHR5cCAoKS0+d2luc2l6ZS53c19yb3cgIT0gKChzdHJ1Y3Qgd2luc2l6ZSAq
KSBhcmcpLT53c19yb3cKLQkgIHx8IGdldF90dHlwICgpLT53aW5zaXplLndzX2NvbCAhPSAo
KHN0cnVjdCB3aW5zaXplICopIGFyZyktPndzX2NvbCkKKwkgIHx8IGdldF90dHlwICgpLT53
aW5zaXplLndzX2NvbCAhPSAoKHN0cnVjdCB3aW5zaXplICopIGFyZyktPndzX2NvbAorCSAg
fHwgZ2V0X3R0eXAgKCktPndpbnNpemUud3NfeXBpeGVsICE9ICgoc3RydWN0IHdpbnNpemUg
KikgYXJnKS0+d3NfeXBpeGVsCisJICB8fCBnZXRfdHR5cCAoKS0+d2luc2l6ZS53c194cGl4
ZWwgIT0gKChzdHJ1Y3Qgd2luc2l6ZSAqKSBhcmcpLT53c194cGl4ZWwKKwkgKQogCXsKIAkg
IGlmIChnZXRfdHR5cCAoKS0+cGNvbl9hY3RpdmF0ZWQgJiYgZ2V0X3R0eXAgKCktPnBjb25f
cGlkKQogCSAgICByZXNpemVfcHNldWRvX2NvbnNvbGUgKChzdHJ1Y3Qgd2luc2l6ZSAqKSBh
cmcpOwpAQCAtMjI3OSw3ICsyMjgyLDEwIEBAIGZoYW5kbGVyX3B0eV9tYXN0ZXI6OmlvY3Rs
ICh1bnNpZ25lZCBpbnQgY21kLCB2b2lkICphcmcpCiAgICAgICBicmVhazsKICAgICBjYXNl
IFRJT0NTV0lOU1o6CiAgICAgICBpZiAoZ2V0X3R0eXAgKCktPndpbnNpemUud3Nfcm93ICE9
ICgoc3RydWN0IHdpbnNpemUgKikgYXJnKS0+d3Nfcm93Ci0JICB8fCBnZXRfdHR5cCAoKS0+
d2luc2l6ZS53c19jb2wgIT0gKChzdHJ1Y3Qgd2luc2l6ZSAqKSBhcmcpLT53c19jb2wpCisJ
ICB8fCBnZXRfdHR5cCAoKS0+d2luc2l6ZS53c19jb2wgIT0gKChzdHJ1Y3Qgd2luc2l6ZSAq
KSBhcmcpLT53c19jb2wKKwkgIHx8IGdldF90dHlwICgpLT53aW5zaXplLndzX3lwaXhlbCAh
PSAoKHN0cnVjdCB3aW5zaXplICopIGFyZyktPndzX3lwaXhlbAorCSAgfHwgZ2V0X3R0eXAg
KCktPndpbnNpemUud3NfeHBpeGVsICE9ICgoc3RydWN0IHdpbnNpemUgKikgYXJnKS0+d3Nf
eHBpeGVsCisJICkKIAl7CiAJICBpZiAoZ2V0X3R0eXAgKCktPnBjb25fYWN0aXZhdGVkICYm
IGdldF90dHlwICgpLT5wY29uX3BpZCkKIAkgICAgcmVzaXplX3BzZXVkb19jb25zb2xlICgo
c3RydWN0IHdpbnNpemUgKikgYXJnKTsKLS0gCjIuMzIuMAoK
--------------DD4DA668A337340072F33162--
