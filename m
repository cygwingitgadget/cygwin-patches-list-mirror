Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id A280D3865470
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 13:55:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A280D3865470
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mr8O8-1lMkER0XHK-00oFtk for <cygwin-patches@cygwin.com>; Tue, 06 Jul 2021
 15:55:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8EA25A80A56; Tue,  6 Jul 2021 15:55:44 +0200 (CEST)
Date: Tue, 6 Jul 2021 15:55:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Define PSAPI_VERSION as 1 before including psapi.h
Message-ID: <YORg4JXAKu4guliV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <96d77c6b-0b46-527e-40bb-40adca640aff@dronecode.org.uk>
 <20210620133727.63966-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210620133727.63966-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:MMQDIniYya6DHg8eZJn//XrWHeWMsDb3wr7JAvkCMtG6q5QeDNd
 3bboVIWLBpuB3+zADGAbgVTeUATsPo0G5t8hvJxx2+ELxB8kEbwKYSt91JjCfBihiG4Simi
 lXA2hSr/7qf8yX8u0JoaAYHZUGv8o5CNjn+4za26F/cXWslFLWkT6lsBvvNy8EtOFZIxXf8
 YG0U915dbkof96hzE9+cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtJ5v/gWbMY=:Vbx7esNVhbOs6jpauhgPkv
 i2XBrMpbghOm+dtIS2Tp2rruu/W01e42kBkQnXGI09VHLTpmpeop53qe32wfBKpLTVHffvpwL
 KEWq+Q0wDatocgvcVsctSVw2w0qVK06K6NHjNDUpF16ZE3xG6WByYFVPX/aHjnoqdQt6vI5oT
 +Vq2Qs24HAvWEx7wJKYAYGvo7V/LKI/7bt8/m3iJVz7+M1i4rFz990lJsHpLknURbp6gWHzGq
 aeZAL2e60YE52oo17ajYxfBiLJXL/HA1rHOWIRdZsABehaTpHU+9uZCryGEPIIvRnYeiIJZcB
 d/YmrIWjirZdklZVyXW7MqRGfeDEbcgwNBcApWHkrqz00k2CTFsz7h9X380wG9KacCypHgbtF
 FSHwJVh9X99lMURZzgXB9cN+Ga2ndDVlSFk213r0RIxStQ+7ptOAyhLzju/Sd0hHx4azhUyh7
 RLZNjthxUqaTMGE5ZaxcCdr0ju8lzT+41lxBDMmZtySDEYZqdiMD5hoO0zS/SWGzGHNafks0O
 FvOn9xqTF1gteeaGsV6+WyNzv/Tkvtdex2oz7pMQ+wmxnUU2fw5RDLOkBKwFAf7crFOFBEHS/
 ae60WU15T4+eFwVVeJc6tpiDeMhuXoxnCD8G9Kp8ignZTfOkExK/OoBhQdqlucyipDhDy52Ha
 Ogjx539vdTpLo75gaXkW6pBobYutET20t/gglaaXHlDiDpY1cWK7DhIomRixi5CBZgD/KBHWz
 RtTVLVb2+GKguQ4QKOPd0JUI7dk+Ws+9YPic5ycjeRp4tPgTZrYexJaqxnNEnlb3V80lOR7G6
 JwkOiw1F1k61cuoxIoQDpYAxm3vonzNceEdFo6BOd12Jhd0m3oSwdlW86vk57nZJX2nxjJbX4
 8YaBwmKZNp+bGYHjJE1g==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 06 Jul 2021 13:55:49 -0000

Hi Jon,

On Jun 20 14:37, Jon Turney wrote:
> The default PSAPI_VERSION is controlled by WIN32_WINNT, which we set to
> 0x0a00 when building utils since 48a76190 (and is the default in w32api
> >= 9.0.0)
> 
> In order for the built executables to run on Windows Vista, we must also
> define PSAPI_VERSION as 1 (otherwise '#define GetModuleFileNameExA
> K32GetModuleFileNameExA' causes a 'The procedure entry point
> K32GetModuleFilenameExA could not be located in the dynamic link library
> kernel32.dll' error at run time).
> 
> Also drop uneeded psapi.h from dlfcn.cc (31ddf45d), resource.cc
> (34a6eeab) and ps.cc (1def2148).
> ---
>  winsup/cygwin/dlfcn.cc      | 1 -
>  winsup/cygwin/resource.cc   | 1 -
>  winsup/utils/dumper.cc      | 1 +
>  winsup/utils/ldd.cc         | 2 +-
>  winsup/utils/mingw/bloda.cc | 1 +
>  winsup/utils/module_info.cc | 1 +
>  winsup/utils/pldd.c         | 1 +
>  winsup/utils/ps.cc          | 1 -
>  8 files changed, 5 insertions(+), 4 deletions(-)

+1.  You really don't have to wait for me to push stuff like that.


Thanks,
Corinna
