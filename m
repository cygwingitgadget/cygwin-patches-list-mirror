Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta5-sa.btinternet.com
 [213.120.69.11])
 by sourceware.org (Postfix) with ESMTPS id 5C9943861925
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:05:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C9943861925
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20201027160519.EYCI28522.sa-prd-fep-047.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:05:19 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AFBE17F869AB
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeduteefveffueelgeeihffhgfegueejkeeugfeitdehkeelkeetledvvdetveegueenucfkphepkeeirddugedtrdduleegrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddugedtrdduleegrdeijedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE17F869AB for cygwin-patches@cygwin.com;
 Tue, 27 Oct 2020 16:05:19 +0000
Subject: Re: [PATCH 2/3] Remove ccwrap
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
 <20201015143652.56501-3-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <93fc76ff-f213-cfa9-dc29-cf4c1a5cea1c@dronecode.org.uk>
Date: Tue, 27 Oct 2020 16:05:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201015143652.56501-3-jon.turney@dronecode.org.uk>
Content-Type: multipart/mixed; boundary="------------4A8D815BD16A40BC77F3A097"
Content-Language: en-GB
X-Spam-Status: No, score=-1199.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 27 Oct 2020 16:05:31 -0000

This is a multi-part message in MIME format.
--------------4A8D815BD16A40BC77F3A097
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2020 15:36, Jon Turney wrote:
> ---
>   winsup/Makefile.common       |  4 +--
>   winsup/acinclude.m4          | 16 +++++------
>   winsup/c++wrap               |  6 -----
>   winsup/ccwrap                | 51 ------------------------------------
>   winsup/configure.cygwin      | 10 -------
>   winsup/cygserver/Makefile.in |  9 +------
>   winsup/cygwin/Makefile.in    | 13 +++------
>   winsup/cygwin/gentls_offsets |  2 +-
>   winsup/utils/Makefile.in     | 11 +-------
>   9 files changed, 16 insertions(+), 106 deletions(-)
>   delete mode 100755 winsup/c++wrap
>   delete mode 100755 winsup/ccwrap


This breaks running make in a subdirectory, when cross-compiling.

The attached should fix that.


--------------4A8D815BD16A40BC77F3A097
Content-Type: text/plain; charset=UTF-8;
 name="0001-Restore-setting-CC-and-CXX-Makefile-variables.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Restore-setting-CC-and-CXX-Makefile-variables.patch"

