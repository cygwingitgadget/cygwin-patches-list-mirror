Return-Path: <SRS0=PxbH=DD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-049.btinternet.com (mailomta29-re.btinternet.com [213.120.69.122])
	by sourceware.org (Postfix) with ESMTPS id E420E3858D28
	for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 11:58:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E420E3858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20230717115818.QATK8012.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 12:58:18 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECE710079C870
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfhuffvfhgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeekkeekgeeglefftdfhueekteejueegueejteeikeffveefleejjedufeekffehteenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvgho
	kffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECE710079C870 for cygwin-patches@cygwin.com; Mon, 17 Jul 2023 12:58:18 +0100
Content-Type: multipart/mixed; boundary="------------b6w1svJa0TNyRgs5A9u0vro7"
Message-ID: <0a9d6f10-f26c-faf2-6fa1-c6a055570f5a@dronecode.org.uk>
Date: Mon, 17 Jul 2023 12:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 00/11] More testsuite fixes
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------b6w1svJa0TNyRgs5A9u0vro7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2023 12:38, Jon Turney wrote:
> 
> cancel11: some funkiness I can't work out, causing the save/restoring signal handlers around system() to not
> work correctly

So, the test here: is the SIGINT handle restored correctly if the thread 
executing system() is cancelled. This test fails, because it's not.

It seems like that scenario was explicitly considered when this test was 
added in https://cygwin.com/pipermail/cygwin-patches/2003q1/003378.html

I think maybe this is a regression introduced in 
https://cygwin.com/cgit/newlib-cygwin/commit/?id=3cb9da14617c58c2821c80d48f0bd80a2deb5fdf

child_info_spawn::worker calls waitpid() which ultimately calls 
cygwait() which notices the thread's cancel event is signalled and acts 
as a cancellation point.

Attached is a patch which adds back the restoration of signal handlers 
on thread cancellation.

I can't find any hints in the mailing lists around 2013-04 about what 
problem that change is fixing, but given the commentary, this might be 
reintroducing another problem, though.
--------------b6w1svJa0TNyRgs5A9u0vro7
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Restore-pthread-cleanup-of-signal-handlers-du.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Restore-pthread-cleanup-of-signal-handlers-du.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhNzk4NzUwZDI3MWUyMDQwMmEwYTVlZmM0YWMwNzNmNTk0OGFkNWI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTQ6NDY6MDAgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IFJlc3RvcmUgcHRocmVhZCBjbGVhbnVwIG9mIHNpZ25hbCBo
YW5kbGVycyBkdXJpbmcKIHN5c3RlbSgpCgpSZW1vdmVkIGluIDNjYjlkYTE0IHdoaWNoIGRl
c2NyaWJlcyBpdCBhcyAnaWxsLWFkdmlzZWQnIChhZGRpdGlvbmFsCmNvbnRleHQgZG9lc24n
dCBhcHBlYXIgdG8gYmUgYXZhaWxhYmxlKS4KCldlIGNhbid0IG5lYXRseSB0dWNrIHRoZSBw
dGhyZWFkX2NsZWFudXBfcHVzaC9wb3AgaW5zaWRlIHRoZSBvYmplY3QsIGFzCnRoZXkgYXJl
IGltcGxlbWVudGVkIGFzIG1hY3JvcyB3aGljaCBtdXN0IGFwcGVhciBpbiB0aGUgc2FtZSBs
ZXhpY2FsCnNjb3BlLgotLS0KIHdpbnN1cC9jeWd3aW4vc3Bhd24uY2MgfCAxNCArKysrKysr
KysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zcGF3bi5jYyBiL3dpbnN1cC9jeWd3
aW4vc3Bhd24uY2MKaW5kZXggODRkZDc0ZTI4Li4zNjk2YWM5YjUgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vc3Bhd24uY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zcGF3bi5jYwpAQCAt
MjU3LDExICsyNTcsMTUgQEAgc3RydWN0IHN5c3RlbV9jYWxsX2hhbmRsZQogICB9CiAgIH5z
eXN0ZW1fY2FsbF9oYW5kbGUgKCkKICAgewotICAgIGlmIChpc19zeXN0ZW1fY2FsbCAoKSkK
KyAgfQorICBzdGF0aWMgdm9pZCBjbGVhbnVwICh2b2lkICphcmcpCisgIHsKKyMgZGVmaW5l
IHRoaXNfICgoc3lzdGVtX2NhbGxfaGFuZGxlICopIGFyZykKKyAgICBpZiAodGhpc18tPmlz
X3N5c3RlbV9jYWxsICgpKQogICAgICAgewotCXNpZ25hbCAoU0lHSU5ULCBvbGRpbnQpOwot
CXNpZ25hbCAoU0lHUVVJVCwgb2xkcXVpdCk7Ci0Jc2lncHJvY21hc2sgKFNJR19TRVRNQVNL
LCAmb2xkbWFzaywgTlVMTCk7CisJc2lnbmFsIChTSUdJTlQsIHRoaXNfLT5vbGRpbnQpOwor
CXNpZ25hbCAoU0lHUVVJVCwgdGhpc18tPm9sZHF1aXQpOworCXNpZ3Byb2NtYXNrIChTSUdf
U0VUTUFTSywgJih0aGlzXy0+b2xkbWFzayksIE5VTEwpOwogICAgICAgfQogICB9CiAjIHVu
ZGVmIGNsZWFudXAKQEAgLTkxMiw4ICs5MTYsMTAgQEAgY2hpbGRfaW5mb19zcGF3bjo6d29y
a2VyIChjb25zdCBjaGFyICpwcm9nX2FyZywgY29uc3QgY2hhciAqY29uc3QgKmFyZ3YsCiAJ
Y2FzZSBfUF9XQUlUOgogCWNhc2UgX1BfU1lTVEVNOgogCSAgc3lzdGVtX2NhbGwuYXJtICgp
OworCSAgcHRocmVhZF9jbGVhbnVwX3B1c2ggKHN5c3RlbV9jYWxsX2hhbmRsZTo6Y2xlYW51
cCwgJnN5c3RlbV9jYWxsKTsKIAkgIGlmICh3YWl0cGlkIChjeWdwaWQsICZyZXMsIDApICE9
IGN5Z3BpZCkKIAkgICAgcmVzID0gLTE7CisJICBwdGhyZWFkX2NsZWFudXBfcG9wICgxKTsK
IAkgIHRlcm1fc3Bhd25fd29ya2VyLmNsZWFudXAgKCk7CiAJICBicmVhazsKIAljYXNlIF9Q
X0RFVEFDSDoKLS0gCjIuMzkuMAoK

--------------b6w1svJa0TNyRgs5A9u0vro7--
