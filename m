Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id B100B384A881
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 18:07:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B100B384A881
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCsgS-1kbA951MJs-008oQH for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 20:07:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BB4E8A8184A; Tue, 13 Oct 2020 20:07:14 +0200 (CEST)
Date: Tue, 13 Oct 2020 20:07:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] format_proc_cpuinfo: add enqcmd cpuinfo flag
Message-ID: <20201013180714.GU26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201013151108.36189-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013151108.36189-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:4I0AR9lTSd/86PzXlxJBRsegVVVsWLfnWU5N9r0bLudak9e88F8
 9A6yE0wRy2pxmkLh6RxYo7rdzUm9Oy9/mqi5Xd9jO3UrAXWpPW8moeni44FuRdoad/+hcVG
 3NVywOQmOnhip31JULh+O3cR0aLfqIf8cXEv+ic1qCj/YWTQYnHJqMETeLO+QE/trNdQY1C
 WNK6xo9wKJj5h1kEGlr1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0f6cjy1Dbwk=:q3ZG30Hy2I9MSyfFBkgusc
 fkXcIk0mJXLQzYWoCW8EGGz5J8wKQyAG1cMOPKYLuWkJLQxVZukBMfO/2GPN6OED3FHnQaSrE
 ynfMyHEw/7zEghsEQ2Ff383Su7CL47EAd1mdZY44t/NC7tF2zPLyxn0Admn0tID/10bxacVKD
 RFQUIO4wXvMM5MQWPvqH4REoL++7rHgGAvPOqfgPvqrYcQy22v8gah/5c4ijmJygne+35BzGW
 I1q6WESsTMEgBU5CdsSmMidUmCZwT44GGrXID1cFlhYEgsZwZzBIxgz/prUaAHpYi+o21VDQI
 PKnRsW3MtWB0fYkW73LIrhzig9nhcGm/gO4SHv7MLIhjhW/Wod85YAz7d/qPFa8GkypnasxrQ
 k5qeKWqpvPXAKiHmtA2Nh/HfINf/79V8/GfI/cko2WlntRSMxdNV0QfhncJ8Sp7FnrBdiuhcR
 o1CU8qb4TReiIGuTOmb2rt8+Tl1JM/MK79ilCrPfCaWG9FAIPult0a/b0Spf2yciVYHYI2tKq
 9zxPlpFgTCQUolqt+Shie6+wZA44e6mUFvnD1/vAghQ/Uz6Z5/DW3QeybduNj2cEqfHhsyb5m
 FtTB6XAGvV5Pa8TV0xb2Cl1Ocn+q7f9/LG2EkJd4BaiuH6QKSIEs0kVjYDXixLscn4V0i739r
 5izzFOTmUyURU7roeNrCVB3XKjr4FTLKdQubV06LYn6DlSrwTGkvVMXqTbpf9+XJGCbSpIAA5
 FzSW+vvvTJn5P+ees9oH165j+D+fBB/i34wbhJffeKV3bALSKz1d4j2P9DczWx1kl8pf6yR2v
 jYWAuA6pqMkYO8cpqIdGJYTZj0UpzlvMwM/uk9X8GObHYndvlFfmsTyecOBEErWJCthF4s/dG
 POd0jgAOKNQpIVHAx6Jg==
X-Spam-Status: No, score=-106.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 13 Oct 2020 18:07:18 -0000

On Oct 13 09:11, Brian Inglis wrote:
> Add linux-next 5.9 cpuinfo flag for Intel enqcmd/s instructions:
> x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions:
> Work submission instruction comes in two flavors. ENQCMD can be called
> both in ring 3 and ring 0 and always uses the contents of a PASID MSR
> when shipping the command to the device. ENQCMDS allows a kernel driver
> to submit commands on behalf of a user process. The driver supplies the
> PASID value in ENQCMDS. There isn't any usage of ENQCMD in the kernel as
> of now.
> The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.
> ---
>  winsup/cygwin/fhandler_proc.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 6f6e8291a0ca..13397150ff53 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1563,6 +1563,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  	  ftcprint (features1, 25, "cldemote");         /* cldemote instr */
>  	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
>  	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
> +	  ftcprint (features1, 29, "enqcmd");		/* enqcmd/s instructions*/
>          }
>  
>        /* AMD MCA cpuid 0x80000007 ebx */
> -- 
> 2.28.0

Pushed.


Thanks,
Corinna
