Return-Path: <cygwin-patches-return-8887-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107168 invoked by alias); 25 Oct 2017 14:56:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107137 invoked by uid 89); 25 Oct 2017 14:56:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Oct 2017 14:56:42 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v9PEucLH003229	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 10:56:38 -0400
Received: from [10.13.22.3] (65-112-130-194.dia.static.qwest.net [65.112.130.194])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v9PEubKs020886	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Wed, 25 Oct 2017 10:56:38 -0400
Subject: Re: [PATCH] cygcheck: Fix parsing of file names containing colons
To: cygwin-patches@cygwin.com
References: <20171025112316.13004-1-kbrown@cornell.edu> <20171025121138.GF22429@calimero.vinschen.de> <20171025121912.GG22429@calimero.vinschen.de> <b995c1b4-81cc-8d6b-91da-a44018393499@cornell.edu> <20171025141940.GH22429@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <c6e21bcd-b058-1c74-6732-a62ab0b7530f@cornell.edu>
Date: Wed, 25 Oct 2017 14:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171025141940.GH22429@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------DB53A57A543F78856412DFBD"
X-PMX-Cornell-Gauge: Gauge=X
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------DB53A57A543F78856412DFBD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2501

On 10/25/2017 10:19 AM, Corinna Vinschen wrote:
> On Oct 25 09:38, Ken Brown wrote:
>> On 10/25/2017 8:19 AM, Corinna Vinschen wrote:
>>> On Oct 25 14:11, Corinna Vinschen wrote:
>>>> Hi Ken,
>>>>
>>>> On Oct 25 07:23, Ken Brown wrote:
>>>>> Up to now the function winsup/utils/dump_setup.cc:base skips past
>>>>> colons when parsing file names.  As a result, a line like
>>>>>
>>>>>     foo foo-1:2.3-4.tar.bz2 1
>>>>>
>>>>> in /etc/setup/installed.db would cause 'cygcheck -cd foo' to report 4
>>>>> as the installed version of foo insted of 1:2.3-4.  This is not an
>>>>> issue now, but it will become an issue when version numbers are
>>>>> allowed to contain epochs.
>>>>> ---
>>>>>    winsup/utils/dump_setup.cc | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
>>>>> index 320d69fab..3922b18f8 100644
>>>>> --- a/winsup/utils/dump_setup.cc
>>>>> +++ b/winsup/utils/dump_setup.cc
>>>>> @@ -56,7 +56,7 @@ base (const char *s)
>>>>>      const char *rv = s;
>>>>>      while (*s)
>>>>>        {
>>>>> -      if ((*s == '/' || *s == ':' || *s == '\\') && s[1])
>>>>> +      if ((*s == '/' || *s == '\\') && s[1])
>>>>
>>>> I think this is a simplified way to test for the colon in paths like
>>>> C:/foo/bar.  Nothing else makes sense in this context.
>>>>
>>>> I'm not sure how much we care, but maybe we shoulkd fix the test to
>>>> ignore the colon only if it's the second character in the incoming
>>>> string?
>>>
>>> Not "ignore", but "use as a delimiter" only as 2nd char in the input.
>>
>> I'm not sure the distinction matters in this case, since the function is
>> just trying to get the base name.  Anyway, how's the attached?
> 
> Fine, thanks.
> 
> But now that you mention it... why does parse_filename() call base() at
> all?  The filenames in installed.db are just basenames anyway.  Does
> that cover an older DB format we don't support anymore, perhaps?

It looks like parse_filename is more-or-less copied from the function 
with the same name in the setup sources (in filemanip.cc).  In that case 
there might be a good reason to call base; I'll have to look more closely.

> I just wonder now if we should simply remove base() and the call to it.
> 
> Either way, you're right, the colon check is just useless, so your first
> patch was entirely sufficient.
> 
> What do you think?  Stick to your patch or remove base()?

I vote for removing base.  The attached patch does this.

Ken

--------------DB53A57A543F78856412DFBD
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup-utils-dump_setup.cc-Remove-the-function-base.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-winsup-utils-dump_setup.cc-Remove-the-function-base.pat";
 filename*1="ch"
Content-length: 1818

RnJvbSBmNjc5NDYyOTM3ZmFmMjYzZGU2ODJjNDdmOGQ4ZTczYjBjN2U0MTM2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogVHVlLCAyNCBPY3QgMjAxNyAxODoy
MTo1MyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hdIHdpbnN1cC91dGlscy9kdW1w
X3NldHVwLmNjOiBSZW1vdmUgdGhlIGZ1bmN0aW9uICdiYXNlJwoKVGhpcyB3
YXMgY2FsbGVkIG9ubHkgb24gZmlsZW5hbWVzIGluIC9ldGMvc2V0dXAvaW5z
dGFsbGVkLmRiLCB3aGljaAphcmUgYWxsIGJhc2VuYW1lcyBhbnl3YXkuICBN
b3Jlb3ZlciwgYmFzZSB3YXNuJ3QgY29ycmVjdGx5IGhhbmRsaW5nCmZpbGVu
YW1lcyBjb250YWluaW5nIGNvbG9ucy4KLS0tCiB3aW5zdXAvdXRpbHMvZHVt
cF9zZXR1cC5jYyB8IDE3ICstLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3dpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjIGIvd2luc3VwL3V0
aWxzL2R1bXBfc2V0dXAuY2MKaW5kZXggMzIwZDY5ZmFiLi40NDE1OTU0Zjkg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjCisrKyBi
L3dpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjCkBAIC00OCwyMSArNDgsNiBA
QCBmaW5kX3Rhcl9leHQgKGNvbnN0IGNoYXIgKnBhdGgpCiAgICAgcmV0dXJu
IDA7CiB9CiAKLXN0YXRpYyBjaGFyICoKLWJhc2UgKGNvbnN0IGNoYXIgKnMp
Ci17Ci0gIGlmICghcykKLSAgICByZXR1cm4gMDsKLSAgY29uc3QgY2hhciAq
cnYgPSBzOwotICB3aGlsZSAoKnMpCi0gICAgewotICAgICAgaWYgKCgqcyA9
PSAnLycgfHwgKnMgPT0gJzonIHx8ICpzID09ICdcXCcpICYmIHNbMV0pCi0J
cnYgPSBzICsgMTsKLSAgICAgIHMrKzsKLSAgICB9Ci0gIHJldHVybiAoY2hh
ciAqKSBydjsKLX0KLQogLyogUGFyc2UgYSBmaWxlbmFtZSBpbnRvIHBhY2th
Z2UsIHZlcnNpb24sIGFuZCBleHRlbnNpb24gY29tcG9uZW50cy4gKi8KIGlu
dAogcGFyc2VfZmlsZW5hbWUgKGNvbnN0IGNoYXIgKmluX2ZuLCBmaWxlcGFy
c2UmIGYpCkBAIC03OSw3ICs2NCw3IEBAIHBhcnNlX2ZpbGVuYW1lIChjb25z
dCBjaGFyICppbl9mbiwgZmlsZXBhcnNlJiBmKQogICBzdHJjcHkgKGYudGFp
bCwgZm4gKyBuKTsKICAgZm5bbl0gPSAnXDAnOwogICBmLnBrZ1swXSA9IGYu
d2hhdFswXSA9ICdcMCc7Ci0gIHAgPSBiYXNlIChmbik7CisgIHAgPSBmbjsK
ICAgZm9yICh2ZXIgPSBwOyAqdmVyOyB2ZXIrKykKICAgICBpZiAoKnZlciAh
PSAnLScpCiAgICAgICBjb250aW51ZTsKLS0gCjIuMTQuMgoK

--------------DB53A57A543F78856412DFBD--
