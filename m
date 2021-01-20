Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 105A53858026
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 11:23:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 105A53858026
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbizQ-1laytl0Vji-00dBly for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021
 12:23:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 13723A80D4C; Wed, 20 Jan 2021 12:23:26 +0100 (CET)
Date: Wed, 20 Jan 2021 12:23:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Reduce buffer size in
 get_console_process_id().
Message-ID: <20210120112326.GT59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210120005700.531-1-takashi.yano@nifty.ne.jp>
 <20210120095024.GR59030@calimero.vinschen.de>
 <20210120194026.0529a3daafa83e8c9dd9311b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120194026.0529a3daafa83e8c9dd9311b@nifty.ne.jp>
X-Provags-ID: V03:K1:b/J/CYrsvJ3A1fxI1CxVUAYpLxDmLDbxetlj2WSyDKBdB0bFkpz
 h8jtRFb3VIbxPgnh8WuB68HdTbvHejJzxWZLJ9Ny0DYwhMm/j/GtjgPihvkmdoKvquZYbMD
 XBtnQ0SR5EcGQn2CwnV+hFxmNK0b5ePQF5geeNazT5GqaH6Wo2cyNpZOi/Wp6kxR+E1yd3i
 TdvhUQlXBnvIt/vXUd88A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VSGoyiwoz14=:PJc+//+w6LLaWhA1DJDaYn
 ZyK4UAiIjvZNTvYdsTM5eEkDJwEJlN+QhlXg/3rDUBuUBBNBiTYmA2k2UWhzpL5xTC3HOGs6v
 UhBcbByYzXxKECPIt6+RxWWbavFVN24vIcPSXpNnA+JDrX+qF/TqzrgVe/SUqqZmrJGSqG+X9
 5IK9k7QUbUiqlqPmPFp1v+kjXeMxu4iXfoD4+kfBmdWp8EOHp3pD0MVjTK8qsr+fuI2f2WJAa
 mx/NGNADMoyjRVwAhQ0ove66vTt2ssDcaOdzHR5waXJIz29AZ6bSvZzZgLXkLhxmgT1yIQEO1
 bOhCl8pwJMbTK51eRd1u7e+R8av3LhfxsMUs76EWNgNV4DbuyYeljbjzCxK0YyebADMFL8XAX
 rF9/teCQzIPaKkNJvtQq/8vRecN6C96wJAXzeRJWLlBLqAK4TAFO8q/QD1q8Mf7Gf78GtSRC6
 igKZToAgow==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 20 Jan 2021 11:23:30 -0000

On Jan 20 19:40, Takashi Yano via Cygwin-patches wrote:
> On Wed, 20 Jan 2021 10:50:24 +0100
> Corinna Vinschen wrote:
> > On Jan 20 09:57, Takashi Yano via Cygwin-patches wrote:
> > > - The buffer used in get_console_process_id(), introduced by commit
> > >   72770148, is too large and ERROR_NOT_ENOUGH_MEMORY occurs in Win7.
> > 
> > Huh, funny!  Will we ever be happy with just 8192 processes per
> > console? :)
> 
> According to my test, when the buffer size is larger than 15683,
> this error occurs. Test environment is Win7 x64. Both inside and
> outside of WOW64, the maximum allowed size seems to be the same.
> 
> Shall we increase to 15683? :p

Ugh, please, no :D

8K processes per console is fine.  The machine will probably be out of
memory before this is a concern.


Corinna
