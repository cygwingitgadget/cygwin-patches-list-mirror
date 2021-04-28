Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 5AE52393A41A
 for <cygwin-patches@cygwin.com>; Wed, 28 Apr 2021 10:40:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5AE52393A41A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MoOIi-1lDa5A3eg4-00opqd for <cygwin-patches@cygwin.com>; Wed, 28 Apr 2021
 12:40:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5B8F2A80F11; Wed, 28 Apr 2021 12:40:00 +0200 (CEST)
Date: Wed, 28 Apr 2021 12:40:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] format_proc_cpuinfo: add v_spec_ctrl, bus_lock_detect
Message-ID: <YIk7gD+HPPtEZOdb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210427232852.51759-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427232852.51759-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:Pt1fg9MI3xEQ0hKIdz+MlIInpGmRko1qRDJr/zMX91moltRrvLN
 zzimZDkRWEPO//YcON/5A3qpHiLExx2wd34d/8NkKPQmH8XvEAZUX+YmAdDx7a+OgrIL1vv
 UPkid3RpIuRkYkWUJ8OAxUMaYaocjLVrzxrJQug2H+hOB+TubjLyPg1cIvD7iOn56iVbhN6
 kTSpGSRAe4pcP+r0CA4Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ep193WuaW8c=:C26E9V41sYlHbQ+tbnhnEF
 iAYCB7r4nkae9LX+AHT0XH7QzmJbeG9OJK2H8VX1aCndbZBQDZmoeBRVyuhVXzINqz9syyvzg
 TykznkceAgISoQZvig5TqBUjoKb/+gFJ+cnXIGuseMlLEbJNzID6K5uZT8YTFo6493W1avOqh
 Ea6En+IauSxMjLnzvCEB6151AuTqbOa1+K5D63U76IbIC8GybG4gopRL2opcfJBIj7a2bH9zL
 8KJlE24aLI7u5DsLtOxSwYhrZXNm4g9WcoEGMJjn7sh7PS2b5GGTg2pu+FkAr3GREsNOwduFW
 UuUAiHfpC6vDiJl5Pzgn1TkRIcFqFXd5NV5Qhya07duN+5cP3uJW7ZJOarXeOQ9fKKFuUo2YN
 Ftq+BOf7cvHQbDd+WmspRz39D5VOCm//rq2CWQOMMj46ysdHWLZFav9SJQvhMvzSuLdDvGkqS
 TQgwT6ID3MnBJ/rmi5Vtt12J3061NYQ12D4F0GMnanwBWelnQwkHJRGvbOBYBN9GMUVAtmauj
 qDbRfqdDAl4ypLiRzl4JUc=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Wed, 28 Apr 2021 10:40:03 -0000

On Apr 27 17:28, Brian Inglis wrote:
> 
> Linux 5.12 Frozen Wasteland added features and changes:
> add AMD 0x8000000a EDX:20 v_spec_ctrl virtual speculation control support
> add Intel 0x00000007 ECX:24 bus_lock_detect bus lock detect debug exception
> ---
>  winsup/cygwin/fhandler_proc.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 

Pushed.


Thanks,
Corinna

