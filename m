Return-Path: <cygwin-patches-return-10168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111092 invoked by alias); 3 Mar 2020 06:22:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111078 invoked by uid 89); 3 Mar 2020 06:22:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=03.03.2020, 03032020
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Mar 2020 06:22:09 +0000
Received: from [192.168.178.45] ([95.90.246.218]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MvKL3-1jQ89X42ef-00rGCA for <cygwin-patches@cygwin.com>; Tue, 03 Mar 2020 07:22:07 +0100
Subject: Re: /proc/partitions: add some space to avoid ragged output format
To: cygwin-patches@cygwin.com
References: <dc387652-11c2-92c5-70e6-b096c318f58c@towo.net> <5655db7b-5ffb-cdda-d944-3d4f3e639329@SystematicSw.ab.ca>
From: Thomas Wolff <towo@towo.net>
X-Tagtoolbar-Keys: D20200303072207675
Message-ID: <f7877c6c-8165-b00e-c265-9a1974cfdb72@towo.net>
Date: Tue, 03 Mar 2020 06:22:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5655db7b-5ffb-cdda-d944-3d4f3e639329@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00274.txt

Am 03.03.2020 um 00:26 schrieb Brian Inglis:
> Hi Thomas,
>
> In this industry, you plan ahead a bit further and longer: you need to go for at
> least a three digit increase (below) or more; legacy 8TB HDDs are cheap and
> common, 20TB are available, 100TB SSDs are available now (#blocks 97656250000 -
> 11 digits), capacity is expanding *faster* than HDDs:
>
> https://www.tomshardware.com/news/100tb-ssd-nimbus-sata-flash,36687.html
>
> and speeds now exceed 6GB/s and 1M IO/s.
>
> We're also at 64C/128T 6GHz (overclocked) chips with 256MB L3 and L4 caches,
> 256GB memory, and over the next decade, feature sizes dropping by an order of
> magnitude from 14nm to 1.4nm, with corresponding increases, so maintainers
> should consider capacity increases when they look at code.
>
> To make this easier next time ;^> I'd define a couple of formats:
>
> #define PROC_PARTITION_HDR	"%5s %5s %12s %s\n\n"
> #define PROC_PARTITION_FMT	"%5d %5d %12U %s\n"
>
> or simplify the code further with:
>
> #define PROC_PARTITION_HDR	"%5s %5s %12s %-6s %-s\n\n"
> #define PROC_PARTITION_FMT	"%5d %5d %12U %-6s %-s\n"
>
> and sprintf the header into the buffer:
>
> -	  print ("major minor  #blocks  name   win-mounts\n\n");
> +	  bufptr += __small_sprintf (bufptr, PROC_PARTITION_HDR,
> +				    "major", "minor", "#blocks",
> +				    "name   win-mounts\n\n");
>
> *or*
>
> -	  print ("major minor  #blocks  name   win-mounts\n\n");
> +	  bufptr += __small_sprintf (bufptr, PROC_PARTITION_HDR,
> +				    "major", "minor", "#blocks",
> +				    "name", "win-mounts\n\n");
>
Hi Brian,
yes, I thought about factoring out the format as well, but then only 
submitted a quick-and-dirty patch.
If you're suggesting a more solid solution, would you submit your patch?
Thomas


> On 2020-03-02 14:39, Thomas Wolff wrote:
>
> ---
>   winsup/cygwin/fhandler_proc.cc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 605a8443f..3373f3ef5 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1491,7 +1491,7 @@ format_proc_partitions (void *, char *&destbuf)
>   	}
>         if (!got_one)
>   	{
> -	  print ("major minor  #blocks  name   win-mounts\n\n");
> +	  print ("major minor    #blocks   name   win-mounts\n\n");
>   	  got_one = true;
>   	}
>         /* Fetch partition info for the entire disk to get its size. */
> @@ -1514,7 +1514,7 @@ format_proc_partitions (void *, char *&destbuf)
>   	  size = 0;
>   	}
>         device dev (drive_num, 0);
> -      bufptr += __small_sprintf (bufptr, "%5d %5d %9U %s\n",
> +      bufptr += __small_sprintf (bufptr, "%5d %5d %12U %s\n",
>   				 dev.get_major (), dev.get_minor (),
>   				 size >> 10, dev.name () + 5);
>         /* Fetch drive layout info to get size of all partitions on the disk. */
> @@ -1561,7 +1561,7 @@ format_proc_partitions (void *, char *&destbuf)
>   	      continue;
>   	    device dev (drive_num, part_num);
>
> -	    bufptr += __small_sprintf (bufptr, "%5d %5d %9U %s",
> +	    bufptr += __small_sprintf (bufptr, "%5d %5d %12U %s",
>   				       dev.get_major (), dev.get_minor (),
>   				       size >> 10, dev.name () + 5);
>   	    /* Check if the partition is mounted in Windows and, if so,
>
