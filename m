Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 68394393D024
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 09:55:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 68394393D024
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOzKm-1kY0Fb01ca-00POJt for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2020
 10:55:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5170CA80D1D; Tue,  1 Dec 2020 10:55:54 +0100 (CET)
Date: Tue, 1 Dec 2020 10:55:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] proc(5) man page
Message-ID: <20201201095554.GK303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
 <20201130104755.GE303847@calimero.vinschen.de>
 <f6be8646-4e4c-9133-f9ac-00a89a437aad@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6be8646-4e4c-9133-f9ac-00a89a437aad@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:1Oe23kfqK+/kMWWVTtQeOQp8vL+Fc+zibDjMxjsMOYBgNQI9ttL
 GqXTYUvnlgAXR1H5zwYk++Xbv2PWMDCI6eLxq6AA8DYBrWI5HTwDnDJs0zEMnbGyABMvqWE
 r8cAtXDPTNnBE3W2G/UP04H4TRMJe8Y82Y1kUYspaV6Md3FZOURJbIT9OEUjbmSboId2siC
 8PL7IftYZNPH1RolvvL0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHtpLp5aV4s=:EWsMirCstjGODC8QSK5Kim
 lKZEZP1BTDiBefPT8gmQOA016Mj+cWHXvK1vYo7K3j0eKiP0egwuwqck3/al2Jpjt/vgq5jGw
 IAYxYVdoyRxkAmGrNQnCh07vL/ojTSeIvZiE6CSuS+G5JiqboReDqvrpN96Elapm5tWux6qiu
 MKvxl/xTL/k43MY48qdjbhgYVRRRfZXsFPLP+aS3OlE18MGwnCZLI4YTpkvnqtYDRKk8pfiy2
 bV3SCKDnSF0gI73y/j7i73RU+ZPLYi1BYtSkHHgqymGEomcKcdVd+y+ncAK6j1GN7tQi1b3bd
 Iyh8RkYNBcr9suBKrt309xrPnzHKe+1BvS3vK9sSg3K+eWAa4Nr+/FP+Z8ogc6UUtkP5f1rC8
 K4RuwXICE+DUx5dpMhNvQThadPYPn3WGTdUJ+gmBSQEcY1Vn54cpIs0hi7oWIzKxHCPy4HQkc
 afxgzTnMeQ==
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
X-List-Received-Date: Tue, 01 Dec 2020 09:55:57 -0000

On Nov 30 17:57, Brian Inglis wrote:
> On 2020-11-30 03:47, Corinna Vinschen wrote:
> > On Nov 24 23:49, Brian Inglis wrote:
> > > Brian Inglis (2):
> > >    specialnames.xml: add proc(5) Cygwin man page
> > >    winsup/doc/Makefile.in: create man5 dir and install generated proc.5
> > > 
> > >   winsup/doc/Makefile.in      |    4 +
> > >   winsup/doc/specialnames.xml | 2094 +++++++++++++++++++++++++++++++++++
> > >   2 files changed, 2098 insertions(+)
> 
> > It would be helpful if you could outline the changes from v1.
> 
> Those were fairly minor fixes to content and some processing outlined in the
> (lengthy) responses to Jon's (lengthy) comments under:
> https://sourceware.org/pipermail/cygwin-patches/2020q4/010829.html
> 
> and I have copied them below, so please clarify if the below is not what you want?

I was after a short list with bullet points, ratehr than copying
an email I have in my inbox anyway :}

Jon, can you please take another look, too?


Thanks,
Corinna
