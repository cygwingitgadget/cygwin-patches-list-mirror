Return-Path: <cygwin-patches-return-8779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67547 invoked by alias); 13 Jun 2017 18:36:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67521 invoked by uid 89); 13 Jun 2017 18:36:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2590, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, party
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 13 Jun 2017 18:36:20 +0000
Received: from [10.2.1.30] (c-73-240-197-175.hsd1.or.comcast.net [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id 2ABE4160F2B	for <cygwin-patches@cygwin.com>; Tue, 13 Jun 2017 11:36:24 -0700 (PDT)
Message-ID: <594030A9.4090301@pismotec.com>
Date: Tue, 13 Jun 2017 18:36:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v2
References: <593B24DD.10209@pismotec.com> <20170612102705.GL13513@calimero.vinschen.de> <593EF4A3.8040906@pismotec.com> <20170613075723.GA16824@calimero.vinschen.de>
In-Reply-To: <20170613075723.GA16824@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00050.txt.bz2


On 2017-06-13 00:57, Corinna Vinschen wrote:> On Jun 12 13:08, Joe Lowe wrote:
>> On 2017-06-12 03:27, Corinna Vinschen wrote:
>>> On Jun  9 15:44, Joe Lowe wrote:
>>>> -	  else
>>>> +	  else if (res == -1)
>>>>    	    {
>>>> -	      /* Volume moint point or unrecognized reparse point type.
>>>> +	      /* Volume moint point or unhandled reparse point.
>>>>    		 Make sure the open handle is not used in later stat calls.
>>>>    		 The handle has been opened with the FILE_OPEN_REPARSE_POINT
>>>>    		 flag, so it's a handle to the reparse point, not a handle
>>>> -		 to the volumes root dir. */
>>>> +		 to the reparse point target. */
>>>>    	      pflags &= ~PC_KEEP_HANDLE;
>>>> -	      /* Volume mount point:  The filesystem information for the top
>>>> -		 level directory should be for the volume top level directory,
>>>> -		 rather than for the reparse point itself.  So we fetch the
>>>> -		 filesystem information again, but with a NULL handle.
>>>> -		 This does what we want because fs_info::update opens the
>>>> -		 handle without FILE_OPEN_REPARSE_POINT. */
>>>> -	      if (res == -1)
>>>> -		fs.update (&upath, NULL);
>>>> +	      /* The filesystem information should be for the target of
>>>> +		 the reparse point rather than for the reparse point itself.
>>>> +		 So we fetch the filesystem information again, but with a
>>>> +		 NULL handle. This does what we want because fs_info::update
>>>> +		 opens the handle without FILE_OPEN_REPARSE_POINT. */
>>>> +	      fs.update (&upath, NULL);
>>>> +	    }
>>>> +	  else
>>>> +	    {
>>>> +	      /* Unknown reparse point type: HSM, dedup, compression, ...
>>>> +	         Treat as normal directory. */
>>>>    	    }
>>>
>>> Nothing against reordering the code, but this drops removing
>>> PC_KEEP_HANDLE from pflags if res == 0, i.e., for unknown reparse
>>> points.
>>
>> Changing the handling for unknown (3rd party) reparse tags is
>> not the primary point of the patch. But the fallback handling
>> for reparse tags should be to do what most win32 apps would do,
>> treat as a normal file/directory and open without the
>> FILE_OPEN_REPARSE_TAG flag.
>>
...
> I don't get what you're arguing for.  Removing the PC_KEEP_HANDLE
> bit will close the (wrong) search handle from path_conv, so that
> subsequent stat calls will stat the target of the reparse point.
> By keeping it in case of unknown reparse points, subsequent stats
> will return the wrong info (reparse point rather than target).

OK. Next pass should be a smaller diff, and I will double check
things. Please check what I end up with in reworked patch and let
me know then if there still is a concern.

Joe L.
