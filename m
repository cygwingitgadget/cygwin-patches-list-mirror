Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 0A9133857C73
 for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2020 09:03:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0A9133857C73
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N18I8-1kPncq2HBC-012WUL for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2020
 10:03:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9B604A81039; Mon, 26 Oct 2020 10:03:09 +0100 (CET)
Date: Mon, 26 Oct 2020 10:03:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
Message-ID: <20201026090309.GX5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
 <20201022172710.GS5492@calimero.vinschen.de>
 <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
 <20201023092700.GU5492@calimero.vinschen.de>
 <20201023093601.GV5492@calimero.vinschen.de>
 <c0c876c8-c666-57bf-b8a9-dbbb3348da46@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0c876c8-c666-57bf-b8a9-dbbb3348da46@dronecode.org.uk>
X-Provags-ID: V03:K1:weWzTfLiBeFmhk9LjUoUP2uPc/ylMG+UENu2SjjhemuIWW17F6T
 Php0doOXihpyfLvW0NFczqXregC+OtXUjWCoogsvmkz9zFxdw0axNauXyzrxT4aC818yrhW
 HNhgfpZ04C+uyYLghwCcb1d1P1DfQITPNfStKa80xGwOhM3N+Y6f8C9b0lrPEOsmFb6G7ld
 5+beh31OgR9ECRqyG9stw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aq7pviuGwcY=:5GQ6N/QyYvKeqRETIuXxKC
 FUHmpm3pCStLaM8tBxhO4IcnmoLiPwOUIOlIw4KlTUKG2s1SFwQAqueNW2gUtZL4x/RmN4yO9
 JOAVTGJ8HKsESrXXiFQPq6t728YTLZj8xiLaWH0DWDTE97lDjPI1XVzYsU0g6AGq5xj+NoWX/
 Ifxyfb/Z7qOz/9ZWYKD/E2Tb61mU8ImscYM1OIhm1Pur+1COHNA3i1cZUCLOxsWqgXJ7eAhF2
 YhL80ZzGzFA89EgEodNWqvHPTNdNUMxZGbtF0xAVx6efMxjKRvzGlbq5zLZuSyr5f1PbSeGsj
 Zrj6nW9MwiYW+XMnU1fu76t6bO/r2qCwi/u8JpSyF2RsAcCViRYaglW8o60Rvjl4AApuWpLsz
 HDdG7XtEiIouJu0Xqo9W63isPI41WptF5UoMX93HlznwSugUsIFMhO2xKzYhQCNH9I8rolggi
 HyrUaEg6Xw==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 26 Oct 2020 09:03:14 -0000

On Oct 23 21:12, Jon Turney wrote:
> On 23/10/2020 10:36, Corinna Vinschen wrote:
> > > > > 
> > > > > Does creating a new subdir called libcygserver just to build the lib
> > > > > clean up things, perhaps?
> > > > 
> > > > I did experiment with something like that, but I'm not sure if it makes
> > > > things any clearer, as:
> > > > 
> > > > (i) It's the same source files built with/without -D__OUTSIDE_CYGWIN__
> > 
> > Oh, btw., this is bothering me for a while now.  This may have been
> > a nice idea at the time, but wouldn't it be much better to put
> > common methods into headers and otherwise split the source between
> > client and server code?
> > 
> > > > (ii) building libcygserver requires the generated file globals.h
> > > 
> > > I don't actually see a reason to keep this.
> > > 
> > > There's nothing wrong simplifying this stuff, removing mkglobals_h and
> > > creating a static version of globals.h inside the source dir.  For
> > > instance, defining enum exit_states or enum winsym_t in global.cc just
> > > to generate a globals.h from there is kind of weird anyway.  Getting rid
> > > of another undocumented perl script and getting rid of the globals.h
> > > build rule sounds rather good to me.
> 
> I'd really prefer to do those kinds of change as separate patches, to
> maximize the chances of having something that works. :)

Sure, no worries!


Corinna
