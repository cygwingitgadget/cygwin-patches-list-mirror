Return-Path: <cygwin-patches-return-8824-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81280 invoked by alias); 18 Aug 2017 22:25:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81188 invoked by uid 89); 18 Aug 2017 22:25:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Aug 2017 22:25:07 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v7IMOkWT006097	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 18:24:46 -0400
Received: from [192.168.0.4] (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v7IMOiG3020372	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 18:24:45 -0400
Subject: Re: renameat2
To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu>
Date: Sat, 19 Aug 2017 16:28:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170818151525.GA6314@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------502437F2CAC5C8A0F32A02B7"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00026.txt.bz2

This is a multi-part message in MIME format.
--------------502437F2CAC5C8A0F32A02B7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 4311

Hi Corinna,

On 8/18/2017 11:15 AM, Corinna Vinschen wrote:
> Hi Ken,
> 
> On Aug 18 09:21, Ken Brown wrote:
>> Linux has a system call 'renameat2' which is like renameat but has an
>> extra 'flags' argument.  In particular, one can pass the
>> RENAME_NOREPLACE flag to cause the rename to fail with EEXIST if the
>> target of the rename exists.  See
>>
>>   http://man7.org/linux/man-pages/man2/rename.2.html
>>
>> macOS has a similar functionality, provided by the function
>> 'renameatx_np' with the flag RENAME_EXCL.
>>
>> There's also a recently introduced Gnulib module 'renameat2', but it
>> requires two system calls on Cygwin (one to test existence and the
>> second to do the rename), so that there is a race condition.  On Linux
>> and macOS it uses renameat2 and renameatx_np to avoid the race.
>>
>> The attached patch implements renameat2 on Cygwin (but only supporting
>> the RENAME_NOREPLACE flag).  I've written it so that a rename that
>> just changes case on a case-insensitive file system succeeds.
>>
>> If the patch is accepted, I'll submit a second patch that documents
>> the new function.
> 
> Neat stuff, but there are a few points for discussion, see below.
> 
>> --- a/winsup/cygwin/include/cygwin/fs.h
>> +++ b/winsup/cygwin/include/cygwin/fs.h
>> @@ -19,4 +19,9 @@ details. */
>>   #define BLKPBSZGET   0x0000127b
>>   #define BLKGETSIZE64 0x00041268
>>   
>> +/* Flags for renameat2, from /usr/include/linux/fs.h. */
>> +#define RENAME_NOREPLACE (1 << 0)
>> +#define RENAME_EXCHANGE  (1 << 1)
>> +#define RENAME_WHITEOUT  (1 << 2)
> 
> Given that there's no standard for this call (yet), do we really want to
> expose flag values we don't support?  I would opt for only RENAME_NOREPLACE
> for now and skip the others.
> 
>> +
>>   #endif
>> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
>> index efd4ac017..7640abfad 100644
>> --- a/winsup/cygwin/include/cygwin/version.h
>> +++ b/winsup/cygwin/include/cygwin/version.h
>> @@ -481,12 +481,14 @@ details. */
>>     314: Export explicit_bzero.
>>     315: Export pthread_mutex_timedlock.
>>     316: Export pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock.
>> +  317: Export renameat2.  Add RENAME_NOREPLACE, RENAME_EXCHANGE,
>> +       RENAME_WHITEOUT.
> 
> You can drop the flag values here.  renameat2 is sufficient.
> 
>> +rename2 (const char *oldpath, const char *newpath, unsigned int flags)
>>   {
>>     tmp_pathbuf tp;
>>     int res = -1;
>> @@ -2068,6 +2073,12 @@ rename (const char *oldpath, const char *newpath)
>>   
>>     __try
>>       {
>> +      if (flags & ~RENAME_NOREPLACE)
>> +	/* RENAME_NOREPLACE is the only flag currently supported. */
>> +	{
>> +	  set_errno (ENOTSUP);
> 
> That should ideally be EINVAL.  Unsupported bit values in a flag argument?
> EINVAL, please.
> 
>> +	  __leave;
>> +	}
>>         if (!*oldpath || !*newpath)
>>   	{
>>   	  /* Reject rename("","x"), rename("x","").  */
>> @@ -2337,6 +2348,13 @@ rename (const char *oldpath, const char *newpath)
>>   	  __leave;
>>   	}
>>   
>> +      /* Should we replace an existing file? */
>> +      if ((removepc || dstpc->exists ()) && (flags & RENAME_NOREPLACE))
>> +	{
>> +	  set_errno (EEXIST);
>> +	  __leave;
>> +	}
>> +
> 
> Do we really need this test here?  If you check at this point and then
> go ahead preparing the actual rename operation, you have the atomicity
> problem again which renameat2 is trying to solve.
> 
> But there's light.  NtSetInformationFile(FileRenameInformation) already
> supports RENAME_NOREPLACE :)
> 
> Have a look at line 2494 (prior to your patch):
> 
>      pfri->ReplaceIfExists = TRUE;
> 
> if you replace this with something like
> 
>      pfri->ReplaceIfExists = !(flags & RENAME_NOREPLACE);
> 
> it should give us the atomic behaviour of renameat2 on Linux.
> 
> Another upside is, the status code returned is STATUS_OBJECT_NAME_COLLISION,
> which translates to Win32 error ERROR_ALREADY_EXISTS, which in turn is
> already converted to EEXIST by Cygwin, so there's nothing more to do :)
> 
> What do you think?

Thanks for the improvements!  A revised patch is attached.  As you'll 
see, I still found a few places where I thought I needed to explicitly 
set the errno to EEXIST.  Let me know if any of these could be avoided.

Thanks.

Ken

--------------502437F2CAC5C8A0F32A02B7
Content-Type: text/plain; charset=UTF-8;
 name="0001-cygwin-Implement-renameat2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-cygwin-Implement-renameat2.patch"
Content-length: 11033

RnJvbSBkNTc5OGIzNzFjZWFiZmU2YTc5MTI0NzJlZGQzMmRhMWViZDdkY2I3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVGh1LCAxNyBBdWcgMjAxNyAwOTox
MjoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIGN5Z3dpbjogSW1wbGVtZW50
IHJlbmFtZWF0MgoKRGVmaW5lIHRoZSBSRU5BTUVfTk9SRVBMQUNFIGZsYWcg
aW4gPGN5Z3dpbi9mcy5oPiBhcyBkZWZpbmVkIG9uIExpbnV4CmluIDxsaW51
eC9mcy5oPi4gIFRoZSBvdGhlciBSRU5BTUVfKiBmbGFncyBkZWZpbmVkIG9u
IExpbnV4IGFyZSBub3QKc3VwcG9ydGVkLgotLS0KIG5ld2xpYi9saWJjL2lu
Y2x1ZGUvc3RkaW8uaCAgICAgICAgICAgIHwgIDMgKysKIHdpbnN1cC9jeWd3
aW4vY29tbW9uLmRpbiAgICAgICAgICAgICAgIHwgIDEgKwogd2luc3VwL2N5
Z3dpbi9pbmNsdWRlL2N5Z3dpbi9mcy5oICAgICAgfCAgNiArKysKIHdpbnN1
cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oIHwgIDMgKy0KIHdp
bnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgICAgICAgICAgICAgIHwgNjcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQogNSBmaWxlcyBjaGFu
Z2VkLCA3MyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3RkaW8uaCBiL25ld2xpYi9s
aWJjL2luY2x1ZGUvc3RkaW8uaAppbmRleCA1ZDhjYjEwOTIuLjMzMWExY2Yw
NyAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRpby5oCisr
KyBiL25ld2xpYi9saWJjL2luY2x1ZGUvc3RkaW8uaApAQCAtMzg0LDYgKzM4
NCw5IEBAIGludAlfRVhGVU4odmRwcmludGYsIChpbnQsIGNvbnN0IGNoYXIg
Kl9fcmVzdHJpY3QsIF9fVkFMSVNUKQogI2VuZGlmCiAjaWYgX19BVEZJTEVf
VklTSUJMRQogaW50CV9FWEZVTihyZW5hbWVhdCwgKGludCwgY29uc3QgY2hh
ciAqLCBpbnQsIGNvbnN0IGNoYXIgKikpOworIyBpZmRlZiBfX0NZR1dJTl9f
CitpbnQJX0VYRlVOKHJlbmFtZWF0MiwgKGludCwgY29uc3QgY2hhciAqLCBp
bnQsIGNvbnN0IGNoYXIgKiwgdW5zaWduZWQgaW50KSk7CisjIGVuZGlmCiAj
ZW5kaWYKIAogLyoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY29tbW9u
LmRpbiBiL3dpbnN1cC9jeWd3aW4vY29tbW9uLmRpbgppbmRleCA4ZGE0MzJi
OGEuLmNhNmZmM2NmOSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9jb21t
b24uZGluCisrKyBiL3dpbnN1cC9jeWd3aW4vY29tbW9uLmRpbgpAQCAtMTE2
OCw2ICsxMTY4LDcgQEAgcmVtcXVvZiBOT1NJR0ZFCiByZW1xdW9sIE5PU0lH
RkUKIHJlbmFtZSBTSUdGRQogcmVuYW1lYXQgU0lHRkUKK3JlbmFtZWF0MiBT
SUdGRQogcmVzX2Nsb3NlID0gX19yZXNfY2xvc2UgU0lHRkUKIHJlc19pbml0
ID0gX19yZXNfaW5pdCBTSUdGRQogcmVzX21rcXVlcnkgPSBfX3Jlc19ta3F1
ZXJ5IFNJR0ZFCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUv
Y3lnd2luL2ZzLmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2Zz
LmgKaW5kZXggZjYwNmZmYzM5Li40OGIwY2NhNDUgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vZnMuaAorKysgYi93aW5zdXAv
Y3lnd2luL2luY2x1ZGUvY3lnd2luL2ZzLmgKQEAgLTE5LDQgKzE5LDEwIEBA
IGRldGFpbHMuICovCiAjZGVmaW5lIEJMS1BCU1pHRVQgICAweDAwMDAxMjdi
CiAjZGVmaW5lIEJMS0dFVFNJWkU2NCAweDAwMDQxMjY4CiAKKy8qIEZsYWdz
IGZvciByZW5hbWVhdDIsIGZyb20gL3Vzci9pbmNsdWRlL2xpbnV4L2ZzLmgu
ICBGb3Igbm93IHdlCisgICBzdXBwb3J0IG9ubHkgUkVOQU1FX05PUkVQTEFD
RS4gKi8KKyNkZWZpbmUgUkVOQU1FX05PUkVQTEFDRSAoMSA8PCAwKQorLyog
I2RlZmluZSBSRU5BTUVfRVhDSEFOR0UgICgxIDw8IDEpICovCisvKiAjZGVm
aW5lIFJFTkFNRV9XSElURU9VVCAgKDEgPDwgMikgKi8KKwogI2VuZGlmCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNp
b24uaCBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5o
CmluZGV4IGVmZDRhYzAxNy4uNzY4NmE2ODY1IDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaAorKysgYi93aW5z
dXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaApAQCAtNDgxLDEy
ICs0ODEsMTMgQEAgZGV0YWlscy4gKi8KICAgMzE0OiBFeHBvcnQgZXhwbGlj
aXRfYnplcm8uCiAgIDMxNTogRXhwb3J0IHB0aHJlYWRfbXV0ZXhfdGltZWRs
b2NrLgogICAzMTY6IEV4cG9ydCBwdGhyZWFkX3J3bG9ja190aW1lZHJkbG9j
aywgcHRocmVhZF9yd2xvY2tfdGltZWR3cmxvY2suCisgIDMxNzogRXhwb3J0
IHJlbmFtZWF0Mi4KIAogICBOb3RlIHRoYXQgd2UgZm9yZ290IHRvIGJ1bXAg
dGhlIGFwaSBmb3IgdWFsYXJtLCBzdHJ0b2xsLCBzdHJ0b3VsbCwKICAgc2ln
YWx0c3RhY2ssIHNldGhvc3RuYW1lLiAqLwogCiAjZGVmaW5lIENZR1dJTl9W
RVJTSU9OX0FQSV9NQUpPUiAwCi0jZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQ
SV9NSU5PUiAzMTYKKyNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01JTk9S
IDMxNwogCiAvKiBUaGVyZSBpcyBhbHNvIGEgY29tcGF0aWJpdHkgdmVyc2lv
biBudW1iZXIgYXNzb2NpYXRlZCB3aXRoIHRoZSBzaGFyZWQgbWVtb3J5CiAg
ICByZWdpb25zLiAgSXQgaXMgaW5jcmVtZW50ZWQgd2hlbiBpbmNvbXBhdGli
bGUgY2hhbmdlcyBhcmUgbWFkZSB0byB0aGUgc2hhcmVkCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjIGIvd2luc3VwL2N5Z3dpbi9z
eXNjYWxscy5jYwppbmRleCA4ODU5MzE2MzIuLjI3NThiYjc3NiAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYworKysgYi93aW5zdXAv
Y3lnd2luL3N5c2NhbGxzLmNjCkBAIC02MCw2ICs2MCw3IEBAIGRldGFpbHMu
ICovCiAjaW5jbHVkZSAidGxzX3BidWYuaCIKICNpbmNsdWRlICJzeW5jLmgi
CiAjaW5jbHVkZSAiY2hpbGRfaW5mby5oIgorI2luY2x1ZGUgPGN5Z3dpbi9m
cy5oPiAgLyogbmVlZGVkIGZvciBSRU5BTUVfTk9SRVBMQUNFICovCiAKICN1
bmRlZiBfY2xvc2UKICN1bmRlZiBfbHNlZWsKQEAgLTIwNDgsMTQgKzIwNDks
MTkgQEAgbnRfcGF0aF9oYXNfZXhlY3V0YWJsZV9zdWZmaXggKFBVTklDT0RF
X1NUUklORyB1cGF0aCkKICAgcmV0dXJuIGZhbHNlOwogfQogCi1leHRlcm4g
IkMiIGludAotcmVuYW1lIChjb25zdCBjaGFyICpvbGRwYXRoLCBjb25zdCBj
aGFyICpuZXdwYXRoKQorLyogSWYgbmV3cGF0aCBuYW1lcyBhbiBleGlzdGlu
ZyBmaWxlIGFuZCB0aGUgUkVOQU1FX05PUkVQTEFDRSBmbGFnIGlzCisgICBz
cGVjaWZpZWQsIGZhaWwgd2l0aCBFRVhJU1QuICBFeGNlcHRpb246IERvbid0
IGZhaWwgaWYgdGhlIHB1cnBvc2UKKyAgIG9mIHRoZSByZW5hbWUgaXMganVz
dCB0byBjaGFuZ2UgdGhlIGNhc2Ugb2Ygb2xkcGF0aCBvbiBhCisgICBjYXNl
LWluc2Vuc2l0aXZlIGZpbGUgc3lzdGVtLiAqLworc3RhdGljIGludAorcmVu
YW1lMiAoY29uc3QgY2hhciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0
aCwgdW5zaWduZWQgaW50IGZsYWdzKQogewogICB0bXBfcGF0aGJ1ZiB0cDsK
ICAgaW50IHJlcyA9IC0xOwogICBwYXRoX2NvbnYgb2xkcGMsIG5ld3BjLCBu
ZXcycGMsICpkc3RwYywgKnJlbW92ZXBjID0gTlVMTDsKICAgYm9vbCBvbGRf
ZGlyX3JlcXVlc3RlZCA9IGZhbHNlLCBuZXdfZGlyX3JlcXVlc3RlZCA9IGZh
bHNlOwogICBib29sIG9sZF9leHBsaWNpdF9zdWZmaXggPSBmYWxzZSwgbmV3
X2V4cGxpY2l0X3N1ZmZpeCA9IGZhbHNlOworICBib29sIG5vcmVwbGFjZSA9
IGZsYWdzICYgUkVOQU1FX05PUkVQTEFDRTsKICAgc2l6ZV90IG9sZW4sIG5s
ZW47CiAgIGJvb2wgZXF1YWxfcGF0aDsKICAgTlRTVEFUVVMgc3RhdHVzID0g
U1RBVFVTX1NVQ0NFU1M7CkBAIC0yMDY4LDYgKzIwNzQsMTIgQEAgcmVuYW1l
IChjb25zdCBjaGFyICpvbGRwYXRoLCBjb25zdCBjaGFyICpuZXdwYXRoKQog
CiAgIF9fdHJ5CiAgICAgeworICAgICAgaWYgKGZsYWdzICYgflJFTkFNRV9O
T1JFUExBQ0UpCisJLyogUkVOQU1FX05PUkVQTEFDRSBpcyB0aGUgb25seSBm
bGFnIGN1cnJlbnRseSBzdXBwb3J0ZWQuICovCisJeworCSAgc2V0X2Vycm5v
IChFSU5WQUwpOworCSAgX19sZWF2ZTsKKwl9CiAgICAgICBpZiAoISpvbGRw
YXRoIHx8ICEqbmV3cGF0aCkKIAl7CiAJICAvKiBSZWplY3QgcmVuYW1lKCIi
LCJ4IiksIHJlbmFtZSgieCIsIiIpLiAgKi8KQEAgLTIzMzcsNiArMjM0OSwx
NyBAQCByZW5hbWUgKGNvbnN0IGNoYXIgKm9sZHBhdGgsIGNvbnN0IGNoYXIg
Km5ld3BhdGgpCiAJICBfX2xlYXZlOwogCX0KIAorICAgICAgLyogSWYgYSBy
ZW1vdmVwYyBleGlzdHMgYW5kIFJFTkFNRV9OT1JFUExBQ0UgaGFzIGJlZW4g
c3BlY2lmaWVkLAorCSB0aGVuIHdlIHdhbnQgdG8gZmFpbCB3aXRoIEVFWElT
VC4gIEJ1dCBkc3RwYyBwb2ludHMgdG8gYQorCSBub24tZXhpc3RpbmcgZmls
ZSwgc28gdGhlIHNldHRpbmcgb2YgUmVwbGFjZUlmRXhpc3RzIGJlbG93CisJ
IHdpbGwgbm90IGNhdXNlIHRoZSBmYWlsdXJlLiAgV2UgbXVzdCB0aGVyZWZv
cmUgZG8gaXQKKwkgZXhwbGljaXRseS4gKi8KKyAgICAgIGlmIChyZW1vdmVw
YyAmJiBub3JlcGxhY2UpCisJeworCSAgc2V0X2Vycm5vIChFRVhJU1QpOwor
CSAgX19sZWF2ZTsKKwl9CisKICAgICAgIC8qIE9wZW5pbmcgdGhlIGZpbGUg
bXVzdCBiZSBwYXJ0IG9mIHRoZSB0cmFuc2FjdGlvbi4gIEl0J3Mgbm90IHN1
ZmZpY2llbnQKIAkgdG8gY2FsbCBvbmx5IE50U2V0SW5mb3JtYXRpb25GaWxl
IHVuZGVyIHRoZSB0cmFuc2FjdGlvbi4gIFRoZXJlZm9yZSB3ZQogCSBoYXZl
IHRvIHN0YXJ0IHRoZSB0cmFuc2FjdGlvbiBoZXJlLCBpZiBuZWNlc3Nhcnku
ICovCkBAIC0yNDEwLDYgKzI0MzMsMTEgQEAgcmVuYW1lIChjb25zdCBjaGFy
ICpvbGRwYXRoLCBjb25zdCBjaGFyICpuZXdwYXRoKQogCSB1bmxpbmtfbnQg
cmV0dXJucyB3aXRoIFNUQVRVU19ESVJFQ1RPUllfTk9UX0VNUFRZLiAqLwog
ICAgICAgaWYgKGRzdHBjLT5pc2RpciAoKSkKIAl7CisJICBpZiAobm9yZXBs
YWNlKQorCSAgICB7CisJICAgICAgc2V0X2Vycm5vIChFRVhJU1QpOworCSAg
ICAgIF9fbGVhdmU7CisJICAgIH0KIAkgIHN0YXR1cyA9IHVubGlua19udCAo
KmRzdHBjKTsKIAkgIGlmICghTlRfU1VDQ0VTUyAoc3RhdHVzKSkKIAkgICAg
ewpAQCAtMjQyMyw2ICsyNDUxLDExIEBAIHJlbmFtZSAoY29uc3QgY2hhciAq
b2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0aCkKIAkgZHVlIHRvIGEgbWFu
Z2xlZCBzdWZmaXguICovCiAgICAgICBlbHNlIGlmICghcmVtb3ZlcGMgJiYg
ZHN0cGMtPmhhc19hdHRyaWJ1dGUgKEZJTEVfQVRUUklCVVRFX1JFQURPTkxZ
KSkKIAl7CisJICBpZiAobm9yZXBsYWNlKQorCSAgICB7CisJICAgICAgc2V0
X2Vycm5vIChFRVhJU1QpOworCSAgICAgIF9fbGVhdmU7CisJICAgIH0KIAkg
IHN0YXR1cyA9IE50T3BlbkZpbGUgKCZuZmgsIEZJTEVfV1JJVEVfQVRUUklC
VVRFUywKIAkJCSAgICAgICBkc3RwYy0+Z2V0X29iamVjdF9hdHRyIChhdHRy
LCBzZWNfbm9uZV9uaWgpLAogCQkJICAgICAgICZpbywgRklMRV9TSEFSRV9W
QUxJRF9GTEFHUywKQEAgLTI0OTEsMTEgKzI1MjQsMTUgQEAgcmVuYW1lIChj
b25zdCBjaGFyICpvbGRwYXRoLCBjb25zdCBjaGFyICpuZXdwYXRoKQogCSAg
X19sZWF2ZTsKIAl9CiAgICAgICBwZnJpID0gKFBGSUxFX1JFTkFNRV9JTkZP
Uk1BVElPTikgdHAud19nZXQgKCk7Ci0gICAgICBwZnJpLT5SZXBsYWNlSWZF
eGlzdHMgPSBUUlVFOworICAgICAgcGZyaS0+UmVwbGFjZUlmRXhpc3RzID0g
IW5vcmVwbGFjZTsKICAgICAgIHBmcmktPlJvb3REaXJlY3RvcnkgPSBOVUxM
OwogICAgICAgcGZyaS0+RmlsZU5hbWVMZW5ndGggPSBkc3RwYy0+Z2V0X250
X25hdGl2ZV9wYXRoICgpLT5MZW5ndGg7CiAgICAgICBtZW1jcHkgKCZwZnJp
LT5GaWxlTmFtZSwgIGRzdHBjLT5nZXRfbnRfbmF0aXZlX3BhdGggKCktPkJ1
ZmZlciwKIAkgICAgICBwZnJpLT5GaWxlTmFtZUxlbmd0aCk7CisgICAgICAv
KiBJZiBkc3RwYyBwb2ludHMgdG8gYW4gZXhpc3RpbmcgZmlsZSBhbmQgUkVO
QU1FX05PUkVQTEFDRSBoYXMKKwkgYmVlbiBzcGVjaWZpZWQsIHRoZW4gd2Ug
c2hvdWxkIGdldCBOVCBlcnJvcgorCSBTVEFUVVNfT0JKRUNUX05BTUVfQ09M
TElTSU9OID09PiBXaW4zMiBlcnJvcgorCSBFUlJPUl9BTFJFQURZX0VYSVNU
UyA9PT4gQ3lnd2luIGVycm9yIEVFWElTVC4gKi8KICAgICAgIHN0YXR1cyA9
IE50U2V0SW5mb3JtYXRpb25GaWxlIChmaCwgJmlvLCBwZnJpLAogCQkJCSAg
ICAgc2l6ZW9mICpwZnJpICsgcGZyaS0+RmlsZU5hbWVMZW5ndGgsCiAJCQkJ
ICAgICBGaWxlUmVuYW1lSW5mb3JtYXRpb24pOwpAQCAtMjUwOSw2ICsyNTQ2
LDExIEBAIHJlbmFtZSAoY29uc3QgY2hhciAqb2xkcGF0aCwgY29uc3QgY2hh
ciAqbmV3cGF0aCkKICAgICAgIGlmIChzdGF0dXMgPT0gU1RBVFVTX0FDQ0VT
U19ERU5JRUQgJiYgZHN0cGMtPmV4aXN0cyAoKQogCSAgJiYgIWRzdHBjLT5p
c2RpciAoKSkKIAl7CisJICBpZiAobm9yZW1vdmUpCisJICAgIHsKKwkgICAg
ICBzZXRfZXJybm8gKEVFWElTVCk7CisJICAgICAgX19sZWF2ZTsKKwkgICAg
fQogCSAgYm9vbCBuZWVkX29wZW4gPSBmYWxzZTsKIAogCSAgaWYgKChkc3Rw
Yy0+ZnNfZmxhZ3MgKCkgJiBGSUxFX1NVUFBPUlRTX1RSQU5TQUNUSU9OUykg
JiYgIXRyYW5zKQpAQCAtMjU3OCw2ICsyNjIwLDEyIEBAIHJlbmFtZSAoY29u
c3QgY2hhciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0aCkKICAgcmV0
dXJuIHJlczsKIH0KIAorZXh0ZXJuICJDIiBpbnQKK3JlbmFtZSAoY29uc3Qg
Y2hhciAqb2xkcGF0aCwgY29uc3QgY2hhciAqbmV3cGF0aCkKK3sKKyAgcmV0
dXJuIHJlbmFtZTIgKG9sZHBhdGgsIG5ld3BhdGgsIDApOworfQorCiBleHRl
cm4gIkMiIGludAogc3lzdGVtIChjb25zdCBjaGFyICpjbWRzdHJpbmcpCiB7
CkBAIC00NzE5LDggKzQ3NjcsOCBAQCByZWFkbGlua2F0IChpbnQgZGlyZmQs
IGNvbnN0IGNoYXIgKl9fcmVzdHJpY3QgcGF0aG5hbWUsIGNoYXIgKl9fcmVz
dHJpY3QgYnVmLAogfQogCiBleHRlcm4gIkMiIGludAotcmVuYW1lYXQgKGlu
dCBvbGRkaXJmZCwgY29uc3QgY2hhciAqb2xkcGF0aG5hbWUsCi0JICBpbnQg
bmV3ZGlyZmQsIGNvbnN0IGNoYXIgKm5ld3BhdGhuYW1lKQorcmVuYW1lYXQy
IChpbnQgb2xkZGlyZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAorCSAg
IGludCBuZXdkaXJmZCwgY29uc3QgY2hhciAqbmV3cGF0aG5hbWUsIHVuc2ln
bmVkIGludCBmbGFncykKIHsKICAgdG1wX3BhdGhidWYgdHA7CiAgIF9fdHJ5
CkBAIC00NzMxLDEzICs0Nzc5LDIwIEBAIHJlbmFtZWF0IChpbnQgb2xkZGly
ZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAogICAgICAgY2hhciAqbmV3
cGF0aCA9IHRwLmNfZ2V0ICgpOwogICAgICAgaWYgKGdlbl9mdWxsX3BhdGhf
YXQgKG5ld3BhdGgsIG5ld2RpcmZkLCBuZXdwYXRobmFtZSkpCiAJX19sZWF2
ZTsKLSAgICAgIHJldHVybiByZW5hbWUgKG9sZHBhdGgsIG5ld3BhdGgpOwor
ICAgICAgcmV0dXJuIHJlbmFtZTIgKG9sZHBhdGgsIG5ld3BhdGgsIGZsYWdz
KTsKICAgICB9CiAgIF9fZXhjZXB0IChFRkFVTFQpIHt9CiAgIF9fZW5kdHJ5
CiAgIHJldHVybiAtMTsKIH0KIAorZXh0ZXJuICJDIiBpbnQKK3JlbmFtZWF0
IChpbnQgb2xkZGlyZmQsIGNvbnN0IGNoYXIgKm9sZHBhdGhuYW1lLAorCSAg
aW50IG5ld2RpcmZkLCBjb25zdCBjaGFyICpuZXdwYXRobmFtZSkKK3sKKyAg
cmV0dXJuIHJlbmFtZWF0MiAob2xkZGlyZmQsIG9sZHBhdGhuYW1lLCBuZXdk
aXJmZCwgbmV3cGF0aG5hbWUsIDApOworfQorCiBleHRlcm4gIkMiIGludAog
c2NhbmRpcmF0IChpbnQgZGlyZmQsIGNvbnN0IGNoYXIgKnBhdGhuYW1lLCBz
dHJ1Y3QgZGlyZW50ICoqKm5hbWVsaXN0LAogCSAgIGludCAoKnNlbGVjdCkg
KGNvbnN0IHN0cnVjdCBkaXJlbnQgKiksCi0tIAoyLjE0LjEKCg==

--------------502437F2CAC5C8A0F32A02B7--
