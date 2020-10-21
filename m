Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta31-re.btinternet.com
 [213.120.69.124])
 by sourceware.org (Postfix) with ESMTPS id 424D83857813
 for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2020 14:31:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 424D83857813
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201021143139.GBZS4289.re-prd-fep-042.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2020 15:31:39 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffgeeifffhhfevhfehtddtvdehteeigeetkeegleektdeitdefveethfegfeehgfenucffohhmrghinhepmhgrkhgvfhhilhgvrdhinhdpghhnuhdrohhrghenucfkphepkeeirddufeelrdduheekrddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddufeelrdduheekrddvjedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.27) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD016E03109 for cygwin-patches@cygwin.com;
 Wed, 21 Oct 2020 15:31:39 +0100
Subject: Re: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
 <20201020134304.11281-4-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
Date: Wed, 21 Oct 2020 15:31:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201020134304.11281-4-jon.turney@dronecode.org.uk>
Content-Type: multipart/mixed; boundary="------------C759FF994398DE7D8FD90C96"
Content-Language: en-GB
X-Spam-Status: No, score=-1201.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL,
 SPF_HELO_PASS, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 21 Oct 2020 14:31:50 -0000

This is a multi-part message in MIME format.
--------------C759FF994398DE7D8FD90C96
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2020 14:43, Jon Turney wrote:
> Express that gendef generates sigfe.s and cygwin.def in a slightly less
> nutty way.
> ---
>   winsup/cygwin/Makefile.in | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index a56a311b8..9d05b17b3 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -785,16 +785,13 @@ $(VERSION_OFILES): version.cc
>   Makefile: ${srcdir}/Makefile.in
>   	/bin/sh ./config.status
>   
> -$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
> +$(DEF_FILE) sigfe.s: gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
>   	$(word 1,$^) --cpu=${target_cpu} --output-def=$@  --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)

Using $@ is wrong if make decides to build sigfe.s first, and $^ will 
contain an unwanted $(DEF_FILE) from the dependency below.

So please try the attached instead.

But maybe I need to do a bit more staring at [1].

[1] 
https://www.gnu.org/software/automake/manual/html_node/Multiple-Outputs.html

>   
>   $(srcdir)/$(TLSOFFSETS_H): gentls_offsets cygtls.h
>   	$^ $@ $(target_cpu) $(COMPILE.cc) -c || rm $@
>   
>   sigfe.s: $(DEF_FILE)
> -	@[ -s $@ ] || \
> -	{ rm -f $(DEF_FILE); $(MAKE) -s -j1 $(DEF_FILE); }; \
> -	[ -s $@ ] && touch $@
>   
>   sigfe.o: sigfe.s $(srcdir)/$(TLSOFFSETS_H)
>   	$(CC) ${CFLAGS} -c -o $@ $<
> 

--------------C759FF994398DE7D8FD90C96
Content-Type: text/plain; charset=UTF-8;
 name="0003-gendef-generates-sigfe.s-and-cygwin.def.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0003-gendef-generates-sigfe.s-and-cygwin.def.patch"

RnJvbSAxNWY4Y2MwZjdjZDI3M2YxZDEwYTc0ODMzOTk0MDM0ODdiMmMyZWIyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IE1vbiwgMTIgT2N0IDIwMjAgMTY6NTk6MDIgKzAxMDAKU3ViamVj
dDogW1BBVENIIDMvNl0gZ2VuZGVmIGdlbmVyYXRlcyBzaWdmZS5zIGFuZCBjeWd3aW4uZGVm
CgpFeHByZXNzIHRoYXQgZ2VuZGVmIGdlbmVyYXRlcyBzaWdmZS5zIGFuZCBjeWd3aW4uZGVm
IGluIGEgc2xpZ2h0bHkgbGVzcwpudXR0eSB3YXkuCi0tLQogd2luc3VwL2N5Z3dpbi9NYWtl
ZmlsZS5pbiB8IDcgKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL01ha2VmaWxlLmlu
IGIvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbgppbmRleCBhNTZhMzExYjguLjcwZTM4ZWFk
NiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbgorKysgYi93aW5zdXAv
Y3lnd2luL01ha2VmaWxlLmluCkBAIC03ODUsMTYgKzc4NSwxMyBAQCAkKFZFUlNJT05fT0ZJ
TEVTKTogdmVyc2lvbi5jYwogTWFrZWZpbGU6ICR7c3JjZGlyfS9NYWtlZmlsZS5pbgogCS9i
aW4vc2ggLi9jb25maWcuc3RhdHVzCiAKLSQoREVGX0ZJTEUpOiBnZW5kZWYgJChzcmNkaXIp
LyQoVExTT0ZGU0VUU19IKSAkKERJTl9GSUxFKQotCSQod29yZCAxLCReKSAtLWNwdT0ke3Rh
cmdldF9jcHV9IC0tb3V0cHV0LWRlZj0kQCAgLS10bHNvZmZzZXRzPSQod29yZCAyLCReKSAk
KHdvcmRsaXN0IDMsOTksJF4pCiskKERFRl9GSUxFKSBzaWdmZS5zOiBnZW5kZWYgJChzcmNk
aXIpLyQoVExTT0ZGU0VUU19IKSAkKERJTl9GSUxFKQorCSQod29yZCAxLCReKSAtLWNwdT0k
e3RhcmdldF9jcHV9IC0tb3V0cHV0LWRlZj0kKERFRl9GSUxFKSAtLXRsc29mZnNldHM9JCh3
b3JkIDIsJF4pICQod29yZGxpc3QgMyw0LCReKQogCiAkKHNyY2RpcikvJChUTFNPRkZTRVRT
X0gpOiBnZW50bHNfb2Zmc2V0cyBjeWd0bHMuaAogCSReICRAICQodGFyZ2V0X2NwdSkgJChD
T01QSUxFLmNjKSAtYyB8fCBybSAkQAogCiBzaWdmZS5zOiAkKERFRl9GSUxFKQotCUBbIC1z
ICRAIF0gfHwgXAotCXsgcm0gLWYgJChERUZfRklMRSk7ICQoTUFLRSkgLXMgLWoxICQoREVG
X0ZJTEUpOyB9OyBcCi0JWyAtcyAkQCBdICYmIHRvdWNoICRACiAKIHNpZ2ZlLm86IHNpZ2Zl
LnMgJChzcmNkaXIpLyQoVExTT0ZGU0VUU19IKQogCSQoQ0MpICR7Q0ZMQUdTfSAtYyAtbyAk
QCAkPAotLSAKMi4yOC4wCgo=
--------------C759FF994398DE7D8FD90C96--
