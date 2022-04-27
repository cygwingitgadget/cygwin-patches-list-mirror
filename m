Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id B27B93858C54
 for <cygwin-patches@cygwin.com>; Wed, 27 Apr 2022 09:30:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B27B93858C54
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRCFu-1nXcu102Q0-00NBYB for <cygwin-patches@cygwin.com>; Wed, 27 Apr 2022
 11:30:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 57BEEA80525; Wed, 27 Apr 2022 11:30:44 +0200 (CEST)
Date: Wed, 27 Apr 2022 11:30:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix build with w32api 10.0.0
Message-ID: <YmkNRCnQq7pR00Ee@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:/Y33QBFPuoY9Ed1su4kd++9qa2XLJT7ImOuy82eFYzzeqIWkm40
 B6wvKujH+kaw/hmXVCKiJwZj8asr46vllf+hhLLKoInYqfzUNIIgUzbN4sZyBqG8HXv00UZ
 JQn2Zn7oHR9PrgiUboPjTzFFdk+T7lGW0/eTNs2gk1gMIM4kK0w4c/K4Q7VUz/wdEEufSsL
 64l9uoyFHR2nEUZt+hUiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WOZ0xKh2MzA=:2e1u0oSLMh+MKxBjXe9lRV
 jZirZda1ZsHf1a/BZLSNbw8e2XTmWTNkixO59vAbGKCLPZCac0jpfvsC6SlYSJGpid74dxvdB
 CtOfpLZCr6ekfmKHmktopbqbUDbIQInGPPuNgPVhxOXKZ0N8QBC4kQMOssCRZWdC5582Qb4W4
 /HxeTovPAcOHG2Zgh8KaPfCXuiRvfDiAUSmWVAhk43KTgfEsIccnDvRVeh57lrUcNAwUDWnN3
 ERWpQrY9N7SWtTgaVmd59BPQsiaT9wfFLHwreEUzO3GBsAKceQnKI2WU46lvpMvMYEVQNiSB0
 e6/eM00fyJfSw5yefeWL4h4Q8PyM6vZ6k/RJYNAiSTrog19sc5P7leH1mxsKwL2sln36acddu
 UNLexI/HyU+owdkYTChMzyRmldbqs7i3CGp/83TABrrKAR6Si0GWLrlM+vH5FlrOWGd8DzFXP
 yp6n1uO7VnHb6uC++gD/Akj1ZLlkjcv5bOLqlf+012GLhzWj3YklDJsPf6K7FBEjeZP5LtkwF
 5EocjO9oj2BNPvaHZM1hdLZ93mFCPp2ILU7JOGg7Lpqw38lt6OEwZ6UhWpxm3fAxYYjZwdgkh
 us5cOxZpfpePWV+4bO7gq5ASEug7e6mliQJe9YlKi4u369Xyek5WGBNb0OdjgM7gXPeB9LZ2r
 JgkwLOzanrqgTwBAnBRYdJmiqe4b2X5dxGtyOPD5a/NqBS38g/m3ljNXdMPNX5iJ838Ka93G2
 dK70s/eTvAbDzNIn
X-Spam-Status: No, score=-94.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 27 Apr 2022 09:30:48 -0000

On Apr 12 18:32, Jon Turney via Cygwin-patches wrote:
> Jon Turney (2):
>   Cygwin: Fix build with w32api 10.0.0
>   Cygwin: Fix typo KERB_S4U_LOGON_FLAG_IDENTITY -> IDENTIFY
                                         ^^^^^^^^^^^^^^^^^^^^
                                         Ooooops

LGTM, thanks,
Corinna
