Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id F1E183861821
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 15:55:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F1E183861821
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M42Ss-1lOjMx1vfs-0007eH for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 16:54:59 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id F0583A80DC9; Tue, 23 Mar 2021 16:54:58 +0100 (CET)
Date: Tue, 23 Mar 2021 16:54:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFoPUmrnw0S+BELd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <YFnit7OtFJeflMQT@calimero.vinschen.de>
 <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk>
 <87a6qtx5dt.fsf@Otto.invalid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6qtx5dt.fsf@Otto.invalid>
X-Provags-ID: V03:K1:M+SdKJEhrTWd1CQbCo+QsgqjaY/mGATW/l5f09fcuIYKmUcO83t
 EfvlTaZlxRCVKfF6cAFVHxUGld8m0x3Aa9RKHsc7igMFA8qLKBAwesxr3jKzLZjiSToGkch
 ZuK1qiIFzJ6pztsjzPqsdGsgBjtvne9eKKTKT15xCoE0EkKn3sgpcfbkvTkATwXhB3QU2de
 w7CdFJUBdSDfbszv2kKiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fAc9QADzkfg=:gMtzAI3qOHdbzhE59jiXxl
 0J1plyVEjIcQh8NDBaIgaou+bXPGnso3uet0ey5I3WWdGS95o4pvx2VosymSRU61roSHb5+3/
 odhM6pyY9WBejM0dh2of52AY5l1d8Z6oSzuvQXJy/uKUi7FaU+l6phZ7svnG/gX9pXu8t/c+J
 2t4xZRxzdo43arjGrqXtDo+9PChA36paUeb4kO8QsVAFjUlmK9mkDEu5fdwVnaADkxaezdZF0
 1Pa8qHcB77xhHZq8ArAs6/AsD/7W1OYIjkzziBtFpQfoe6FmWeytmRVruI4gdvDCPuKAOJvl9
 BcgOVF+9/NBTW490FqpfpIEP/5BMWm37tkYUM2HeicpVduB8jJO7zOQw4RAujhN/+lpGTzqIQ
 tlg67a849HQqskhrywGS+/rfJUuiWyg2ulIeWWy5nxbOag2CwfOYpF7pUE/TuI/QjX+jfo8W8
 +0lfGpHmmDtHvYv/iiRrJXK4Vpu5ZsYGCyuzEVnv7zJ6sJsHPdGG
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 15:55:04 -0000

On Mar 23 16:21, ASSI wrote:
> Jon Turney writes:
> > 'run' is used by the start menu item which starts the X server.
> >
> > If that doesn't use it, a visible console window is created for the
> > bash process it starts (which is the parent of the X server process
> > and lives for it's lifetime).
> >
> > (As a separate issue, I'm not sure all the complex gymnastics run does
> > to creste the window invisibly are doing anything useful, since we
> > seem to briefly show the window and then hide it)
> 
> It may be time to finally retire run and finish the work on run2…

\o/


Corinna
