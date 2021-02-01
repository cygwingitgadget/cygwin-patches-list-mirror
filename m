Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id B0D743858018
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 09:42:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0D743858018
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoNu2-1lmDFU08ZU-00omih for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 10:42:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7ED65A80D7F; Mon,  1 Feb 2021 10:42:19 +0100 (CET)
Date: Mon, 1 Feb 2021 10:42:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getdtablesize: always return OPEN_MAX_MAX
Message-ID: <20210201094219.GE375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210128025150.46708-1-kbrown@cornell.edu>
 <20210128102029.GY4393@calimero.vinschen.de>
 <151a4199-92f2-43aa-dd91-5d86c2e1d3c6@cornell.edu>
 <20210128160749.GB4393@calimero.vinschen.de>
 <20210128161304.GC4393@calimero.vinschen.de>
 <a4cd3c3f-d217-026a-3cce-b29187ecd1e9@cornell.edu>
 <36a6753f-9aaa-f2ce-f71f-40385b3214c3@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a6753f-9aaa-f2ce-f71f-40385b3214c3@cornell.edu>
X-Provags-ID: V03:K1:WydTa9PMpzfJsxyvymbTb1a+DSDn3JhVs/Am/YkuQwriqy4hTCh
 G3Tk5ROZISIhly/ffO6vkpQWqh1b2DcQYDGXweRSnyT6gzV3AA7MfzPyXzYPq2Bo+DG7m9Y
 4Tfmfx273Xoy0es8VspN674jzWnrSZK4za1K1wtuhUTv9syWS6G0qBNkwCXmllvwo2UdJ+M
 8PRhdtQKTLPxYHpWfHtgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:joVgIT9oiLs=:HpBUJHb6trLYzG/G2SqUg1
 svlgr/bsTIjU0TrcYC6CVUbrcmbic6wf6UC2JIy3v0w1BZauosOuKHBGUb3SfMGSYEoWqLU0/
 3FhGLmNFhbo+VnYlh8B/ooRuFt+hmYSIiQKJ3R/fKR8gQbPhdW12+CHA7Af4+rB29rzwstJvG
 MzNauQZ7etjk1/U1d0fQq8vrfkFuWn+nLn8x2QXs1ARtAXyqCHDyP0qImaL4DTXArSPQo8vIU
 cI2QAsfShPlJthwA0GqJXcHpMFW0e85jBF3DqbJWhTz0FXLyjhzKZF7LF/SH8x3LwQKJIjpjG
 ToJcVc6jVpgw7hJ2bLTO8jtcDWoCxQ4Hg1DEL6fJX4un0HXNpZLxF4VFSrnwQzoNxXBpP/vrl
 +MZgC2MHcxmZGeJZzj0s+3vLJLW5OK8UvBbmgDz8UOXuQfljHZRssqsCGgqXo065BGDg3nfIx
 AlJRy5+PyQ==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 01 Feb 2021 09:42:24 -0000

On Jan 29 14:23, Ken Brown via Cygwin-patches wrote:
> On 1/28/2021 5:28 PM, Ken Brown via Cygwin-patches wrote:
> > > ...ideally by adding a file include/cygwin/limits.h included by
> > > include/limits.h, which defines __OPEN_MAX et al, as required.
> > 
> > I'm not completely sure I follow.  Do you mean include/cygwin/limits.h
> > should contain
> > 
> >    #define __OPEN_MAX 3200
> > 
> > and include/limits.h should contain
> > 
> >    #define OPEN_MAX __OPEN_MAX ?
> > 
> > For the sake of my education, could you explain the reason for this?
> 
> Trying to answer my own question, I guess the idea is to hide implementation
> details from viewers of limits.h.  Is that right?

Yes, that was the idea, kind of like a poor mans include/bits dir on
Linux...

> I took a stab at this and
> am about to send a patchset.  I'm not sure whether I made a reasonable
> choice of "et al" in "__OPEN_MAX et al".

Sorry, I didn't mean to imply you will have to do that right away.
It was just a thought to move over more values in later patches.


Corinna
