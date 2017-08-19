Return-Path: <cygwin-patches-return-8826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36659 invoked by alias); 19 Aug 2017 14:29:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36631 invoked by uid 89); 19 Aug 2017 14:29:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 14:29:46 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v7JEThm2001110	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 10:29:44 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v7JETgub023026	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 10:29:43 -0400
Subject: Re: renameat2
To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu>
Date: Sat, 19 Aug 2017 17:14:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170819095707.GE6314@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------EFA1146437304222727DAFAA"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------EFA1146437304222727DAFAA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3323

Hi Corinna,

On 8/19/2017 5:57 AM, Corinna Vinschen wrote:
> Hi Ken,
> 
> On Aug 18 18:24, Ken Brown wrote:
> Thanks for the improvements!  A revised patch is attached.  As you'll see, I
>> still found a few places where I thought I needed to explicitly set the
>> errno to EEXIST.  Let me know if any of these could be avoided.
> 
> No, you're right.  Just one thing:
> 
>> @@ -2410,6 +2433,11 @@ rename (const char *oldpath, const char *newpath)
>>   	 unlink_nt returns with STATUS_DIRECTORY_NOT_EMPTY. */
>>         if (dstpc->isdir ())
>>   	{
>> +	  if (noreplace)
>> +	    {
>> +	      set_errno (EEXIST);
>> +	      __leave;
>> +	    }
>>   	  status = unlink_nt (*dstpc);
>>   	  if (!NT_SUCCESS (status))
>>   	    {
>> @@ -2423,6 +2451,11 @@ rename (const char *oldpath, const char *newpath)
>>   	 due to a mangled suffix. */
>>         else if (!removepc && dstpc->has_attribute (FILE_ATTRIBUTE_READONLY))
>>   	{
>> +	  if (noreplace)
>> +	    {
>> +	      set_errno (EEXIST);
>> +	      __leave;
>> +	    }
>>   	  status = NtOpenFile (&nfh, FILE_WRITE_ATTRIBUTES,
>>   			       dstpc->get_object_attr (attr, sec_none_nih),
>>   			       &io, FILE_SHARE_VALID_FLAGS,
> 
> Both of the above cases are just border cases of one and the same
> problem, the destination file already exists.
> 
> In retrospect your original patch was more concise:
> 
> +      /* Should we replace an existing file? */
> +      if ((removepc || dstpc->exists ()) && (flags & RENAME_NOREPLACE))
> +       {
> +         set_errno (EEXIST);
> +         __leave;
> +       }
> 
> The atomicity considerations are not affected by this test anyway, but
> it would avoid starting and stopping a transaction on NTFS for no good
> reason.
> 
> Maybe it's better to revert to this test and drop the other two again?
> 
>> @@ -2491,11 +2524,15 @@ rename (const char *oldpath, const char *newpath)
>>   	  __leave;
>>   	}
>>         pfri = (PFILE_RENAME_INFORMATION) tp.w_get ();
>> -      pfri->ReplaceIfExists = TRUE;
>> +      pfri->ReplaceIfExists = !noreplace;
>>         pfri->RootDirectory = NULL;
>>         pfri->FileNameLength = dstpc->get_nt_native_path ()->Length;
>>         memcpy (&pfri->FileName,  dstpc->get_nt_native_path ()->Buffer,
>>   	      pfri->FileNameLength);
>> +      /* If dstpc points to an existing file and RENAME_NOREPLACE has
>> +	 been specified, then we should get NT error
>> +	 STATUS_OBJECT_NAME_COLLISION ==> Win32 error
>> +	 ERROR_ALREADY_EXISTS ==> Cygwin error EEXIST. */
>>         status = NtSetInformationFile (fh, &io, pfri,
>>   				     sizeof *pfri + pfri->FileNameLength,
>>   				     FileRenameInformation);
>> @@ -2509,6 +2546,11 @@ rename (const char *oldpath, const char *newpath)
>>         if (status == STATUS_ACCESS_DENIED && dstpc->exists ()
>>   	  && !dstpc->isdir ())
>>   	{
>> +	  if (noremove)
>> +	    {
>> +	      set_errno (EEXIST);
>> +	      __leave;
>> +	    }
> 
> Oh, right, that's a good catch.
> 
> The patch is ok as is, just let me know what you think of the above
> minor tweak (and send the revised patch if you agree).

Yes, I agree.  But can't I also drop the third test (where you said 
"good catch") for the same reason?  I've done that in the attached.  If 
I'm wrong and I still need that third test, let me know and I'll put it 
back.

Thanks.

Ken

--------------EFA1146437304222727DAFAA
Content-Type: text/plain; charset=UTF-8;
 name="0001-cygwin-Implement-renameat2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-cygwin-Implement-renameat2.patch"
Content-length: 9321

RnJvbSBiYmZmMTZiNzI3MTcyYTQ1OWE5YTA1MmIwYjk0ODY0MWM4MmQ4MGVi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVGh1LCAxNyBBdWcgMjAxNyAwOTox
MjoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGN5Z3dpbjogSW1wbGVtZW50
IHJlbmFtZWF0MgoKRGVmaW5lIHRoZSBSRU5BTUVfTk9SRVBMQUNFIGZsYWcg
aW4gPGN5Z3dpbi9mcy5oPiBhcyBkZWZpbmVkIG9uIExpbnV4CmluIDxsaW51
eC9mcy5oPi4gIFRoZSBvdGhlciBSRU5BTUVfKiBmbGFncyBkZWZpbmVkIG9u
IExpbnV4IGFyZSBub3QKc3VwcG9ydGVkLgotLS0KIG5ld2xpYi9saWJjL2lu
Y2x1ZGUvc3RkaW8uaCAgICAgICAgICAgIHwgIDMgKysrCiB3aW5zdXAvY3ln
d2luL2NvbW1vbi5kaW4gICAgICAgICAgICAgICB8ICAxICsKIHdpbnN1cC9j
eWd3aW4vaW5jbHVkZS9jeWd3aW4vZnMuaCAgICAgIHwgIDYgKysrKysKIHdp
bnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oIHwgIDMgKyst
CiB3aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjICAgICAgICAgICAgICB8IDQ4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KIDUgZmlsZXMg
Y2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9uZXdsaWIvbGliYy9pbmNsdWRlL3N0ZGlvLmggYi9uZXds
aWIvbGliYy9pbmNsdWRlL3N0ZGlvLmgKaW5kZXggNWQ4Y2IxMDkyLi4zMzFh
MWNmMDcgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3RkaW8u
aAorKysgYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N0ZGlvLmgKQEAgLTM4NCw2
ICszODQsOSBAQCBpbnQJX0VYRlVOKHZkcHJpbnRmLCAoaW50LCBjb25zdCBj
aGFyICpfX3Jlc3RyaWN0LCBfX1ZBTElTVCkKICNlbmRpZgogI2lmIF9fQVRG
SUxFX1ZJU0lCTEUKIGludAlfRVhGVU4ocmVuYW1lYXQsIChpbnQsIGNvbnN0
IGNoYXIgKiwgaW50LCBjb25zdCBjaGFyICopKTsKKyMgaWZkZWYgX19DWUdX
SU5fXworaW50CV9FWEZVTihyZW5hbWVhdDIsIChpbnQsIGNvbnN0IGNoYXIg
KiwgaW50LCBjb25zdCBjaGFyICosIHVuc2lnbmVkIGludCkpOworIyBlbmRp
ZgogI2VuZGlmCiAKIC8qCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2Nv
bW1vbi5kaW4gYi93aW5zdXAvY3lnd2luL2NvbW1vbi5kaW4KaW5kZXggOGRh
NDMyYjhhLi5jYTZmZjNjZjkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
Y29tbW9uLmRpbgorKysgYi93aW5zdXAvY3lnd2luL2NvbW1vbi5kaW4KQEAg
LTExNjgsNiArMTE2OCw3IEBAIHJlbXF1b2YgTk9TSUdGRQogcmVtcXVvbCBO
T1NJR0ZFCiByZW5hbWUgU0lHRkUKIHJlbmFtZWF0IFNJR0ZFCityZW5hbWVh
dDIgU0lHRkUKIHJlc19jbG9zZSA9IF9fcmVzX2Nsb3NlIFNJR0ZFCiByZXNf
aW5pdCA9IF9fcmVzX2luaXQgU0lHRkUKIHJlc19ta3F1ZXJ5ID0gX19yZXNf
bWtxdWVyeSBTSUdGRQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNs
dWRlL2N5Z3dpbi9mcy5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dp
bi9mcy5oCmluZGV4IGY2MDZmZmMzOS4uNDhiMGNjYTQ1IDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2ZzLmgKKysrIGIvd2lu
c3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi9mcy5oCkBAIC0xOSw0ICsxOSwx
MCBAQCBkZXRhaWxzLiAqLwogI2RlZmluZSBCTEtQQlNaR0VUICAgMHgwMDAw
MTI3YgogI2RlZmluZSBCTEtHRVRTSVpFNjQgMHgwMDA0MTI2OAogCisvKiBG
bGFncyBmb3IgcmVuYW1lYXQyLCBmcm9tIC91c3IvaW5jbHVkZS9saW51eC9m
cy5oLiAgRm9yIG5vdyB3ZQorICAgc3VwcG9ydCBvbmx5IFJFTkFNRV9OT1JF
UExBQ0UuICovCisjZGVmaW5lIFJFTkFNRV9OT1JFUExBQ0UgKDEgPDwgMCkK
Ky8qICNkZWZpbmUgUkVOQU1FX0VYQ0hBTkdFICAoMSA8PCAxKSAqLworLyog
I2RlZmluZSBSRU5BTUVfV0hJVEVPVVQgICgxIDw8IDIpICovCisKICNlbmRp
ZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92
ZXJzaW9uLmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNp
b24uaAppbmRleCBlZmQ0YWMwMTcuLjc2ODZhNjg2NSAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKKysrIGIv
d2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKQEAgLTQ4
MSwxMiArNDgxLDEzIEBAIGRldGFpbHMuICovCiAgIDMxNDogRXhwb3J0IGV4
cGxpY2l0X2J6ZXJvLgogICAzMTU6IEV4cG9ydCBwdGhyZWFkX211dGV4X3Rp
bWVkbG9jay4KICAgMzE2OiBFeHBvcnQgcHRocmVhZF9yd2xvY2tfdGltZWRy
ZGxvY2ssIHB0aHJlYWRfcndsb2NrX3RpbWVkd3Jsb2NrLgorICAzMTc6IEV4
cG9ydCByZW5hbWVhdDIuCiAKICAgTm90ZSB0aGF0IHdlIGZvcmdvdCB0byBi
dW1wIHRoZSBhcGkgZm9yIHVhbGFybSwgc3RydG9sbCwgc3RydG91bGwsCiAg
IHNpZ2FsdHN0YWNrLCBzZXRob3N0bmFtZS4gKi8KIAogI2RlZmluZSBDWUdX
SU5fVkVSU0lPTl9BUElfTUFKT1IgMAotI2RlZmluZSBDWUdXSU5fVkVSU0lP
Tl9BUElfTUlOT1IgMzE2CisjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9N
SU5PUiAzMTcKIAogLyogVGhlcmUgaXMgYWxzbyBhIGNvbXBhdGliaXR5IHZl
cnNpb24gbnVtYmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2hhcmVkIG1lbW9y
eQogICAgcmVnaW9ucy4gIEl0IGlzIGluY3JlbWVudGVkIHdoZW4gaW5jb21w
YXRpYmxlIGNoYW5nZXMgYXJlIG1hZGUgdG8gdGhlIHNoYXJlZApkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyBiL3dpbnN1cC9jeWd3
aW4vc3lzY2FsbHMuY2MKaW5kZXggODg1OTMxNjMyLi42MTg3MmZlNTggMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKKysrIGIvd2lu
c3VwL2N5Z3dpbi9zeXNjYWxscy5jYwpAQCAtNjAsNiArNjAsNyBAQCBkZXRh
aWxzLiAqLwogI2luY2x1ZGUgInRsc19wYnVmLmgiCiAjaW5jbHVkZSAic3lu
Yy5oIgogI2luY2x1ZGUgImNoaWxkX2luZm8uaCIKKyNpbmNsdWRlIDxjeWd3
aW4vZnMuaD4gIC8qIG5lZWRlZCBmb3IgUkVOQU1FX05PUkVQTEFDRSAqLwog
CiAjdW5kZWYgX2Nsb3NlCiAjdW5kZWYgX2xzZWVrCkBAIC0yMDQ4LDE0ICsy
MDQ5LDE5IEBAIG50X3BhdGhfaGFzX2V4ZWN1dGFibGVfc3VmZml4IChQVU5J
Q09ERV9TVFJJTkcgdXBhdGgpCiAgIHJldHVybiBmYWxzZTsKIH0KIAotZXh0
ZXJuICJDIiBpbnQKLXJlbmFtZSAoY29uc3QgY2hhciAqb2xkcGF0aCwgY29u
c3QgY2hhciAqbmV3cGF0aCkKKy8qIElmIG5ld3BhdGggbmFtZXMgYW4gZXhp
c3RpbmcgZmlsZSBhbmQgdGhlIFJFTkFNRV9OT1JFUExBQ0UgZmxhZyBpcwor
ICAgc3BlY2lmaWVkLCBmYWlsIHdpdGggRUVYSVNULiAgRXhjZXB0aW9uOiBE
b24ndCBmYWlsIGlmIHRoZSBwdXJwb3NlCisgICBvZiB0aGUgcmVuYW1lIGlz
IGp1c3QgdG8gY2hhbmdlIHRoZSBjYXNlIG9mIG9sZHBhdGggb24gYQorICAg
Y2FzZS1pbnNlbnNpdGl2ZSBmaWxlIHN5c3RlbS4gKi8KK3N0YXRpYyBpbnQK
K3JlbmFtZTIgKGNvbnN0IGNoYXIgKm9sZHBhdGgsIGNvbnN0IGNoYXIgKm5l
d3BhdGgsIHVuc2lnbmVkIGludCBmbGFncykKIHsKICAgdG1wX3BhdGhidWYg
dHA7CiAgIGludCByZXMgPSAtMTsKICAgcGF0aF9jb252IG9sZHBjLCBuZXdw
YywgbmV3MnBjLCAqZHN0cGMsICpyZW1vdmVwYyA9IE5VTEw7CiAgIGJvb2wg
b2xkX2Rpcl9yZXF1ZXN0ZWQgPSBmYWxzZSwgbmV3X2Rpcl9yZXF1ZXN0ZWQg
PSBmYWxzZTsKICAgYm9vbCBvbGRfZXhwbGljaXRfc3VmZml4ID0gZmFsc2Us
IG5ld19leHBsaWNpdF9zdWZmaXggPSBmYWxzZTsKKyAgYm9vbCBub3JlcGxh
Y2UgPSBmbGFncyAmIFJFTkFNRV9OT1JFUExBQ0U7CiAgIHNpemVfdCBvbGVu
LCBubGVuOwogICBib29sIGVxdWFsX3BhdGg7CiAgIE5UU1RBVFVTIHN0YXR1
cyA9IFNUQVRVU19TVUNDRVNTOwpAQCAtMjA2OCw2ICsyMDc0LDEyIEBAIHJl
bmFtZSAoY29uc3QgY2hhciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0
aCkKIAogICBfX3RyeQogICAgIHsKKyAgICAgIGlmIChmbGFncyAmIH5SRU5B
TUVfTk9SRVBMQUNFKQorCS8qIFJFTkFNRV9OT1JFUExBQ0UgaXMgdGhlIG9u
bHkgZmxhZyBjdXJyZW50bHkgc3VwcG9ydGVkLiAqLworCXsKKwkgIHNldF9l
cnJubyAoRUlOVkFMKTsKKwkgIF9fbGVhdmU7CisJfQogICAgICAgaWYgKCEq
b2xkcGF0aCB8fCAhKm5ld3BhdGgpCiAJewogCSAgLyogUmVqZWN0IHJlbmFt
ZSgiIiwieCIpLCByZW5hbWUoIngiLCIiKS4gICovCkBAIC0yMzM3LDYgKzIz
NDksMTMgQEAgcmVuYW1lIChjb25zdCBjaGFyICpvbGRwYXRoLCBjb25zdCBj
aGFyICpuZXdwYXRoKQogCSAgX19sZWF2ZTsKIAl9CiAKKyAgICAgIC8qIFNo
b3VsZCB3ZSByZXBsYWNlIGFuIGV4aXN0aW5nIGZpbGU/ICovCisgICAgICBp
ZiAoKHJlbW92ZXBjIHx8IGRzdHBjLT5leGlzdHMgKCkpICYmIG5vcmVwbGFj
ZSkKKwl7CisJICBzZXRfZXJybm8gKEVFWElTVCk7CisJICBfX2xlYXZlOwor
CX0KKwogICAgICAgLyogT3BlbmluZyB0aGUgZmlsZSBtdXN0IGJlIHBhcnQg
b2YgdGhlIHRyYW5zYWN0aW9uLiAgSXQncyBub3Qgc3VmZmljaWVudAogCSB0
byBjYWxsIG9ubHkgTnRTZXRJbmZvcm1hdGlvbkZpbGUgdW5kZXIgdGhlIHRy
YW5zYWN0aW9uLiAgVGhlcmVmb3JlIHdlCiAJIGhhdmUgdG8gc3RhcnQgdGhl
IHRyYW5zYWN0aW9uIGhlcmUsIGlmIG5lY2Vzc2FyeS4gKi8KQEAgLTI0OTEs
MTEgKzI1MTAsMTUgQEAgcmVuYW1lIChjb25zdCBjaGFyICpvbGRwYXRoLCBj
b25zdCBjaGFyICpuZXdwYXRoKQogCSAgX19sZWF2ZTsKIAl9CiAgICAgICBw
ZnJpID0gKFBGSUxFX1JFTkFNRV9JTkZPUk1BVElPTikgdHAud19nZXQgKCk7
Ci0gICAgICBwZnJpLT5SZXBsYWNlSWZFeGlzdHMgPSBUUlVFOworICAgICAg
cGZyaS0+UmVwbGFjZUlmRXhpc3RzID0gIW5vcmVwbGFjZTsKICAgICAgIHBm
cmktPlJvb3REaXJlY3RvcnkgPSBOVUxMOwogICAgICAgcGZyaS0+RmlsZU5h
bWVMZW5ndGggPSBkc3RwYy0+Z2V0X250X25hdGl2ZV9wYXRoICgpLT5MZW5n
dGg7CiAgICAgICBtZW1jcHkgKCZwZnJpLT5GaWxlTmFtZSwgIGRzdHBjLT5n
ZXRfbnRfbmF0aXZlX3BhdGggKCktPkJ1ZmZlciwKIAkgICAgICBwZnJpLT5G
aWxlTmFtZUxlbmd0aCk7CisgICAgICAvKiBJZiBkc3RwYyBwb2ludHMgdG8g
YW4gZXhpc3RpbmcgZmlsZSBhbmQgUkVOQU1FX05PUkVQTEFDRSBoYXMKKwkg
YmVlbiBzcGVjaWZpZWQsIHRoZW4gd2Ugc2hvdWxkIGdldCBOVCBlcnJvcgor
CSBTVEFUVVNfT0JKRUNUX05BTUVfQ09MTElTSU9OID09PiBXaW4zMiBlcnJv
cgorCSBFUlJPUl9BTFJFQURZX0VYSVNUUyA9PT4gQ3lnd2luIGVycm9yIEVF
WElTVC4gKi8KICAgICAgIHN0YXR1cyA9IE50U2V0SW5mb3JtYXRpb25GaWxl
IChmaCwgJmlvLCBwZnJpLAogCQkJCSAgICAgc2l6ZW9mICpwZnJpICsgcGZy
aS0+RmlsZU5hbWVMZW5ndGgsCiAJCQkJICAgICBGaWxlUmVuYW1lSW5mb3Jt
YXRpb24pOwpAQCAtMjU3OCw2ICsyNjAxLDEyIEBAIHJlbmFtZSAoY29uc3Qg
Y2hhciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0aCkKICAgcmV0dXJu
IHJlczsKIH0KIAorZXh0ZXJuICJDIiBpbnQKK3JlbmFtZSAoY29uc3QgY2hh
ciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0aCkKK3sKKyAgcmV0dXJu
IHJlbmFtZTIgKG9sZHBhdGgsIG5ld3BhdGgsIDApOworfQorCiBleHRlcm4g
IkMiIGludAogc3lzdGVtIChjb25zdCBjaGFyICpjbWRzdHJpbmcpCiB7CkBA
IC00NzE5LDggKzQ3NDgsOCBAQCByZWFkbGlua2F0IChpbnQgZGlyZmQsIGNv
bnN0IGNoYXIgKl9fcmVzdHJpY3QgcGF0aG5hbWUsIGNoYXIgKl9fcmVzdHJp
Y3QgYnVmLAogfQogCiBleHRlcm4gIkMiIGludAotcmVuYW1lYXQgKGludCBv
bGRkaXJmZCwgY29uc3QgY2hhciAqb2xkcGF0aG5hbWUsCi0JICBpbnQgbmV3
ZGlyZmQsIGNvbnN0IGNoYXIgKm5ld3BhdGhuYW1lKQorcmVuYW1lYXQyIChp
bnQgb2xkZGlyZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAorCSAgIGlu
dCBuZXdkaXJmZCwgY29uc3QgY2hhciAqbmV3cGF0aG5hbWUsIHVuc2lnbmVk
IGludCBmbGFncykKIHsKICAgdG1wX3BhdGhidWYgdHA7CiAgIF9fdHJ5CkBA
IC00NzMxLDEzICs0NzYwLDIwIEBAIHJlbmFtZWF0IChpbnQgb2xkZGlyZmQs
IGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAogICAgICAgY2hhciAqbmV3cGF0
aCA9IHRwLmNfZ2V0ICgpOwogICAgICAgaWYgKGdlbl9mdWxsX3BhdGhfYXQg
KG5ld3BhdGgsIG5ld2RpcmZkLCBuZXdwYXRobmFtZSkpCiAJX19sZWF2ZTsK
LSAgICAgIHJldHVybiByZW5hbWUgKG9sZHBhdGgsIG5ld3BhdGgpOworICAg
ICAgcmV0dXJuIHJlbmFtZTIgKG9sZHBhdGgsIG5ld3BhdGgsIGZsYWdzKTsK
ICAgICB9CiAgIF9fZXhjZXB0IChFRkFVTFQpIHt9CiAgIF9fZW5kdHJ5CiAg
IHJldHVybiAtMTsKIH0KIAorZXh0ZXJuICJDIiBpbnQKK3JlbmFtZWF0IChp
bnQgb2xkZGlyZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAorCSAgaW50
IG5ld2RpcmZkLCBjb25zdCBjaGFyICpuZXdwYXRobmFtZSkKK3sKKyAgcmV0
dXJuIHJlbmFtZWF0MiAob2xkZGlyZmQsIG9sZHBhdGhuYW1lLCBuZXdkaXJm
ZCwgbmV3cGF0aG5hbWUsIDApOworfQorCiBleHRlcm4gIkMiIGludAogc2Nh
bmRpcmF0IChpbnQgZGlyZmQsIGNvbnN0IGNoYXIgKnBhdGhuYW1lLCBzdHJ1
Y3QgZGlyZW50ICoqKm5hbWVsaXN0LAogCSAgIGludCAoKnNlbGVjdCkgKGNv
bnN0IHN0cnVjdCBkaXJlbnQgKiksCi0tIAoyLjE0LjEKCg==

--------------EFA1146437304222727DAFAA--
