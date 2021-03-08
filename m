Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id D697B394D809
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 10:14:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D697B394D809
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6KMR-1lpfCe0lHV-016f1d for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 11:14:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BD189A8266C; Mon,  8 Mar 2021 11:14:44 +0100 (CET)
Date: Mon, 8 Mar 2021 11:14:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Message-ID: <YEX5FO0ISV06h9QY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:HY8QS2bxqcRRHHvTtTFLmj+dwUsTYfCHs/oOSYmp+gw0g5EAbtr
 6Vlr8PEiz8JHFTYT2CW/iKpHYnVZ2T+TcYYDts9kq239U1irI3CV/TET0rXz3oqYSoNmEN4
 jYf/Un6Wjxu+4SlKf2DZAKlnbexofXYqk5b5Yfs+z3LojtjdGkQ/He0tahP7q9dY4oSnfuX
 MblEVvPMzdUJpICWXSphA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/rP/6NAhvw=:+MfqA9B3KZ5DlOTOsT2u8/
 Xv7QR5pBI5mgQGGYRUJUCW/FHO3mLjd9Tzvs8xql4nOatrBg7U54/CkMapeWXXj2GJB9yQdpN
 vyZJ5OTyVI1KC8rxA2XI6XCnpBESLSRs566CqKyz1p8Or/Pvg/VcGe4h6I/GNEMLy0DkH+tAY
 klFykpy7rJcRB001AmW+7d2Axoo1WD6FV4KKvjW56IfDVqNDLUCrTq0X8jU3KQxOO0f84gpkf
 3MmqU/JRoqLJ+RH9AQMd0779bh6Hy8FmxAYCvtf+1K/zoaNLjSU6DtB1J1ecmNOIkY7EOZ3oA
 IviAJGtjO/cOnMIvHcx3q84aHm/3CZMufWARttQRwmpVUnxihkFz3DXbsF9sL38778OPo1ukV
 GyGo/QBbjKQAAGwNicwDE/nnU1e/mCG1v41/acnGdxlNObSEULuR1nLPoioDzBQQ2amJPE2EM
 JFnsufkDkg==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 08 Mar 2021 10:14:48 -0000

On Mar  7 13:26, Brian Inglis wrote:
> On 2021-03-07 12:15, Jon Turney wrote:
> > On 07/03/2021 16:31, Brian Inglis wrote:
> > > ---
> > >   winsup/doc/dll.xml | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> > I don't think the link here actually has much value, and would be
> > inclined to drop it, as far as I can tell it's just giving that as an
> > example of a toolchain which produces 'lib'-prefixed DLLs.
> > 
> > Also, reading the whole page, the section "Linking against DLLs" needs
> > updating since GNU ld has had the ability to link directly against DLLs
> > (automatically generating the necessary import stubs) for a number of
> > years.
> > 
> > Also, there are other mentions of MinGW.org on the cygwin website (e.g.
> > https://cygwin.com/links.html) which also need updating, if that URL is
> > no longer valid.
> 
> I checked the tree and Corinna cleaned up some a few years ago.
> 
> I already checked winsup/doc/ and there were no other substantive uses of
> MinGW unless you would prefer *ALL* mentions of MinGW be suffixed with -w64.
> 
> I did not look closely at cygwin-htdocs, as git complained when I tried to
> update, so I wiped that repo,

If git complained, your repo was just not in the latets state.
Maybe just using `git reset --hard origin/master' would have fixed it.


Corinna
