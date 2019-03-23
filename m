Return-Path: <cygwin-patches-return-9220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82186 invoked by alias); 23 Mar 2019 20:24:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82174 invoked by uid 89); 23 Mar 2019 20:24:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=H*R:D*ca, advised, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 20:24:53 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 7nCBhqK8VGusj7nCChsgQT; Sat, 23 Mar 2019 14:24:48 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
To: cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <20190323170408.GA3471@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <e003c1ad-234b-2eda-fd91-6bd644547c1a@SystematicSw.ab.ca>
Date: Sat, 23 Mar 2019 20:24:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323170408.GA3471@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00030.txt.bz2

On 2019-03-23 11:04, Corinna Vinschen wrote:
> On Mar 22 21:45, Brian Inglis wrote:
>> diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
>> index 4fce3e0b3..c81805ab6 100644
>> --- a/winsup/utils/ps.cc
>> +++ b/winsup/utils/ps.cc
>> @@ -337,6 +337,17 @@ main (int argc, char *argv[])
>>  		p->start_time = to_time_t (&ct);
>>  	      CloseHandle (h);
>>  	    }
>> +	  if (!h || 0 == p->start_time || -1 == p->start_time)
> 
>           if (!h || !p->start_time)
> 
> should be sufficient.  cygwin_internal(CW_GETPINFO_FULL) memsets the
> struct returned to all 0 before filling it with available data.

Case -1 is an invalid time_t conversion - everything else is valid! ;^>

>> +	    {
>> +	      SYSTEM_TIMEOFDAY_INFORMATION stodi;
>> +	      status = NtQuerySystemInformation (SystemTimeOfDayInformation,
>> +					(PVOID) &stodi, sizeof stodi, NULL);
>> +	      if (!NT_SUCCESS (status))
>> +		fprintf (stderr,
>> +			"NtQuerySystemInformation(SystemTimeOfDayInformation), "
>> +					"status %08x", status);
>> +	      p->start_time = to_time_t ((FILETIME*)&stodi.BootTime);
>> +	    }
>>  	}
>>  
>>        char uname[128];
> Wouldn't it make sense to fetch SystemTimeOfDayInformation only once
> and then just set p->start_time above?
Yea - thought about doing that - will redo that way.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
