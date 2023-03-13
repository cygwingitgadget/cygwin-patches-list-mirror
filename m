Return-Path: <SRS0=ciRW=7F=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta7-sa.btinternet.com [213.120.69.13])
	by sourceware.org (Postfix) with ESMTPS id EE5E438582A4
	for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 14:18:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE5E438582A4
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20230313141833.ZRMB4274.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 14:18:33 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6406812D00BEA1CD
X-Originating-IP: [86.139.167.100]
X-OWM-Source-IP: 86.139.167.100 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetffeftdeftedtleduteehleelgfelfffhjedvueekveefvefgueehtdekkefgkeenucffohhmrghinheptgihghifihhnqdguohgtrdhshhenucfkphepkeeirddufeelrdduieejrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekiedrudefledrudeijedruddttddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqddutddtrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (86.139.167.100) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 6406812D00BEA1CD for cygwin-patches@cygwin.com; Mon, 13 Mar 2023 14:18:33 +0000
Message-ID: <0cef86b3-ea03-a627-2847-2130a93872b3@dronecode.org.uk>
Date: Mon, 13 Mar 2023 14:18:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Cygwin: doc: Update postinstall/preremove scripts
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230308141719.7361-1-jon.turney@dronecode.org.uk>
 <ZA7tWpqAmlcKg+v7@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <ZA7tWpqAmlcKg+v7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1197.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/03/2023 09:31, Corinna Vinschen wrote:
> Hi Jon,
> 
> On Mar  8 14:17, Jon Turney wrote:
>> Update postinstall/preremove scripts to use CYGWIN_START_MENU_SUFFIX and
>> CYGWIN_SETUP_OPTIONS.
> 
> It would be great if you could explain your change in the commit
> message...
> 

Yeah, that's fair. How about:

"Since setup 2.925, it indicates to postinstall and preremove scripts 
the start menu suffix to use via the CYGWIN_START_MENU_SUFFIX env var.

It also indicates, via the CYGWIN_SETUP_OPTIONS env var, if the option 
to disable startmenu shortcut creation is supplied.

Update the Cygwin documentation postinstall and preremove scripts to 
take these env vars into consideration."

>>   winsup/doc/etc.postinstall.cygwin-doc.sh | 19 +++++++++++++++----
>>   winsup/doc/etc.preremove.cygwin-doc.sh   |  8 ++++++--
>>   2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
>> index 97f88a16d..313c1d3ff 100755
>> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
>> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
>> @@ -36,9 +36,20 @@ do
>>   	fi
>>   done
>>   
>> +# setup was run with options not to create startmenu items
>> +case ${CYGWIN_SETUP_OPTIONS} in
>> +  *no-startmenu*)
>> +    exit 0
>> +    ;;
>> +esac
>> +
>>   # Cygwin Start Menu directory
>> -case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
>> -smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
>> +if [ ! -v CYGWIN_START_MENU_SUFFIX ]
> 
> Isn't -v a bash extension? Ideally the shebang should reflect that.
> Otherwise, -z?

This is actually controlled by setup, which runs postinstall and 
preremove scripts with an .sh extension using bash.

But yeah, I'll change the shebang.