RnJvbSAyN2FjNzM3ZGEzMzQ3YjM5MThhNWU0MTQyY2E3YWFiYmNiODQ4ZThkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFR1ZSwgMjcgT2N0IDIwMjAgMTU6MzE6MDYgKzAwMDAKU3ViamVj
dDogW1BBVENIXSBSZXN0b3JlIHNldHRpbmcgQ0MgYW5kIENYWCBNYWtlZmlsZSB2YXJpYWJs
ZXMKCmI1NWUzZjE5IHdhcyBhIGJpdCB0b28gYWdncmVzc2l2ZSBpbiBkcm9wcGluZywgcmF0
aGVyIHRoYW4ganVzdAp1bi1leHBvcnRpbmcgdGhlc2UgTWFrZWZpbGUgdmFyaWFibGVzLiAg
V2UgbmVlZCB0byBzZXQgdGhlc2UgdG8gdGhlCmNvbmZpZ3VyZWQgaG9zdCBjb21waWxlciBp
ZiB3ZSBhcmUgY3Jvc3MtY29tcGlsaW5nLCBvdGhlcndpc2UgdGhleQpkZWZhdWx0IHRvIHRo
ZSBidWlsZCBjb21waWxlci4KCkFsc28gZXhwb3J0IENDIHRvIHRoZSBta3ZlcnMuc2ggc2Ny
aXB0ICh3aGljaCByZXF1aXJlcyBpdCBzaW5jZQo0ZWNhNWU2YSkuICBJdCdzIHVuY2xlYXIg
d2h5IHdlIGNhbid0IGp1c3QgY2F1c2Ugd2luZHJlcyB0byB1c2UgdGhlCmJ1aWxkICdjcHAn
IGFzIHRoZSBwcmUtcHJvY2Vzc29yIHRoZXJlLgotLS0KIHdpbnN1cC9jeWdzZXJ2ZXIvTWFr
ZWZpbGUuaW4gfCAzICsrKwogd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbiAgICB8IDQgKysr
Kwogd2luc3VwL3V0aWxzL01ha2VmaWxlLmluICAgICB8IDMgKysrCiAzIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnc2VydmVyL01h
a2VmaWxlLmluIGIvd2luc3VwL2N5Z3NlcnZlci9NYWtlZmlsZS5pbgppbmRleCA3YjI1MGRk
NjguLjY1YzQwMjUxNyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3NlcnZlci9NYWtlZmlsZS5p
bgorKysgYi93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmluCkBAIC0xMSw2ICsxMSw5IEBA
IHRhcmdldF9idWlsZGRpcjo9QHRhcmdldF9idWlsZGRpckAKIHdpbnN1cF9zcmNkaXI6PUB3
aW5zdXBfc3JjZGlyQAogY29uZmlndXJlX2FyZ3M9QGNvbmZpZ3VyZV9hcmdzQAogCitDQzo9
QENDQAorQ1hYOj1AQ1hYQAorCiBDRkxBR1M6PUBDRkxBR1NACiBvdmVycmlkZSBDWFhGTEFH
Uz1AQ1hYRkxBR1NACiBvdmVycmlkZSBDWFhGTEFHUys9LU1NRCAtV2ltcGxpY2l0LWZhbGx0
aHJvdWdoPTUgLVdlcnJvciAtRF9fT1VUU0lERV9DWUdXSU5fXyAtRFNZU0NPTkZESVI9Ilwi
JChzeXNjb25mZGlyKVwiIgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5p
biBiL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuaW4KaW5kZXggZGFkNTI2Yjc0Li5mNjIzNmQ5
MDkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuaW4KKysrIGIvd2luc3Vw
L2N5Z3dpbi9NYWtlZmlsZS5pbgpAQCAtMTQsNiArMTQsOSBAQCB0YXJnZXRfYnVpbGRkaXI6
PUB0YXJnZXRfYnVpbGRkaXJACiB3aW5zdXBfc3JjZGlyOj1Ad2luc3VwX3NyY2RpckAKIGNv
bmZpZ3VyZV9hcmdzPUBjb25maWd1cmVfYXJnc0AKIAorQ0M6PUBDQ0AKK0NYWDo9QENYWEAK
KwogQ0ZMQUdTPz1AQ0ZMQUdTQAogQ1hYRkxBR1M/PUBDWFhGTEFHU0AKIElOQ0xVREVTPz1A
SU5DTFVERVNACkBAIC03NzMsNiArNzc2LDcgQEAgc3JjX2ZpbGVzIDo9ICQoZm9yZWFjaCBk
aXIsJChWUEFUSCksJChmaW5kX3NyY19maWxlcykpCiAjIHNlY29uZCwgc28gdmVyc2lvbi5j
YyBpcyBhbHdheXMgb2xkZXIgdGhhbiB3aW52ZXIubwogdmVyc2lvbi5jYzogbWt2ZXJzLnNo
IGluY2x1ZGUvY3lnd2luL3ZlcnNpb24uaCB3aW52ZXIucmMgJChzcmNfZmlsZXMpCiAJQGVj
aG8gIk1ha2luZyB2ZXJzaW9uLmNjIGFuZCB3aW52ZXIubyI7XAorCWV4cG9ydCBDQz0iJHtD
Q30iO1wKIAkvYmluL3NoICR7d29yZCAxLCRefSAke3dvcmQgMiwkXn0gJHt3b3JkIDMsJF59
ICQoV0lORFJFUykgJHtDRkxBR1N9IC1JJHtzcmNkaXJ9L2luY2x1ZGUKICQoVkVSU0lPTl9P
RklMRVMpOiB2ZXJzaW9uLmNjCiAKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9NYWtlZmls
ZS5pbiBiL3dpbnN1cC91dGlscy9NYWtlZmlsZS5pbgppbmRleCBhZGQyOWQxMGYuLmUyMTg3
NDAyNyAxMDA2NDQKLS0tIGEvd2luc3VwL3V0aWxzL01ha2VmaWxlLmluCisrKyBiL3dpbnN1
cC91dGlscy9NYWtlZmlsZS5pbgpAQCAtMTEsNiArMTEsOSBAQCB0YXJnZXRfYnVpbGRkaXI6
PUB0YXJnZXRfYnVpbGRkaXJACiB3aW5zdXBfc3JjZGlyOj1Ad2luc3VwX3NyY2RpckAKIGNv
bmZpZ3VyZV9hcmdzPUBjb25maWd1cmVfYXJnc0AKIAorQ0M6PUBDQ0AKK0NYWDo9QENYWEAK
KwogQ0ZMQUdTX0NPTU1PTj0tV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTQgLVdlcnJvcgogQ0ZM
QUdTOj1AQ0ZMQUdTQAogQ1hYRkxBR1M6PUBDWFhGTEFHU0AKLS0gCjIuMjkuMAoK
--------------4A8D815BD16A40BC77F3A097--
